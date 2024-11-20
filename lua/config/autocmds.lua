-- Use absolute line numbers during insert mode only
vim.api.nvim_create_autocmd({ "InsertEnter", "InsertLeave" }, {
	desc = "Display absolute line number in Insert mode",
	callback = function(opts)
		if vim.wo.number then
			vim.wo.relativenumber = opts.event == "InsertLeave"
		end
	end,
})

-- Use absolute numbers on unfocused windows
vim.api.nvim_create_autocmd({ "WinLeave", "WinEnter" }, {
	desc = "Display absolute line number on inactive windows",
	callback = function(opts)
		if vim.wo.number then
			vim.wo.relativenumber = opts.event == "WinEnter"
		end
	end,
})

-- Don't show any numbers inside terminals
vim.api.nvim_create_autocmd("TermOpen", {
	desc = "Display absolute line number on inactive windows",
	callback = function()
		vim.wo.number = false
		vim.wo.relativenumber = false
	end,
})

-- Filetype specific indenting
vim.api.nvim_create_autocmd("FileType", {
	desc = "Display absolute line number on inactive windows",
	pattern = "python",
	callback = function()
		vim.bo.tabstop = 4
		vim.bo.shiftwidth = 4
		vim.bo.softtabstop = 4
	end,
})

-- Highlight on yank
vim.api.nvim_create_autocmd("TextYankPost", {
	callback = function()
		vim.highlight.on_yank({ on_visual = false })
	end,
})

-- LSP Progress notification
---@type table<number, {token:lsp.ProgressToken, msg:string, done:boolean}[]>
local progress = vim.defaulttable()
vim.api.nvim_create_autocmd("LspProgress", {
	---@param ev {data: {client_id: integer, params: lsp.ProgressParams}}
	callback = function(ev)
		local client = vim.lsp.get_client_by_id(ev.data.client_id)
		local value = ev.data.params.value --[[@as {percentage?: number, title?: string, message?: string, kind: "begin" | "report" | "end"}]]
		if not client or type(value) ~= "table" then
			return
		end
		local p = progress[client.id]

		for i = 1, #p + 1 do
			if i == #p + 1 or p[i].token == ev.data.params.token then
				p[i] = {
					token = ev.data.params.token,
					msg = ("[%3d%%] %s%s"):format(
						value.kind == "end" and 100 or value.percentage or 100,
						value.title or "",
						value.message and (" **%s**"):format(value.message) or ""
					),
					done = value.kind == "end",
				}
				break
			end
		end

		local msg = {} ---@type string[]
		progress[client.id] = vim.tbl_filter(function(v)
			return table.insert(msg, v.msg) or not v.done
		end, p)

		local spinner = { "⠋", "⠙", "⠹", "⠸", "⠼", "⠴", "⠦", "⠧", "⠇", "⠏" }
		vim.notify(table.concat(msg, "\n"), vim.log.levels.INFO, {
			id = "lsp_progress",
			title = client.name,
			opts = function(notif)
				notif.icon = #progress[client.id] == 0 and " "
					or spinner[math.floor(vim.uv.hrtime() / (1e6 * 80)) % #spinner + 1]
			end,
		})
	end,
})
