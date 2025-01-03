---@type LazySpec
return {
	"stevearc/oil.nvim",
	---@module 'oil'
	---@type oil.SetupOpts
	opts = {},
	cmd = "Oil",
	event = "VimEnter",
	keys = {
		{
			"-",
			function()
				require("oil").open()
			end,
			desc = "Open parent directory using Oil",
		},
		-- {
		-- 	"<C-n>",
		-- 	function()
		-- 		require("oil").toggle_float()
		-- 	end,
		-- 	desc = "Toggle Oil float window",
		-- },
	},

	-- Optional dependencies
	-- dependencies = { { "echasnovski/mini.icons", opts = {} } },
	-- dependencies = { "nvim-tree/nvim-web-devicons" }, -- use if prefer nvim-web-devicons
}
