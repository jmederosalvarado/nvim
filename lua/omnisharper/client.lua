local CODELENS_REQUEST = "textDocument/codeLens"
local CODELENS_RESOLVE = "codeLens/resolve"

local RUN_TEST_COMMAND = "omnisharper/client/runTest"
local DEBUG_TEST_COMMAND = "omnisharper/client/debugTest"

local function walk_code_elements(elements, action, recursion_predicate)
	for _, element in ipairs(elements) do
		action(element)

		if element.Children then
			if recursion_predicate and not recursion_predicate(element) then
				return
			end

			walk_code_elements(element.Children, action)
		end
	end
end

local function request_test_codelens(omnisharp_request, params, callback, notify)
	local filename = vim.uri_to_fname(params.textDocument.uri)

	local success = omnisharp_request("o#/v2/codestructure", {
		["fileName"] = filename,
	}, function(err, res)
		if err then
			return callback(err, res)
		end

		local test_codelenses = {}

		walk_code_elements(res.Elements, function(element)
			if element.Kind ~= "method" then
				return
			end

			local test_method_name = vim.tbl_get(element, "Properties", "testMethodName")
			local test_framework_name = vim.tbl_get(element, "Properties", "testFramework")
			if not test_method_name or not test_framework_name then
				return
			end

			local start_line = vim.tbl_get(element, "Ranges", "name", "Start", "Line")
			local start_column = vim.tbl_get(element, "Ranges", "name", "Start", "Column")
			if not start_line or not start_column then
				return
			end

			local end_line = vim.tbl_get(element, "Ranges", "name", "End", "Line")
			local end_column = vim.tbl_get(element, "Ranges", "name", "End", "Column")
			if not end_line or not end_column then
				return
			end

			local function create_test_codelens(type)
				return {
					range = {
						["end"] = {
							character = end_column,
							line = end_line,
						},
						start = {
							character = start_column,
							line = start_line,
						},
					},
					data = {
						type = type,
						filename = filename,
						test_method_name = test_method_name,
						test_framework_name = test_framework_name,
					},
				}
			end

			vim.list_extend(test_codelenses, {
				create_test_codelens("RunTest"),
				create_test_codelens("DebugTest"),
			})
		end)

		return callback(nil, test_codelenses)
	end)

	return success, nil
end

local function request_resolve_codelens(omnisharp_request, params, callback, notify)
	local codelens_data_type = vim.tbl_get(params, "data", "type")
	if codelens_data_type ~= "RunTest" and codelens_data_type ~= "DebugTest" then
		return omnisharp_request(CODELENS_RESOLVE, params, callback, notify)
	end

	local codelens_data = params.data

	local success = omnisharp_request("o#/project", {
		["fileName"] = codelens_data.filename,
	}, function(err, res)
		if err then
			return callback(err, res)
		end

		local title, command
		if codelens_data.type == "RunTest" then
			title = "Run"
			command = RUN_TEST_COMMAND
		elseif codelens_data.type == "DebugTest" then
			title = "Debug"
			command = DEBUG_TEST_COMMAND
		end

		return callback(nil, {
			range = vim.tbl_deep_extend("error", {}, params.range),
			command = {
				title = title,
				command = command,
				arguments = vim.tbl_deep_extend("error", codelens_data, {
					target_framework_version = vim.tbl_get(res or {}, "MsBuildProject", "TargetFramework"),
				}),
			},
		})
	end)

	return success, nil
end

---@param cmd string
---@param cmd_args string[]
local function omnisharper_builder(cmd, cmd_args)
	return function(dispatch)
		local omnisharper = vim.lsp.rpc.start(cmd, cmd_args, dispatch)

		if not omnisharper then
			return
		end

		omnisharper.direct_request = omnisharper.request

		local omnisharper_request_table = {
			[CODELENS_REQUEST] = request_test_codelens,
			[CODELENS_RESOLVE] = request_resolve_codelens,
		}

		---@diagnostic disable-next-line: duplicate-set-field
		function omnisharper.request(method, params, callback, notify)
			local request = omnisharper_request_table[method]
			if request then
				return request(omnisharper.direct_request, params, callback, notify)
			end

			return omnisharper.direct_request(method, params, callback, notify)
		end

		return omnisharper
	end
