local function builtin(name, opts)
  return function()
    require("telescope.builtin")[name](opts or {})
  end
end

---@type LazySpec
return {
  "nvim-telescope/telescope.nvim",
  cmd = "Telescope",
  dependencies = {
    "nvim-lua/plenary.nvim",
    {
      "nvim-telescope/telescope-fzf-native.nvim",
      build = "make",
      cond = function()
        return vim.fn.executable("make") == 1
      end,
    },
  },
  init = function()
    vim.api.nvim_create_user_command("Help", builtin("help_tags"), { desc = "Search help tags" })
  end,
  keys = {
    {
      "<leader><space>",
      builtin("buffers"),
      desc = "Find Existing Buffers",
    },
    {
      "<leader>/",
      builtin("current_buffer_fuzzy_find"),
      desc = "Fuzzy Search Current Buffer",
    },
    {
      "<leader>ff",
      builtin("find_files"),
      desc = "[F]ind [F]iles",
    },
    {
      "<leader>fg",
      builtin("git_files"),
      desc = "Find [G]it Files",
    },
    {
      "<leader>fr",
      builtin("oldfiles"),
      desc = "Find [R]ecent Files",
    },
    {
      "<leader>fc",
      builtin("find_files", {
        cwd = vim.fn.stdpath("config"),
        hidden = true,
      }),
      desc = "Find [C]onfig Files",
    },
    {
      "g/",
      builtin("live_grep"),
      mode = "n",
      desc = "Grep in cwd",
    },
    {
      "<leader>sw",
      builtin("grep_string", { word_match = "-w" }),
      mode = "n",
      desc = "Search Word",
    },
    {
      "<leader>sd",
      builtin("diagnostics"),
      desc = "Search Diagnostics",
    },
    {
      "<leader>sD",
      builtin("diagnostics", { bufnr = 0 }),
      desc = "Search Buffer Diagnostics",
    },
    {
      "<leader>sh",
      builtin("help_tags"),
      desc = "Search Help",
    },
  },
  opts = {
    defaults = {
      prompt_prefix = "? ",
      selection_caret = "❯ ",
    },
    pickers = {
      buffers = {
        sort_mru = true,
        ignore_current_buffer = true,

        theme = "dropdown",
        previewer = false,
      },
      builtin = {
        theme = "dropdown",
        previewer = false,
      },
      command_history = {
        theme = "dropdown",
      },
      current_buffer_fuzzy_find = {
        theme = "dropdown",
        previewer = false,
      },
      diagnostics = {
        initial_mode = "normal",
      },
      git_files = {
        show_untracked = true,
      },
    },
    extensions = {
      fzf = {},
    },
  },
  config = function(_, opts)
    local telescope = require("telescope")

    opts.defaults = require("telescope.themes").get_ivy(vim.tbl_deep_extend("force", opts.defaults, {
      layout_config = { height = { 0.4, min = 15 } },
    }))

    telescope.setup(opts)

    pcall(telescope.load_extension, "fzf")
  end,
}
