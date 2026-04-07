local installed = require("nvim-treesitter").get_installed() or {}
if #installed == 0 then
  return
end

require("treesitter-context").setup({
  multiwindow = true,
})

vim.api.nvim_create_autocmd("FileType", {
  group = vim.api.nvim_create_augroup("tssetup", { clear = true }),
  desc = "Enable Treesitter features when a parser is installed",
  pattern = installed,
  callback = function()
    -- syntax highlighting, provided by Neovim
    vim.treesitter.start()
    -- folds, provided by Neovim
    vim.wo.foldexpr = "v:lua.vim.treesitter.foldexpr()"
    vim.wo.foldmethod = "expr"
    -- indentation, provided by nvim-treesitter
    vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
  end,
})
