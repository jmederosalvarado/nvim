---@type LazySpec
return {
  "ellisonleao/gruvbox.nvim",
  enabled = false,
  priority = 100,
  lazy = false,
  opts = {
    terminal_colors = true, -- add neovim terminal colors
    undercurl = true,
    underline = true,
    bold = true,
    italic = {
      strings = true,
      emphasis = true,
      comments = true,
      operators = false,
      folds = true,
    },
    strikethrough = true,
    invert_selection = false,
    invert_signs = false,
    invert_tabline = false,
    inverse = true, -- invert background for search, diffs, statuslines and errors
    contrast = "soft", -- can be "hard", "soft" or empty string
    palette_overrides = {},
    overrides = {},
    dim_inactive = false,
    transparent_mode = false,
  },
  --- @diagnostic disable-next-line: unused-local
  config = function(self, opts)
    vim.opt.background = "light"
    require("gruvbox").setup(opts)
    vim.cmd.colorscheme("gruvbox")
  end,
}
