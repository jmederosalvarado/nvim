vim.keymap.set("x", "<Leader>yr", function()
  -- Make the current buffer path relative to the working directory.
  local file = vim.fn.fnamemodify(vim.api.nvim_buf_get_name(0), ":.")
  if file == "" then
    vim.notify("Current buffer has no file name", vim.log.levels.WARN)
    return
  end

  -- Visual mode marks can be returned in either order, so normalize them.
  local start_line = vim.fn.line("'<")
  local end_line = vim.fn.line("'>")
  if start_line > end_line then
    start_line, end_line = end_line, start_line
  end

  -- Format the location as file:line or file:first-last for multi-line ranges.
  local text = file .. ":" .. start_line
  if start_line ~= end_line then
    text = text .. "-" .. end_line
  end

  -- Write directly to the primary X clipboard register.
  vim.fn.setreg("*", text)
end, {
  desc = "Copy relative file path and selected line range to *",
  silent = true,
})
