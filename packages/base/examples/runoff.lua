
-- @example Implementation of a simple runoff model.
-- There is an initial rain in the highest cells.
-- Each cell then sends its water equally to all neighbors
-- with lower height. 
-- @image runoff.bmp

cell = Cell{
	init = function(cell)
		cell.water = 0
	end,
	rain = function(cell)
		if cell.height > 200 then
			cell.water = cell.water + 200
		end
	end,
	logwater = function(cell)
		if cell.water < 1 then
			return 0
		else
			return math.log(cell.water)
		end
	end,
	runoff = function(cell)
		local quantity = cell.past.water / #cell:getNeighborhood()

		forEachNeighbor(cell, function(cell, neighbor)
			neighbor.water = neighbor.water + quantity
		end)
	end
}

config = getConfig()

cs = CellularSpace{
	dbType = config.dbType,
	host = config.host,
	user = config.user,
	password = config.password,
	database = "cabecadeboi",
	theme = "cells90x90",
	select = {"height_ as height"},
	instance = cell
}

cs:createNeighborhood{
	strategy = "mxn",
	filter = function(cell, cell2)
		return cell.height >= cell2.height
	end
}

Map{
	target = cs,
	select = "height",
	min = 0,
	max = 260,
	slices = 8,
	color = "Grays"
}

map = Map{
	target = cs,
	select = "logwater",
	min = 0,
	max = 30,
	slices = 15,
	color = "Blues"
}

timer = Timer{
	Event{action = function()
		cs:rain()
		return false
	end},
	Event{action = function()
		cs:synchronize()
		cs:init()
		cs:runoff()

		local quantity = 0

		forEachCell(cs, function(cell)
			quantity = quantity + cell.water
		end)
	end},
	Event{action = function()
		cs:notify()
	end}
}

timer:execute(100)
