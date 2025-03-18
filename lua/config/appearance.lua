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
      [vim.diagnostic.severity.INFO] = "DiagnosticSignInfo",
      [vim.diagnostic.severity.HINT] = "DiagnosticSignHint",
    },
    text = {
      [vim.diagnostic.severity.ERROR] = "",
      [vim.diagnostic.severity.WARN] = "",
      [vim.diagnostic.severity.INFO] = "",
      [vim.diagnostic.severity.HINT] = "",
    },
    severity = {
      min = vim.diagnostic.severity.INFO,
    },
  },
  severity_sort = true,
  update_in_insert = true,
  underline = false,
  float = { border = "solid" },
})
