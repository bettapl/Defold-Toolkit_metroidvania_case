local Checkpoint = require "scripts.gameplay.checkpoint"

local M = {}

function M.get_room(checkpoint)
	assert(checkpoint ~= nil, "Checkpoint is required")

	return Checkpoint.get_room(checkpoint)
end

function M.get_position(checkpoint)
	assert(checkpoint ~= nil, "Checkpoint is required")

	return Checkpoint.get_position(checkpoint)
end

function M.can_respawn(checkpoint)
	assert(checkpoint ~= nil, "Checkpoint is required")

	return Checkpoint.get_room(checkpoint) ~= nil
end

return M