return {
	"TimUntersberger/neogit",
	enable = false,
	cmd = "Neogit",
	init = function()
		vim.keymap.set("n", "<leader>gg", function()
			require("neogit").open()
		end, { desc = "Neo[G]it" })
	end,
	config = {
		kind = "split",
		signs = {
			-- { CLOSED, OPENED }
			section = { "", "" },
			item = { "", "" },
			hunk = { "", "" },
		},
		integrations = { diffview = true },
	},
}
