return {
	"hrsh7th/nvim-cmp",
	event = "InsertEnter",
	dependencies = {
		-- appearance
		"onsails/lspkind.nvim",

		-- autocomplete pairs
		{ "windwp/nvim-autopairs", opts = { check_ts = true } },

		-- snippets
		"rafamadriz/friendly-snippets",
		"L3MON4D3/LuaSnip",
		"saadparwaiz1/cmp_luasnip",

		-- cmp sources
		"hrsh7th/cmp-nvim-lua",
		"hrsh7th/cmp-nvim-lsp",
		"petertriho/cmp-git",
		"hrsh7th/cmp-nvim-lsp-signature-help",
		"hrsh7th/cmp-buffer",
		"hrsh7th/cmp-path",
	},
	config = function()
		local cmp = require("cmp")
		local types = require("cmp.types")
		local luasnip = require("luasnip")

		cmp.setup({
			snippet = {
				expand = function(args)
					luasnip.lsp_expand(args.body)
				end,
			},
			formatting = {
				fields = {
					"abbr",
					"kind",
					"menu",
				},
				expandable_indicator = true,
				format = require("lspkind").cmp_format({
					mode = "symbol_text",
					before = function(entry, vim_item)
						vim_item.menu = ({
							nvim_lsp = "[LSP]",
							luasnip = "[SNIP]",
							nvim_lua = "[LUA]",
							buffer = "[BUF]",
							path = "[PATH]",
						})[entry.source.name]

						return vim_item
					end,
				}),
			},
			mapping = {
				["<C-Space>"] = cmp.mapping(cmp.mapping.complete({}), { "i", "s" }),

				["<C-n>"] = cmp.mapping(function(fallback)
					if cmp.visible() then
						cmp.select_next_item({ behavior = types.cmp.SelectBehavior.Insert })
					elseif luasnip.locally_jumpable(1) then
						luasnip.jump(1)
					else
						-- fallback()
					end
				end, { "i", "s" }),

				["<C-p>"] = cmp.mapping(function(fallback)
					if cmp.visible() then
						cmp.select_prev_item({ behavior = types.cmp.SelectBehavior.Insert })
					elseif luasnip.locally_jumpable(-1) then
						luasnip.jump(-1)
					else
						-- fallback()
					end
				end, { "i", "s" }),

				["<C-y>"] = cmp.mapping(
					cmp.mapping.confirm({ select = true, behavior = cmp.ConfirmBehavior.Insert }),
					{ "i", "s" }
				),

				["<C-e>"] = cmp.mapping(cmp.mapping.abort(), { "i", "s" }),
				["<C-c>"] = cmp.mapping(cmp.mapping.close(), { "i", "s" }),

				["<C-u>"] = cmp.mapping.scroll_docs(-4),
				["<C-d>"] = cmp.mapping.scroll_docs(4),
			},
			sources = {
				{ name = "nvim_lsp" },
				{ name = "nvim_lsp_signature_help" },
				{ name = "luasnip" },
				{ name = "buffer", max_item_count = 5 },
				{ name = "path" },
			},
			experimental = {
				ghost_text = false,
			},
		})

		-- Set configuration for gitcommit
		cmp.setup.filetype("gitcommit", {
			sources = cmp.config.sources({
				{ name = "git" },
			}, {
				{ name = "buffer" },
			}),
		})
		require("cmp_git").setup()

		-- cmp.setup.cmdline("/", {
		-- 	sources = {
		-- 		{ name = "buffer" },
		-- 	},
		-- })
		--
		-- cmp.setup.cmdline("?", {
		-- 	sources = {
		-- 		{ name = "buffer" },
		-- 	},
		-- })
		--
		-- cmp.setup.cmdline(":", {
		-- 	sources = {
		-- 		{ name = "path" },
		-- 		{ name = "cmdline" },
		-- 	},
		-- })

		require("nvim-autopairs").setup({ check_ts = true })
		cmp.event:on(
			"confirm_done",
			require("nvim-autopairs.completion.cmp").on_confirm_done({ map_char = { tex = "" } })
		)

		require("luasnip.loaders.from_vscode").load()
	end,
}
