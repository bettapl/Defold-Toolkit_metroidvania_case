local Ability = require "scripts.gameplay.ability"
local M = {}

function M.new()
	return {
		abilities = {},
		slots = {}
	}
end

function M.add(manager, ability)
	assert(manager ~= nil, "Manager is required")
	assert(ability ~= nil, "Ability is required")
	assert(type(ability.name) == "string", "Ability name is required")

	manager.abilities[ability.name] = ability
end

function M.get(manager, name)
	assert(manager ~= nil, "Manager is required")
	assert(type(name) == "string", "Ability name must be a string")

	return manager.abilities[name]
end

function M.has(manager, name)
	assert(manager ~= nil, "Manager is required")
	assert(type(name) == "string", "Ability name must be a string")

	return manager.abilities[name] ~= nil
end

function M.remove(manager, name)
	assert(manager ~= nil, "Manager is required")
	assert(type(name) == "string", "Ability name must be a string")

	manager.abilities[name] = nil

	for slot, ability_name in pairs(manager.slots) do
		if ability_name == name then
			manager.slots[slot] = nil
		end
	end
end

function M.update(manager, dt)
	assert(manager ~= nil, "Manager is required")
	assert(type(dt) == "number", "Delta time must be a number")

	for _, ability in pairs(manager.abilities) do
		Ability.update(ability, dt)
	end
end

function M.assign_slot(manager, slot, ability_name)
	assert(manager ~= nil, "Manager is required")
	assert(type(slot) == "number", "Slot must be a number")
	assert(type(ability_name) == "string", "Ability name must be a string")
	assert(manager.abilities[ability_name] ~= nil, "Ability does not exist: " .. ability_name)

	manager.slots[slot] = ability_name
end

function M.get_slot(manager, slot)
	assert(manager ~= nil, "Manager is required")
	assert(type(slot) == "number", "Slot must be a number")

	return manager.slots[slot]
end

function M.clear_slot(manager, slot)
	assert(manager ~= nil, "Manager is required")
	assert(type(slot) == "number", "Slot must be a number")

	manager.slots[slot] = nil
end

function M.use_slot(manager, slot, data)
	assert(manager ~= nil, "Manager is required")
	assert(type(slot) == "number", "Slot must be a number")

	local ability_name = manager.slots[slot]

	if not ability_name then
		return false
	end

	local ability = manager.abilities[ability_name]

	if not ability then
		return false
	end

	return Ability.use(ability, data)
end

return M