end

-- commands = {
-- 	[RUN_TEST_COMMAND] = function(cmd, ctx)
-- 		vim.notify("Running test with: " .. vim.inspect(cmd.arguments))
--
-- 		local omnisharper = vim.lsp.get_client_by_id(ctx.client_id)
--
-- 		omnisharper.rpc.direct_request("o#/v2/getteststartinfo", {
-- 			["fileName"] = cmd.arguments.filename,
-- 			["MethodName"] = cmd.arguments.test_method_name,
-- 			["TestFrameworkName"] = cmd.arguments.test_framework_name,
-- 			["TargetFrameworkVersion"] = cmd.arguments.target_framework_version,
-- 		}, function(err, res)
-- 			if err then
-- 				vim.notify("Error: " .. vim.inspect(err), vim.log.levels.ERROR)
-- 				return
-- 			end
-- 			vim.notify("Test result: " .. vim.inspect(res), vim.log.levels.INFO)
-- 		end)
-- 	end,
-- 	[DEBUG_TEST_COMMAND] = function(cmd, ctx)
-- 		vim.notify("Debugging test with: " .. vim.inspect(cmd.arguments))
--
-- 		local omnisharper = vim.lsp.get_client_by_id(ctx.client_id)
--
-- 		omnisharper.rpc.direct_request("o#/v2/debugtest/getstartinfo", {
-- 			["fileName"] = cmd.arguments.filename,
-- 			["MethodName"] = cmd.arguments.test_method_name,
-- 			["TestFrameworkName"] = cmd.arguments.test_framework_name,
-- 			["TargetFrameworkVersion"] = cmd.arguments.target_framework_version,
-- 		}, function(err, res)
-- 			if err then
-- 				vim.notify("Err: " .. vim.inspect(err), vim.log.levels.ERROR)
-- 				return
-- 			end
--
-- 			local program = res.FileName
-- 			local args = vim.tbl_map(
-- 				function(arg)
-- 					local res = string.gsub(arg, '"', "")
-- 					return res
-- 				end,
-- 				vim.tbl_filter(function(arg)
-- 					return arg ~= ""
-- 				end, vim.split(res.Arguments, " "))
-- 			)
--
-- 			vim.notify("Res: " .. vim.inspect({ program, unpack(args) }), vim.log.levels.INFO)
--
-- 			-- require("dap").run({
-- 			-- 	name = "Debug Test",
-- 			-- 	type = "coreclr",
-- 			-- 	request = "launch",
-- 			-- 	program = args[1],
-- 			-- 	args = { unpack(args, 2) },
-- 			-- 	justMyCode = false,
-- 			-- })
--
-- 			local jobid = vim.fn.jobstart({ program, unpack(args) }, {
-- 				stderr_buffered = true,
-- 				stdout_buffered = true,
-- 				on_stdout = function(_, data)
-- 					vim.notify("Test output: " .. vim.inspect(data))
-- 				end,
-- 				on_stderr = function(_, data)
-- 					vim.notify("Test error: " .. vim.inspect(data))
-- 				end,
-- 				on_exit = function(_, code, _)
-- 					vim.notify("Test exited with code: " .. code, vim.log.levels.INFO)
-- 					omnisharper.rpc.direct_request("o#/v2/debugtest/stop", vim.empty_dict(), function(err, res)
-- 						if err then
-- 							vim.notify("Stop Err: " .. vim.inspect(err), vim.log.levels.ERROR)
-- 						else
-- 							vim.notify("Stop Res: " .. vim.inspect(err), vim.log.levels.INFO)
-- 						end
-- 					end)
-- 				end,
-- 			})
--
-- 			local pid = vim.fn.jobpid(jobid)
--
-- 			require("dap").run({
-- 				name = "Debug Test",
-- 				type = "coreclr",
-- 				request = "attach",
-- 				processId = pid,
-- 				cwd = vim.fn.getcwd(),
-- 			})
--
-- 			omnisharper.rpc.direct_request("o#/v2/debugtest/launch", {
-- 				["fileName"] = cmd.arguments.filename,
-- 				["TargetProcessId"] = pid,
-- 			}, function(err, res)
-- 				if err then
-- 					vim.notify("Launch Err: " .. vim.inspect(err), vim.log.levels.ERROR)
-- 				else
-- 					vim.notify("Launch Res: " .. vim.inspect(res), vim.log.levels.INFO)
-- 				end
-- 			end)
-- 		end)
-- 	end,
-- },

