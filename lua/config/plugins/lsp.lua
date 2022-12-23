--  This function gets run when an LSP connects to a particular buffer.
local on_attach = function(client, bufnr)
	local map = function(keys, func, desc)
		if desc then
			desc = "LSP: " .. desc
		end

		vim.keymap.set("n", keys, func, { buffer = bufnr, desc = desc })
	end

	map("<leader>rn", vim.lsp.buf.rename, "[R]e[n]ame")
	map("<leader>ca", vim.lsp.buf.code_action, "[C]ode [A]ction")

	map("gd", vim.lsp.buf.definition, "[G]oto [D]efinition")
	map("gD", vim.lsp.buf.type_definition, "Type [D]efinition")

	local telescope_builtin = require("lazy-require").require_on_exported_call("telescope.builtin")
	map("gr", telescope_builtin.lsp_references, "[G]o to [R]eferences")
	map("gi", telescope_builtin.lsp_implementations, "[G]o to [I]mplementations")

	map("<leader>ds", telescope_builtin.lsp_document_symbols, "[D]ocument [S]ymbols")
	map("<leader>ws", telescope_builtin.lsp_dynamic_workspace_symbols, "[W]orkspace [S]ymbols")

	-- See `:help K` for why this keymap
	map("K", vim.lsp.buf.hover, "Hover Documentation")
	-- nmap('<C-k>', vim.lsp.buf.signature_help, 'Signature Documentation')

	-- Lesser used LSP functionality
	-- map("gD", vim.lsp.buf.declaration, "[G]oto [D]eclaration")
	-- map("<leader>wa", vim.lsp.buf.add_workspace_folder, "[W]orkspace [A]dd Folder")
	-- map("<leader>wr", vim.lsp.buf.remove_workspace_folder, "[W]orkspace [R]emove Folder")
	-- map("<leader>wl", function()
	-- 	print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
	-- end, "[W]orkspace [L]ist Folders")

	-- we want to use the null-ls formatter, so disable the built-in one
	-- local disable_formatting = { "pyright", "sumneko_lua" }
	-- if vim.tbl_contains(disable_formatting, client.name) then
	--     client.server_capabilities.documentFormattingProvider = false
	-- end

	if client.server_capabilities.documentFormattingProvider then
		-- Create a command `:Format` local to the LSP buffer
		vim.api.nvim_buf_create_user_command(
			bufnr,
			"Format",
			vim.lsp.buf.format,
			{ desc = "Format current buffer with LSP" }
		)

		map("<leader>fm", vim.lsp.buf.format, "Format buffer")
	end

	if client.name == "omnisharp" then
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
		}
	end
end

