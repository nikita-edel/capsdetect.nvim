local win_user32 = nil
local win_bit = nil

local win_caps = 0x14 -- VK_CAPITAL

local ffi_ok, ffi = pcall(require, "ffi")
if ffi_ok then
	pcall(ffi.cdef, [[short GetKeyState(int nVirtKey);]])

	local user32_ok, user32 = pcall(ffi.load, "user32")
	local bit_ok, bit = pcall(require, "bit")

	if user32_ok and bit_ok then
		win_user32 = user32
		win_bit = bit
	end
else
	error("failed to load ffi", 0)
end

local function get_windows_caps()
	if win_user32 == nil or win_bit == nil then
		-- silently fail
		return false
	end

	return win_bit.band(tonumber(win_user32.GetKeyState(win_caps)), 1) ~= 0
end

return get_windows_caps
