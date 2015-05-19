-- @example Implementation of Conway's Game of Life.
-- It creates the initial distribution of alive cells randomly.
-- @arg PROBABILITY The probability of a Cell to be alive in the
-- beginning of the simulation. The default value is 0.15.
-- @arg TURNS The number of simulation steps. The default value is 20.

PROBABILITY = 0.15
TURNS = 20

ALIVE = 1
DEAD  = 2

function random(cs)
	forEachCell (cs, function (cell)
		local v = math.random()
		if v <= PROBABILITY then
			cell.state = ALIVE
		else
			cell.state = DEAD
		end
	end)
end

function countAlive(cell)
	local count = 0
	forEachNeighbor(cell, function(cell, neigh)
		if neigh.past.state == ALIVE then
			count = count + 1
		end
	end)
	return count
end

cs = CellularSpace{
	xdim = 50
}

math.randomseed(os.time())
random(cs)
cs:createNeighborhood()

lifeLeg = Legend{
	grouping = "uniquevalues",
	colorBar = {
		{color = "black", value = ALIVE},
		{color = "white", value = DEAD}
	},
	size = 1,
	pen = 2
}

--[[
obs = Observer{
	subject = cs,
	attributes = {"state"},
	legends = {lifeLeg}
}
--]]


gameoflife = Automaton{
	it = Trajectory{
		target = cs,
		select = function(cell) return true end,
	},
	State{
		id = "alive",
		Jump{
			function(event, agent, cell)
				return (cell.past.state == DEAD)
			end,
			target = "dead"
		},
		Flow{
			function( event, agent, cell )
				local n = countAlive(cell)
				if (n > 3) or (n < 2) then cell.state = DEAD end
			end
		}
	},
	State{
		id = "dead",
		Jump{
			function(event, agent, cell)
				return (cell.past.state == ALIVE)
			end,
			target = "alive"
		},
		Flow{
			function(event, agent, cell)
				local n = countAlive(cell)
				if n == 3 then cell.state = ALIVE end
			end
		}
	}
}

env = Environment{
	id = "env"
}

time = Timer{
	Event{action = function(event)
		local tick = event:getTime()
		cs:synchronize()
		cs:notify()
		gameoflife:execute(event)
	end}
}
env:add(cs)
env:add(gameoflife)
env:add(time)

gameoflife:setTrajectoryStatus(true)

env:execute(TURNS)

