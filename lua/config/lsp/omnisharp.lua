local utils = require("config.lsp.utils")

---Finds the possible Targets
---@param fname string @The name of the file to find possible targets for
---@return string[] @The possible targets.
local function find_possible_targets(fname)
	local targets = {}
	local sln_matcher = utils.matcher_for_pattern("*sln")
	local csproj_matcher = utils.matcher_for_pattern("*csproj")
	for path in utils.path.iterate_parents(fname) do
		local sln_targets = sln_matcher(path)
		if #sln_targets > 0 then
			vim.list_extend(targets, sln_targets)
			break
		end
		vim.list_extend(targets, vim.tbl_map(utils.path.dirname, csproj_matcher(path)))
	end

	local cwd = vim.fn.getcwd()
	if utils.path.is_descendant(cwd, fname) and not vim.tbl_contains(targets, cwd) then
		table.insert(targets, cwd)
	end

	return targets
end

local M = {}

M.server_config = {
	default_cmd = { "omnisharp" },
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
	if not utils.bufname_valid(bufname) then
		return
	end

	local bufpath = utils.path.sanitize(bufname)
	local targets = find_possible_targets(bufpath)
	if #targets == 1 then
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

	local args = {}
	vim.list_extend(args, { "-z", "-lsp" })
	vim.list_extend(args, { "--encoding", "utf-8" })
	vim.list_extend(args, { "-hpid", tostring(vim.fn.getpid()) })
	vim.list_extend(args, { "-s", target })
	vim.list_extend(args, {
		"DotNet:enablePackageRestore=false",
		"FormattingOptions:EnableEditorConfigSupport=true",
		"FormattingOptions:OrganizeImports=true",
		-- "MsBuild:LoadProjectsOnDemand=true",
		"RoslynExtensionsOptions:EnableAnalyzersSupport=true",
		"RoslynExtensionsOptions:EnableImportCompletion=true",
		-- "Sdk:IncludePrereleases=true",
		"RoslynExtensionsOptions:AnalyzeOpenDocumentsOnly=true",
	})

	local capabilities = vim.lsp.protocol.make_client_capabilities()
	local ok, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
	if ok then
		-- nvim-cmp supports additional completion capabilities
		capabilities = cmp_nvim_lsp.default_capabilities(capabilities)
	end

	local client_id = M.client_by_target[target]
	if client_id == nil then
		client_id = vim.lsp.start_client({
			name = "omnisharp",
			capabilities = capabilities,
			cmd = { unpack(M.server_config.default_cmd), unpack(args) },
			on_init = function()
				vim.notify(
					"Omnisharp client initialized with target " .. vim.fn.fnamemodify(target, ":~:."),
					vim.log.levels.INFO
				)
			end,
			on_attach = function(client, bufnr)
				client.server_capabilities.semanticTokensProvider = {
					legend = {
						tokenModifiers = { "static" },
						tokenTypes = {
							"comment",
							"excluded",
							"identifier",
							"keyword",
							"keyword",
							"number",
							"operator",
							"operator",
							"preprocessor",
							"string",
							"whitespace",
							"text",
							"static",
							"preprocessor",
							"punctuation",
							"string",
							"string",
							"class",
							"delegate",
							"enum",
							"interface",
							"module",
							"struct",
							"typeParameter",
							"field",
							"enumMember",
							"constant",
							"local",
							"parameter",
							"method",
							"method",
							"property",
							"event",
							"namespace",
							"label",
							"xml",
							"xml",
							"xml",
							"xml",
							"xml",
							"xml",
							"xml",
							"xml",
							"xml",
							"xml",
							"xml",
							"xml",
							"xml",
							"xml",
							"xml",
							"xml",
							"xml",
							"xml",
							"xml",
							"xml",
							"xml",
							"regex",
							"regex",
							"regex",
							"regex",
							"regex",
							"regex",
							"regex",
							"regex",
							"regex",
						},
					},
					range = true,
					full = vim.empty_dict(),
				}

				vim.schedule_wrap(M.server_config.on_attach)(client, bufnr)
			end,
			on_exit = function()
				M.client_by_target[target] = nil
			end,
		})
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
