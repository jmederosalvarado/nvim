---@type LazySpec
local spec = {
	"nvim-telescope/telescope.nvim",
	cmd = "Telescope",
	dependencies = {
		"nvim-lua/plenary.nvim",

		-- extensions
		{ "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
	},
}

local telescope_builtin = setmetatable({}, {
	__index = function(_, k)
		return function(...)
			return require("telescope.builtin")[k](...)
		end
	end,
})

spec.keys = {
	{ "<leader>f", telescope_builtin.builtin, desc = "[F]ind builtin functionality" },
	{ "<leader><space>", telescope_builtin.buffers, desc = "[ ] Find existing buffers" },
	{
		"<leader>/",
		function()
			-- You can pass additional configuration to telescope to change theme, layout, etc.
			require("telescope.builtin").current_buffer_fuzzy_find(require("telescope.themes").get_dropdown({
				winblend = 10,
				previewer = false,
			}))
		end,
		desc = "[/] Fuzzily search in current buffer]",
	},
	{ "<leader>ff", telescope_builtin.find_files, desc = "[F]ind [F]iles" },
	{ "<leader>fw", telescope_builtin.live_grep, desc = "[F]ind by [W]ords" },
	{
		"<leader>fd",
		function()
			vim.ui.select({ "ERROR", "WARN", "INFO", "HINT" }, {
				prompt = "Select diagnostic severity:",
			}, function(choice)
				if choice ~= nil then
					require("telescope.builting").diagnostics({ severity = vim.diagnostic.severity[choice] })
				end
			end)
		end,
		desc = "[F]ind [D]iagnostics",
	},
	{ "<leader>fo", telescope_builtin.oldfiles, desc = "[F]ind recently [O]pened files" },
	{ "<leader>f?", telescope_builtin.help_tags, desc = "[F]ind [?]help" },
}

spec.init = function()
	vim.api.nvim_create_user_command("Help", function(_)
		telescope_builtin.help_tags()
	end, { desc = "Search help tags" })

	vim.lsp.buf.references = telescope_builtin.lsp_references
	vim.lsp.buf.implementation = telescope_builtin.lsp_implementation
end

spec.opts = {
	defaults = {
		prompt_prefix = "? ",
		selection_caret = "❯ ",
	},
	pickers = {
		find_files = {
			layout_strategy = "vertical",
			layout_config = {
				mirror = true,
			},
		},
	},
	extensions = {
		fzf = {},
	},
}

return spec
