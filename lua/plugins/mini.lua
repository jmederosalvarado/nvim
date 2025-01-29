local mini = {}

mini["ai"] = {
	enabled = true,
}

mini["statusline"] = {
	enabled = true,
}

mini["surround"] = {
	enabled = false,
}

mini["bracketed"] = {
	enabled = true,
}

mini["comment"] = {
	enabled = false,
}

mini["diff"] = {
	enabled = true,
	opts = {
		view = {
			style = "sign",
		},
	},
}

mini["icons"] = {
	enabled = false,
}

---@type LazySpec
return {
	"echasnovski/mini.nvim",
	lazy = false,
	config = function()
		for mod, plugin in pairs(mini) do
			if not plugin.enabled then
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
