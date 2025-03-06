---@type LazySpec
return {
	"catppuccin/nvim",
	name = "catppuccin",
	enabled = true,
	priority = 100,
	lazy = false,
	opts = {
		flavour = "frappe",
		background = {
			light = "latte",
			dark = "mocha",
		},
		transparent_background = false,
		show_end_of_buffer = false,
		term_colors = true,
		compile = {
			enabled = false,
			path = vim.fn.stdpath("cache") .. "/catppuccin",
		},
		dim_inactive = {
			enabled = false,
			shade = "dark",
			percentage = 0.15,
		},
		no_italic = false, -- Force no italic
		no_bold = false, -- Force no bold
		styles = {
			comments = { "italic" },
			conditionals = {},
			loops = {},
			functions = {},
			keywords = {},
			strings = {},
			variables = {},
			numbers = {},
			booleans = {},
			properties = {},
			types = {},
			operators = {},
		},
		integrations = {
			treesitter = true,
			treesitter_context = true,
			cmp = true,
			gitsigns = true,
			telescope = {
				enabled = true,
				-- style = "nvchad"
			},
			mason = true,
			nvimtree = true,
			markdown = true,
			notify = true,
			neogit = true,
			lightspeed = true,
			lsp_trouble = true,
			indent_blankline = {
				enabled = true,
				colored_indent_levels = false,
			},
			native_lsp = {
				enabled = true,
				virtual_text = {
					errors = {},
					hints = {},
					warnings = {},
					information = {},
				},
				underlines = {
					errors = { "underline" },
					hints = { "underline" },
					warnings = { "underline" },
					information = { "underline" },
				},
			},
		},
		color_overrides = {
			mocha = {
				base = "#1e1e21",
				mantle = "#1a1a1d",
				crust = "#16161a",

				surface0 = "#24242B",
				surface1 = "#373745",
				surface2 = "#4A4A4B",

				overlay0 = "#5E5E6E",
				overlay1 = "#707080",
				overlay2 = "#8383a3",

				subtext0 = "#9595a6",
				subtext1 = "#A9A9c9",

				text = "#D2D2e2",
			},
			frappe = {
				base = "#26262a",
				mantle = "#222226",
				crust = "#1E1E22",

				surface0 = "#36363B",
				surface1 = "#46464D",
				surface2 = "#5E5E67",

				overlay0 = "#6E6E79",
				overlay1 = "#80808D",
				overlay2 = "#9393a3",

				subtext0 = "#A6A6b7",
				subtext1 = "#B9B9cc",

				text = "#D2D2e8",
			},
		},
		custom_highlights = function(colors)
			return {
				DiagnosticSignError = { style = { "reverse" } },
				TreesitterContextBottom = { style = {} },
			}
		end,
	},
	config = function(self, opts)
		require("catppuccin").setup(opts)
		vim.cmd.colorscheme("catppuccin")
	end,
}
