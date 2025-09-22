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

function M.copy_line()
	local line = vim.api.nvim_get_current_line()
	if cfg.remove_indent then
		line = TrimIndent(line)
	end
	M.copy(line)
	local line_num = vim.fn.line(".")
	print("Copied line " .. line_num .. ": " .. line)
end

function M.copy_context()
	local res = M.copy("")
	print("Copied context: " .. res)
end

---@param selection string
---@return string
function M.copy(selection)
	local file = vim.fn.expand("%:p")
	if #cfg.prefix ~= 0 and file:sub(1, #cfg.prefix) == cfg.prefix then
		file = file:sub(#cfg.prefix + 1)
	end
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

---@param str string
---@return string
function TrimIndent(str)
	return str:match("^%s*(.-)%s*$")
end

return M
