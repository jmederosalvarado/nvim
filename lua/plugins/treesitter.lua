---@type LazySpec
local treesitter = {
  "nvim-treesitter/nvim-treesitter",
  event = "BufReadPre",
  build = ":TSUpdate",
  config = function()
    ---@diagnostic disable-next-line missing-fields
    require("nvim-treesitter.configs").setup({
      --[[
			sync_install = true,
			ensure_installed = {
				"c",
				"lua",

				"rust",
				"toml",

				"c_sharp",

				"go",
				"gomod",
				"gowork",

				"zig",

				"python",
			},
      ]]
      auto_install = true,

      highlight = { enable = true },
      indent = { enable = true, disable = { "python", "yaml" } },
    })
  end,
}

---@type LazySpec
local treesitter_context = {
  "nvim-treesitter/nvim-treesitter-context",
  enabled = false,
  event = "BufReadPre",
  opts = {
    --   enable = true, -- Enable this plugin (Can be enabled/disabled later via commands)
    --   multiwindow = false, -- Enable multiwindow support.
    --   max_lines = 0, -- How many lines the window should span. Values <= 0 mean no limit.
    --   min_window_height = 0, -- Minimum editor window height to enable context. Values <= 0 mean no limit.
    --   line_numbers = true,
    --   multiline_threshold = 20, -- Maximum number of lines to show for a single context
    --   trim_scope = "outer", -- Which context lines to discard if `max_lines` is exceeded. Choices: 'inner', 'outer'
    mode = "topline", -- Line used to calculate context. Choices: 'cursor', 'topline'
    --   -- Separator between context and content. Should be a single character string, like '-'.
    --   -- When separator is set, the context will only show up when there are at least 2 lines above cursorline.
    --   separator = nil,
    --   zindex = 20, -- The Z-index of the context window
    --   on_attach = nil, -- (fun(buf: integer): boolean) return false to disable attaching
  },
}

---@type LazySpec
return { treesitter, treesitter_context }
