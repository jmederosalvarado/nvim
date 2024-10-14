-- Diagnostics {{{

local icons = require("config.icons")

vim.diagnostic.config({
	virtual_text = {
		spacing = 4,
		prefix = icons.circle_filled,
		source = "if_many",
		severity = {
			min = vim.diagnostic.severity.INFO,
		},
	},
    signs = {
        numhl = {
            [vim.diagnostic.severity.ERROR] = "DiagnosticSignError",
            [vim.diagnostic.severity.WARN] = "DiagnosticSignWarn",
            [vim.diagnostic.severity.INFO] = "DiagnosticNumInfo",
            [vim.diagnostic.severity.HINT] = "DiagnosticNumHint",
        },
        text = {
            [vim.diagnostic.severity.ERROR] = "",
            [vim.diagnostic.severity.WARN] = "",
            [vim.diagnostic.severity.INFO] = "",
            [vim.diagnostic.severity.HINT] = "",
        },
        severity = {
            min = vim.diagnostic.severity.INFO,
        }
    },
	severity_sort = true,
	update_in_insert = true,
	underline = false,
	float = { border = "solid" },
})

-- }}}

vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
	border = "solid",
})
vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, {
	border = "solid",
})
