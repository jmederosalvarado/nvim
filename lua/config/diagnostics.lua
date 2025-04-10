vim.diagnostic.config({
  -- virtual_lines = {
  --   current_line = true,
  --   format = function(diagnostic)
  --     if diagnostic.severity <= vim.diagnostic.severity.INFO then
  --       return diagnostic.message
  --     end
  --   end,
  -- },
  virtual_text = {
    spacing = 4,
    prefix = "*",
    source = "if_many",
    severity = {
      min = vim.diagnostic.severity.INFO,
    },
  },
  signs = {
    text = {
      [vim.diagnostic.severity.ERROR] = "",
      [vim.diagnostic.severity.WARN] = "",
      [vim.diagnostic.severity.INFO] = "",
    },
    severity = {
      min = vim.diagnostic.severity.INFO,
    },
  },
  severity_sort = true,
  update_in_insert = false,
  underline = false,
  float = { border = "solid" },
})

vim.keymap.set("n", "<leader>pd", function()
  local virtual_lines_config = {
    current_line = false,
    format = function(diagnostic)
      if diagnostic.severity <= vim.diagnostic.severity.INFO then
        return diagnostic.message
      end
    end,
  }
  local virtual_text_config = {
    spacing = 4,
    prefix = "*",
    source = "if_many",
    severity = {
      min = vim.diagnostic.severity.INFO,
    },
  }

  if vim.diagnostic.config().virtual_lines then
    vim.diagnostic.config({
      virtual_lines = false,
      virtual_text = virtual_text_config,
    })
  else
    vim.diagnostic.config({
      virtual_lines = virtual_lines_config,
      virtual_text = false,
    })
  end
end, { desc = "Toggle diagnostic virtual_lines" })
