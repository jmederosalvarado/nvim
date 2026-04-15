local opts = {
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
}

opts.defaults = require("telescope.themes").get_ivy(vim.tbl_deep_extend("force", opts.defaults, {
  layout_config = { height = { 0.4, min = 15 } },
}))

local telescope = require("telescope")

telescope.setup(opts)
pcall(telescope.load_extension, "fzf")

local function builtin(name, opts)
  return function()
    require("telescope.builtin")[name](opts or {})
  end
end

vim.api.nvim_create_user_command("Help", builtin("help_tags"), { desc = "Search help tags" })

vim.keymap.set(
  "n",
  "<leader>fc",
  builtin("find_files", {
    cwd = vim.fn.stdpath("config"),
    hidden = true,
  }),
  { desc = "Find [C]onfig Files" }
)

vim.keymap.set("n", "<leader>ff", builtin("find_files"), { desc = "[F]ind [F]iles" })
vim.keymap.set("n", "<leader><space>", builtin("buffers"), { desc = "Find Existing Buffers" })

vim.keymap.set("n", "<leader>/", builtin("current_buffer_fuzzy_find"), { desc = "Fuzzy Search Current Buffer" })
vim.keymap.set("n", "g/", builtin("live_grep"), { desc = "Grep in cwd" })

vim.keymap.set("v", "g/", builtin("grep_string"), { desc = "Grep visual selection" })

vim.keymap.set("n", "<leader>sd", builtin("diagnostics"), { desc = "Search Diagnostics" })
vim.keymap.set("n", "<leader>sD", builtin("diagnostics", { bufnr = 0 }), { desc = "Search Buffer Diagnostics" })

vim.api.nvim_create_autocmd("LspAttach", {
  group = vim.api.nvim_create_augroup("telescope_lsp_attach", { clear = true }),
  desc = "Configure Telescope LSP keymaps when language server attaches to buffer",
  callback = function(args)
    vim.keymap.set("n", "gO", builtin("lsp_document_symbols"), { buffer = args.buf, desc = "Search document symbols" })
    vim.keymap.set(
      "n",
      "g0",
      builtin("lsp_workspace_symbols"),
      { buffer = args.buf, desc = "Search workspace symbols" }
    )
  end,
})
