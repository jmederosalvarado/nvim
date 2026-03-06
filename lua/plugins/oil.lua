---@type LazySpec
return {
  "stevearc/oil.nvim",
  ---@module 'oil'
  ---@type oil.SetupOpts
  opts = {},
  cmd = "Oil",
  event = "VimEnter",
  keys = {
    { "-", "<Cmd>Oil<CR>", desc = "Open parent directory using Oil" },
    {
      "<Leader>-",
      function()
        require("oil").open(vim.fn.getcwd())
      end,
      desc = "Open current working directory using Oil",
    },
  },
}
