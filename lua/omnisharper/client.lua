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

local function wrap_on_attach(user_on_attach)
	return function(client, bufnr)
		user_on_attach(client, bufnr)

		local filename = vim.api.nvim_buf_get_name(bufnr)

		local success = client.request("o#/v2/codestructure", {
			["fileName"] = filename,
		}, function(err, res)
			if err then
				vim.notify("Error: " .. vim.inspect(err), vim.log.levels.ERROR)
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
					vim.notify(vim.inspect(element))
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
		end)

		return success, nil
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

	capabilities = vim.tbl_deep_extend("keep", capabilities, {
		workspace = {
			configuration = true,
		},
	})

	return vim.lsp.start_client({
		name = "omnisharp",
		capabilities = capabilities,
		cmd = { unpack(cmd), unpack(args) },
		handlers = {
			["textDocument/definition"] = require("omnisharp_extended").handler,
		},
		commands = {},
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

			-- client.server_capabilities.semanticTokensProvider = nil

			vim.schedule_wrap(wrap_on_attach(on_attach))(client, bufnr)
		end,
		on_exit = function()
			M.client_by_target[target] = nil
		end,
	})
end

return M
