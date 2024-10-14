local fidget = {
	"j-hui/fidget.nvim",
	lazy = false,
	priority = 99,
	opts = {
		-- Options related to notification subsystem
		notification = {
			override_vim_notify = true, -- Automatically override vim.notify() with Fidget
		},
	},
}

local notify = {
	"rcarriga/nvim-notify",
	lazy = false,
	priority = 99,
	config = function()
		vim.notify = require("notify")
	end,
}

return notify
