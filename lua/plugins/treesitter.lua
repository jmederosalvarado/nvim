---@type LazySpec
return {
	"nvim-treesitter/nvim-treesitter",
	event = "BufReadPre",
	build = ":TSUpdate",
	config = function()
        ---@diagnostic disable-next-line missing-fields
		require("nvim-treesitter.configs").setup({
			highlight = { enable = true },
			indent = { enable = true, disable = { "python", "yaml" } },
			-- matchup = { enable = true },
		})
	end,
}
