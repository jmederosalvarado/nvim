return {
	{
		"nvim-treesitter/nvim-treesitter",
		event = "BufReadPre",
		build = function()
			require("nvim-treesitter.install").update({ with_sync = true })
		end,
		config = function()
			require("nvim-treesitter.configs").setup({
				auto_install = false,

				highlight = { enable = true },
				incremental_selection = { enable = false },
				indent = { enable = true, disable = { "python", "yaml" } },
				matchup = { enable = true },
			})
		end,
	},

	{
		"nvim-treesitter/nvim-treesitter-context",
		dependencies = { "nvim-treesitter/nvim-treesitter" },
		event = "BufReadPost",
		config = true,
	},
}
