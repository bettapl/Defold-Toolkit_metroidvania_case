local Timer = require "scripts.core.timer"
local M = {}

function M.new(name, on_use)
	assert(type(name) == "string", "Ability name must be a string")
	assert(on_use == nil or type(on_use) == "function", "on_use must be a function")

	local ability = {
		name = name,
		unlocked = false,
		enabled = true,
		active = false,
		cooldown = 0,
		cooldown_remaining = 0,
		on_use = on_use
	}

	return ability
end

function M.unlock(ability)
	assert(ability ~= nil, "Ability is required")

	ability.unlocked = true
end

function M.lock(ability)
	assert(ability ~= nil, "Ability is required")

	ability.unlocked = false
end

function M.enable(ability)
	assert(ability ~= nil, "Ability is required")

	ability.enabled = true
end

function M.disable(ability)
	assert(ability ~= nil, "Ability is required")

	ability.enabled = false
end

function M.can_use(ability)
	assert(ability ~= nil, "Ability is required")

	return ability.unlocked and ability.enabled
end

function M.use(ability, data)
	assert(ability ~= nil, "Ability is required")

	if not M.can_use(ability) then
		return false
	end

	if ability.cooldown_remaining > 0 then
		return false
	end

	ability.active = true
	ability.cooldown_remaining = ability.cooldown

	if ability.on_use then
		ability.on_use(data)
	end

	return true
end

function M.stop(ability)
	assert(ability ~= nil, "Ability is required")

	ability.active = false
end

function M.set_cooldown(ability, duration)
	assert(ability ~= nil, "Ability is required")
	assert(type(duration) == "number", "Cooldown must be a number")
	assert(duration >= 0, "Cooldown cannot be negative")

	ability.cooldown = duration
end

function M.update(ability, dt)
	assert(ability ~= nil, "Ability is required")
	assert(type(dt) == "number", "Delta time must be a number")

	if ability.cooldown_remaining > 0 then
		ability.cooldown_remaining = math.max(
			0,
			ability.cooldown_remaining - dt
		)
	end
end

function M.get_cooldown(ability)
	assert(ability ~= nil, "Ability is required")

	return ability.cooldown
end

function M.get_cooldown_remaining(ability)
	assert(ability ~= nil, "Ability is required")

	return ability.cooldown_remaining
end

return M