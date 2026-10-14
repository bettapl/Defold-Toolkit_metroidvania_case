local M = {}

function M.new()
	return {
		items = {}
	}
end

function M.add(inventory, item_name, amount)
	assert(inventory ~= nil, "Inventory is required")
	assert(type(item_name) == "string", "Item name must be a string")
	assert(type(amount) == "number", "Amount must be a number")
	assert(amount > 0, "Amount must be greater than 0")

	inventory.items[item_name] = (inventory.items[item_name] or 0) + amount
end

function M.remove(inventory, item_name, amount)
	assert(inventory ~= nil, "Inventory is required")
	assert(type(item_name) == "string", "Item name must be a string")
	assert(type(amount) == "number", "Amount must be a number")
	assert(amount > 0, "Amount must be greater than 0")

	local current_amount = inventory.items[item_name]

	if current_amount == nil then
		return false
	end

	if current_amount < amount then
		return false
	end

	inventory.items[item_name] = current_amount - amount

	if inventory.items[item_name] == 0 then
		inventory.items[item_name] = nil
	end

	return true
end

function M.has(inventory, item_name)
	assert(inventory ~= nil, "Inventory is required")
	assert(type(item_name) == "string", "Item name must be a string")

	return inventory.items[item_name] ~= nil
end

function M.get_count(inventory, item_name)
	assert(inventory ~= nil, "Inventory is required")
	assert(type(item_name) == "string", "Item name must be a string")

	return inventory.items[item_name] or 0
end

function M.clear(inventory)
	assert(inventory ~= nil, "Inventory is required")

	inventory.items = {}
end

function M.get_items(inventory)
	assert(inventory ~= nil, "Inventory is required")

	return inventory.items
end

return M