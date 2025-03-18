---@type LazySpec
return {
  "Saghen/blink.cmp",
  enabled = true,
  lazy = false, -- lazy loading handled internally
  version = "*", -- use a release tag to download pre-built binaries

  dependencies = {
    -- optional: provides snippets for the snippet source
    "rafamadriz/friendly-snippets",

    "xzbdmw/colorful-menu.nvim",
  },

  ---@module 'blink.cmp'
  ---@type blink.cmp.Config
  opts = {
    completion = {
      -- Show documentation when selecting a completion item
      documentation = { auto_show = true, auto_show_delay_ms = 500 },

      menu = {
        draw = {
          -- We don't need label_description now because label and label_description are already
          -- combined together in label by colorful-menu.nvim.
          columns = { { "kind_icon", "kind", gap = 1 }, { "label" } },
          components = {
            kind_icon = {
              ellipsis = false,
              text = function(ctx)
                local kind_icon, _, _ = require("mini.icons").get("lsp", ctx.kind)
                return kind_icon
              end,
            },
            label = {
              text = function(ctx)
                return require("colorful-menu").blink_components_text(ctx)
              end,
              highlight = function(ctx)
                return require("colorful-menu").blink_components_highlight(ctx)
              end,
            },
          },
        },
      },
    },
    -- default list of enabled providers defined so that you can extend it
    -- elsewhere in your config, without redefining it, via `opts_extend`
    sources = {
      default = function()
        if vim.bo.filetype == "lua" then
          return { "lazydev", "lsp", "path", "snippets", "buffer" }
        end

        return { "lsp", "path", "snippets", "buffer" }
      end,

      providers = {
        lazydev = {
          name = "LazyDev",
          module = "lazydev.integrations.blink",
          -- make lazydev completions top priority (see `:h blink.cmp`)
          score_offset = 100,
        },
      },
    },

    -- Experimental signature help support
    signature = { enabled = true },

    -- Disable cmdline completion
    cmdline = { enabled = false },
  },
}
