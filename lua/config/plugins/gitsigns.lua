return {
	"lewis6991/gitsigns.nvim",
	event = "BufReadPre",
	config = {
		preview_config = {
			border = "solid",
		},
		current_line_blame = true,
		on_attach = function(bufnr)
			local gs = require("gitsigns")

			local function map(mode, l, r, opts)
				opts = opts or {}
				if type(opts) == "string" then
					opts = { desc = opts }
				end
				opts.buffer = bufnr
				vim.keymap.set(mode, l, r, opts)
			end

			map("n", "]h", function()
				if vim.wo.diff then
					return "]h"
				end
				vim.schedule(gs.next_hunk)
				return "<Ignore>"
			end, { expr = true, desc = "Next Hunk" })

			map("n", "[h", function()
				if vim.wo.diff then
					return "[h"
				end
				vim.schedule(gs.prev_hunk)
				return "<Ignore>"
			end, { expr = true, desc = "Prev Hunk" })

			map({ "n", "v" }, "<leader>hs", gs.stage_hunk, "[S]tage Hunk")
			map({ "n", "v" }, "<leader>hr", gs.reset_hunk, "[R]eset Hunk")
			map("n", "<leader>hu", gs.undo_stage_hunk, "[U]ndo Stage Hunk")
			map("n", "<leader>hp", gs.preview_hunk, "[P]review Hunk")

			map("n", "<leader>hS", gs.stage_buffer, "[S]tage Buffer")
			map("n", "<leader>hR", gs.reset_buffer, "[R]eset Buffer")

			map("n", "<leader>hb", function()
				gs.blame_line({ full = true })
			end, "[B]lame Line")

			map("n", "<leader>hd", gs.diffthis, "[D]iff This")
			map("n", "<leader>hD", function()
				gs.diffthis("~")
			end, "[D]iff This ~")
		end,
	},
}
