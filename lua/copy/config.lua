local M = {}

M.defaults = {
	keymap = {
		cp_context = "<leader>cc",
		cp_line = "<leader>cl",
		cp_visual = "<leader>cc",
	},
	-- Prefix to strip absolute path
	prefix = nil,
}

function M.setup(custom_opts)
	custom_opts = custom_opts or {}
	return vim.tbl_deep_extend("force", M.defaults, custom_opts)
end

return M
