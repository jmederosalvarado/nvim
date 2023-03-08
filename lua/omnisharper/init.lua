local util = require("lspconfig.util")

local function walk_code_elements(elements, action, recursion_predicate)
	for _, element in ipairs(elements) do
		action(element)

		if element.Children then
			if recursion_predicate and not recursion_predicate(element) then
				return
			end

			walk_code_elements(element.Children, action)
		end
	end
end

local function run_curr_test(client)
	client.request("o#/v2/codestructure", {
		["fileName"] = vim.api.nvim_buf_get_name(0),
		-- ["fileName"] = vim.lsp.util.make_text_document_params().uri,
	}, function(err, res)
		if err then
			vim.notify("Error getting code structure from omnisharp: " .. err.message, vim.log.levels.ERROR)
			return
		end

		local test

		walk_code_elements(res.Elements, function(element)
			if element.Kind ~= "method" then
				return
			end

			local framework = vim.tbl_get(element, "Properties", "testFramework")
			local method_name = vim.tbl_get(element, "Properties", "testMethodName")
			if not framework or not method_name then
				return
			end

			local start_line = vim.tbl_get(element, "Ranges", "full", "Start", "Line")
			local end_line = vim.tbl_get(element, "Ranges", "full", "End", "Line")
			if not start_line or not end_line then
				return
			end

			local cursor_pos = vim.api.nvim_win_get_cursor(0)
			if cursor_pos[1] < start_line or cursor_pos[1] > end_line then
				return
			end

			test = { framework = framework, method_name = method_name }
		end)

		vim.notify("Running test: " .. vim.inspect(test))
	end)
end

---Finds the possible Targets
---@param fname string @The name of the file to find possible targets for
---@return string[], (string|nil) @The possible targets.
local function find_possible_targets(fname)
	local prefered_target = nil
	local targets = {}

	local sln_dir = util.root_pattern("*sln")(fname)
	if sln_dir then
		vim.list_extend(targets, vim.fn.glob(util.path.join(sln_dir, "*.sln"), true, true))
	end

	if #targets == 1 then
		prefered_target = targets[1]
	end

	local csproj_dir = util.root_pattern("*csproj")(fname)
	if csproj_dir then
		table.insert(targets, csproj_dir)
	end

	local git_dir = util.root_pattern(".git")(fname)
	if git_dir and not vim.tbl_contains(targets, git_dir) then
		table.insert(targets, git_dir)
	end

	local cwd = vim.fn.getcwd()
	if util.path.is_descendant(cwd, fname) and not vim.tbl_contains(targets, cwd) then
		table.insert(targets, cwd)
	end

	if #targets == 1 then
		prefered_target = targets[1]
	end

	return targets, prefered_target
end

local M = {}

M.server_config = {
	cmd = nil,
	capabilities = nil,
	on_attach = nil,
}
M.client_by_target = {} ---@type table<string, number|nil>
M.targets_by_bufnr = {} ---@type table<number, string[]>
M.selected_target_by_bufnr = {} ---@type table<number, string|nil>

function M.init_buf_targets(bufnr)
	bufnr = bufnr or vim.api.nvim_get_current_buf()
	if vim.api.nvim_buf_get_option(bufnr, "buftype") == "nofile" then
		return
	end

	if M.targets_by_bufnr[bufnr] ~= nil then
		return
	end

	local bufname = vim.api.nvim_buf_get_name(bufnr)
	if not util.bufname_valid(bufname) then
		return
	end

	local bufpath = util.path.sanitize(bufname)
	local targets, prefered_target = find_possible_targets(bufpath)
	if prefered_target then
		M.selected_target_by_bufnr[bufnr] = targets[1]
	elseif #targets > 1 then
		vim.api.nvim_create_user_command("OmnisharpSelectTarget", function()
			M.select_target(vim.api.nvim_get_current_buf())
		end, { desc = "Selects the target for the current buffer" })

		local active_possible_targets = {}
		for _, target in ipairs(targets) do
			if M.client_by_target[target] then
				table.insert(active_possible_targets, target)
			end
		end
		if #active_possible_targets == 1 then
			M.selected_target_by_bufnr[bufnr] = active_possible_targets[1]
		end
	end
	M.targets_by_bufnr[bufnr] = targets
end

function M.attach_or_spawn(bufnr)
	bufnr = bufnr or vim.api.nvim_get_current_buf()

	local target = M.selected_target_by_bufnr[bufnr]
	if target == nil then
		return
	end

	local client_id = M.client_by_target[target]
	if client_id == nil then
		client_id = require("omnisharper.client").spawn(
			M.server_config.cmd,
			target,
			M.server_config.on_attach,
			M.server_config.capabilities
		)
		if client_id == nil then
			vim.notify(
				"Failed to start omnisharp client for " .. vim.fn.fnamemodify(target, ":~:."),
				vim.log.levels.ERROR
			)
			return
		end
		M.client_by_target[target] = client_id
	end

	if vim.lsp.buf_attach_client(bufnr, client_id) == false then
		vim.notify("Failed to attach omnisharp client for " .. vim.fn.fnamemodify(target, ":~:."), vim.log.levels.ERROR)
	end
end

function M.select_target(bufnr)
	vim.ui.select(M.targets_by_bufnr[bufnr], {
		prompt = "Select target",
	}, function(selected)
		M.selected_target_by_bufnr[bufnr] = selected
		M.attach_or_spawn(bufnr)
	end)
end

function M.setup_autocmds()
	local lsp_group = vim.api.nvim_create_augroup("OmnisharpServer", { clear = true })

	vim.api.nvim_create_autocmd("FileType", {
		pattern = { "cs" },
		callback = function(opt)
			M.init_buf_targets(opt.buf)
			M.attach_or_spawn(opt.buf)
		end,
		group = lsp_group,
		desc = "",
	})
end

function M.setup(config)
	if config ~= nil then
		M.server_config = vim.tbl_deep_extend("force", M.server_config, config)
	end
	M.setup_autocmds()
end

return M
