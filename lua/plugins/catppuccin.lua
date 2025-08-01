local hsluv = require("hsluv")

-- local h, s = 7, 0.65

---@param colors CtpColors<{[1]:number, [2]: number, [3]: number}>
---@param h number
---@param s number
---@param l number
---@return CtpColors<string>
local function override(colors, h, s, l)
  return vim.tbl_map(function(hsl)
    return hsluv.hsluv_to_hex({ hsl[1] + h, hsl[2] * s, hsl[3] * l })
  end, colors)
end

---@param colors CtpColors<{[1]:number, [2]: number, [3]: number}>
---@param target_hsluv {[1]:number, [2]: number, [3]: number}
---@param target_hex string?
---@return CtpColors<string>
local function override_to_target(colors, target_hsluv, target_hex)
  local h, s, l = target_hsluv[1] - colors.base[1], target_hsluv[2] / colors.base[2], target_hsluv[3] / colors.base[3]

  local overriden = override(colors, h, s, l)

  return vim.tbl_extend("force", override(colors, h, s, l), {
    base = target_hex or hsluv.hsluv_to_hex(target_hsluv),
  })
end

local base_hex, base_hsl = nil, { 250, 15, 15 } -- custom default background
-- local base_hex, base_hsl = nil, { 0, 0, 9.3 } -- cursor default background
-- local base_hex, base_hsl = "#282c34", { 250.1, 19.6, 17.9 } -- ghostty default background

---Overrides the mocha palette
---@param colors CtpColors<{[1]:number, [2]: number, [3]: number}>
---@return CtpColors<string>
local function override_mocha(colors)
  return override_to_target(colors, { base_hsl[1], base_hsl[2], base_hsl[3] - 4 })
end

---Overrides the mocha palette
---@param colors CtpColors<{[1]:number, [2]: number, [3]: number}>
---@return CtpColors<string>
local function override_macchiato(colors)
  return override_to_target(colors, { base_hsl[1], base_hsl[2], base_hsl[3] }, base_hex)
end

---Overrides the mocha palette
---@param colors CtpColors<{[1]:number, [2]: number, [3]: number}>
---@return CtpColors<string>
local function override_frappe(colors)
  return override_to_target(colors, { base_hsl[1], base_hsl[2], base_hsl[3] + 4 })
end

---@module 'catppuccin'
---@type CtpColors<string>
local cat_latte = override({
  -- stylua: ignore start

  -- rosewater = { 22.21,  53.82, 65.55 }, -- #dc8a78
  -- flamingo  = { 12.18,  58.72, 61.79 }, -- #dd7878
  -- pink      = { 324.02, 75.94, 65.56 }, -- #ea76cb
  -- mauve     = { 276.46, 91.02, 44.79 }, -- #8839ef
  -- red       = { 7.89,   96.44, 44.72 }, -- #d20f39
  -- maroon    = { 9.40,   71.73, 53.71 }, -- #e64553
  -- peach     = { 22.21,  98.74, 61.84 }, -- #fe640b
  -- yellow    = { 42.84,  95.96, 65.85 }, -- #df8e1d
  -- green     = { 124.67, 89.23, 58.42 }, -- #40a02b
  -- teal      = { 200.09, 96.44, 55.11 }, -- #179299
  -- sky       = { 237.13, 99.69, 63.83 }, -- #04a5e5
  -- sapphire  = { 213.89, 95.31, 60.28 }, -- #209fb5
  -- blue      = { 259.84, 95.31, 47.46 }, -- #1e66f5
  -- lavender  = { 261.90, 98.22, 59.89 }, -- #7287fd

  -- text     = { 262.14, 20.20, 34.29 }, -- #4c4f69
  -- subtext1 = { 261.67, 16.40, 40.88 }, -- #5c5f77
  -- subtext0 = { 261.16, 14.36, 47.30 }, -- #6c6f85
  overlay2 = { 260.58, 14.28, 53.57 }, -- #7c7f93
  overlay1 = { 259.90, 14.52, 59.70 }, -- #8c8fa1
  overlay0 = { 256.99, 15.39, 66.02 }, -- #9ca0b0
  surface2 = { 255.68, 16.38, 71.92 }, -- #acb0be
  surface1 = { 254.00, 17.93, 77.73 }, -- #bcc0cc
  surface0 = { 251.75, 20.53, 83.45 }, -- #ccd0da
  base     = { 248.30, 28.87, 95.10 }, -- #eff1f5
  mantle   = { 248.44, 27.35, 92.28 }, -- #e6e9ef
  crust    = { 248.58, 25.67, 89.09 }, -- #dce0e8

  -- stylua: ignore end
}, 0, 1.1, 0.9)

