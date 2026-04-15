vim.api.nvim_create_autocmd("LspAttach", {
  group = vim.api.nvim_create_augroup("lsp_attach", { clear = true }),
  desc = "Configure everything when language server attaches to buffer",
  callback = function(args)
    local client = assert(vim.lsp.get_client_by_id(args.data.client_id), "Couldn't get LSP client from id")

    -- Enable builtin vim.lsp completion
    vim.lsp.completion.enable(true, client.id, args.buf, { autotrigger = true })
    vim.keymap.set("i", "<C-Space>", function()
      vim.lsp.completion.get()
    end, { buffer = args.buf, desc = "Use CTRL-space to trigger LSP completion" })

    -- Enable inlay hints for servers with support
    if client.server_capabilities.inlayHintProvider then
      vim.lsp.inlay_hint.enable(true, { bufnr = args.buf })
    end

    -- Enable code lenses for servers with support
    -- if client.server_capabilities.codeLensProvider then
    --   vim.lsp.codelens.enable(true, { bufnr = args.buf })
    -- end
  end,
})

-- Enable language servers
vim.lsp.enable({ "lua_ls", "rust_analyzer", "taplo" })
