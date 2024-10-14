vim.keymap.set({ "v", "n" }, "<leader>y", '"+y', { silent = true })

vim.keymap.set({ "v", "n" }, "<leader>d", '"_d', { silent = true })
vim.keymap.set({ "x" }, "p", "P", { silent = true })

vim.keymap.set("n", "<C-d>", "5jzz", { silent = true })
vim.keymap.set("n", "<C-u>", "5kzz", { silent = true })

-- Diagnostic keymaps
vim.keymap.set("n", "[d", function()
	vim.diagnostic.jump({
		count = -1,
		_highest = true,
		-- severity = {
		-- 	min = vim.diagnostic.severity.WARN,
		-- },
	})
end)
vim.keymap.set("n", "]d", function()
	vim.diagnostic.jump({
		count = 1,
		_highest = true,
		-- severity = {
		-- 	min = vim.diagnostic.severity.WARN,
		-- },
	})
end)
vim.keymap.set("n", "<leader>e", vim.diagnostic.open_float)
