---@type LazySpec
return {
	{ "williamboman/mason.nvim", cmd = "Mason", config = true },

	{
		"folke/lazydev.nvim",
		ft = "lua", -- only load on lua files
		---@module 'lazydev'
		---@type lazydev.Config
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
		---@module 'roslyn'
		---@type RoslynNvimConfig
		opts = {
			choose_target = function(targets)
				return vim.iter(targets):find(function(target)
					return vim.fs.basename(target) == "Nethermind.sln"
				end)
			end,
			lock_target = true,
		},
	},

	{
		"williamboman/mason-lspconfig.nvim",
		event = "BufReadPre",
		dependencies = {
			"neovim/nvim-lspconfig",
			"Saghen/blink.cmp",
		},
		config = function()
			-- Using cmp
			--
			-- local capabilities = vim.tbl_deep_extend(
			-- 	"force",
			-- 	vim.lsp.protocol.make_client_capabilities(),
			-- 	require("cmp_nvim_lsp").default_capabilities()
			-- )

			-- Using blink
			-- local capabilities = require("blink.cmp").get_lsp_capabilities(vim.lsp.protocol.make_client_capabilities())

			-- Default
			-- local capabilities = vim.lsp.protocol.make_client_capabilities()

			require("lspconfig").zls.setup({
				-- capabilities = capabilities,
			})

			require("mason-lspconfig").setup()
			require("mason-lspconfig").setup_handlers({
				-- The first entry (without a key) will be the default handler
				function(server_name) -- default handler (optional)
					require("lspconfig")[server_name].setup({
						-- capabilities = capabilities,
					})
				end,

				["rust_analyzer"] = function()
					require("lspconfig").rust_analyzer.setup({
						-- capabilities = capabilities,
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
						-- capabilities = capabilities,
						settings = {
							gopls = {
								staticcheck = true,
								gofumpt = false,
							},
						},
					})
				end,
			})
		end,
	},
}
