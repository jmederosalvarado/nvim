local M = {}

local vim = vim
local validate = vim.validate
local api = vim.api
local lsp = vim.lsp
local uv = vim.loop

local is_windows = uv.os_uname().sysname == "Windows_NT"

function M.bufname_valid(bufname)
	if #bufname > 0 and (bufname:match("^/") or bufname:match("^[a-zA-Z]:")) then
		return true
	end

	return false
end

-- Some path utilities
M.path = (function()
	local function escape_wildcards(path)
		return path:gsub("([%[%]%?%*])", "\\%1")
	end

	local function sanitize(path)
		if is_windows then
			path = path:sub(1, 1):upper() .. path:sub(2)
			path = path:gsub("\\", "/")
		end
		return path
	end

	local function exists(filename)
		local stat = uv.fs_stat(filename)
		return stat and stat.type or false
	end

	local function is_dir(filename)
		return exists(filename) == "directory"
	end

	local function is_file(filename)
		return exists(filename) == "file"
	end

	local function is_fs_root(path)
		if is_windows then
			return path:match("^%a:$")
		else
			return path == "/"
		end
	end

	local function is_absolute(filename)
		if is_windows then
			return filename:match("^%a:") or filename:match("^\\\\")
		else
			return filename:match("^/")
		end
	end

	local function dirname(path)
		local strip_dir_pat = "/([^/]+)$"
		local strip_sep_pat = "/$"
		if not path or #path == 0 then
			return
		end
		local result = path:gsub(strip_sep_pat, ""):gsub(strip_dir_pat, "")
		if #result == 0 then
			if is_windows then
				return path:sub(1, 2):upper()
			else
				return "/"
			end
		end
		return result
	end

	local function path_join(...)
		return table.concat(vim.tbl_flatten({ ... }), "/")
	end

	-- Traverse the path calling cb along the way.
	local function traverse_parents(path, cb)
		path = uv.fs_realpath(path)
		local dir = path
		-- Just in case our algo is buggy, don't infinite loop.
		for _ = 1, 100 do
			dir = dirname(dir)
			if not dir then
				return
			end
			-- If we can't ascend further, then stop looking.
			if cb(dir, path) then
				return dir, path
			end
			if is_fs_root(dir) then
				break
			end
		end
	end

	-- Iterate the path until we find the rootdir.
	local function iterate_parents(path)
		local function it(_, v)
			if v and not is_fs_root(v) then
				v = dirname(v)
			else
				return
			end
			if v and uv.fs_realpath(v) then
				return v, path
			else
				return
			end
		end
		return it, path, path
	end

	local function is_descendant(root, path)
		if not path then
			return false
		end

		local function cb(dir, _)
			return dir == root
		end

		local dir, _ = traverse_parents(path, cb)

		return dir == root
	end

	local path_separator = is_windows and ";" or ":"

	return {
		escape_wildcards = escape_wildcards,
		is_dir = is_dir,
		is_file = is_file,
		is_absolute = is_absolute,
		exists = exists,
		dirname = dirname,
		join = path_join,
		sanitize = sanitize,
		traverse_parents = traverse_parents,
		iterate_parents = iterate_parents,
		is_descendant = is_descendant,
		path_separator = path_separator,
	}
end)()

function M.search_ancestors(startpath, func)
	validate({ func = { func, "f" } })
	local matches = func(startpath)
	if matches then
		return startpath, matches
	end
	local guard = 100
	for path in M.path.iterate_parents(startpath) do
		-- Prevent infinite recursion if our algorithm breaks
		guard = guard - 1
		if guard == 0 then
			return
		end

		if func(path) then
			return path
		end
	end
end

function M.matcher_for_pattern(pattern)
	return function(path)
		local matches = {}
		for _, p in ipairs(vim.fn.glob(M.path.join(M.path.escape_wildcards(path), pattern), true, true)) do
			if M.path.exists(p) then
				table.insert(matches, p)
			end
		end
		return matches
	end
end

function M.find_git_ancestor(startpath)
	return M.search_ancestors(startpath, function(path)
		-- Support git directories and git files (worktrees)
		if M.path.is_dir(M.path.join(path, ".git")) or M.path.is_file(M.path.join(path, ".git")) then
			return path
		end
	end)
end

function M.find_node_modules_ancestor(startpath)
	return M.search_ancestors(startpath, function(path)
		if M.path.is_dir(M.path.join(path, "node_modules")) then
			return path
		end
	end)
end

function M.find_package_json_ancestor(startpath)
	return M.search_ancestors(startpath, function(path)
		if M.path.is_file(M.path.join(path, "package.json")) then
			return path
		end
	end)
end

function M.insert_package_json(config_files, field)
	local root_with_package = M.find_package_json_ancestor(vim.fn.expand("%:p:h"))

	if root_with_package then
		-- only add package.json if it contains field parameter
		local path_sep = is_windows and "\\" or "/"
		for line in io.lines(root_with_package .. path_sep .. "package.json") do
			if line:find(field) then
				table.insert(config_files, "package.json")
				break
			end
		end
	end
	return config_files
end

function M.get_active_clients_list_by_ft(filetype)
	local clients = vim.lsp.get_active_clients()
	local clients_list = {}
	for _, client in pairs(clients) do
		local filetypes = client.config.filetypes or {}
		for _, ft in pairs(filetypes) do
			if ft == filetype then
				table.insert(clients_list, client.name)
			end
		end
	end
	return clients_list
end

function M.get_other_matching_providers(filetype)
	local configs = require("lspconfig.configs")
	local active_clients_list = M.get_active_clients_list_by_ft(filetype)
	local other_matching_configs = {}
	for _, config in pairs(configs) do
		if not vim.tbl_contains(active_clients_list, config.name) then
			local filetypes = config.filetypes or {}
			for _, ft in pairs(filetypes) do
				if ft == filetype then
					table.insert(other_matching_configs, config)
				end
			end
		end
	end
	return other_matching_configs
end

function M.get_active_client_by_name(bufnr, servername)
	for _, client in pairs(vim.lsp.get_active_clients({ bufnr = bufnr })) do
		if client.name == servername then
			return client
		end
	end
end

return M
