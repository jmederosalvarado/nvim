local lazyroot = vim.fn.stdpath("data") .. "/lazy"

-- bootstrap lazy package manager
local lazypath = lazyroot .. "/lazy.nvim"

if not (vim.uv or vim.loop).fs_stat(lazypath) then
	print("===============================")
	print("    Bootstrapping lazy.nvim    ")
	print("===============================")

	local out = vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"--single-branch",
		"https://github.com/folke/lazy.nvim.git",
		lazypath,
	})
	if vim.v.shell_error ~= 0 then
		vim.api.nvim_echo({
			{ "Failed to clone lazy.nvim:\n", "ErrorMsg" },
			{ out, "WarningMsg" },
			{ "\nPress any key to exit..." },
		}, true, {})
		vim.fn.getchar()
		os.exit(1)
	end
end

vim.opt.runtimepath:prepend(lazypath)

require("lazy").setup("config.plugins", {
	root = lazyroot,
	defaults = {
		lazy = true,
	},
	lockfile = vim.fn.stdpath("config") .. "/lazy-lock.json",
	dev = {
		path = "~/src",
		patterns = { "jmederosalvarado" },
	},
	install = {
		-- install missing plugins on startup. This doesn't increase startup time.
		missing = true,
		-- try to load one of these colorschemes when starting an installation during startup
		colorscheme = { "catppuccin", "habamax" },
	},
	checker = {
		enable = true,
		check_pinned = true,
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
