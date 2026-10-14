local M = {}

function M.new()
	return {
		values = {}
	}
end

function M.set(stats, name, value)
	assert(stats ~= nil, "Stats is required")
	assert(type(name) == "string", "Stat name must be a string")
	assert(type(value) == "number", "Stat value must be a number")

	stats.values[name] = value
end

function M.get(stats, name)
	assert(stats ~= nil, "Stats is required")
	assert(type(name) == "string", "Stat name must be a string")

	return stats.values[name]
end

function M.modify(stats, name, amount)
	assert(stats ~= nil, "Stats is required")
	assert(type(name) == "string", "Stat name must be a string")
	assert(type(amount) == "number", "Amount must be a number")

	local current_value = stats.values[name]

	assert(current_value ~= nil, "Stat does not exist: " .. name)

	local new_value = current_value + amount

	local max_value = stats.values[name .. "_max"]

	if max_value ~= nil then
		new_value = math.min(new_value, max_value)
	end

	local min_value = stats.values[name .. "_min"]

	if min_value ~= nil then
		new_value = math.max(new_value, min_value)
	end

	stats.values[name] = new_value

	return new_value
end

function M.has(stats, name)
	assert(stats ~= nil, "Stats is required")
	assert(type(name) == "string", "Stat name must be a string")

	return stats.values[name] ~= nil
end

function M.set_max(stats, name, max_value)
	assert(stats ~= nil, "Stats is required")
	assert(type(name) == "string", "Stat name must be a string")
	assert(type(max_value) == "number", "Max value must be a number")

	assert(stats.values[name] ~= nil, "Stat does not exist: " .. name)

	stats.values[name .. "_max"] = max_value
end

function M.get_max(stats, name)
	assert(stats ~= nil, "Stats is required")
	assert(type(name) == "string", "Stat name must be a string")

	return stats.values[name .. "_max"]
end

function M.set_min(stats, name, min_value)
	assert(stats ~= nil, "Stats is required")
	assert(type(name) == "string", "Stats name must be a string")
	assert(type(min_value) == "number", "Min value must be a number")

	assert(stats.values[name] ~= nil, "Stat does not exist: " .. name)

	stats.values[name .. "_min"] = min_value
end

function M.get_min(stats, name)
	assert(stats ~= nil, "Stats is required")
	assert(type(name) == "string", "Stat name must be a string")

	return stats.values[name .. "_min"]
end

function M.remove(stats, name)
	assert(stats ~= nil, "Stats is required")
	assert(type(name) == "string", "Stat name must be a string")

	stats.values[name] = nil
	stats.values[name .. "_min"] = nil
	stats.values[name .. "_max"] = nil
end

return M