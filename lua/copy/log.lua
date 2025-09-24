local M = {}
local log_file = vim.fn.stdpath("data") .. "/copy_nvim_debug.log"

function M.debug(...)
	local args = { ... }
	local message = table.concat(
		vim.tbl_map(function(arg)
			return type(arg) == "table" and vim.inspect(arg) or tostring(arg)
		end, args),
		" "
	)

	local timestamp = os.date("%Y-%m-%d %H:%M:%S")
	local log_entry = string.format("[%s] %s\n", timestamp, message)

	local file = io.open(log_file, "a")
	if file then
		file:write(log_entry)
		file:close()
	end
end

return M
