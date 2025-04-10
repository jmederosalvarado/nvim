---@type vim.lsp.Config
return {
  cmd = { "rust-analyzer" }, -- this should be set in mason config
  filetypes = { "rust" },
  root_dir = function(bufnr, callback)
    local root = vim.fs.root(bufnr, { "Cargo.toml" })
    if root then
      vim.system(
        { "cargo", "metadata", "--no-deps", "--format-version", "1" },
        { cwd = root },
        function(out)
          if out.code == 0 then
            local ok, data = pcall(vim.json.decode, out.stdout)
            if ok and data and data.workspace_root then
              callback(data.workspace_root)
            end
          end
        end
      )
    end
  end,
  settings = {
    autoformat = true,
    ["rust-analyzer"] = {
      check = {
        command = "clippy",
        allTargets = false,
      },
    },
  },
}
