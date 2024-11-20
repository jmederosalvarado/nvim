local default_get_option = vim.filetype.get_option
---@diagnostic disable-next-line: duplicate-set-field
vim.filetype.get_option = function(filetype, option)
	if option == "commentstring" then
		require("ts_context_commentstring.internal").calculate_commentstring()
	end
	return default_get_option(filetype, option)
end

return {
	"JoosepAlviste/nvim-ts-context-commentstring",
	opts = { enable_autocmd = false },
}
