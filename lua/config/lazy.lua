local lazyroot = vim.fn.stdpath("data") .. "/lazy"

-- bootstrap lazy package manager
local lazypath = lazyroot .. "/lazy.nvim"

if not (vim.uv or vim.loop).fs_stat(lazypath) then
  print("lazy.nvim: Cloning repository")

  local process = vim.system({
    "git",
    "clone",
    "--filter=blob:none",
    "--single-branch",
    "https://github.com/folke/lazy.nvim.git",
    lazypath,
  })

  -- Wait for the process to exit
  local result = process:wait()

  -- Handle unsuccessful exit
  if result.code ~= 0 then
    print("lazy.nvim: Failed to clone: " .. result.stderr)
    return
  end

  print("lazy.nvim: Cloned successfully")
end

vim.opt.runtimepath:prepend(lazypath)

require("lazy").setup("plugins", {
  root = lazyroot,
  defaults = {
    lazy = true,
  },
  dev = {
    path = "~/src",
    patterns = { "jmederosalvarado" },
  },
  checker = {
    enable = true,
    check_pinned = true,
  },
  change_detection = {
    enabled = false,
    notify = false,
  },

  performance = {
    rtp = {
      disabled_plugins = {
        "2html_plugin",
        "getscript",
        "getscriptPlugin",
        "gzip",
        "logipat",
        "netrw",
        "netrwPlugin",
        "netrwSettings",
        "netrwFileHandlers",
        "matchit",
        "tar",
        "tarPlugin",
        "rrhelper",
        "spellfile_plugin",
        "vimball",
        "vimballPlugin",
        "zip",
        "zipPlugin",
      },
    },
  },
})
