local M = {}

local cfg = {}

function M.setup(opts)
	local config = require("copy.config")
	cfg = config.setup(opts)

	vim.api.nvim_create_user_command("Copy line with context", M.copy_line, {})
	vim.keymap.set("n", cfg.keymap.line, M.copy_line, { desc = "Copies line with context" })
end

function M.copy_line()
	local line = vim.api.nvim_get_current_line()
	M.copy(line)
end

function M.copy(selection)
	local file = vim.fn.expand("%:p")
	if cfg.prefix and file:sub(1, #cfg.prefix) == cfg.prefix then
		file = file:sub(#cfg.prefix + 1)
	end
	local line_num = vim.fn.line(".")

	local res = string.format("%s:%d\n%s", file, line_num, selection)
	vim.fn.setreg("+", res)
	print("Copied line " .. line_num .. ": " .. selection)
end

return M
