---@type LazySpec
return {
	"catppuccin/nvim",
	name = "catppuccin",
	priority = 1000,
	lazy = false,
	opts = {
		background = {
			light = "latte",
			dark = "frappe",
		},
		no_italic = false, -- Force no italic
		no_bold = true, -- Force no bold
		integrations = {
			harpoon = true,
			mason = true,
			-- snacks = true,
			-- mini = {
			-- 	enabled = true,
			-- 	indentscope_color = "", -- catppuccin color (eg. `lavender`) Default: text
			-- },
			noice = true,
			telescope = {
				enabled = true,
				-- style = "nvchad",
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
			-- frappe = {
			-- 	rosewater = "#f2d5cf",
			-- 	flamingo = "#eebebe",
			-- 	pink = "#f4b8e4",
			-- 	mauve = "#ca9ee6",
			-- 	red = "#e78284",
			-- 	maroon = "#ea999c",
			-- 	peach = "#ef9f76",
			-- 	yellow = "#e5c890",
			-- 	green = "#a6d189",
			-- 	teal = "#81c8be",
			-- 	sky = "#99d1db",
			-- 	sapphire = "#85c1dc",
			-- 	blue = "#8caaee",
			-- 	lavender = "#babbf1",
			-- 	text = "#c6d0f5",
			-- 	subtext1 = "#b5bfe2",
			-- 	subtext0 = "#a5adce",
			-- 	overlay2 = "#949cbb",
			-- 	overlay1 = "#838ba7",
			-- 	overlay0 = "#737994",
			-- 	surface2 = "#626880",
			-- 	surface1 = "#51576d",
			-- 	surface0 = "#414559",
			-- 	base = "#303446",
			-- 	mantle = "#292c3c",
			-- 	crust = "#232634",
			-- },
			latte = {
				base = "#EFEFEF",
				mantle = "#E8E8E8",
				crust = "#E2E2E2",

				surface0 = "#DADADE",
				surface1 = "#D0D0D4",
				surface2 = "#C6C6CB",

				overlay0 = "#9999A3",
				overlay1 = "#7F7F89",
				overlay2 = "#666670",

				subtext0 = "#4D4D56",
				subtext1 = "#333339",

				text = "#1A1A20",
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
