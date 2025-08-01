local enclosed = {
  ["A"] = { clear = "Ⓐ", filled = "🅐" },
  ["B"] = { clear = "Ⓑ", filled = "🅑" },
  ["C"] = { clear = "Ⓒ", filled = "🅒" },
  ["D"] = { clear = "Ⓓ", filled = "🅓" },
  ["E"] = { clear = "Ⓔ", filled = "🅔" },
  ["F"] = { clear = "Ⓕ", filled = "🅕" },
  ["G"] = { clear = "Ⓖ", filled = "🅖" },
  ["H"] = { clear = "Ⓗ", filled = "🅗" },
  ["I"] = { clear = "Ⓘ", filled = "🅘" },
  ["J"] = { clear = "Ⓙ", filled = "🅙" },
  ["K"] = { clear = "Ⓚ", filled = "🅚" },
  ["L"] = { clear = "Ⓛ", filled = "🅛" },
  ["M"] = { clear = "Ⓜ", filled = "🅜" },
  ["N"] = { clear = "Ⓝ", filled = "🅝" },
  ["O"] = { clear = "Ⓞ", filled = "🅞" },
  ["P"] = { clear = "Ⓟ", filled = "🅟" },
  ["Q"] = { clear = "Ⓠ", filled = "🅠" },
  ["R"] = { clear = "Ⓡ", filled = "🅡" },
  ["S"] = { clear = "Ⓢ", filled = "🅢" },
  ["T"] = { clear = "Ⓣ", filled = "🅣" },
  ["U"] = { clear = "Ⓤ", filled = "🅤" },
  ["V"] = { clear = "Ⓥ", filled = "🅥" },
  ["W"] = { clear = "Ⓦ", filled = "🅦" },
  ["X"] = { clear = "Ⓧ", filled = "🅧" },
  ["Y"] = { clear = "Ⓨ", filled = "🅨" },
  ["Z"] = { clear = "Ⓩ", filled = "🅩" },
}

---@type LazySpec
return {
  "echasnovski/mini.nvim",
  lazy = false,
  keys = {
    {
      "<leader>ph",
      function()
        require("mini.diff").toggle_overlay(0)
      end,
      desc = "Toggle diff overlay in current buffer",
    },
  },
  init = function()
    -- vim.notify = require("mini.notify").make_notify()
  end,
  config = function()
    -- Text Editing
    require("mini.ai").setup({})
    require("mini.align").setup({})
    -- require("mini.pairs").setup({})
    require("mini.surround").setup({})

    -- General
    require("mini.bracketed").setup({})
    require("mini.git").setup({})
    require("mini.diff").setup({
      view = {
        style = "sign",
      },
    })

    -- Appearance
    -- require("mini.notify").setup({})

    -- require("mini.statusline").setup({
    --   content = {
    --     active = function()
    --       local mode, mode_hl = MiniStatusline.section_mode({ trunc_width = 120 })
    --       local git = MiniStatusline.section_git({ trunc_width = 40 })
    --       local diff = MiniStatusline.section_diff({ trunc_width = 75 })
    --       local diagnostics = MiniStatusline.section_diagnostics({ trunc_width = 75 })
    --       local lsp = MiniStatusline.section_lsp({ trunc_width = 75 })
    --       local filename = MiniStatusline.section_filename({ trunc_width = 140 })
    --       local fileinfo = MiniStatusline.section_fileinfo({ trunc_width = 120 })
    --       local location = MiniStatusline.section_location({ trunc_width = 75 })
    --       local search = MiniStatusline.section_searchcount({ trunc_width = 75 })
    --
    --       return MiniStatusline.combine_groups({
    --         { hl = mode_hl, strings = { mode } },
    --         { hl = "MiniStatuslineDevinfo", strings = { git } },
    --         "%<", -- Mark general truncate point
    --         { hl = "MiniStatuslineFilename", strings = { filename } },
    --         "%=", -- End left alignment
    --         -- { hl = "MiniStatuslineFileinfo", strings = { fileinfo } },
    --         { hl = mode_hl, strings = { search, location } },
    --       })
    --     end,
    --   },
    -- })

    require("mini.icons").setup({ style = "ascii" })
    local mini_icons_get = MiniIcons.get
    ---@diagnostic disable-next-line: duplicate-set-field
    MiniIcons.get = function(...)
      local icon, hl, is_default = mini_icons_get(...)
      local new_icon = enclosed[icon]
      if new_icon then
        icon = new_icon.filled
      end
      return icon, hl, is_default
    end
  end,
}
