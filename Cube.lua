-- Cube.lua
Cube = Class{}

Cube.CUBE_SIZE = 10


function Cube:init(x, y, spawnIndex,spawned)
    self.x = x
    self.y = y
    self.spawnIndex = spawnIndex
    self.spawned = false
end

function Cube:render()
    -- Use the CUBE_SIZE constant for the size of the cube
    love.graphics.rectangle('fill', self.x, self.y, Cube.CUBE_SIZE, Cube.CUBE_SIZE)
end



---------------------------------------------------
function Cube:obsCollided(observer)
end
---------------------------------------------------

-- Function to generate a random spawn point from a given list of spawn points
function Cube.randomSpawn(spawnList)
    local randomIndex = love.math.random(1, #spawnList)
    return spawnList[randomIndex]
end
