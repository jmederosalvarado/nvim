---@type LazySpec
return {
	"tpope/vim-fugitive",
	cmd = { "G", "Git", "GBrowse" },
	dependencies = { "tpope/vim-rhubarb" },
	keys = {
		{ "<leader>gs", "<Cmd>Git<CR>", desc = "Fu[G]itive [S]tatus" },
	},
}
