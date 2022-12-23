-- AUTOCMDS {{{

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
	desc = "Display absolute line number on inactive windows",
	pattern = "python",
	callback = function()
		vim.bo.tabstop = 4
		vim.bo.shiftwidth = 4
		vim.bo.softtabstop = 4
	end,
})

-- Highlight on yank
vim.api.nvim_create_autocmd("TextYankPost", {
	callback = function()
		vim.highlight.on_yank({ on_visual = false })
	end,
})

-- }}}

-- APPEARANCE {{{

local function diagnostic_sign_define(name, _)
	local hl = "DiagnosticSign" .. name
	local numhl = "DiagnosticNum" .. name
	vim.fn.sign_define(hl, { text = "", numhl = numhl })
end

diagnostic_sign_define("Error", "")
diagnostic_sign_define("Warn", "")
diagnostic_sign_define("Info", "")
diagnostic_sign_define("Hint", "")

vim.diagnostic.config({
	virtual_text = {
		spacing = 4,
		prefix = "",
		source = "if_many",
		severity = {
			min = vim.diagnostic.severity.INFO,
		},
	},
	severity_sort = true,
	update_in_insert = true,
	underline = false,
	float = { border = "solid" },
})

vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
	border = "solid",
})
vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, {
	border = "solid",
})

-- }}}
