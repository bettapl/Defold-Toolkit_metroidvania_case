local M = {}

function M.new(max_health)
	assert(type(max_health) == "number", "Max health must be a number")
	assert(max_health > 0, "Max health must be greater than 0")

	return {
		current = max_health,
		max = max_health,
		dead = false
	}
end

function M.damage(health, amount)
	assert(health ~= nil, "Health is required")
	assert(type(amount) == "number", "Damage amount must be a number")
	assert(amount > 0, "Damage amount must be greater than 0")

	if health.dead then
		return false
	end

	health.current = math.max(0, health.current - amount)

	if health.current == 0 then
		health.dead = true
	end

	return true
end

function M.heal(health, amount)
	assert(health ~= nil, "Health is required")
	assert(type(amount) == "number", "Heal amount must be a number")
	assert(amount > 0, "Heal amount must be greater than 0")

	if health.dead then
		return false
	end

	health.current = math.min(health.max, health.current + amount)

	return true
end

function M.get_current(health)
	assert(health ~= nil, "Health is required")

	return health.current
end

function M.get_max(health)
	assert(health ~= nil, "Health is required")

	return health.max
end

function M.is_dead(health)
	assert(health ~= nil, "Health is required")

	return health.dead
end

function M.revive(health, amount)
	assert(health ~= nil, "Health is required")
	assert(type(amount) == "number", "Revive amount must be a number")
	assert(amount > 0, "Revive amount must be greater than 0")

	health.current = math.min(amount, health.max)
	health.dead = false

	return true
end

return M