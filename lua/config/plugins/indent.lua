return {
	"lukas-reineke/indent-blankline.nvim",
	event = "BufReadPre",
	main = "ibl",
	config = true,
	opts = {
		indent = {
			char = "┊",
			tab_char = "┊",
		},
	},
}
