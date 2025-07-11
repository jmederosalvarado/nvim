--  This function gets run when an LSP connects to a particular buffer.
---@param client vim.lsp.Client
---@param bufnr integer
local on_attach = function(client, bufnr)
  local map = function(keys, func, desc)
    if desc then
      desc = "LSP: " .. desc
    end

    vim.keymap.set("n", keys, func, { buffer = bufnr, desc = desc })
  end

  if client.name == "rust-analyzer" and not vim.lsp.inlay_hint.is_enabled({ bufnr = bufnr }) then
    vim.lsp.inlay_hint.enable(true, { bufnr = bufnr })
  end

  map("gd", vim.lsp.buf.definition, "[G]oto [D]efinition")
  map("gy", vim.lsp.buf.type_definition, "Type [D]efinition")

  -- vim.lsp.completion.enable(true, client.id, bufnr, {
  --   autotrigger = true,
  --   -- convert = function(item) end,
  -- })
end

vim.api.nvim_create_autocmd("LspAttach", {
  callback = function(args)
    local client = vim.lsp.get_client_by_id(args.data.client_id)
    if client == nil then
      error("vim.lsp.get_client_by_id(" .. args.data.client_id .. ") returned nil")
      return
    end
    return on_attach(client, args.buf)
  end,
})

-- vim.lsp.config("basedpyright", {
--   cmd = { "uvx", "--from", "basedpyright", "basedpyright-langserver", "--stdio" },
-- })
vim.lsp.config("ruff", {
  cmd = { "uvx", "ruff", "server" },
})

vim.lsp.enable({ "lua_ls", "rust_analyzer", "gopls", "basedpyright", "ruff", "taplo" })
