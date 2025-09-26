---@type LazySpec
return {
  "folke/snacks.nvim",
  priority = 1000,
  lazy = false,
  ---@module 'snacks'
  ---@type snacks.Config
  opts = {
    -- your configuration comes here
    -- or leave it empty to use the default settings
    -- refer to the configuration section below
    bigfile = { enabled = true },
    indent = { enabled = true },
    input = { enabled = true },
    notifier = { enabled = true },
    picker = { enabled = true, layout = "bottom", prompt = "❯ " },
    quickfile = { enabled = true },
    scope = { enabled = true },
    -- scroll = { enabled = true },
    statuscolumn = { enabled = true },
    words = { enabled = true },
  },
  init = function()
    vim.api.nvim_create_user_command("Help", function(_)
      Snacks.picker.help()
    end, { desc = "Search help tags" })

    vim.api.nvim_create_user_command("Pick", function(_)
      Snacks.picker()
    end, { desc = "Search the built-in Snacks pickers" })
  end,
  keys = {
    {
      "<leader>pp",
      function()
        Snacks.picker()
      end,
      desc = "Search Snacks [p]ickers",
    },

    {
      "<leader><space>",
      function()
        Snacks.picker.smart()
      end,
      desc = "Smart Find Files",
    },
    {
      "<leader>ff",
      function()
        Snacks.picker.files()
      end,
      desc = "[F]ind [F]iles",
    },
    {
      "g/",
      function()
        Snacks.picker.grep()
      end,
      mode = "n",
      desc = "Grep in cwd",
    },
    {
      "g/",
      function()
        Snacks.picker.grep_word()
      end,
      desc = "Grep visual selection",
      mode = { "v", "x" },
    },

    {
      "<leader>fc",
      function()
        Snacks.picker.files({ cwd = vim.fn.stdpath("config") })
      end,
      desc = "Find Config File",
    },
  },
}
