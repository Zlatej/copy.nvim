local log = require("copy.log")
local M = {}

local cfg = {}

function M.setup(opts)
	local config = require("copy.config")
	cfg = config.setup(opts)

	-- Line
	vim.api.nvim_create_user_command("CopyLine", M.copy_line, {})
	vim.keymap.set("n", cfg.keymap.cp_line, M.copy_line, { desc = "Copy line with context" })
	-- Context
	vim.api.nvim_create_user_command("CopyContext", M.copy_context, {})
	vim.keymap.set("n", cfg.keymap.cp_context, M.copy_context, { desc = "Copy context" })
	-- Visual
	-- vim.api.nvim_create_user_command("CopyVisual", M.copy_selection, {})
	-- vim.keymap.set("v", cfg.keymap.cp_visual, M.copy_selection, { desc = "Copy visual selection" })
end

---@param str string
---@return string
local function trimIndent(str)
	return str:match("^%s*(.-)%s*$")
end

function M.copy_line()
	local line = vim.api.nvim_get_current_line()
	if cfg.remove_indent then
		line = trimIndent(line)
	end
	M.copy(line)
	local line_num = vim.fn.line(".")
	print("Copied line " .. line_num .. ": " .. line)
end

function M.copy_context()
	local res = M.copy("")
	print("Copied context: " .. res)
end

---@param path string
---@return string
local function trim_slash(path)
	log.debug(path:sub(1, 1))
	if path:sub(1, 1) == "/" then
		return path:sub(2)
	end
	return path
end

---@param path string
---@return string
local function remove_prefix_path(path)
	for _, fragment in ipairs(cfg.prefixes) do
		log.debug("path=" .. path, "fragment=" .. fragment)
		path = trim_slash(path)
		fragment = trim_slash(fragment)
		log.debug("path=" .. path, "fragment=" .. fragment)
		if path:sub(1, #fragment) == fragment then
			path = path:sub(#fragment + 1)
		end
	end
	return trim_slash(path)
end

---@param selection string
---@return string
function M.copy(selection)
	local file = vim.fn.expand("%:p")
	file = remove_prefix_path(file)
	local line_num = vim.fn.line(".")

	local res
	if #selection ~= 0 then
		res = string.format("%s:%d\n%s", file, line_num, selection)
	else
		res = string.format("%s:%d", file, line_num)
	end

	vim.fn.setreg("+", res)
	return res
end

return M
