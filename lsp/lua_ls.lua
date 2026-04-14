local library = vim.list_extend(
  { vim.env.VIMRUNTIME },
  vim.tbl_map(function(plugin)
    return plugin.path
  end, vim.pack.get())
)

return {
  settings = {
    Lua = {
      runtime = {
        version = "LuaJIT",
        path = { "lua/?.lua", "lua/?/init.lua" },
        pathStrict = true,
      },
      workspace = {
        checkThirdParty = false,
        library = library,
      },
      diagnostics = {
        libraryFiles = "Opened",
      },
    },
  },
}
