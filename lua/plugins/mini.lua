local mini = {
	-- Text Editing
	ai = {},
    align = {},
	-- pairs = {},
	surround = {},

	-- General

	bracketed = {},
	git = {},
	diff = {
		opts = {
			view = {
				style = "sign",
			},
		},
	},
	sessions = {
		opts = {
			autoread = true,
		},
	},

	-- Appearance

	notify = {},
	statusline = {
		opts = {
			content = {
				active = function()
					local mode, mode_hl = MiniStatusline.section_mode({ trunc_width = 120 })
					local git = MiniStatusline.section_git({ trunc_width = 40 })
					local diff = MiniStatusline.section_diff({ trunc_width = 75 })
					local diagnostics = MiniStatusline.section_diagnostics({ trunc_width = 75 })
					local lsp = MiniStatusline.section_lsp({ trunc_width = 75 })
					local filename = MiniStatusline.section_filename({ trunc_width = 140 })
					local fileinfo = MiniStatusline.section_fileinfo({ trunc_width = 120 })
					local location = MiniStatusline.section_location({ trunc_width = 75 })
					local search = MiniStatusline.section_searchcount({ trunc_width = 75 })

					return MiniStatusline.combine_groups({
						{ hl = mode_hl, strings = { mode } },
						{ hl = "MiniStatuslineDevinfo", strings = { git } },
						"%<", -- Mark general truncate point
						{ hl = "MiniStatuslineFilename", strings = { filename } },
						"%=", -- End left alignment
						-- { hl = "MiniStatuslineFileinfo", strings = { fileinfo } },
						{ hl = mode_hl, strings = { search, location } },
					})
				end,
			},
		},
	},
	icons = {},
	-- base16 = { config = false },
}

---@type LazySpec
return {
	"echasnovski/mini.nvim",
	lazy = false,
	config = function()
		for mod, plugin in pairs(mini) do
			if plugin.enabled == false or (type(plugin.config) == "boolean" and not plugin.config) then
				goto continue
			end

			if type(plugin.config) == "function" then
				plugin.config()
			elseif type(plugin.opts) == "table" then
				require("mini." .. mod).setup(plugin.opts)
			else
				require("mini." .. mod).setup({})
			end

			::continue::
		end
	end,
}
