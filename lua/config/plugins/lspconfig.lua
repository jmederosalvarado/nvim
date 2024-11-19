---@type LazySpec
return {
	{ "williamboman/mason.nvim", cmd = "Mason", config = true },

	{
		"williamboman/mason-lspconfig.nvim",
		event = "BufReadPre",
		dependencies = {
			"neovim/nvim-lspconfig",
		},
		config = function()
			local cmp_nvim_lsp = require("cmp_nvim_lsp")
			local capabilities = vim.tbl_deep_extend(
				"force",
				vim.lsp.protocol.make_client_capabilities(),
				cmp_nvim_lsp.default_capabilities()
			)

			require("lspconfig").zls.setup({
				capabilities = capabilities,
			})

			require("mason-lspconfig").setup()
			require("mason-lspconfig").setup_handlers({
				-- The first entry (without a key) will be the default handler
				function(server_name) -- default handler (optional)
					require("lspconfig")[server_name].setup({
						capabilities = capabilities,
					})
				end,

				["lua_ls"] = function()
					require("lspconfig").lua_ls.setup({
						capabilities = capabilities,
						settings = {
							Lua = {
								runtime = {
									version = "LuaJIT",
									special = { reload = "require" },
								},
								workspace = {
									library = {
										vim.fn.expand("$VIMRUNTIME/lua"),
										vim.fn.expand("$VIMRUNTIME/lua/vim/lsp"),
										vim.fn.stdpath("data") .. "/lazy/lazy.nvim/lua/lazy",
									},
								},
							},
						},
					})
				end,

				["rust_analyzer"] = function()
					require("lspconfig").rust_analyzer.setup({
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
						capabilities = capabilities,
						settings = {
							gopls = {
								staticcheck = true,
								gofumpt = false,
							},
						},
					})
				end,
			})

			-- vim.lsp.set_log_level("DEBUG")
		end,
	},
}
