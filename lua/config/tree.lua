-- https://github.com/nvim-tree/nvim-tree.lua/discussions/1896
local sort_by_name = true
local function sort_by_natural(nodes)
	local function sorter(left, right)
		if left.type ~= "directory" and right.type == "directory" then
			return false
		elseif left.type == "directory" and right.type ~= "directory" then
			return true
		end
		left = left.name:lower()
		right = right.name:lower()

		if left == right then
			return false
		end

		for i = 1, math.max(string.len(left), string.len(right)), 1 do
			local l = string.sub(left, i, -1)
			local r = string.sub(right, i, -1)

			if
				type(tonumber(string.sub(l, 1, 1))) == "number"
				and type(tonumber(string.sub(r, 1, 1))) == "number"
			then
				local l_number = tonumber(string.match(l, "^[0-9]+"))
				local r_number = tonumber(string.match(r, "^[0-9]+"))

				if l_number ~= r_number then
					return l_number < r_number
				end
			elseif string.sub(l, 1, 1) ~= string.sub(r, 1, 1) then
				return l < r
			end
		end
	end

	if sort_by_name then
		table.sort(nodes, sorter)
	else
		return "modification_time"
	end
end

local api = require 'nvim-tree.api'
local cycle_sort = function()
	sort_by_name = not sort_by_name
	api.tree.reload()
	if sort_by_name then
		vim.notify("Sorting by name")
	else
		vim.notify("Sorting by modification time")
	end
end
---
vim.keymap.set('n', 'T', cycle_sort)

require("nvim-tree").setup({
	sort_by = sort_by_natural,
})
