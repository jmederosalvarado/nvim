-- Use absolute line numbers during insert mode only
vim.api.nvim_create_autocmd({ "InsertEnter", "InsertLeave" }, {
	desc = "Display absolute line number in Insert mode",
	callback = function(opts)
		if vim.wo.number then
			vim.wo.relativenumber = opts.event == "InsertLeave"
		end
	end,
})

-- Use absolute numbers on unfocused windows
vim.api.nvim_create_autocmd({ "WinLeave", "WinEnter" }, {
	desc = "Display absolute line number on inactive windows",
	callback = function(opts)
		if vim.wo.number then
			vim.wo.relativenumber = opts.event == "WinEnter"
		end
	end,
})

-- Don't show any numbers inside terminals
vim.api.nvim_create_autocmd("TermOpen", {
	desc = "Display absolute line number on inactive windows",
	callback = function()
		vim.wo.number = false
		vim.wo.relativenumber = false
	end,
})

-- Filetype specific indenting
vim.api.nvim_create_autocmd("FileType", {
	desc = "Change identing on certain filetypes",
	pattern = { "python", "markdown", "Avante", "AvanteInput" },
    group = vim.api.nvim_create_augroup('ftident', { clear = true }),
	callback = function()
		vim.notify("detected filetype")
		vim.bo.tabstop = 4
		vim.bo.shiftwidth = 4
		vim.bo.softtabstop = 4
	end,
})

-- Set jsonc filetype for json files
vim.api.nvim_create_autocmd({ "BufNewFile", "BufRead" }, {
	desc = "Set jsonc filetype for json files",
	pattern = { "*.json" },
	callback = function()
		vim.bo.filetype = "jsonc"
	end,
})

-- Highlight on yank
vim.api.nvim_create_autocmd("TextYankPost", {
	callback = function()
		vim.highlight.on_yank({ on_visual = false })
	end,
})
