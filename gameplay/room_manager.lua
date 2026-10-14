local M = {}

function M.new()
	return {
		current_room = nil
	}
end

function M.enter(manager, room_name)
	assert(manager ~= nil, "Manager is required")
	assert(type(room_name) == "string", "Room name must be a string")

	manager.current_room = room_name
end

function M.get_current(manager)
	assert(manager ~= nil, "Manager is required")

	return manager.current_room
end

function M.is_current(manager, room_name)
	assert(manager ~= nil, "Manager is required")
	assert(type(room_name) == "string", "Room name must be a string")

	return manager.current_room == room_name
end

function M.clear(manager)
	assert(manager ~= nil, "Manager is required")

	manager.current_room = nil
end

return M