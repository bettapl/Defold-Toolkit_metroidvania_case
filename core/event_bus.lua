local M = {}

local listeners = {}

function M.on(event_name, callback)
	assert(type(event_name) == "string", "Event name must be a string")
	assert(type(callback) == "function", "Callback must be a function")
	
	if not listeners[event_name] then
		listeners[event_name] = {}
	end

	local event_listeners = listeners[event_name]

	for _, existing_callback in ipairs(event_listeners) do
		if existing_callback == callback then
			return function() end
		end
	end
	
	table.insert(event_listeners, callback)

	return function()
		M.off(event_name, callback)
	end
end

function M.emit(event_name, data)
	local event_listeners = listeners[event_name]

	if not event_listeners then 
		return
	end

	local snapshot = {}

	for i, callback in ipairs(event_listeners) do
		snapshot[i] = callback
	end
	
	for _, callback in ipairs(snapshot) do
		callback(data)
	end
end

function M.off(event_name, callback)
	local event_listeners = listeners[event_name]

	if not event_listeners then
		return
	end

	for i = #event_listeners, 1, -1 do
		if event_listeners[i] == callback then
			table.remove(event_listeners, i)
			break
		end
	end

	if #event_listeners == 0 then
		listeners[event_name] = nil
	end
end

function M.clear(event_name)
	listeners[event_name] = nil
end

function M.clear_all()
	listeners = {}
end

function M.has(event_name)
	local event_listeners = listeners[event_name]

	return event_listeners ~= nil and #event_listeners > 0
end

function M.once(event_name, callback)
	local unsubscribe

	unsubscribe = M.on(event_name, function(data)
		unsubscribe()
		callback(data)
	end)

	return unsubscribe
end

return M
