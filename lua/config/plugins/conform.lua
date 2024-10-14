---@type LazySpec
local spec = { "stevearc/conform.nvim" }

spec.opts = {
	formatters_by_ft = {
		lua = { "stylua" },
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
			vim.fn.getpos("'<")
			require("conform").format()
		end,
		mode = "",
		desc = "Format buffer",
	},
}

return spec
