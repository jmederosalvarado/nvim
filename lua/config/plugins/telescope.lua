local spec = {
	"nvim-telescope/telescope.nvim",
	cmd = "Telescope",
	dependencies = {
		-- extensions
		{ "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
	},
}

spec.init = function()
	local telescope_builtin = require("lazy-require").require_on_exported_call("telescope.builtin")

	vim.keymap.set("n", "<leader>f", telescope_builtin.builtin, { desc = "[F]ind builtin functionality" })
	vim.keymap.set("n", "<leader><space>", telescope_builtin.buffers, { desc = "[ ] Find existing buffers" })
	vim.keymap.set("n", "<leader>/", function()
		-- You can pass additional configuration to telescope to change theme, layout, etc.
		telescope_builtin.current_buffer_fuzzy_find(require("telescope.themes").get_dropdown({
			winblend = 10,
			previewer = false,
		}))
	end, { desc = "[/] Fuzzily search in current buffer]" })
	vim.keymap.set("n", "<leader>ff", telescope_builtin.find_files, { desc = "[F]ind [F]iles" })
	vim.keymap.set("n", "<leader>fw", telescope_builtin.live_grep, { desc = "[F]ind by [W]ords" })
	vim.keymap.set("n", "<leader>fd", function()
		vim.ui.select({ "ERROR", "WARN", "INFO", "HINT" }, {
			prompt = "Select diagnostic severity:",
		}, function(choice)
			if choice ~= nil then
				telescope_builtin.diagnostics({ severity = vim.diagnostic.severity[choice] })
			end
		end)
	end, { desc = "[F]ind [D]iagnostics" })
	vim.keymap.set("n", "<leader>fo", telescope_builtin.oldfiles, { desc = "[F]ind recently [O]pened files" })
	vim.keymap.set("n", "<leader>f?", telescope_builtin.help_tags, { desc = "[F]ind [?]help" })

	vim.api.nvim_create_user_command("Help", function(_)
		telescope_builtin.help_tags()
	end, { desc = "Search help tags" })
end

spec.config = function()
	local telescope = require("telescope")

	telescope.setup({
		defaults = {
			prompt_prefix = "   ",
			selection_caret = "❯ ",
		},
	})

	telescope.load_extension("fzf")
end

return spec
