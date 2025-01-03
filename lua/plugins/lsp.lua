---@type LazySpec
return {
	{ "williamboman/mason.nvim", cmd = "Mason", config = true },

	{
		"folke/lazydev.nvim",
		ft = "lua", -- only load on lua files
		opts = {
			library = {
				"lazy.nvim",
				-- See the configuration section for more details
				-- Load luvit types when the `vim.uv` word is found
				{ path = "luvit-meta/library", words = { "vim%.uv" } },
			},
		},
		dependencies = { "Bilal2453/luvit-meta", lazy = true }, -- optional `vim.uv` typings
	},

	{
		"seblj/roslyn.nvim",
		ft = "cs",
		opts = {},
	},

	{
		"williamboman/mason-lspconfig.nvim",
		event = "BufReadPre",
		dependencies = {
			"neovim/nvim-lspconfig",
			-- "hrsh7th/cmp-nvim-lsp",
			"Saghen/blink.cmp",
		},
		config = function()
			-- local capabilities = vim.tbl_deep_extend(
			-- 	"force",
			-- 	vim.lsp.protocol.make_client_capabilities(),
			-- 	require("cmp_nvim_lsp").default_capabilities()
			-- )
			local capabilities = require("blink.cmp").get_lsp_capabilities(vim.lsp.protocol.make_client_capabilities())
			local capabilities = vim.lsp.protocol.make_client_capabilities()

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
