local M = {}

M.active_refreshes = {}

function M.refresh_codelens(client, bufnr)
	if M.active_refreshes[bufnr] then
		return
	end
	M.active_refreshes[bufnr] = true
	client.request("textDocument/codeLens", {
		textDocument = vim.lsp.util.make_text_document_params(),
	}, function(err, res, ctx, cfg)
		for _, lens in ipairs(res) do
			client.request("codeLens/resolve", lens, M.handle_codelens, bufnr)
		end
	end, bufnr)
end

function M.handle_codelens(err, res, ctx, cfg)
	M.active_refreshes[ctx.bufnr] = nil
	-- vim.notify("CodeLens: " .. vim.inspect(res))
end

function M.on_attach(client, bufnr)
	vim.api.nvim_create_autocmd("CursorHold", {
		buffer = bufnr,
		callback = function()
			M.refresh_codelens(client, bufnr)
		end,
	})
end

return M
