---@diagnostic disable: missing-fields
require("bqf").setup({
  func_map = {
    fzffilter = "",
  },
  preview = {
    auto_preview = false,

    border = vim.o.winborder,
    -- winblend = vim.o.winblend,
  },
})

local function set_bqf_hl()
  -- vim.api.nvim_set_hl(0, "BqfPreviewTitle", { link = "FloatBorder" }) -- defaults to Title
  -- vim.api.nvim_set_hl(0, "BqfPreviewFloat", { link = "NormalFloat" }) -- defaults to Normal
  vim.api.nvim_set_hl(0, "BqfPreviewBorder", { link = "BqfPreviewFloat" }) -- defaults to FloatBorder
end

set_bqf_hl()
vim.api.nvim_create_autocmd("ColorScheme", {
  group = vim.api.nvim_create_augroup("bqf_hl", { clear = true }),
  desc = "Customize nvim-bqf highlights.",
  callback = set_bqf_hl,
})
