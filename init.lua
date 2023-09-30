require("config.opts")
require("config.maps")
require("config.misc")
require("config.lazy")

_G.iprint = function(...)
	print(vim.inspect(...))
end
