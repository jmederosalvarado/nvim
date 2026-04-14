require("mini.ai").setup()
require("mini.align").setup()
require("mini.sessions").setup({
  autoread = false,
  autowrite = true,
})
require("mini.surround").setup()

require("mini.bracketed").setup()
require("mini.notify").setup()
