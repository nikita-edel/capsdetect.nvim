local OS = vim.loop.os_uname().sysname
local get_caps_fn = nil
if OS == "Linux" then
	get_caps_fn = require("capsdetect.platform.linux")
elseif OS == "Darwin" then
	get_caps_fn = require("capsdetect.platform.macos")
elseif vim.fn.has("win32") == 1 then
	get_caps_fn = require("capsdetect.platform.windows")
else
	error("capsdetect: unsupported OS", 0)
end

if type(get_caps_fn) ~= "function" then
	error("capsdetect: failed to load get_caps callback", 0)
end

return get_caps_fn
