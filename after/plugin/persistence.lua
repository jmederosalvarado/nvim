require("persistence").setup()

vim.api.nvim_create_autocmd("VimEnter", {
  nested = true,
  group = vim.api.nvim_create_augroup("persistence_autoload", { clear = true }),
  desc = "Load session automatically when starting without files",
  callback = function()
    if vim.fn.argc() > 0 or vim.g.started_with_stdin or vim.tbl_isempty(vim.api.nvim_list_uis()) then
      return
    end

    require("persistence").load()
  end,
})
