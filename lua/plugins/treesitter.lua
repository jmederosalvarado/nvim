---@type LazySpec
local treesitter = {
  "nvim-treesitter/nvim-treesitter",
  event = "BufReadPre",
  build = ":TSUpdate",
  config = function()
    ---@diagnostic disable-next-line missing-fields
    require("nvim-treesitter.configs").setup({
      auto_install = true,
      highlight = { enable = true },
      indent = { enable = true, disable = { "python", "yaml" } },
    })
  end,
}

---@type LazySpec
return { treesitter }
