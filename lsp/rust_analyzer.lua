-- Session-local overrides applied to active rust-analyzer clients and re-applied
-- to newly attached clients without changing the base config in this file.
local ra_runtime_overrides = {}

local ra_toggle_specs = {
  test_cfg = {
    default = true,
    label = "cfg.setTest",
    path = { "cfg", "setTest" },
    patch = function(value)
      return {
        ["rust-analyzer"] = {
          cfg = {
            setTest = value,
          },
        },
      }
    end,
  },
  exclude_test_refs = {
    default = false,
    label = "references.excludeTests",
    path = { "references", "excludeTests" },
    patch = function(value)
      return {
        ["rust-analyzer"] = {
          references = {
            excludeTests = value,
          },
        },
      }
    end,
  },
}

if vim.fn.exists(":RAToggle") == 0 then
  vim.api.nvim_create_user_command("RAToggle", function(opts)
    local spec = ra_toggle_specs[opts.args]
    if not spec then
      vim.notify(("unknown RAToggle target: %s"):format(opts.args), vim.log.levels.ERROR)
      return
    end

    local current = vim.tbl_get(ra_runtime_overrides, "rust-analyzer", unpack(spec.path))
    if current == nil then
      local clients = vim.lsp.get_clients({ bufnr = 0, name = "rust_analyzer" })
      if #clients > 0 then
        -- Fall back to the current buffer's live client state so toggles compose
        -- correctly even if the setting has not been stored in overrides yet.
        current = vim.tbl_get(clients[1].settings, "rust-analyzer", unpack(spec.path))
      end
    end
    if current == nil then
      current = spec.default
    end

    local next_value = not current
    local patch = spec.patch(next_value)

    -- Keep the toggled value around for rust-analyzer clients that attach later in this session.
    ra_runtime_overrides = vim.tbl_deep_extend("force", ra_runtime_overrides, patch)

    for _, client in ipairs(vim.lsp.get_clients({ name = "rust_analyzer" })) do
      -- Neovim answers workspace/configuration from client.settings, so update
      -- the live client state before notifying rust-analyzer about the change.
      client.settings = vim.tbl_deep_extend("force", client.settings or {}, vim.deepcopy(patch))
      client:notify("workspace/didChangeConfiguration", { settings = client.settings })
    end

    vim.notify(("rust-analyzer %s = %s"):format(spec.label, tostring(next_value)))
  end, {
    desc = "Toggle a rust-analyzer runtime setting",
    nargs = 1,
    complete = function()
      return vim.tbl_keys(ra_toggle_specs)
    end,
  })
end

return {
  on_attach = function(client)
    if next(ra_runtime_overrides) == nil then
      return
    end

    -- Re-apply session overrides to new or restarted rust-analyzer clients so
    -- RAToggle persists for the lifetime of this Neovim session.
    client.settings = vim.tbl_deep_extend("force", client.settings or {}, vim.deepcopy(ra_runtime_overrides))
    client:notify("workspace/didChangeConfiguration", { settings = client.settings })
  end,
  settings = {
    ["rust-analyzer"] = {
      check = {
        allTargets = true,
        command = "clippy",
        workspace = false,
      },
      references = {
        excludeImports = true,
      },
    },
  },
}
