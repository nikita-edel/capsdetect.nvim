local defaults = {
	schedule = {
		dont_schedule = false,
		refresh_ms = 100,
		callback = nil,
		use_indicator = true,
		update_global = true,
	},
}

local M = {}
M.options = vim.deepcopy(defaults)

function M.setup(opts)
	M.options =
		vim.tbl_deep_extend("force", vim.deepcopy(defaults), opts or {})

	return M
end

return M
