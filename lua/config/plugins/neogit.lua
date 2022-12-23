local M = {
	"TimUntersberger/neogit",
    enable = false,
	cmd = "Neogit",
}

M.init = function()
	vim.keymap.set("n", "<leader>gg", function()
		require("neogit").open()
	end, { desc = "Neo[G]it" })
end

M.config = {
	kind = "split",
	signs = {
		-- { CLOSED, OPENED }
		section = { "", "" },
		item = { "", "" },
		hunk = { "", "" },
	},
	integrations = { diffview = true },
}

return M
