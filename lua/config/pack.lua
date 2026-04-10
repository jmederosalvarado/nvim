local pack_plugin_dir = vim.fn.stdpath("data") .. "/site/pack/core/opt"

local pack_plugin_path = function(name)
  return pack_plugin_dir .. "/" .. name
end

vim.api.nvim_create_autocmd("PackChanged", {
  group = vim.api.nvim_create_augroup("pack_hooks", { clear = true }),
  callback = function(ev)
    local name = ev.data.spec.name
    local is_install = ev.data.kind == "install"
    local is_update = ev.data.kind == "update"

    if name == "telescope-fzf-native.nvim" and (is_install or is_update) then
      if vim.fn.executable("make") ~= 1 then
        vim.notify("Skipping telescope-fzf-native.nvim build because 'make' is unavailable.", vim.log.levels.WARN)
        return
      end

      local result = vim.system({ "make" }, { cwd = pack_plugin_path(name) }):wait()
      if result.code ~= 0 then
        local msg = result.stderr and result.stderr or "Failed building telescope-fzf-native.nvim"
        vim.notify(msg, vim.log.levels.ERROR)
      end
    end

    if name == "nvim-treesitter" and (is_install or is_update) then
      vim.cmd.packadd(name)
      require("nvim-treesitter").update(nil, { summary = true }):wait()
    end
  end,
})

local plugins = {
  "https://github.com/echasnovski/mini.nvim",
  "https://github.com/lewis6991/gitsigns.nvim",
  "https://github.com/neovim/nvim-lspconfig",
  "https://github.com/williamboman/mason.nvim",
  "https://github.com/stevearc/conform.nvim",
  "https://github.com/tpope/vim-fugitive",
  "https://github.com/tpope/vim-rhubarb",
  { src = "https://github.com/ThePrimeagen/harpoon", version = "harpoon2" },
  "https://github.com/nvim-lua/plenary.nvim",
  "https://github.com/nvim-lualine/lualine.nvim",
  "https://github.com/stevearc/oil.nvim",
  "https://github.com/olimorris/persisted.nvim",
  "https://github.com/folke/snacks.nvim",
  "https://github.com/nvim-treesitter/nvim-treesitter",
  "https://github.com/nvim-treesitter/nvim-treesitter-context",
  "https://github.com/nvim-telescope/telescope.nvim",
  "https://github.com/nvim-telescope/telescope-fzf-native.nvim",
}

vim.pack.add(plugins)
