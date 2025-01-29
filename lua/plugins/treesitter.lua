---@type LazySpec
return {
	"nvim-treesitter/nvim-treesitter",
	event = "BufReadPre",
	build = ":TSUpdate",
	config = function()
		---@diagnostic disable-next-line missing-fields
		require("nvim-treesitter.configs").setup({
			--[[
			sync_install = true,
			ensure_installed = {
				"c",
				"lua",

				"rust",
				"toml",

				"c_sharp",

				"go",
				"gomod",
				"gowork",

				"zig",

				"python",
			},
            --]]
			auto_install = true,

			highlight = { enable = true },
			indent = { enable = true, disable = { "python", "yaml" } },
		})
	end,
}
