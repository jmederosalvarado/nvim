return {
	"folke/snacks.nvim",
	priority = 1000,
	lazy = false,
	---@type snacks.Config
	opts = {
		bigfile = { enabled = true },
		quickfile = { enabled = true },
		notifier = { enabled = true },
		statuscolumn = { enabled = true },
		words = { enabled = true },
	},
    keys = {
        -- {
        --     "<C-;>",
        --     function ()
        --         require("snacks").terminal.toggle()
        --     end
        -- }
    }
}
