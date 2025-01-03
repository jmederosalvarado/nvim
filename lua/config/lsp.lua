--  This function gets run when an LSP connects to a particular buffer.
---@param client vim.lsp.Client
---@param bufnr integer
local on_attach = function(client, bufnr)
	local map = function(keys, func, desc)
		if desc then
			desc = "LSP: " .. desc
		end

		vim.keymap.set("n", keys, func, { buffer = bufnr, desc = desc })
	end

	-- map("<leader>rn", vim.lsp.buf.rename, "[R]e[n]ame")
	-- map("<leader>cc", vim.lsp.buf.code_action, "[C]ode [A]ction")

	map("gd", vim.lsp.buf.definition, "[G]oto [D]efinition")
	map("gt", vim.lsp.buf.type_definition, "Type [D]efinition")
	--
	-- -- See `:help K` for why this keymap
	-- map("K", vim.lsp.buf.hover, "Hover Documentation")
	-- vim.keymap.set(
	-- 	{ "i", "s" },
	-- 	"<C-k>",
	-- 	vim.lsp.buf.signature_help,
	-- 	{ buffer = bufnr, desc = "Signature Documentation" }
	-- )

	map("gr", function()
		vim.lsp.buf.references()
	end, "[G]o to [R]eferences")
	map("gi", function()
		vim.lsp.buf.implementation()
	end, "[G]o to [I]mplementations")

	-- local telescope_builtin = require("lazy-require").require_on_exported_call("telescope.builtin")
	-- map("gr", telescope_builtin.lsp_references, "[G]o to [R]eferences")
	-- map("gi", telescope_builtin.lsp_implementations, "[G]o to [I]mplementations")
	--
	-- -- map("g0", telescope_builtin.lsp_document_symbols, "[D]ocument [S]ymbols")
	-- map("g0", telescope_builtin.lsp_document_symbols, "[D]ocument [S]ymbols")
	-- map("<leader>ws", telescope_builtin.lsp_dynamic_workspace_symbols, "[W]orkspace [S]ymbols")
end

vim.api.nvim_create_autocmd("LspAttach", {
	callback = function(args)
		local bufnr = args.buf
		local client = vim.lsp.get_client_by_id(args.data.client_id)
		if client == nil then
			error("vim.lsp.get_client_by_id(" .. args.data.client_id .. ") returned nil")
		end
		return on_attach(client, bufnr)
	end,
})
