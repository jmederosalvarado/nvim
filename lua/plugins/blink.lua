---@type LazySpec
return {
	"Saghen/blink.cmp",
	enabled = true,
	lazy = false, -- lazy loading handled internally
	-- optional: provides snippets for the snippet source
	dependencies = "rafamadriz/friendly-snippets",

	-- use a release tag to download pre-built binaries
	version = "*",

	---@module 'blink.cmp'
	---@type blink.cmp.Config
	opts = {
		-- 'default' for mappings similar to built-in completion
		-- 'super-tab' for mappings similar to vscode (tab to accept, arrow keys to navigate)
		-- 'enter' for mappings similar to 'super-tab' but with 'enter' to accept
		-- See the full "keymap" documentation for information on defining your own keymap.
		keymap = { preset = "default" },

		appearance = {
			-- Sets the fallback highlight groups to nvim-cmp's highlight groups
			-- Useful for when your theme doesn't support blink.cmp
			-- Will be removed in a future release
			use_nvim_cmp_as_default = true,
			-- Set to 'mono' for 'Nerd Font Mono' or 'normal' for 'Nerd Font'
			-- Adjusts spacing to ensure icons are aligned
			nerd_font_variant = "mono",
		},

		-- default list of enabled providers defined so that you can extend it
		-- elsewhere in your config, without redefining it, via `opts_extend`
		sources = {
			default = function()
				if vim.bo.filetype == "lua" then
					return { "lazydev", "lsp", "path", "snippets", "buffer" }
				end

				return { "lsp", "path", "snippets", "buffer" }
			end,

			providers = {
				lazydev = {
					name = "LazyDev",
					module = "lazydev.integrations.blink",
					fallbacks = { "lsp" },
				},
			},
		},
	},
}
