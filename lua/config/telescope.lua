local nnoremap = vim.keymap.nnoremap


require("telescope").setup({
	defaults = {
		prompt_prefix = "# ",
		selection_caret = "❯ ",
	},
})

nnoremap({ "<leader>ff", "<cmd>lua require('telescope.builtin').find_files()<cr>" })
nnoremap({ "<leader>fg", "<cmd>lua require('telescope.builtin').live_grep()<cr>" })
nnoremap({ "<leader>fb", "<cmd>lua require('telescope.builtin').buffers()<cr>" })

nnoremap({ "<leader>fq", "<cmd>lua require('telescope.builtin').quickfix()<cr>" })
nnoremap({ "<leader>fl", "<cmd>lua require('telescope.builtin').loclist()<cr>" })

vim.cmd("command! TeleMan lua require('telescope.builtin').man_pages()")
vim.cmd("command! TeleHelp lua require('telescope.builtin').help_tags()")

-- harpoon setup
nnoremap({ "<leader>aa", "<cmd>lua require('harpoon.mark').add_file()<CR>" })
nnoremap({ "<leader>at", "<cmd>lua require('harpoon.ui').toggle_quick_menu()<CR>" })
nnoremap({ "<leader>ah", "<cmd>lua require('harpoon.ui').nav_file(1)<CR>" })
nnoremap({ "<leader>aj", "<cmd>lua require('harpoon.ui').nav_file(2)<CR>" })
nnoremap({ "<leader>ak", "<cmd>lua require('harpoon.ui').nav_file(3)<CR>" })
nnoremap({ "<leader>al", "<cmd>lua require('harpoon.ui').nav_file(4)<CR>" })

require("telescope").load_extension('fzf')
-- require("telescope").load_extension("harpoon")

-- nnoremap({ "<leader>fa", "<cmd>lua require('telescope').extensions.harpoon.marks({})<CR>" })
