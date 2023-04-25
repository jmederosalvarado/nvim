return {
	"tjdevries/lazy-require.nvim",

	"nvim-lua/plenary.nvim",
	{
		"nvim-tree/nvim-web-devicons",
		config = { default = true },
	},

	{
		"zbirenbaum/copilot.lua",
		event = "VeryLazy",
		config = {
			panel = {
				enabled = true,
				auto_refresh = false,
				keymap = {
					jump_prev = "[[",
					jump_next = "]]",
					accept = "<CR>",
					refresh = "gr",
					open = "<M-CR>",
				},
			},
			suggestion = {
				enabled = true,
				auto_trigger = true,
				debounce = 75,
				keymap = {
					accept = "<Tab>",
					accept_word = false,
					accept_line = false,
					next = "<M-]>",
					prev = "<M-[>",
					dismiss = "<C-]>",
				},
			},
		},
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
		"folke/persistence.nvim",
		init = function()
			vim.api.nvim_create_autocmd("VimEnter", {
				callback = function()
					if vim.fn.argc() == 0 then
						require("persistence").load()
					end
				end,
				desc = "Load persisted session for the current directory",
				nested = true,
			})
			-- vim.keymap.set("n", "<leader>pp", function()
			-- 	require("persistence").load()
			-- end, { desc = "Load [P]ersisted session for the current directory" })
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
		config = {
			char = "┊", -- ▏┊
			context_char = "┊", -- ▏┊
			show_current_context = true,
			show_trailing_blankline_indent = false,
			use_treesitter = true,
			max_indent_increase = 1,
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
		"ggandor/leap.nvim",
		keys = {
			{ "gs", mode = { "n", "x", "o" } },
			{ "s", mode = { "n", "x", "o" } },
			{ "S", mode = { "n", "x", "o" } },
			{ "x", mode = { "x", "o" } },
			{ "X", mode = { "x", "o" } },
		},
		config = function()
			require("leap").set_default_keymaps()
		end,
	},

	{
		"ggandor/flit.nvim",
		keys = {
			{ "f", mode = { "n", "x", "o" } },
			{ "F", mode = { "n", "x", "o" } },
			{ "t", mode = { "n", "x", "o" } },
			{ "T", mode = { "n", "x", "o" } },
		},
		dependencies = { "ggandor/leap.nvim" },
		config = true,
	},

	{
		"akinsho/toggleterm.nvim",
		version = "*",
		event = "VeryLazy",
		opts = {
			open_mapping = "<C-;>",
		},
	},

	{
		"jmederosalvarado/gruvy.nvim",
		enabled = false,
		priority = 100,
		lazy = false,
		config = function()
			vim.cmd("colorscheme gruvy")
		end,
	},

	{
		"catppuccin/nvim",
		name = "catppuccin",
		priority = 100,
		lazy = false,
		config = function()
			require("catppuccin").setup({
				flavour = "frappe",
				background = {
					light = "latte",
					dark = "frappe",
				},
				transparent_background = false,
				term_colors = true,
				compile = {
					enabled = false,
					path = vim.fn.stdpath("cache") .. "/catppuccin",
				},
				dim_inactive = {
					enabled = false,
					shade = "dark",
					percentage = 0.15,
				},
				styles = {
					comments = { "italic" },
					conditionals = { "italic" },
					loops = {},
					functions = {},
					keywords = {},
					strings = {},
					variables = {},
					numbers = {},
					booleans = {},
					properties = {},
					types = {},
					operators = {},
				},
				integrations = {
					treesitter = true,
					treesitter_context = true,
					cmp = true,
					gitsigns = true,
					telescope = true,
					nvimtree = true,
					markdown = true,
					notify = true,
					neogit = true,
					lightspeed = true,
					lsp_trouble = true,
					indent_blankline = {
						enabled = true,
						colored_indent_levels = false,
					},
					native_lsp = {
						enabled = true,
						virtual_text = {
							errors = { "italic" },
							hints = { "italic" },
							warnings = { "italic" },
							information = { "italic" },
						},
						underlines = {
							errors = { "underline" },
							hints = { "underline" },
							warnings = { "underline" },
							information = { "underline" },
						},
					},
				},
				color_overrides = {},
				highlight_overrides = {},
			})
			vim.cmd.colorscheme("catppuccin")
		end,
	},
}
