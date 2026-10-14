local M = {}

function M.new()
	return {
		room = nil,
		position = nil
	}
end

function M.set(checkpoint, room_name, position)
	assert(checkpoint ~= nil, "Checkpoint is required")
	assert(type(room_name) == "string", "Room name must be a string")

	checkpoint.room = room_name
	checkpoint.position = position
end

function M.get_room(checkpoint)
	assert(checkpoint ~= nil, "Checkpoint is required")

	return checkpoint.room
end

function M.get_position(checkpoint)
	assert(checkpoint ~= nil, "Checkpoint is required")

	return checkpoint.position
end

function M.clear(checkpoint)
	assert(checkpoint ~= nil, "Checkpoint is required")

	checkpoint.room = nil
	checkpoint.position = nil
end

return M