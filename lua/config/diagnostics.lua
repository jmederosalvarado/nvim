---@type vim.diagnostic.Opts.VirtualText
local virtual_text_config = {
  spacing = 4,
  prefix = "*",
  source = "if_many",
  severity = {
    min = vim.diagnostic.severity.INFO,
  },
}

---@type vim.diagnostic.Opts.VirtualLines
local virtual_lines_config = {
  current_line = false,
  -- severity = {
  --   min = vim.diagnostic.severity.INFO,
  -- },
}

vim.diagnostic.config({
  virtual_lines = false,
  virtual_text = virtual_text_config,
  signs = {
    text = {
      [vim.diagnostic.severity.ERROR] = "🅔",
      [vim.diagnostic.severity.WARN] = "🅦",
      [vim.diagnostic.severity.INFO] = "🅘",
      [vim.diagnostic.severity.HINT] = "🅗",
    },
  },
  -- severity_sort = true,
})

-- Alternate between showing virtual lines and virtual text
vim.keymap.set("n", "<Leader>e", function()
  if vim.diagnostic.config().virtual_lines then
    vim.diagnostic.config({
      virtual_lines = false,
      virtual_text = virtual_text_config,
    })
  else
    vim.diagnostic.config({
      virtual_lines = virtual_lines_config,
      virtual_text = false,
    })
  end
end, { desc = "Toggle diagnostic virtual_lines" })

-- Open quickfix list with diagnostics
vim.keymap.set("n", "<Leader>q", function()
  local errs = {
    min = vim.diagnostic.severity.WARN,
  }
  local infos = {
    max = vim.diagnostic.severity.INFO,
  }
  local severity = errs
  if vim.diagnostic.count(nil, { severity = severity }) == 0 then
    severity = infos
  end
  vim.diagnostic.setqflist({
    severity = severity,
  })
end, { desc = "Open diagnostic [Q]uickfix list" })
