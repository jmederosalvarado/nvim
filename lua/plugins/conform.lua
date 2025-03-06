---@type LazySpec
local spec = {
  'stevearc/conform.nvim',
  cmd = 'ConformInfo',
}

---@module 'conform'
---@type conform.setupOpts
spec.opts = {
  formatters_by_ft = {
    lua = { 'stylua' },
    zig = { 'zigfmt' },
    markdown = { 'prettierd' },
    html = { 'prettierd' },
    javascript = { 'prettierd' },
    typescript = { 'prettierd' },
    rust = { 'rustfmt', lsp_format = 'fallback' },
  },
  formatters = {
    stylua = {
      prepend_args = {
        '--column-width',
        '120',
        '--line-endings',
        'Unix',
        '--indent-type',
        'Spaces',
        '--indent-width',
        '2',
        '--quote-style',
        'AutoPreferSingle',
        '--call-parentheses',
        'Always',
        '--collapse-simple-statement',
        'Always',
      },
    },
    shfmt = {
      prepend_args = { '-i', '2' },
    },
  },
}

spec.init = function()
  -- If you want the formatexpr, here is the place to set it
  vim.o.formatexpr = "v:lua.require'conform'.formatexpr()"
end

spec.keys = {
  {
    '<leader>fm',
    function() require('conform').format({ async = true }) end,
    desc = 'Format buffer',
  },
}

return spec
