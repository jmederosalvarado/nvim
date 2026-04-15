require("conform").setup({
  formatters_by_ft = {
    lua = { "stylua" },
    zig = { "zigfmt" },
    markdown = { "prettierd" },
    html = { "prettierd" },
    javascript = { "prettierd" },
    typescript = { "prettierd" },
    json = { "prettierd" },
    rust = { "rustfmt", lsp_format = "fallback" },
    python = { "ruff_fix", "ruff_organize_imports", "ruff_format" },
    toml = { "taplo" },
  },
  formatters = {
    stylua = {
      prepend_args = {
        "--column-width",
        "120",
        "--indent-type",
        "Spaces",
        "--indent-width",
        "2",
      },
    },
    shfmt = {
      prepend_args = { "-i", "2" },
    },
    ruff_format = {
      command = "uvx",
      prepend_args = { "ruff" },
    },
    ruff_fix = {
      command = "uvx",
      prepend_args = { "ruff" },
    },
    ruff_organize_imports = {
      command = "uvx",
      prepend_args = { "ruff" },
    },
  },
})

vim.o.formatexpr = "v:lua.require'conform'.formatexpr()"

vim.keymap.set("n", "<Leader>fm", function()
  require("conform").format({ async = true })
end, { desc = "Format buffer" })
