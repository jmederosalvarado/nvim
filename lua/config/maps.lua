vim.keymap.set({ "v", "n" }, "<leader>y", '"+y', { silent = true })

vim.keymap.set({ "v", "n" }, "<leader>d", '"_d', { silent = true })
vim.keymap.set({ "x" }, "p", "P", { silent = true })

-- Diagnostic keymaps
vim.keymap.set("n", "[d", vim.diagnostic.goto_prev)
vim.keymap.set("n", "]d", vim.diagnostic.goto_next)
vim.keymap.set("n", "<leader>e", vim.diagnostic.open_float)
