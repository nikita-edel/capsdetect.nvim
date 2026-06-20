local macos_cg = nil

local ffi_ok, ffi = pcall(require, "ffi")

if ffi_ok then
	pcall(
		ffi.cdef,
		[[
			typedef int CGEventSourceStateID;
			typedef unsigned long long CGEventFlags;
			CGEventFlags CGEventSourceFlagsState(CGEventSourceStateID stateID);
		]]
	)

	local cg_ok, cg = pcall(
		ffi.load,
		"/System/Library/Frameworks/CoreGraphics.framework/CoreGraphics"
	)

	if cg_ok then
		macos_cg = cg
	end
else
	error("failed to load ffi", 0)
end

local function get_macos_caps()
	if macos_cg == nil then
		-- silently fail
		return false
	end

	local flags = tonumber(macos_cg.CGEventSourceFlagsState(1))

	return math.floor(flags / 0x00010000) % 2 == 1
end

return get_macos_caps
