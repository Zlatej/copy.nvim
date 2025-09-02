local M = {}

local cfg = {}

function M.setup(opts)
	local config = require("copy.config")
	cfg = config.setup(opts)

	vim.api.nvim_create_user_command("Copy line with context", M.copy_line, {})
	vim.api.nvim_create_user_command("Copy context", M.copy_context, {})
	vim.keymap.set("n", cfg.keymap.cp_line, M.copy_line, { desc = "Copies line with context" })
	vim.keymap.set("n", cfg.keymap.cp_visual, M.copy_context, { desc = "Copies context" })
end

function M.copy_line()
	local line = vim.api.nvim_get_current_line()
	M.copy(line)
end

function M.copy_context()
	M.copy("")
end

---@param selection string|string[]
function M.copy(selection)
	local file = vim.fn.expand("%:p")
	if cfg.prefix and file:sub(1, #cfg.prefix) == cfg.prefix then
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
	print("Copied line " .. line_num .. ": " .. selection)
end

return M
