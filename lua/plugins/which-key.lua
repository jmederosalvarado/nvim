---@type LazySpec
return {
  "folke/which-key.nvim",
  enabled = false,
  event = "VeryLazy",
  ---@module "which-key"
  ---@type wk.Opts
  opts = {},
  keys = {
    {
      "<leader>?",
      function()
        require("which-key").show({ global = false })
      end,
      desc = "Buffer Local Keymaps (which-key)",
    },
  },
}
