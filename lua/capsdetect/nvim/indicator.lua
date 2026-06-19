local win = nil
local buf = nil

local window_config = {
	relative = "cursor",
	row = -1,
	col = 0,
	width = 4,
	height = 1,
	style = "minimal",
	border = "none",
}

local function close_window()
	if win ~= nil and vim.api.nvim_win_is_valid(win) then
		vim.api.nvim_win_close(win, true)
	end

	win = nil
end

local function get_buffer()
	if buf ~= nil and vim.api.nvim_buf_is_valid(buf) then
		return buf
	end

	buf = vim.api.nvim_create_buf(false, true)
	vim.api.nvim_buf_set_lines(buf, 0, -1, false, { "CAPS" })
	vim.api.nvim_buf_add_highlight(buf, -1, "ErrorMsg", 0, 0, -1)

	return buf
end

local function open_window()
	win = vim.api.nvim_open_win(get_buffer(), false, window_config)
end

local function update_window(state)
	if not state then
		close_window()
		return
	end

	if win ~= nil and vim.api.nvim_win_is_valid(win) then
		vim.api.nvim_win_set_config(win, window_config)
		return
	end

	open_window()
end

return update_window
