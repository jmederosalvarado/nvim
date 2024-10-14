--  This function gets run when an LSP connects to a particular buffer.
local on_attach = function(client, bufnr)
	local map = function(keys, func, desc)
		if desc then
			desc = "LSP: " .. desc
		end

		vim.keymap.set("n", keys, func, { buffer = bufnr, desc = desc })
	end

	map("<leader>rn", vim.lsp.buf.rename, "[R]e[n]ame")
	map("<leader>cc", vim.lsp.buf.code_action, "[C]ode [A]ction")

	map("gd", vim.lsp.buf.definition, "[G]oto [D]efinition")
	map("gD", vim.lsp.buf.type_definition, "Type [D]efinition")

	local telescope_builtin = require("lazy-require").require_on_exported_call("telescope.builtin")
	map("gr", telescope_builtin.lsp_references, "[G]o to [R]eferences")
	map("gi", telescope_builtin.lsp_implementations, "[G]o to [I]mplementations")

	map("<leader>ds", telescope_builtin.lsp_document_symbols, "[D]ocument [S]ymbols")
	map("<leader>ws", telescope_builtin.lsp_dynamic_workspace_symbols, "[W]orkspace [S]ymbols")

	-- See `:help K` for why this keymap
	map("K", vim.lsp.buf.hover, "Hover Documentation")
	-- nmap('<C-k>', vim.lsp.buf.signature_help, 'Signature Documentation')

	-- Lesser used LSP functionality
	-- map("gD", vim.lsp.buf.declaration, "[G]oto [D]eclaration")
	-- map("<leader>wa", vim.lsp.buf.add_workspace_folder, "[W]orkspace [A]dd Folder")
	-- map("<leader>wr", vim.lsp.buf.remove_workspace_folder, "[W]orkspace [R]emove Folder")
	-- map("<leader>wl", function()
	-- 	print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
	-- end, "[W]orkspace [L]ist Folders")

	-- we want to use the null-ls formatter, so disable the built-in one
	-- local disable_formatting = { "pyright", "sumneko_lua" }
	-- if vim.tbl_contains(disable_formatting, client.name) then
	--     client.server_capabilities.documentFormattingProvider = false
	-- end

	-- -- CodeLens
	-- local libpl_codelens = require("lazy-require").require_on_exported_call("libpl.codelens")
	-- map("<leader>cl", libpl_codelens.run, "Run [C]ode[L]ens")
	-- vim.api.nvim_create_autocmd({ "BufEnter", "CursorHold", "InsertLeave" }, {
	-- 	buffer = bufnr,
	-- 	callback = function(opts)
	-- 		libpl_codelens.refresh(opts.buf)
	-- 	end,
	-- })
end

vim.api.nvim_create_autocmd("LspAttach", {
	callback = function(args)
		local bufnr = args.buf
		local client = vim.lsp.get_client_by_id(args.data.client_id)
		return on_attach(client)
	end,
})