---@module 'catppuccin'
---@type CtpColors<string>
local cat_mocha = override_mocha({
  -- stylua: ignore start

  -- rosewater = { 24.34,  60.29, 90.73 }, -- #f5e0dc
  -- flamingo  = { 12.18,  65.78, 85.48 }, -- #f2cdcd
  -- pink      = { 321.39, 77.04, 83.84 }, -- #f5c2e7
  -- mauve     = { 282.78, 88.67, 73.99 }, -- #cba6f7
  -- red       = { 355.75, 82.81, 69.72 }, -- #f38ba8
  -- maroon    = { 2.32,   68.65, 73.41 }, -- #eba0ac
  -- peach     = { 37.03,  89.58, 78.65 }, -- #fab387
  -- yellow    = { 66.20,  74.78, 90.61 }, -- #f9e2af
  -- green     = { 125.50, 41.22, 84.80 }, -- #a6e3a1
  -- teal      = { 176.09, 54.56, 84.74 }, -- #94e2d5
  -- sky       = { 208.53, 61.61, 83.18 }, -- #89dceb
  -- sapphire  = { 227.08, 70.12, 76.44 }, -- #74c7ec
  -- blue      = { 250.77, 93.17, 72.80 }, -- #89b4fa
  -- lavender  = { 261.02, 98.30, 78.28 }, -- #b4befe

  -- text     = { 255.71, 71.99, 85.81 }, -- #cdd6f4
  -- subtext1 = { 256.17, 43.93, 78.63 }, -- #bac2de
  -- subtext0 = { 257.06, 30.81, 70.98 }, -- #a6adc8
  overlay2 = { 257.70, 22.63, 63.51 }, -- #9399b2
  overlay1 = { 258.78, 18.03, 55.50 }, -- #7f849c
  overlay0 = { 259.68, 14.84, 47.62 }, -- #6c7086
  surface2 = { 261.03, 15.56, 39.12 }, -- #585b70
  surface1 = { 262.32, 15.88, 30.66 }, -- #45475a
  surface0 = { 251.04, 17.48, 21.40 }, -- #313244
  base     = { 265.87, 19.12, 11.97 }, -- #1e1e2e
  mantle   = { 265.87, 18.00, 8.83 }, -- #181825
  crust    = { 265.87, 16.98, 5.41 }, -- #11111b

  -- stylua: ignore end
})

---@module 'catppuccin'
---@type CtpColors<string>
local cat_macchiato = override_macchiato({
  -- stylua: ignore start

-- rosewater = { 24.71,  61.76, 89.28 }, -- #f4dbd6
-- flamingo  = { 12.18,  64.86, 83.44 }, -- #f0c6c6
-- pink      = { 321.18, 78.50, 82.66 }, -- #f5bde6
-- mauve     = { 281.92, 88.11, 72.10 }, -- #c6a0f6
-- red       = { 4.20,   75.19, 67.68 }, -- #ed8796
-- maroon    = { 7.50,   73.90, 71.89 }, -- #ee99a0
-- peach     = { 34.40,  81.43, 75.65 }, -- #f5a97f
-- yellow    = { 64.28,  51.54, 85.89 }, -- #eed49f
-- green     = { 120.05, 45.79, 82.07 }, -- #a6da95
-- teal      = { 177.80, 54.85, 80.37 }, -- #8bd5ca
-- sky       = { 207.15, 54.55, 81.93 }, -- #91d7e3
-- sapphire  = { 226.11, 61.59, 75.72 }, -- #7dc4e4
-- blue      = { 253.30, 86.04, 70.75 }, -- #8aadf4
-- lavender  = { 262.59, 88.25, 78.02 }, -- #b7bdf8

-- text     = { 256.94, 76.04, 84.86 }, -- #cad3f5
-- subtext1 = { 257.42, 48.61, 78.03 }, -- #b8c0e0
-- subtext0 = { 256.94, 34.41, 71.01 }, -- #a5adcb
overlay2 = { 257.80, 26.67, 63.94 }, -- #939ab7
overlay1 = { 257.31, 21.01, 56.61 }, -- #8087a2
overlay0 = { 259.47, 17.58, 48.88 }, -- #6e738d
surface2 = { 259.07, 19.39, 41.13 }, -- #5b6078
surface1 = { 260.26, 20.84, 33.23 }, -- #494d64
surface0 = { 259.94, 24.66, 24.87 }, -- #363a4f
base     = { 261.12, 27.99, 16.16 }, -- #24273a
mantle   = { 262.03, 25.39, 12.75 }, -- #1e2030
crust    = { 263.44, 21.78, 9.23 }, -- #181926

  -- stylua: ignore end
})

