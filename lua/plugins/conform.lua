---@type LazySpec
local spec = {
	"stevearc/conform.nvim",
	cmd = "ConformInfo",
}

---@module 'conform'
---@type conform.setupOpts
spec.opts = {
	formatters_by_ft = {
		lua = { "stylua" },
		zig = { "zigfmt" },
	},
	formatters = {
		shfmt = {
			prepend_args = { "-i", "2" },
		},
	},
}

spec.init = function()
	-- If you want the formatexpr, here is the place to set it
	vim.o.formatexpr = "v:lua.require'conform'.formatexpr()"
end

spec.keys = {
	{
		"<leader>fm",
		function()
			require("conform").format({ async = true })
		end,
		desc = "Format buffer",
	},
}

return spec
