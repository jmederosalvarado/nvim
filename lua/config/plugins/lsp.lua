--  This function gets run when an LSP connects to a particular buffer.
local on_attach = function(client, bufnr)
	local map = function(keys, func, desc)
		if desc then
			desc = "LSP: " .. desc
		end

		vim.keymap.set("n", keys, func, { buffer = bufnr, desc = desc })
	end

	map("<leader>rn", vim.lsp.buf.rename, "[R]e[n]ame")
	map("<leader>cc", vim.lsp.buf.code_action, "[C]ode [A]ction")

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

	-- -- CodeLens
	-- local libpl_codelens = require("lazy-require").require_on_exported_call("libpl.codelens")
	-- map("<leader>cl", libpl_codelens.run, "Run [C]ode[L]ens")
	-- vim.api.nvim_create_autocmd({ "BufEnter", "CursorHold", "InsertLeave" }, {
	-- 	buffer = bufnr,
	-- 	callback = function(opts)
	-- 		libpl_codelens.refresh(opts.buf)
	-- 	end,
	-- })
end

return {

	{ "williamboman/mason.nvim", config = true },

	{
		"williamboman/mason-lspconfig.nvim",
		event = "BufReadPre",
		dependencies = {
			"neovim/nvim-lspconfig",
			-- plugins to setup lsp servers
			"folke/neodev.nvim",
			"jmederosalvarado/roslyn.nvim",

			-- better ui for lsp progress
			{ "j-hui/fidget.nvim", tag = "legacy", config = true },
		},
		config = function()
			local cmp_nvim_lsp = require("cmp_nvim_lsp")
			local capabilities = vim.tbl_deep_extend(
				"force",
				vim.lsp.protocol.make_client_capabilities(),
				cmp_nvim_lsp.default_capabilities()
			)

			require("roslyn").setup({
				on_attach = on_attach,
				capabilities = capabilities,
			})

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
								checkOnSave = {
									command = "clippy",
									allTargets = false,
								},
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

				["zls"] = function()
					require("lspconfig").zls.setup({
						on_attach = on_attach,
						capabilities = capabilities,
						settings = {
							-- use_comptime_interpreter = true,
							warn_style = true,
						},
					})
				end,
			})

			-- vim.lsp.set_log_level("DEBUG")
		end,
	},
}
