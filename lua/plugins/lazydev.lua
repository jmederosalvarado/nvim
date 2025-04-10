---@type LazySpec
return {
  "folke/lazydev.nvim",
  ft = "lua", -- only load on lua files
  ---@module 'lazydev'
  ---@type lazydev.Config
  opts = {
    integrations = {
      cmp = false,
      coq = false,
      lspconfig = false,
    },
    library = {
      "lazy.nvim",
      -- See the configuration section for more details
      -- Load luvit types when the `vim.uv` word is found
      { path = "luvit-meta/library", words = { "vim%.uv" } },
    },
  },
  dependencies = { "Bilal2453/luvit-meta", lazy = true }, -- optional `vim.uv` typings
  init = function()
    vim.lsp.config("lua_ls", {
      root_dir = function(bufnr, set_root_dir)
        local ws = require("lazydev").find_workspace(bufnr)
        if ws then
          set_root_dir(ws)
        else
          set_root_dir(vim.fs.root(0, {
            ".luarc.json",
            ".luarc.jsonc",
            ".luacheckrc",
            ".stylua.toml",
            "stylua.toml",
            "selene.toml",
            "selene.yml",
            ".git",
          }))
        end
      end,
    })
  end,
}
