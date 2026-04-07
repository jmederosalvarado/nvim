vim.api.nvim_create_autocmd("LspAttach", {
  group = vim.api.nvim_create_augroup("lspconfig", { clear = true }),
  desc = "Configure everything when language server attaches to buffer",
  callback = function(args)
    local client = assert(vim.lsp.get_client_by_id(args.data.client_id), "Couldn't get LSP client from id")

    vim.lsp.completion.enable(true, client.id, args.buf, { autotrigger = true })

    -- Enable inlay hints for servers with support
    if client.server_capabilities.inlayHintProvider then
      vim.lsp.inlay_hint.enable(true, { bufnr = args.buf })
    end

    -- Enable code lenses for servers with support
    if client.server_capabilities.codeLensProvider then
      vim.lsp.codelens.enable(true, { bufnr = args.buf })
    end
  end,
})

-- Configure Rust Analyzer
vim.lsp.config("rust_analyzer", {
  settings = {
    ["rust-analyzer"] = {
      check = {
        allTargets = true,
        command = "clippy",
        workspace = false,
      },
    },
  },
})

-- Enable language servers
vim.lsp.enable({ "lua_ls", "rust_analyzer", "taplo" })
