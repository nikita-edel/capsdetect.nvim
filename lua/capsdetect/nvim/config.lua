local M = {}
local defaults = {
	schedule = {
		update_global = true,
		use_indicator = true,
		refresh_ms = 200,
		callback = nil,
	},
}

M = vim.deepcopy(defaults)

function M.setup(opts)
	local merged = vim.tbl_deep_extend("force", defaults, opts or {})

	for key in pairs(M) do
		M[key] = nil
	end

	for key, value in pairs(merged) do
		M[key] = value
	end
end

return M
