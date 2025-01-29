---@type LazySpec
return {
	"ThePrimeagen/harpoon",
	branch = "harpoon2",
	dependencies = { "nvim-lua/plenary.nvim" },
    ---@module 'harpoon.config'
    ---@type HarpoonConfig
	opts = {},
	keys = {
		{
			"<C-a>",
			function()
				require("harpoon"):list():add()
			end,
			desc = "[A]dd file to harpoon",
		},
		{
			"<C-f>",
			function()
				require("harpoon").ui:toggle_quick_menu(require("harpoon"):list())
			end,
			desc = "Toggle harpoon quick menu",
		},
		{
			"<C-j>",
			function()
				require("harpoon"):list():select(1)
			end,
			desc = "Switch to harpoon file 1",
		},
		{
			"<C-k>",
			function()
				require("harpoon"):list():select(2)
			end,
			desc = "Switch to harpoon file 2",
		},
		{
			"<C-l>",
			function()
				require("harpoon"):list():select(3)
			end,
			desc = "Switch to harpoon file 3",
		},
		{
			"<C-;>",
			function()
				require("harpoon"):list():select(4)
			end,
			desc = "Switch to harpoon file 4",
		},
	},
}
