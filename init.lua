-- vim.cmd.colorscheme("habamax")
--
require("config.opts")
require("config.maps")
require("config.autocmds")
require("config.lsp")
require("config.appearance")
require("config.lazy")

_G.iprint = function(...)
	print(vim.inspect(...))
end
