---@type LazySpec
return {
	"yetone/avante.nvim",
    enabled = false,
	event = "VeryLazy",
	lazy = false,
	-- Set this to "*" to always pull the latest release version,
	-- or set it to false to update to the latest code changes.
	version = false,
	---@module 'avante'
	---@type avante.Config
	opts = {
		provider = "groqllama",
		-- WARNING: high-frequency, and therefore expensive, operation
		auto_suggestions_provider = "copilot",
		behaviour = {
			auto_suggestions = true, -- Experimental stage
			auto_set_highlight_group = true,
			auto_set_keymaps = true,
			auto_apply_diff_after_generation = false,
			support_paste_from_clipboard = false,
			-- Whether to remove unchanged lines when applying a code block
			minimize_diff = true,
		},
		mappings = {
			suggestion = {
				accept = "<Tab>",
				next = "<M-]>",
				prev = "<M-[>",
				dismiss = "<C-]>",
			},
		},
		vendors = {
			groqllama = {
				__inherited_from = "openai",
				api_key_name = "GROQ_API_KEY",
				endpoint = "https://api.groq.com/openai/v1/",
				model = "llama-3.3-70b-versatile",
			},
		},
	},
	-- if you want to build from source then do `make BUILD_FROM_SOURCE=true`
	build = "make",
	dependencies = {
		"stevearc/dressing.nvim",
		"nvim-lua/plenary.nvim",
		"MunifTanjim/nui.nvim",

		--- The below dependencies are optional,
		"nvim-telescope/telescope.nvim", -- for file_selector provider telescope
		-- "hrsh7th/nvim-cmp", -- autocompletion for avante commands and mentions
		-- "nvim-tree/nvim-web-devicons", -- or echasnovski/mini.icons
		"zbirenbaum/copilot.lua", -- for providers='copilot'
		{
			-- Make sure to set this up properly if you have lazy=true
			"MeanderingProgrammer/render-markdown.nvim",
			---@module 'render-markdown'
			---@type render.md.UserConfig
			opts = {
				file_types = { "Avante" },
			},
			ft = { "Avante" },
		},
	},
}
