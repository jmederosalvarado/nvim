require("gitsigns").setup({
  attach_to_untracked = true,
  -- word_diff = true,
  on_attach = function(bufnr)
    local gitsigns = require("gitsigns")

    local function map(mode, lhs, rhs, desc)
      vim.keymap.set(mode, lhs, rhs, { buffer = bufnr, desc = desc })
    end

    map("n", "[H", function()
      gitsigns.nav_hunk("first")
    end, "Go to first hunk")

    map("n", "[h", function()
      gitsigns.nav_hunk("prev")
    end, "Go to previous hunk")

    map("n", "]h", function()
      gitsigns.nav_hunk("next")
    end, "Go to next hunk")

    map("n", "]H", function()
      gitsigns.nav_hunk("last")
    end, "Go to last hunk")

    map("n", "<leader>hp", function()
      gitsigns.preview_hunk_inline()
    end, "Preview hunk inline")

    map("n", "=", function()
      gitsigns.preview_hunk_inline()
    end, "Preview hunk inline")

    map("n", "<leader>hQ", function()
      gitsigns.setqflist("all")
    end, "Open repo hunks in quickfix")

    map("n", "<leader>hq", gitsigns.setqflist, "Open buffer hunks in quickfix")

    map({ "o", "x" }, "ih", gitsigns.select_hunk, "Select hunk")
  end,
})
