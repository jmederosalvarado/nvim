--  This function gets run when an LSP connects to a particular buffer.
---@param client vim.lsp.Client
---@param bufnr integer
local on_attach = function(client, bufnr)
  local map = function(keys, func, desc)
    if desc then desc = 'LSP: ' .. desc end

    vim.keymap.set('n', keys, func, { buffer = bufnr, desc = desc })
  end

  if client.name == 'rust_analyzer' and not vim.lsp.inlay_hint.is_enabled({ bufnr = bufnr }) then
    vim.lsp.inlay_hint.enable(true, { bufnr = bufnr })
  end

  map('gd', vim.lsp.buf.definition, '[G]oto [D]efinition')
  map('gt', vim.lsp.buf.type_definition, 'Type [D]efinition')
end

vim.api.nvim_create_autocmd('LspAttach', {
  callback = function(args)
    local client = vim.lsp.get_client_by_id(args.data.client_id)
    if client == nil then
      error('vim.lsp.get_client_by_id(' .. args.data.client_id .. ') returned nil')
      return
    end
    return on_attach(client, args.buf)
  end,
})
