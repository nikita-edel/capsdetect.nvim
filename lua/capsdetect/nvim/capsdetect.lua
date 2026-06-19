local config = require("capsdetect.nvim.config")
local get_caps_state = require("capsdetect.nvim.caps_fn")

local M = {
	get_caps_state = get_caps_state,
}

local timer = nil
local update_indicator = nil

local function set_caps(state)
	local schedule = config.options.schedule

	if schedule.update_global then
		vim.g.caps_state = state
	end

	if schedule.use_indicator then
		if update_indicator == nil then
			update_indicator = require("capsdetect.nvim.indicator")
		end

		update_indicator(state)
	end

	if schedule.callback ~= nil then
		if type(schedule.callback) ~= "function" then
			error(
				"capsdetect: schedule callback needs to be a function",
				0
			)
		end

		schedule.callback(state)
	end
end

local function update_capslock()
	vim.schedule(function()
		local state = get_caps_state()

		if state == nil then
			return
		end

		set_caps(state)
	end)
end

function M.start()
	local schedule = config.options.schedule

	if schedule.dont_schedule then
		M.stop()
		return
	end

	if timer ~= nil then
		vim.fn.timer_stop(timer)
		timer = nil
	end

	timer = vim.fn.timer_start(schedule.refresh_ms, function()
		update_capslock()
	end, { ["repeat"] = -1 })
end

function M.stop()
	if timer == nil then
		return
	end

	vim.fn.timer_stop(timer)
	timer = nil

	if update_indicator ~= nil then
		update_indicator(false)
	end
end

return M
