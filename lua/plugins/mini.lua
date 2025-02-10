local mini = {
	-- Text Editing
	["ai"] = {},
	["pairs"] = {},
	["surround"] = {},

	-- General

	["bracketed"] = {},
	["diff"] = {
		opts = {
			view = {
				style = "sign",
			},
		},
	},

	-- Appearance

	["statusline"] = {},
	["icons"] = {
		enabled = false,
	},
}

---@type LazySpec
return {
	"echasnovski/mini.nvim",
	lazy = false,
	config = function()
		for mod, plugin in pairs(mini) do
			if plugin.enabled == false then
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
