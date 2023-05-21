local spec = {
	"nvim-tree/nvim-tree.lua",
	command = "NvimTreeToggle",
	keys = {
		{
			"<C-n>",
			function()
				require("nvim-tree.api").tree.toggle()
			end,
			mode = "n",
			desc = "Toggles [N]vim Tree",
			silent = true,
		},
	},
}

spec.config = function()
	local icons = require("config.icons")
	require("nvim-tree").setup({
		view = {
			adaptive_size = true,
		},
		renderer = {
			indent_markers = { enable = true },
			highlight_git = true,
			special_files = {},
			icons = {
				git_placement = "after", -- before or after
				show = {
					file = true,
					folder = true,
					folder_arrow = false,
					git = false,
				},
				glyphs = {

					default = icons.circle_empty,
					symlink = icons.circle_empty,
					folder = {
						default = icons.circle_empty,
						open = icons.circle_filled,
						empty = icons.circle_empty,
						empty_open = icons.circle_filled,
						symlink = icons.circle_empty,
						symlink_open = icons.circle_filled,
					},
					git = {
						ignored = "",
						unstaged = "!",
						staged = "+",
						unmerged = "↹",
						-- unmerged = "",
						renamed = "»",
						untracked = "?",
						deleted = "✗",
					},
				},
			},
		},
		filters = {
			custom = { "^.git$", "^node_modules$" },
		},
		update_cwd = true,
		update_focused_file = {
			enable = true,
			update_root = false,
		},
		diagnostics = {
			enable = false,
			show_on_dirs = true,
			show_on_open_dirs = true,
			severity = {
				min = vim.diagnostic.severity.WARN,
				max = vim.diagnostic.severity.ERROR,
			},
			icons = {
				-- hint = "",
				-- info = "",
				-- warning = "",
				-- error = "",
			},
		},
		git = {
			ignore = false,
		},
		actions = {
			open_file = {
				quit_on_open = false,
				resize_window = true,
			},
		},
		notify = {
			threshold = vim.log.levels.WARN,
		},
	})
end

return spec