return {

	{
		"williamboman/mason.nvim",
		config = true,
	},

	{
		"williamboman/mason-lspconfig.nvim",
		event = "BufReadPre",
		dependencies = {
			"neovim/nvim-lspconfig",
			-- plugins to setup lsp servers
			"folke/neodev.nvim",

			-- better ui for lsp progress
			{ "j-hui/fidget.nvim", config = true },
		},
		config = function()
			local capabilities = vim.lsp.protocol.make_client_capabilities()
			local ok, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
			if ok then
				-- nvim-cmp supports additional completion capabilities
				capabilities = cmp_nvim_lsp.default_capabilities(capabilities)
			end

			require("mason-lspconfig").setup()
			require("mason-lspconfig").setup_handlers({
				-- The first entry (without a key) will be the default handler
				function(server_name) -- default handler (optional)
					require("lspconfig")[server_name].setup({
						on_attach = on_attach,
						capabilities = capabilities,
					})
				end,

				["lua_ls"] = function()
					require("neodev").setup()
					require("lspconfig").lua_ls.setup({
						on_attach = on_attach,
						capabilities = capabilities,
						settings = {
							Lua = {
								format = { enable = false },
								telemetry = { enable = false },
								workspace = { checkThirdParty = false },
							},
						},
					})
				end,

				["rust_analyzer"] = function()
					require("lspconfig").rust_analyzer.setup({
						on_attach = on_attach,
						capabilities = capabilities,
						settings = {
							["rust-analyzer"] = {
								["checkOnSave.command"] = "clippy",
							},
						},
					})
				end,

				["gopls"] = function()
					require("lspconfig").gopls.setup({
						on_attach = on_attach,
						capabilities = capabilities,
						settings = {
							gopls = {
								staticcheck = true,
								gofumpt = false,
							},
						},
					})
				end,

				["omnisharp"] = function()
					require("lspconfig").omnisharp.setup({
						on_attach = on_attach,
						-- on_new_config = function(new_config, new_root_dir)
						-- 	local default_cmd = require("mason-lspconfig.server_configurations.omnisharp")().cmd
						-- 	local default_on_new_config =
						-- 		require("lspconfig.server_configurations.omnisharp").default_config.on_new_config
						-- 	-- clear the cmd table
						-- 	for k in pairs(new_config.cmd) do
						-- 		new_config.cmd[k] = nil
						-- 	end
						--
						-- 	-- add the default cmd
						-- 	new_config.cmd = vim.list_extend(new_config.cmd, default_cmd)
						--
						-- 	-- call default on_new_config
						-- 	default_on_new_config(new_config, new_root_dir)
						-- end,
						on_new_config = function(new_config, new_root_dir)
							local cache = require("config.cache")

							if cache.omnisharp.default_cmd == nil then
								cache.omnisharp.default_cmd = vim.list_slice(new_config.cmd)
								vim.list_extend(cache.omnisharp.default_cmd, { "-z", "-lsp" })
								vim.list_extend(cache.omnisharp.default_cmd, { "--encoding", "utf-8" })
								vim.list_extend(cache.omnisharp.default_cmd, { "--hostPID", tostring(vim.fn.getpid()) })
							end

							local dir_cmd = cache.omnisharp.cmd_by_dir[new_root_dir]

							if dir_cmd == nil then
								dir_cmd = vim.list_slice(cache.omnisharp.default_cmd)

								-- TODO: Choose sln file from root dir and use that instead
								vim.list_extend(dir_cmd, { "-s", new_root_dir })

								table.insert(dir_cmd, "DotNet:enablePackageRestore=false")

								if new_config.enable_editorconfig_support then
									table.insert(dir_cmd, "FormattingOptions:EnableEditorConfigSupport=true")
								end

								if new_config.organize_imports_on_format then
									table.insert(dir_cmd, "FormattingOptions:OrganizeImports=true")
								end

								if new_config.enable_ms_build_load_projects_on_demand then
									table.insert(dir_cmd, "MsBuild:LoadProjectsOnDemand=true")
								end

								if new_config.enable_roslyn_analyzers then
									table.insert(dir_cmd, "RoslynExtensionsOptions:EnableAnalyzersSupport=true")
								end

								if new_config.enable_import_completion then
									table.insert(dir_cmd, "RoslynExtensionsOptions:EnableImportCompletion=true")
								end

								if new_config.sdk_include_prereleases then
									table.insert(dir_cmd, "Sdk:IncludePrereleases=true")
								end

								if new_config.analyze_open_documents_only then
									table.insert(dir_cmd, "RoslynExtensionsOptions:AnalyzeOpenDocumentsOnly=true")
								end

								cache.omnisharp.cmd_by_dir[new_root_dir] = dir_cmd
							end

							local longest = math.max(#new_config.cmd, #dir_cmd)
							for i = 1, longest do
								new_config.cmd[i] = dir_cmd[i]
							end
						end,
						capabilities = capabilities,

						-- Enables support for reading code style, naming convention and analyzer
						-- settings from .editorconfig.
						enable_editorconfig_support = true,

						-- If true, MSBuild project system will only load projects for files that
						-- were opened in the editor. This setting is useful for big C# codebases
						-- and allows for faster initialization of code navigation features only
						-- for projects that are relevant to code that is being edited. With this
						-- setting enabled OmniSharp may load fewer projects and may thus display
						-- incomplete reference lists for symbols.
						enable_ms_build_load_projects_on_demand = false,

						-- Enables support for roslyn analyzers, code fixes and rulesets.
						enable_roslyn_analyzers = true,

						-- Specifies whether 'using' directives should be grouped and sorted during
						-- document formatting.
						organize_imports_on_format = true,

						-- Enables support for showing unimported types and unimported extension
						-- methods in completion lists. When committed, the appropriate using
						-- directive will be added at the top of the current file. This option can
						-- have a negative impact on initial completion responsiveness,
						-- particularly for the first few completion sessions after opening a
						-- solution.
						enable_import_completion = true,

						-- Specifies whether to include preview versions of the .NET SDK when
						-- determining which version to use for project loading.
						sdk_include_prereleases = true,

						-- Only run analyzers against open files when 'enableRoslynAnalyzers' is
						-- true
						analyze_open_documents_only = true,
					})
				end,
			})

			-- vim.lsp.set_log_level("DEBUG")
		end,
	},

	{
		"jay-babu/mason-null-ls.nvim",
		dependencies = {
			"jose-elias-alvarez/null-ls.nvim",
		},
		event = "BufReadPre",
		config = function()
			require("mason-null-ls").setup()
			require("mason-null-ls").setup_handlers({
				function(source_name, methods)
					-- all sources with no handler get passed here

					-- keep the original functionality of `automatic_setup = true`
					require("mason-null-ls.automatic_setup")(source_name, methods)
				end,
				["isort"] = function()
					local nls = require("null-ls")
					nls.register(nls.builtins.formatting.isort.with({
						args = { "--stdout", "--profile", "black", "-" },
					}))
				end,
				["shfmt"] = function()
					local nls = require("null-ls")
					nls.register(nls.builtins.formatting.shfmt.with({
						filetypes = vim.fn.extend(nls.builtins.formatting.shfmt.filetypes, { "zsh", "bash" }),
					}))
				end,
			})
			require("null-ls").setup({
				on_attach = on_attach,
			})
		end,
	},
}
