local cmp = require("cmp")
local types = require("cmp.types")

local luasnip = require("luasnip")
require("luasnip.loaders.from_vscode").load()

local has_words_before = function()
	local line, col = unpack(vim.api.nvim_win_get_cursor(0))
	return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
end

cmp.setup({
	snippet = {
		expand = function(args)
			-- vim.fn["vsnip#anonymous"](args.body)
			luasnip.lsp_expand(args.body)
		end,
	},

	preselect = types.cmp.PreselectMode.None,

	mapping = {
		["<C-Space>"] = cmp.mapping.complete(),

		["<C-n>"] = cmp.mapping.select_next_item(),
		["<C-p>"] = cmp.mapping.select_prev_item(),
		["<C-y>"] = cmp.mapping.confirm({ select = true, behavior = cmp.ConfirmBehavior.Insert }),

		["<C-e>"] = cmp.mapping.abort(),
		["<C-c>"] = cmp.mapping.close(),

		["<C-d>"] = cmp.mapping.scroll_docs(-4),
		["<C-f>"] = cmp.mapping.scroll_docs(4),

		-- ["<CR>"] = cmp.mapping.confirm({
		-- 	behavior = cmp.ConfirmBehavior.Replace,
		-- 	select = false,
		-- }),
		-- ["<Tab>"] = cmp.mapping(function(fallback)
		-- 	if cmp.visible() then
		-- 		cmp.select_next_item({ behavior = types.cmp.SelectBehavior.Select })
		-- 	elseif luasnip.expand_or_jumpable() then
		-- 		luasnip.expand_or_jump()
		-- 	elseif has_words_before() then
		-- 		cmp.complete()
		-- 	else
		-- 		fallback()
		-- 	end
		-- end, {
		-- 	"i",
		-- 	"s",
		-- }),

		-- ["<S-Tab>"] = cmp.mapping(function(fallback)
		-- 	if cmp.visible() then
		-- 		cmp.select_prev_item({ behavior = types.cmp.SelectBehavior.Select })
		-- 	elseif luasnip.jumpable(-1) then
		-- 		luasnip.jump(-1)
		-- 	else
		-- 		fallback()
		-- 	end
		-- end, {
		-- 	"i",
		-- 	"s",
		-- }),
	},

	formatting = {
		format = require("lspkind").cmp_format({
			menu = {
				["nvim_lsp"] = "[LSP]",
				["luasnip"] = "[SNIP]",
				["buffer"] = "[BUF]",
				["path"] = "[PATH]",
			},
		}),
	},

	experimental = {
		-- native_menu = true,
		ghost_text = true,
	},

	sources = {
		{ name = "nvim_lsp" },
		-- { name = "vsnip" },
		{ name = "luasnip" },
		{ name = "buffer", max_item_count = 5 },
		{ name = "path" },
	},
})

require("nvim-autopairs").setup({ check_ts = true })
cmp.event:on('confirm_done', require("nvim-autopairs.completion.cmp").on_confirm_done({ map_char = { tex = '' } }))
