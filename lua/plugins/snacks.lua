---@type LazySpec
return {
  "folke/snacks.nvim",
  priority = 1000,
  lazy = false,
  ---@module 'snacks'
  ---@type snacks.Config
  opts = {
    -- your configuration comes here
    -- or leave it empty to use the default settings
    -- refer to the configuration section below
    bigfile = { enabled = true },
    indent = { enabled = true },
    input = { enabled = true },
    notifier = { enabled = true },
    picker = { enabled = true, layout = "bottom" },
    quickfile = { enabled = true },
    scope = { enabled = true },
    -- scroll = { enabled = true },
    statuscolumn = { enabled = true },
    words = { enabled = true },
  },
  init = function()
    vim.api.nvim_create_user_command("Help", function(_)
      Snacks.picker.help()
    end, { desc = "Search help tags" })

    ---@type table<number, {token:lsp.ProgressToken, msg:string, done:boolean}[]>
    local progress = vim.defaulttable()
    vim.api.nvim_create_autocmd("LspProgress", {
      ---@param ev {data: {client_id: integer, params: lsp.ProgressParams}}
      callback = function(ev)
        local client = vim.lsp.get_client_by_id(ev.data.client_id)
        local value = ev.data.params.value --[[@as {percentage?: number, title?: string, message?: string, kind: "begin" | "report" | "end"}]]
        if not client or type(value) ~= "table" then
          return
        end
        local p = progress[client.id]

        for i = 1, #p + 1 do
          if i == #p + 1 or p[i].token == ev.data.params.token then
            p[i] = {
              token = ev.data.params.token,
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

        local spinner = { "⠋", "⠙", "⠹", "⠸", "⠼", "⠴", "⠦", "⠧", "⠇", "⠏" }
        vim.notify(table.concat(msg, "\n"), "info", {
          id = "lsp_progress",
          title = client.name,
          opts = function(notif)
            notif.icon = #progress[client.id] == 0 and " "
              or spinner[math.floor(vim.uv.hrtime() / (1e6 * 80)) % #spinner + 1]
          end,
        })
      end,
    })
  end,
  keys = {
    -- Top Pickers & Explorer
    {
      "<leader><space>",
      function()
        Snacks.picker.smart()
      end,
      desc = "Smart Find Files",
    },
    {
      "<leader>/",
      function()
        Snacks.picker.grep()
      end,
      desc = "Grep",
    },
    {
      "<leader>:",
      function()
        Snacks.picker.command_history()
      end,
      desc = "Command History",
    },
    -- {
    --   "<leader>e",
    --   function()
    --     Snacks.explorer()
    --   end,
    --   desc = "File Explorer",
    -- },
    -- find
    {
      "<leader>fc",
      function()
        Snacks.picker.files({ cwd = vim.fn.stdpath("config") })
      end,
      desc = "Find Config File",
    },
    {
      "<leader>ff",
      function()
        Snacks.picker.files({ layout = "bottom" })
      end,
      desc = "[F]ind [F]iles",
    },
    {
      "<leader>fg",
      function()
        Snacks.picker.git_files()
      end,
      desc = "Find Git Files",
    },
    {
      "<leader>fp",
      function()
        Snacks.picker.projects()
      end,
      desc = "Projects",
    },
    {
      "<leader>fr",
      function()
        Snacks.picker.recent()
      end,
      desc = "Recent",
    },
    -- Grep
    {
      "<leader>sb",
      function()
        Snacks.picker.lines()
      end,
      desc = "Buffer Lines",
    },
    {
      "<leader>sB",
      function()
        Snacks.picker.grep_buffers()
      end,
      desc = "Grep Open Buffers",
    },
    {
      "<leader>sg",
      function()
        Snacks.picker.grep()
      end,
      desc = "Grep",
    },
    {
      "<leader>sw",
      function()
        Snacks.picker.grep_word()
      end,
      desc = "Visual selection or word",
      mode = { "n", "x" },
    },
    -- search
    {
      "<leader>sb",
      function()
        Snacks.picker.lines()
      end,
      desc = "Buffer Lines",
    },
    {
      "<leader>sd",
      function()
        Snacks.picker.diagnostics()
      end,
      desc = "Diagnostics",
    },
    {
      "<leader>sD",
      function()
        Snacks.picker.diagnostics_buffer()
      end,
      desc = "Buffer Diagnostics",
    },
    {
      "<leader>sh",
      function()
        Snacks.picker.help()
      end,
      desc = "Help Pages",
    },
    {
      "<leader>si",
      function()
        Snacks.picker.icons()
      end,
      desc = "Icons",
    },
    {
      "<leader>sp",
      function()
        Snacks.picker.lazy()
      end,
      desc = "Search for Plugin Spec",
    },
    -- LSP
    -- {
    --   "gd",
    --   function()
    --     Snacks.picker.lsp_definitions()
    --   end,
    --   desc = "Goto Definition",
    -- },
    -- {
    --   "gD",
    --   function()
    --     Snacks.picker.lsp_declarations()
    --   end,
    --   desc = "Goto Declaration",
    -- },
    -- {
    --   "gr",
    --   function()
    --     Snacks.picker.lsp_references()
    --   end,
    --   nowait = true,
    --   desc = "References",
    -- },
    -- {
    --   "gI",
    --   function()
    --     Snacks.picker.lsp_implementations()
    --   end,
    --   desc = "Goto Implementation",
    -- },
    -- {
    --   "gy",
    --   function()
    --     Snacks.picker.lsp_type_definitions()
    --   end,
    --   desc = "Goto T[y]pe Definition",
    -- },
    -- {
    --   "<leader>ss",
    --   function()
    --     Snacks.picker.lsp_symbols()
    --   end,
    --   desc = "LSP Symbols",
    -- },
    -- {
    --   "<leader>sS",
    --   function()
    --     Snacks.picker.lsp_workspace_symbols()
    --   end,
    --   desc = "LSP Workspace Symbols",
    -- },
  },
}
