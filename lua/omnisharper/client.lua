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
		cmd = { unpack(cmd), unpack(args) },
		handlers = {
			["textDocument/definition"] = require("omnisharp_extended").handler,
			["textDocument/codeLens"] = function(err, res, ctx, cfg)
				vim.notify("CodeLens: " .. vim.inspect(res), vim.log.levels.INFO)
			end,
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

			vim.schedule_wrap(on_attach)(client, bufnr)
		end,
		on_exit = function()
			M.client_by_target[target] = nil
		end,
	})
end

return M
