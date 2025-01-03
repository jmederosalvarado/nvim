---@type LazySpec
return {
	"olimorris/persisted.nvim",
	lazy = false,
	opts = {
		use_git_branch = true,
		autosave = true,
		autoload = true,
	},
	init = function()
		vim.o.sessionoptions = "buffers,terminal,help,curdir,folds,globals,tabpages,winpos,winsize"
	end,
}
