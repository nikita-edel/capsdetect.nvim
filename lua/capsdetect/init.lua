local config = require("capsdetect.config")
local scheduler = require("capsdetect.capsdetect")

local M = {}

M.get_caps_state = scheduler.get_caps_state

function M.setup(opts)
	config.setup(opts)
	scheduler.start()

	return M
end

function M.start()
	scheduler.start()
end

function M.stop()
	scheduler.stop()
end

M.setup()

return M
