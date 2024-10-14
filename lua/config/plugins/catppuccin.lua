---@type LazySpec
return {
	"catppuccin/nvim",
	name = "catppuccin",
	enabled = vim.g.colorscheme == "catppuccin",
	priority = 100,
	lazy = false,
	opts = {
		flavour = "frappe",
		background = {
			light = "latte",
			dark = "frappe",
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
				rosewater = "#EA6962",
				flamingo = "#EA6962",
				pink = "#D3869B",
				mauve = "#D3869B",
				red = "#EA6962",
				maroon = "#EA6962",
				peach = "#BD6F3E",
				yellow = "#D8A657",
				green = "#A9B665",
				teal = "#89B482",
				sky = "#89B482",
				sapphire = "#89B482",
				blue = "#7DAEA3",
				lavender = "#7DAEA3",
				text = "#D4BE98",
				subtext1 = "#BDAE8B",
				subtext0 = "#A69372",
				overlay2 = "#8C7A58",
				overlay1 = "#735F3F",
				overlay0 = "#958272",
				surface2 = "#4B4F51",
				surface1 = "#2A2D2E",
				surface0 = "#232728",
				base = "#1D2021",
				mantle = "#191C1D",
				crust = "#151819",
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
