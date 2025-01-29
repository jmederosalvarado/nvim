---@type LazySpec
return {
	"Saghen/blink.cmp",
	enabled = true,
	lazy = false, -- lazy loading handled internally
	version = "*", -- use a release tag to download pre-built binaries

	dependencies = {
		-- optional: provides snippets for the snippet source
		"rafamadriz/friendly-snippets",

		-- add blink.compat
		{
			"saghen/blink.compat",
			-- use the latest release, via version = '*', if you also use the latest release for blink.cmp
			version = "*",
			-- lazy.nvim will automatically load the plugin when it's required by blink.cmp
			lazy = true,
			-- make sure to set opts so that lazy.nvim calls blink.compat's setup
			opts = {},
		},
	},

	---@module 'blink.cmp'
	---@type blink.cmp.Config
	opts = {
		-- default list of enabled providers defined so that you can extend it
		-- elsewhere in your config, without redefining it, via `opts_extend`
		sources = {
			default = function()
				if vim.bo.filetype == "lua" then
					return { "lazydev", "lsp", "path", "snippets", "buffer" }
				end

				if vim.bo.filetype == "AvanteInput" then
					return { "avante_commands", "avante_files", "avante_mentions" }
				end

				return { "lsp", "path", "snippets", "buffer" }
			end,

			providers = {
				lazydev = {
					name = "LazyDev",
					module = "lazydev.integrations.blink",
					-- make lazydev completions top priority (see `:h blink.cmp`)
					score_offset = 100,
				},
				avante_commands = {
					name = "avante_commands",
					module = "blink.compat.source",
					score_offset = 90, -- show at a higher priority than lsp
					opts = {},
				},
				avante_files = {
					name = "avante_files",
					module = "blink.compat.source",
					score_offset = 100, -- show at a higher priority than lsp
					opts = {},
				},
				avante_mentions = {
					name = "avante_mentions",
					module = "blink.compat.source",
					score_offset = 1000, -- show at a higher priority than lsp
					opts = {},
				},
			},

			-- Disable cmdline completions
			cmdline = {},
		},

		-- Experimental signature help support
		signature = { enabled = true },
	},
}
