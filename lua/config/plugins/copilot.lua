---@type LazySpec
return {
	"zbirenbaum/copilot.lua",
	event = "InsertEnter",
    enabled = false,
	opts = {
		panel = {
			enabled = true,
			auto_refresh = true,
			keymap = {
				jump_prev = "[[",
				jump_next = "]]",
				accept = "<CR>",
				refresh = "gr",
				open = "<M-CR>",
			},
		},
		suggestion = {
			enabled = true,
			auto_trigger = true,
			debounce = 75,
			keymap = {
				accept = "<Tab>",
				accept_word = false,
				accept_line = false,
				next = "<M-]>",
				prev = "<M-[>",
				dismiss = "<C-]>",
			},
		},
		filetypes = {
			["*"] = true,
		},
		copilot_node_command = "node", -- Node.js version must be > 16.x
		server_opts_overrides = {},
	},
}
