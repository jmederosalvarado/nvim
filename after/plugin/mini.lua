require("mini.ai").setup()
require("mini.align").setup()
require("mini.sessions").setup({
  autoread = true,
  autowrite = true,
})
require("mini.surround").setup()

require("mini.bracketed").setup()
require("mini.notify").setup()

-- require("mini.diff").setup({
--   view = {
--     style = "sign",
--   },
-- })

-- vim.keymap.set("n", "<leader>ph", function()
--   require("mini.diff").toggle_overlay(0)
-- end, { desc = "Toggle diff overlay in current buffer" })
