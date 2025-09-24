local M = {}

M.defaults = {
	keymap = {
		cp_context = "<leader>cc",
		cp_line = "<leader>cl",
		cp_visual = "<leader>cc",
	},
	-- Prefixes to strip absolute path
	prefixes = {},
	remove_indent = true,
}

function M.setup(custom_opts)
	custom_opts = custom_opts or {}
	return vim.tbl_deep_extend("force", M.defaults, custom_opts)
end

return M
