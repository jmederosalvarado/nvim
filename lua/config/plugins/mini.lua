local mini = {}

mini["ai"] = {
	enabled = true,
}

mini["surround"] = {
	enabled = true,
}

mini["bracketed"] = {
	enabled = true,
}

mini["comment"] = {
	enabled = true,
}

mini["diff"] = {
	enabled = true,
}

mini["hues"] = {
	enabled = true,
	opts = {
		background = "#351721",
		foreground = "#cdc4c6",
	},
}

mini["icons"] = {
	enabled = true,
	opts = {
		background = "#351721",
		foreground = "#cdc4c6",
	},
}

return {
	"echasnovski/mini.nvim",
	enabled = true,
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
