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

vim.keymap.set("n", "<leader>ph", function()
  require("mini.diff").toggle_overlay(0)
end, { desc = "Toggle diff overlay in current buffer" })

require("mini.ai").setup()
require("mini.align").setup()
require("mini.surround").setup()

require("mini.bracketed").setup()
require("mini.diff").setup({
  view = {
    style = "sign",
  },
})
require("mini.indentscope").setup()
require("mini.notify").setup()

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
