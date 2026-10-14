local M = {}

function M.new(initial_state)
	assert(initial_state ~= nil, "Initial state is required")

	local machine = {
		current = initial_state,
		states = {}
	}

	return machine
end

function M.add(machine, name, on_enter, on_exit, on_update)
	assert(machine ~= nil, "Machine is required")
	assert(type(name) == "string", "State name must be a string")
	assert(on_enter == nil or type(on_enter) == "function", "on_enter must be a function")
	assert(on_exit == nil or type(on_exit) == "function", "on_exit must be a function")
	assert(on_update == nil or type(on_update) == "function", "on_update must be a function")

	machine.states[name] = {
		on_enter = on_enter,
		on_exit = on_exit,
		on_update = on_update
	}
end

function M.set(machine, new_state)
	assert(machine ~= nil, "Machine is required")
	assert(new_state ~= nil, "New state is required")

	if machine.current == new_state then
		return false
	end

	local new_state_data = machine.states[new_state]

	assert(new_state_data ~= nil, "State does not exist: " .. tostring(new_state))

	local old_state = machine.current
	local old_state_data = machine.states[old_state]

	if old_state_data and old_state_data.on_exit then
		old_state_data.on_exit(machine, old_state)
	end

	machine.current = new_state

	if new_state_data.on_enter then
		new_state_data.on_enter(machine, new_state)
	end

	return old_state, new_state
end

function M.get(machine)
	assert(machine ~= nil, "Machine is required")

	return machine.current
end

function M.remove(machine, name)
	assert(machine ~= nil, "Machine is required")
	assert(type(name) == "string", "State name must be a string")

	assert(machine.current ~= name, "Cannot remove the current state")

	machine.states[name] = nil
end

function M.has(machine, name)
	assert(machine ~= nil, "Machine is required")
	assert(type(name) == "string", "State name must be a string")

	return machine.states[name] ~= nil
end

function M.update(machine, dt)
	assert(machine ~= nil, "Machine is required")

	local state = machine.states[machine.current]

	if state and state.on_update then
		state.on_update(machine, dt)
	end
end

function M.is(machine, state_name)
	assert(machine ~= nil, "Machine is required")
	assert(type(state_name) == "string", "State name must be a string")

	return machine.current == state_name
end

return M