local M = {}

---Creates a new OmniSharper lsp server
---@param cmd string[]
---@param target string
---@param on_attach function
---@param capabilities table
function M.spawn(cmd, target, on_attach, capabilities)
	local args = {}
	vim.list_extend(args, { "-z", "-lsp" })
	vim.list_extend(args, { "--encoding", "utf-8" })
	vim.list_extend(args, { "-hpid", tostring(vim.fn.getpid()) })
	vim.list_extend(args, { "-s", target })
	vim.list_extend(args, {
		"DotNet:enablePackageRestore=false",
		"FormattingOptions:EnableEditorConfigSupport=true",
		"FormattingOptions:OrganizeImports=true",
		-- "MsBuild:LoadProjectsOnDemand=true",
		"RoslynExtensionsOptions:EnableAnalyzersSupport=true",
		"RoslynExtensionsOptions:EnableDecompilationSupport=true",
		"RoslynExtensionsOptions:EnableImportCompletion=true",
		-- "Sdk:IncludePrereleases=true",
		"RoslynExtensionsOptions:AnalyzeOpenDocumentsOnly=true",
	})

	return vim.lsp.start_client({
		name = "omnisharp",
		capabilities = capabilities,
		cmd = omnisharper_builder(cmd[1], args),
		handlers = {
			["textDocument/definition"] = require("omnisharp_extended").handler,
		},
		on_init = function()
			vim.notify(
				"OmniSharper client initialized for target " .. vim.fn.fnamemodify(target, ":~:."),
				vim.log.levels.INFO
			)
		end,
		on_attach = function(client, bufnr)
			client.server_capabilities.semanticTokensProvider = {
				legend = {
					tokenModifiers = { "static" },
					tokenTypes = {
						"comment",
						"excluded",
						"identifier",
						"keyword",
						"keyword",
						"number",
						"operator",
						"operator",
						"preprocessor",
						"string",
						"whitespace",
						"text",
						"static",
						"preprocessor",
						"punctuation",
						"string",
						"string",
						"class",
						"delegate",
						"enum",
						"interface",
						"module",
						"struct",
						"typeParameter",
						"field",
						"enumMember",
						"constant",
						"local",
						"parameter",
						"method",
						"method",
						"property",
						"event",
						"namespace",
						"label",
						"xml",
						"xml",
						"xml",
						"xml",
						"xml",
						"xml",
						"xml",
						"xml",
						"xml",
						"xml",
						"xml",
						"xml",
						"xml",
						"xml",
						"xml",
						"xml",
						"xml",
						"xml",
						"xml",
						"xml",
						"xml",
						"regex",
						"regex",
						"regex",
						"regex",
						"regex",
						"regex",
						"regex",
						"regex",
						"regex",
					},
				},
				range = true,
				full = vim.empty_dict(),
			}

			client.server_capabilities.semanticTokensProvider = nil

			vim.schedule_wrap(on_attach)(client, bufnr)
		end,
		on_exit = function()
			M.client_by_target[target] = nil
		end,
	})
end

return M
