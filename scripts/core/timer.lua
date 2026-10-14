local M = {}

local timers = {}

function M.after(delay, callback, data)
	assert(type(delay) == "number", "Delay must be a number")
	assert(type(callback) == "function", "Callback must be a function")

	local timer_id

	timer_id = timer.delay(delay, false, function()
		callback(data)
		M.cancel(timer_id)
	end)

	table.insert(timers, timer_id)

	return timer_id
end

function M.every(interval, callback, data)
	assert(type(interval) == "number", "Interval must be a number")
	assert(type(callback) == "function", "Callback must be a function")

	local timer_id = timer.delay(interval, true, function()
		callback(data)
	end)

	table.insert(timers, timer_id)

	return timer_id
end

function M.cancel(timer_id)
	timer.cancel(timer_id)

	for i = #timers, 1, -1 do
		if timers[i] == timer_id then
			table.remove(timers, i)
			break
		end
	end
end

function M.cancel_all()
	for _, timer_id in ipairs(timers) do
		timer.cancel(timer_id)
	end

	timers = {}
end

return M