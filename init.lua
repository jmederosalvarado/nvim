---@type "catppuccin"
vim.g.colorscheme = "catppuccin"

require("config.opts")
require("config.maps")
require("config.autocmds")
require("config.appearance")
require("config.lazy")

_G.iprint = function(...)
	print(vim.inspect(...))
end
