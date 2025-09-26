---@type LazySpec
return {
  "tpope/vim-fugitive",
  cmd = { "G", "Git", "GBrowse" },
  dependencies = { "tpope/vim-rhubarb" },
  keys = {
    { "<Leader>gs", "<Cmd>Git<CR>", desc = "Fu[G]itive [S]tatus" },
  },
}
