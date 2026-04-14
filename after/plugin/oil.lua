vim.keymap.set("n", "-", "<Cmd>Oil<CR>", { desc = "Open parent directory using Oil" })

vim.keymap.set("n", "<Leader>-", function()
  require("oil").open(vim.fn.getcwd())
end, { desc = "Open current working directory using Oil" })

require("oil").setup({})
