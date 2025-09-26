local function spin(done)
  -- local spinner = { "⠋", "⠙", "⠹", "⠸", "⠼", "⠴", "⠦", "⠧", "⠇", "⠏" }
  local spinner = { "", "", "", "", "", "" }
  if not done then -- "✔"
    return spinner[math.floor(vim.uv.hrtime() / (1e6 * 80)) % #spinner + 1]
  else
    return "✔"
  end
end

---@type table<number, {token:lsp.ProgressToken, msg:string, done:boolean}[]>
local progress = vim.defaulttable()
vim.api.nvim_create_autocmd("LspProgress", {
  ---@param e {data: {client_id: integer, params: lsp.ProgressParams}}
  callback = function(e)
    local client = vim.lsp.get_client_by_id(e.data.client_id)
    local value = e.data.params.value --[[@as {percentage?: number, title?: string, message?: string, kind: "begin" | "report" | "end"}]]
    if not client or type(value) ~= "table" then
      return
    end
    local p = progress[client.id]

    for i = 1, #p + 1 do
      if i == #p + 1 or p[i].token == e.data.params.token then
        p[i] = {
          token = e.data.params.token,
          msg = ("[%3d%%] %s%s"):format(
            value.kind == "end" and 100 or value.percentage or 100,
            value.title or "",
            value.message and (" **%s**"):format(value.message) or ""
          ),
          done = value.kind == "end",
        }
        break
      end
    end

    local msg = {} ---@type string[]
    progress[client.id] = vim.tbl_filter(function(v)
      return table.insert(msg, v.msg) or not v.done
    end, p)

    vim.notify(table.concat(msg, "\n"), vim.log.levels.INFO, {
      id = "lsp_progress",
      title = client.name,
      opts = function(notif)
        notif.icon = spin(#progress[client.id] == 0)
      end,
    })
  end,
})

vim.api.nvim_create_autocmd("LspAttach", {
  group = vim.api.nvim_create_augroup("lspconfig", { clear = true }),
  desc = "Configure everything when language server attaches to buffer",
  callback = function(args)
    local client = assert(vim.lsp.get_client_by_id(args.data.client_id), "Couldn't get LSP client from id")

    -- Enable inlay hints for servers with support
    if client.server_capabilities.inlayHintProvider then
      vim.lsp.inlay_hint.enable(true, { bufnr = args.buf })
    end

    -- if client:supports_method("textDocument/foldingRange") then
    --   vim.wo.foldlevel = 99
    --   vim.wo.foldmethod = "expr"
    --   vim.wo.foldexpr = "v:lua.vim.lsp.foldexpr()"
    -- end
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
vim.lsp.enable({ "lua_ls", "gopls", "rust_analyzer", "taplo" })
