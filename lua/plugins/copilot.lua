---@type LazySpec
return {
  "zbirenbaum/copilot.lua",
  event = "InsertEnter",
  enabled = false,
  cmd = "Copilot",
  ---@module 'copilot'
  ---@type copilot_config
  opts = {
    suggestion = {
      auto_trigger = true,
      keymap = {
        accept = "<Tab>",
      },
    },
  },
}