---@module 'catppuccin'
---@type CtpColors<string>
local cat_frappe = override_frappe({
  -- stylua: ignore start

  -- rosewater = { 24.90,  60.79, 87.47 }, -- #f2d5cf
  -- flamingo  = { 12.18,  64.41, 81.14 }, -- #eebebe
  -- pink      = { 321.27, 77.90, 81.36 }, -- #f4b8e4
  -- mauve     = { 289.80, 67.93, 71.37 }, -- #ca9ee6
  -- red       = { 11.20,  68.20, 65.45 }, -- #e78284
  -- maroon    = { 10.11,  68.40, 71.34 }, -- #ea999c
  -- peach     = { 32.53,  73.26, 72.53 }, -- #ef9f76
  -- yellow    = { 62.70,  49.55, 81.83 }, -- #e5c890
  -- green     = { 114.42, 50.55, 79.34 }, -- #a6d189
  -- teal      = { 178.50, 55.74, 75.88 }, -- #81c8be
  -- sky       = { 207.05, 46.19, 80.45 }, -- #99d1db
  -- sapphire  = { 224.94, 54.50, 75.01 }, -- #85c1dc
  -- blue      = { 254.25, 79.11, 69.82 }, -- #8caaee
  -- lavender  = { 265.25, 77.13, 77.48 }, -- #babbf1

  -- text     = { 256.88, 77.52, 83.81 }, -- #c6d0f5
  -- subtext1 = { 256.45, 52.68, 77.62 }, -- #b5bfe2
  -- subtext0 = { 257.79, 37.89, 71.11 }, -- #a5adce
  overlay2 = { 257.36, 29.24, 64.69 }, -- #949cbb
  overlay1 = { 256.54, 22.60, 58.11 }, -- #838ba7
  overlay0 = { 258.55, 18.99, 51.22 }, -- #737994
  surface2 = { 257.73, 19.60, 44.31 }, -- #626880
  surface1 = { 257.16, 21.76, 37.24 }, -- #51576d
  surface0 = { 259.43, 20.98, 29.67 }, -- #414559
  base     = { 258.94, 24.58, 22.04 }, -- #303446
  mantle   = { 259.96, 23.26, 18.36 }, -- #292c3c
  crust    = { 259.15, 23.93, 15.44 }, -- #232634

  -- stylua: ignore end
})

--[[

local ghostty_mocha = {
  "palette = 0=" .. cat_mocha.surface1,
  "palette = 1=#f38ba8",
  "palette = 2=#a6e3a1",
  "palette = 3=#f9e2af",
  "palette = 4=#89b4fa",
  "palette = 5=#f5c2e7",
  "palette = 6=#94e2d5",
  "palette = 7=" .. cat_mocha.subtext1,
  "palette = 8=" .. cat_mocha.surface2,
  "palette = 9=#f37799",
  "palette = 10=#89d88b",
  "palette = 11=#ebd391",
  "palette = 12=#74a8fc",
  "palette = 13=#f2aede",
  "palette = 14=#6bd7ca",
  "palette = 15=" .. cat_mocha.subtext0,
  "background = " .. cat_mocha.base,
  "foreground = " .. cat_mocha.text,
  "cursor-color = #f5e0dc",
  "cursor-text = " .. cat_mocha.base,
  "selection-background = " .. cat_mocha.overlay2, -- #{{ overlay2 | mix(color=base, amount=0.2) }}
  "selection-foreground = " .. cat_mocha.text,
}

vim.print(table.concat(ghostty_mocha, "\n"))

]]

---@type LazySpec
return {
  "catppuccin/nvim",
  name = "catppuccin",
  enabled = true,
  priority = 100,
  lazy = false,
  ---@module 'catppuccin'
  ---@type CatppuccinOptions
  opts = {
    -- background = {
    --   light = "latte",
    --   dark = "macchiato",
    -- },
    no_italic = false, -- Force no italic
    styles = {
      comments = { "italic" }, -- Change the style of comments
      conditionals = {}, -- default is { "italic" }
      loops = {},
      functions = {},
      keywords = {},
      strings = {},
      variables = {},
      numbers = {},
      booleans = {},
      properties = {},
      types = {},
      operators = {},
      miscs = {},
    },
    auto_integrations = true,
    integrations = {
      native_lsp = {
        enabled = true,
        virtual_text = {
          errors = {},
          warnings = {},
          information = {},
          hints = {},
          ok = {},
        },
        underlines = {
          errors = { "undercurl" },
          warnings = { "undercurl" },
          information = { "undercurl" },
          hints = { "undercurl" },
          ok = { "undercurl" },
        },
      },
    },
    color_overrides = {
      latte = cat_latte,
      mocha = cat_mocha,
      macchiato = cat_macchiato,
      frappe = cat_frappe,
    },
  },
  config = function(self, opts)
    require("catppuccin").setup(opts)
    vim.cmd.colorscheme("catppuccin")
  end,
}
