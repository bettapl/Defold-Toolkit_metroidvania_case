local M = {}

function M.new()
	return {
		components = {}
	}
end

function M.add(gameplay_object, name, component)
	assert(gameplay_object ~= nil, "Gameplay object is required")
	assert(type(name) == "string", "Component name must be a string")
	assert(component ~= nil, "Component is required")

	gameplay_object.components[name] = component
end

function M.get(gameplay_object, name)
	assert(gameplay_object ~= nil, "Gameplay object is required")
	assert(type(name) == "string", "Component name must be a string")

	return gameplay_object.components[name]
end

function M.has(gameplay_object, name)
	assert(gameplay_object ~= nil, "Gameplay object is required")
	assert(type(name) == "string", "Component name must be a string")

	return gameplay_object.components[name] ~= nil
end

function M.remove(gameplay_object, name)
	assert(gameplay_object ~= nil, "Gameplay object is required")
	assert(type(name) == "string", "Component name must be a string")

	gameplay_object.components[name] = nil
end

function M.clear(gameplay_object)
	assert(gameplay_object ~= nil, "Gameplay object is required")

	gameplay_object.components = {}
end

return M