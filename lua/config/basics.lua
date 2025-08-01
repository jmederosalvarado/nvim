-- Configure tabs, spaces and indentation behavior
vim.opt.tabstop = 4 -- Number of spaces a tab character displays as
vim.opt.shiftwidth = 4 -- Number of spaces for each indentation level
vim.opt.softtabstop = 4 -- Number of spaces inserted when pressing Tab
vim.opt.expandtab = true -- Convert tabs to spaces
-- vim.opt.smartindent = true -- Smart autoindenting for new lines

-- Behavior for wrapped lines
vim.opt.breakindent = true -- Preserve indentation for wrapped lines
vim.opt.showbreak = "↪ "

-- Enable mouse support
vim.opt.mouse = "a"

-- Enable line numbers by defualt
vim.opt.number = true
vim.opt.relativenumber = true

-- Show cursor line
vim.opt.cursorline = true

-- Keep some lines / columns of context around cursor
vim.opt.scrolloff = 4
vim.opt.sidescrolloff = 4

-- Don't show the mode, since it's already in the status line
vim.opt.showmode = false

-- Decrease timouts and update times
vim.o.timeoutlen = 300 -- Time to wait for a mapped sequence to complete
vim.o.updatetime = 200 -- Interval to save swap file and trigger `CursorHold`

-- Split behavior
vim.o.splitbelow = true -- Put the new window below the current one.
vim.o.splitright = true -- Put the new window right of the current one.
vim.o.splitkeep = "screen" -- Keep the text on the same screen line.

-- Case-insensitive searching UNLESS \C or one or more capital letters in the search term.
vim.o.ignorecase = true
vim.o.smartcase = true

-- Preview substitutions live, even offscreen ones
vim.o.inccommand = "split"

vim.o.swapfile = false -- Swap file
vim.o.undofile = true -- Persist undo history between editing sessions

-- Show some useful charaters that would normally be invisible (e.g. tabs, spaces)
vim.opt.list = true
vim.opt.listchars = { trail = "·", tab = "» " }

-- Configure some special charaters (usually for UI element)
vim.opt.fillchars = { eob = " " }

-- Configure completion
vim.opt.completeopt = { "fuzzy", "menuone", "noselect", "popup" }

-- Set default float window border
vim.opt.winborder = "solid"

-- Set <SPACE> as the leader key
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Highlight on yank
vim.api.nvim_create_autocmd("TextYankPost", {
  group = vim.api.nvim_create_augroup("hl_on_yank", { clear = true }),
  desc = "Highlight when yanking text.",
  callback = function()
    vim.hl.on_yank()
  end,
})

local linenums_augroup = vim.api.nvim_create_augroup("linenums", { clear = true })

-- Display absolute line number on Insert mode.
vim.api.nvim_create_autocmd({ "InsertEnter", "InsertLeave" }, {
  group = linenums_augroup,
  desc = "Display absolute line number in Insert mode",
  callback = function(opts)
    vim.wo.relativenumber = vim.wo.number and opts.event == "InsertLeave"
  end,
})

-- Display absolute line number on inactive windows.
vim.api.nvim_create_autocmd({ "WinLeave", "WinEnter" }, {
  group = linenums_augroup,
  desc = "Display absolute line number on inactive windows",
  callback = function(opts)
    vim.wo.relativenumber = vim.wo.number and opts.event == "WinEnter"
  end,
})

-- Don't show any line numbers inside terminals
vim.api.nvim_create_autocmd("TermOpen", {
  group = linenums_augroup,
  desc = "Don't display any numbers inside terminals",
  callback = function()
    vim.wo.number = false
    vim.wo.relativenumber = false
  end,
})

-- Change indentation settings for some file types
--     lua: indent using 2 spaces
vim.api.nvim_create_autocmd("FileType", {
  group = vim.api.nvim_create_augroup("ftident", { clear = true }),
  desc = "Change identing on certain filetypes",
  pattern = { "lua" },
  callback = function()
    vim.bo.tabstop = 2
    vim.bo.shiftwidth = 2
    vim.bo.softtabstop = 2
  end,
})

-- Set jsonc filetype for json files
vim.api.nvim_create_autocmd({ "BufNewFile", "BufRead" }, {
  group = vim.api.nvim_create_augroup("json2jsonc", { clear = true }),
  desc = "Set jsonc filetype for json files",
  pattern = { "*.json" },
  callback = function()
    vim.bo.filetype = "jsonc"
  end,
})

-- Clear highlights on search when pressing <ESC> in normal mode.
vim.keymap.set("n", "<Esc>", "<Cmd>nohlsearch<CR>", { desc = "Clear search highlights" })

-- Exit terminal mode in the builtin terminal.
vim.keymap.set("t", "<Esc><Esc>", "<C-\\><C-n>", { desc = "Exit terminal mode" })

-- Copy to system clipboard
vim.keymap.set({ "v", "n" }, "<Leader>y", '"+y', { desc = "Copy to system (unnamedplus) clipboard", silent = true })

-- Delete without copying
vim.keymap.set({ "v", "n" }, "<Leader>d", '"_d', { desc = "Delete without copying", silent = true })

-- Replace selection, without copying selected text
vim.keymap.set({ "x" }, "p", "P", { desc = "Put, replacing selection, without copying it", silent = true })

-- Scroll by moving the cursor a lines
vim.keymap.set("n", "<C-d>", "5jzz", { desc = "Scroll down by moving the cursor a few lines", silent = true })
vim.keymap.set("n", "<C-u>", "5kzz", { desc = "Scroll up by moving the cursor a few lines", silent = true })
