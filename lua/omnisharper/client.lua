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

local function get_test_codelenses(request)
	local request_result = nil

	request("o#/v2/codestructure", {
		["fileName"] = vim.api.nvim_buf_get_name(0),
		-- ["fileName"] = vim.lsp.util.make_text_document_params().uri,
	}, function(err, res)
		request_result = { err = err, res = res }
	end)

	local wait_result = vim.wait(1000, function()
		return request_result ~= nil
	end, 10)

	if not wait_result then
		return {}
	end

	if request_result.err then
		vim.notify("Error getting code structure from omnisharp: " .. request_result.err.message, vim.log.levels.ERROR)
		return {}
	end

	local test_codelenses = {}

	walk_code_elements(request_result.res.Elements, function(element)
		if element.Kind ~= "method" then
			return
		end

		local framework = vim.tbl_get(element, "Properties", "testFramework")
		local method_name = vim.tbl_get(element, "Properties", "testMethodName")
		if not framework or not method_name then
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
					framework = framework,
					method_name = method_name,
				},
			}
		end

		vim.list_extend(test_codelenses, {
			create_test_codelens("RunTest"),
			create_test_codelens("DebugTest"),
		})
	end)

	return test_codelenses
end

---@param cmd string
---@param cmd_args string[]
local function wrap_omnisharp(cmd, cmd_args)
	return function(dispatch)
		local omnisharp = vim.lsp.rpc.start(cmd, cmd_args, dispatch)

		if not omnisharp then
			return
		end

		local request = omnisharp.request

		---@diagnostic disable-next-line: duplicate-set-field
		function omnisharp.request(method, params, callback, notify)
			if method == "textDocument/codeLens" then
				local prev_callback = callback

				callback = function(err, res)
					if not err then
						vim.list_extend(res, get_test_codelenses(request))
					end

					return prev_callback(err, res)
				end

				return request(method, params, callback, notify)
			elseif method == "codeLens/resolve" then
				local codelens_data_type = vim.tbl_get(params, "data", "type")
				if codelens_data_type ~= "RunTest" and codelens_data_type ~= "DebugTest" then
					return request(method, params, callback, notify)
				end

				local codelens_data_framework = vim.tbl_get(params, "data", "framework")
				local codelens_data_method_name = vim.tbl_get(params, "data", "method_name")
				if not codelens_data_framework or not codelens_data_method_name then
					callback({
						code = -1,
						message = "Error resolving test codelens: missing framework or method name",
					}, nil)
					return true, nil
				end

				callback(nil, {
					range = vim.tbl_deep_extend("error", {}, params.range),
					command = {
						title = codelens_data_type,
						command = "omnisharper.test.run",
						arguments = {
							codelens_data_framework,
							codelens_data_method_name,
						},
					},
				})
				return true, nil
			end

			return request(method, params, callback, notify)
		end

		return omnisharp
	end
end

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
		cmd = wrap_omnisharp(cmd[1], args),
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

			vim.schedule_wrap(function(client, bufnr)
				on_attach(client, bufnr)

				vim.api.nvim_create_autocmd({ "BufEnter", "CursorHold", "InsertLeave" }, {
					buffer = bufnr,
					callback = function()
						vim.lsp.codelens.refresh()
					end,
				})
			end)(client, bufnr)
		end,
		on_exit = function()
			M.client_by_target[target] = nil
		end,
	})
end

return M
