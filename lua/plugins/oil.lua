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
  },
}
