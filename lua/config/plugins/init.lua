---@type LazySpec[]
return {
	"tjdevries/lazy-require.nvim",

	"nvim-lua/plenary.nvim",
	{
		"nvim-tree/nvim-web-devicons",
		config = function()
			local icons = require("config.icons")
			local devicons = require("nvim-web-devicons")

			devicons.setup({ default = true })
			devicons.set_default_icon(icons.circle_empty)
			for _, icon in pairs(devicons.get_icons()) do
				icon.icon = icons.circle_empty
			end
		end,
	},

	{
		"karb94/neoscroll.nvim",
		event = "VeryLazy",
		config = true,
	},

	-- {
	-- 	"folke/todo-comments.nvim",
	-- 	requires = "nvim-lua/plenary.nvim",
	-- 	config = use_config("todo_comments"),
	-- },

	{
		"NvChad/nvim-colorizer.lua",
		cmd = "ColorizerAttachToBuffer",
		config = true,
	},
	{
		"tpope/vim-fugitive",
		cmd = { "G", "Git", "GBrowse" },
		dependencies = { "tpope/vim-rhubarb" },
		init = function()
			vim.keymap.set("n", "<leader>gs", "<Cmd>Git<CR>", { desc = "Fu[G]itive [S]tatus" })
		end,
	},
	{
		"sindrets/diffview.nvim",
		cmd = { "DiffviewOpen", "DiffviewClose", "DiffviewToggleFiles", "DiffviewFocusFiles" },
		config = true,
	},
	{ "pwntester/octo.nvim", cmd = "Octo", config = true },
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

	{
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
		config = true,
	},

	{
		"numToStr/Comment.nvim",
		dependencies = "JoosepAlviste/nvim-ts-context-commentstring",
		keys = {
			{ "gcc", mode = "n" },
			{ "gbc", mode = "n" },

			{ "gc", mode = { "n", "v" } },
			{ "gb", mode = { "n", "v" } },

			{ "gco", mode = "n" },
			{ "gcA", mode = "n" },
			{ "gcO", mode = "n" },
		},
		config = function()
			require("Comment").setup({
				pre_hook = require("ts_context_commentstring.integrations.comment_nvim").create_pre_hook(),
			})
		end,
	},

	{
		"luukvbaal/statuscol.nvim",
		lazy = false,
		config = true,
	},

	{
		"lukas-reineke/indent-blankline.nvim",
		event = "BufReadPre",
		main = "ibl",
		config = true,
		opts = {
			indent = {
				char = "▏", -- ▏┊
				tab_char = "▎",
			},
		},
	},

	{
		"rcarriga/nvim-notify",
		lazy = false,
		priority = 99,
		config = function()
			vim.notify = require("notify")
		end,
	},

	{
		"akinsho/toggleterm.nvim",
		version = "*",
		event = "VeryLazy",
		keys = { "<C-;>" },
		opts = {
			open_mapping = "<C-;>",
		},
	},
}
