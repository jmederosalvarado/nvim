-- local function harpooned()
--   return table.concat(require("harpoon"):list():display(), " | ")
-- end

---@type LazySpec
return {
  "nvim-lualine/lualine.nvim",
  event = "VeryLazy",
  -- enabled = false,
  opts = {
    options = {
      section_separators = { left = "", right = "" },
      component_separators = { left = "|", right = "|" },
      always_show_tabline = false,
      disabled_filetypes = {
        statusline = { "snacks_layout_box" },
      },
    },
    sections = {
      lualine_a = { "mode" },
      lualine_b = { "branch", "diff", "diagnostics" },
      lualine_c = { "filename" },
      lualine_x = {},
      lualine_y = { "progress" },
      lualine_z = { "location" },
    },
    tabline = {
      lualine_a = {},
      lualine_b = { "tabs" },
      lualine_c = {},
      lualine_x = {},
      lualine_y = {},
      lualine_z = {},
    },
    extensions = { "fugitive", "lazy", "mason", "oil", "quickfix" },
  },
}
