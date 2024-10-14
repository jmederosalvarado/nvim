-- return {
-- 	"numToStr/Comment.nvim",
-- 	dependencies = {
-- 		{
-- 			"JoosepAlviste/nvim-ts-context-commentstring",
-- 			opts = { enable_autocmd = false },
-- 		},
-- 	},
-- 	keys = {
-- 		{ "gcc", mode = "n" },
-- 		{ "gbc", mode = "n" },
--
-- 		{ "gc", mode = { "n", "v" } },
-- 		{ "gb", mode = { "n", "v" } },
--
-- 		{ "gco", mode = "n" },
-- 		{ "gcA", mode = "n" },
-- 		{ "gcO", mode = "n" },
-- 	},
-- 	config = function()
-- 		---@diagnostic disable-next-line: missing-fields
-- 		require("Comment").setup({
-- 			pre_hook = require("ts_context_commentstring.integrations.comment_nvim").create_pre_hook(),
-- 		})
-- 	end,
-- }
--

local default_get_option = vim.filetype.get_option
---@diagnostic disable-next-line: duplicate-set-field
vim.filetype.get_option = function(filetype, option)
	if option == "commentstring" then
		require("ts_context_commentstring.internal").calculate_commentstring()
	end
	return default_get_option(filetype, option)
end

return {
	"JoosepAlviste/nvim-ts-context-commentstring",
	opts = { enable_autocmd = false },
}
