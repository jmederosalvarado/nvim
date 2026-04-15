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

MiniIcons.mock_nvim_web_devicons()
