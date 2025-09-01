local M = {}

function M.setup(opts)
	opts = opts or {}
	vim.api.nvim_create_user_command("Copy line with context", M.copy_line, {})
	vim.api.nvim_create_user_command("Copy selection with context", M.copy_selection, {})
	local keymap_line = opts.keymap or "<leader>cc"
	local keymap_selection = opts.keymap or "<leader>cc"
	vim.keymap.set("n", keymap_line, M.copy_line, { desc = "Copies line with context" })
	vim.keymap.set("v", keymap_selection, M.copy_selection, { desc = "Copies selection with context" })
end

function M.copy_line()
	local line = vim.api.nvim_get_current_line()
	M.copy(line)
end

---@param selection string
function M.copy(selection)
	local file = vim.fn.expand("%:p")
	local line_num = vim.fn.line(".")

	local res = string.format("%s:%d\n%s", file, line_num, selection)
	vim.fn.setreg("+", res)
end

return M
