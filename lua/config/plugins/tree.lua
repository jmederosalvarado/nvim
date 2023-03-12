local spec = {
	"nvim-tree/nvim-tree.lua",
}

spec.init = function()
	vim.keymap.set("n", "<C-n>", function()
		require("nvim-tree").toggle()
	end, { desc = "Toggles [N]vim Tree", silent = true })
end

spec.config = {
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
				folder = false,
				folder_arrow = true,
				git = true,
			},
			glyphs = {
				git = {
					ignored = "",
					unstaged = "!",
					staged = "+",
					unmerged = "",
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
			hint = "",
			info = "",
			warning = "",
			error = "",
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
}

return spec
