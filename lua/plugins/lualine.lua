---@type LazySpec
return {
	"nvim-lualine/lualine.nvim",
	lazy = false,
    enabled = false,
	config = function()
		local lualine = require("lualine")

		local tabs = {
			"tabs",

			max_length = vim.o.columns / 3, -- Maximum width of tabs component.
			-- Note:
			-- It can also be a function that returns
			-- the value of `max_length` dynamically.

			mode = 0,
			-- 0: Shows tab_nr
			-- 1: Shows tab_name
			-- 2: Shows tab_nr + tab_name
		}

        local opts = {
			options = {
				section_separators = { left = "", right = "" },
				component_separators = { left = "|", right = "|" },
				globalstatus = false,
				always_show_tabline = false,
				disabled_filetypes = { "AvanteInput", "Avante" },
			},
			sections = {
				lualine_a = { "mode" },
				lualine_b = { "filename" },
				lualine_c = { "diagnostics" },
				lualine_x = {
					-- {
					-- 	require("noice").api.status.mode.get,
					-- 	cond = require("noice").api.status.mode.has,
					-- },
					-- {
					-- 	require("noice").api.status.search.get,
					-- 	cond = require("noice").api.status.search.has,
					-- },
				},

				lualine_y = { "branch" },
				lualine_z = { "location" },
			},
			inactive_sections = {
				lualine_a = { "filename" },
				lualine_b = {},
				lualine_c = {},
				lualine_x = {},
				lualine_y = {},
				lualine_z = {},
			},
			tabline = {
				lualine_a = {},
				lualine_b = { tabs },
				lualine_c = {},
				lualine_x = {},
				lualine_y = {},
				lualine_z = {},
			},
			extensions = {
				"fugitive",
				"quickfix",
				"nvim-tree",
				"oil",
				"mason",
				"lazy",
			},
		}

		lualine.setup(opts)
	end,
}
