local lightbulb = require("nvim-lightbulb")

local lightbulb_sign = "⚡"

local old_update_lightbulb = lightbulb.update_lightbulb
lightbulb.update_lightbulb = function()
	return old_update_lightbulb({
		sign = {
			enabled = false,
			priority = 10,
		},
		float = {
			enabled = false,
			text = lightbulb_sign,
			win_opts = {},
		},
		virtual_text = {
			enabled = false,
			text = lightbulb_sign,
		},
		status_text = {
			enabled = true,
			text = lightbulb_sign,
			text_unavailable = "",
		},
	})
end

vim.fn.sign_define("LightBulbSign", { text = lightbulb_sign, texthl = "DiagnosticSignHint" })
vim.cmd([[autocmd CursorHold,CursorHoldI * lua require'nvim-lightbulb'.update_lightbulb()]])
