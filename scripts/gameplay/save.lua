local M = {}

function M.new()
	return {
		version = 1,
		data = {}
	}
end

function M.exists(filename)
	assert(type(filename) == "string", "Filename must be a string")

	local data = sys.load(filename)

	return next(data) ~= nil
end

function M.set(save, key, value)
	assert(save ~= nil, "Save is required")
	assert(type(key) == "string", "Key must be a string")

	save.data[key] = value
end

function M.get(save, key)
	assert(save ~= nil, "Save is required")
	assert(type(key) == "string", "Key must be a string")

	return save.data[key]
end

function M.save_to_file(save, filename)
	assert(save ~= nil, "Save is required")
	assert(type(filename) == "string", "Filename must be a string")

	sys.save(filename, save.data)
end

function M.load_from_file(save, filename)
	assert(save ~= nil, "Save is required")
	assert(type(filename) == "string", "Filename must be a string")
	
	local data = sys.load(filename)

	if next(data) ~= nil then
		save.data = data
	end
end

function M.remove(save, key)
	assert(save ~= nil, "Save is required")
	assert(type(key) == "string", "Key must be a string")

	save.data[key] = nil
end

return M