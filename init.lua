-- Disable builtin runtime plugins here, before any startup code runs.
vim.g.loaded_gzip = 1 -- edit compressed files like .gz/.xz transparently
vim.g.loaded_man = 1 -- :Man inside Neovim
-- vim.g.loaded_matchit = 1 -- extended % matching
-- vim.g.loaded_matchparen = 1 -- highlight matching delimiter under cursor

vim.g.loaded_netrw = 1 -- netrw package itself
vim.g.loaded_netrwPlugin = 1 -- netrw loader/plugin
vim.g.loaded_nvim_net_plugin = 1 -- built-in remote URL/archive opener

vim.g.loaded_remote_plugins = 1 -- remote-plugin manifest loader
vim.g.loaded_shada_plugin = 1 -- .shada file editing support
vim.g.loaded_spellfile_plugin = 1 -- auto-download missing spellfiles
vim.g.loaded_tarPlugin = 1 -- browse/edit tar archives
vim.g.loaded_tutor_mode_plugin = 1 -- :Tutor
vim.g.loaded_zipPlugin = 1 -- browse/edit zip archives

-- Define leaders before loading any runtime files, since keymaps and plugins may
-- expand <Leader> during startup and will capture whatever value exists then.
-- Set <Space> as the leader key.
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Package management via vim.pack

local pack_dir = vim.fn.stdpath("data") .. "/site/pack/core/opt"
local function pack_path(name)
  return vim.fs.joinpath(pack_dir, name)
end

-- Define hooks for package change events.
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

      local result = vim.system({ "make" }, { cwd = pack_path(name) }):wait()
      if result.code ~= 0 then
        vim.notify("Failed building telescope-fzf-native.nvim: " .. result.stderr, vim.log.levels.ERROR)
      end
    end

    if name == "nvim-treesitter" and (is_install or is_update) then
      vim.cmd.packadd(name)
      require("nvim-treesitter").update(nil, { summary = true }):wait()
    end
  end,
})

local gh = "https://github.com/"

vim.pack.add({
  gh .. "echasnovski/mini.nvim",
  gh .. "lewis6991/gitsigns.nvim",
  gh .. "neovim/nvim-lspconfig",
  gh .. "williamboman/mason.nvim",
  gh .. "stevearc/conform.nvim",
  gh .. "tpope/vim-fugitive",
  gh .. "tpope/vim-rhubarb",
  { src = gh .. "ThePrimeagen/harpoon", version = "harpoon2" },
  gh .. "nvim-lua/plenary.nvim",
  gh .. "nvim-lualine/lualine.nvim",
  gh .. "stevearc/oil.nvim",
  gh .. "folke/snacks.nvim",
  gh .. "nvim-treesitter/nvim-treesitter",
  gh .. "nvim-treesitter/nvim-treesitter-context",
  gh .. "nvim-telescope/telescope.nvim",
  gh .. "nvim-telescope/telescope-fzf-native.nvim",
})
