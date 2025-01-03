---@type LazySpec
return {
	"hrsh7th/nvim-cmp",
	event = "InsertEnter",
	enabled = false,
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
		"hrsh7th/cmp-nvim-lsp",
		"hrsh7th/cmp-buffer",
		"hrsh7th/cmp-path",
		"petertriho/cmp-git",
	},
	config = function()
		local cmp = require("cmp")
		local types = require("cmp.types")
		local luasnip = require("luasnip")

		local default_sources = {
			{ name = "nvim_lsp" },
			{ name = "luasnip" },
			{ name = "buffer", max_item_count = 5 },
			{ name = "path" },
		}

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
							buffer = "[BUF]",
							path = "[PATH]",
							lazydev = "[LAZY]",
						})[entry.source.name] or "[ANY]"

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
			sources = default_sources,
			experimental = {
				ghost_text = false,
			},
		})

		cmp.setup.filetype("lua", {
			sources = {
				{
					name = "lazydev",
					group_index = 0, -- set group index to 0 to skip loading LuaLS completions
				},
				unpack(default_sources),
			},
		})

		require("nvim-autopairs").setup({ check_ts = true })
		cmp.event:on(
			"confirm_done",
			require("nvim-autopairs.completion.cmp").on_confirm_done({ map_char = { tex = "" } })
		)

		require("luasnip.loaders.from_vscode").load()
	end,
}
