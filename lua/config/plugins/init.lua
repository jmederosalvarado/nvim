return {
	"tjdevries/lazy-require.nvim",

	"nvim-lua/plenary.nvim",
	{
		"nvim-tree/nvim-web-devicons",
		-- config = function()
		-- 	local icons = require("config.icons")
		-- 	local devicons = require("nvim-web-devicons")
		--
		-- 	devicons.setup({ default = true })
		-- 	devicons.set_default_icon(icons.circle_empty)
		-- 	for _, icon in pairs(devicons.get_icons()) do
		-- 		icon.icon = icons.circle_empty
		-- 	end
		-- end,
	},

	{
		"tpope/vim-fugitive",
		cmd = { "G", "Git", "GBrowse" },
		dependencies = { "tpope/vim-rhubarb" },
		init = function()
			vim.keymap.set("n", "<leader>gs", "<Cmd>Git<CR>", { desc = "Fu[G]itive [S]tatus" })
		end,
	},

	{ "tpope/vim-repeat", event = "VeryLazy" },
	{ "tpope/vim-unimpaired", event = "VeryLazy" },
	{ "tpope/vim-abolish", event = "VeryLazy" },

	{
		"andymass/vim-matchup",
		event = "BufReadPost",
		init = function()
			vim.g.matchup_matchparen_offscreen = {
				-- method = "popup",
			}
		end,
	},
}
