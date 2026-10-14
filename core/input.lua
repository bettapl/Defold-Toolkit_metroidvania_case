local M = {}

function M.new()
	return {
		actions = {}
	}
end

function M.bind(input, action_name, key)
	assert(input ~= nil, "Input is required")
	assert(type(action_name) == "string", "Action name must be a string")
	assert(type(key) == "number", "Key must be a number")

	input.actions[action_name] = key
end

function M.unbind(input, action_name)
	assert(input ~= nil, "Input is required")
	assert(type(action_name) == "string", "Action name must be a string")

	input.actions[action_name] = nil
end

function M.get_binding(input, action_name)
	assert(input ~= nil, "Input is required")
	assert(type(action_name) == "string", "Action name must be a string")

	return input.actions[action_name]
end

function M.has(input, action_name)
	assert(input ~= nil, "Input is required")
	assert(type(action_name) == "string", "Action name must be a string")

	return input.actions[action_name] ~= nil
end

function M.clear(input)
	assert(input ~= nil, "Input is required")

	input.actions = {}
end

return M