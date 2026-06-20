local function get_linux_caps()
	local paths = vim.fn.glob(
		"/sys/class/leds/input*::capslock/brightness",
		false,
		true
	)

	for _, path in ipairs(paths) do
		local ok, lines = pcall(vim.fn.readfile, path, "", 1)
		-- fail silently
		if not ok or lines[1] == nil then
			return false
		end

		if lines[1] == "1" then
			return true
		end
	end
	return false
end

return get_linux_caps
