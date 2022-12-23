local lazyroot = vim.fn.stdpath("data") .. "/lazy"

-- bootstrap lazy package manager
local lazypath = lazyroot .. "/lazy.nvim"

if not vim.loop.fs_stat(lazypath) then
	print("===============================")
	print("    Bootstrapping lazy.nvim    ")
	print("===============================")

	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"--single-branch",
		"https://github.com/folke/lazy.nvim.git",
		lazypath,
	})
end

vim.opt.runtimepath:prepend(lazypath)


require("lazy").setup("config.plugins", {
	root = lazyroot,
	defaults = {
		lazy = true,
	},
	lockfile = vim.fn.stdpath("config") .. "/lazy-lock.json",
	dev = {
		path = "~/src/plugins.nvim",
	},
      install = {
        -- install missing plugins on startup. This doesn't increase startup time.
        missing = true,
        -- try to load one of these colorschemes when starting an installation during startup
        colorscheme = { "catppuccin", "habamax" },
      },
	performance = {
		rtp = {
			disabled_plugins = {
				"2html_plugin",
				"getscript",
				"getscriptPlugin",
				"gzip",
				"logipat",
				"netrw",
				"netrwPlugin",
				"netrwSettings",
				"netrwFileHandlers",
				"matchit",
				"tar",
				"tarPlugin",
				"rrhelper",
				"spellfile_plugin",
				"vimball",
				"vimballPlugin",
				"zip",
				"zipPlugin",
			},
		},
	},
})
