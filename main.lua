push = require 'push'
Class = require 'class'
require 'Observer'
require 'Cube'

WINDOW_WIDTH = 1280
WINDOW_HEIGHT = 720

VIRTUAL_WIDTH = 432
VIRTUAL_HEIGHT = 243

OBS_SPEED = 200

spawnCount = 1
currentCubeCount = 0
randomNumber = 0

--INITIALIZE GAME
function love.load()

    spawnPoints = {
        -- Left column
        {x = VIRTUAL_WIDTH / 4, y = VIRTUAL_HEIGHT / 6},
        {x = VIRTUAL_WIDTH / 4, y = VIRTUAL_HEIGHT / 2},
        {x = VIRTUAL_WIDTH / 4, y = VIRTUAL_HEIGHT * 5 / 6},
    
        -- Right column
        {x = VIRTUAL_WIDTH * 3 / 4, y = VIRTUAL_HEIGHT / 6},
        {x = VIRTUAL_WIDTH * 3 / 4, y = VIRTUAL_HEIGHT / 2},
        {x = VIRTUAL_WIDTH * 3 / 4, y = VIRTUAL_HEIGHT * 5 / 6}
    }

    
--- chatgen
--make a table of cubes from spawnpoints.

  -- Initialize cubes table
  cubes = {}

  -- Create cube objects and add them to the cubes table
  for i, spawnPoint in ipairs(spawnPoints) do
      local cube = Cube(spawnPoint.x, spawnPoint.y, i, false)  -- made i to track which 123456 cube spawned index, false applies to spawned 
      table.insert(cubes, cube)
  end
--------------



    love.graphics.setDefaultFilter('nearest', 'nearest')
    smallFont = love.graphics.newFont('font.ttf', 8)
    love.graphics.setFont(smallFont)

    push:setupScreen(VIRTUAL_WIDTH, VIRTUAL_HEIGHT, WINDOW_WIDTH, WINDOW_HEIGHT, {
        fullscreen = false,
        resizable = false,
        vsync = true
    })

    observer = Observer(VIRTUAL_WIDTH / 2 - 2, VIRTUAL_HEIGHT / 2 - 2, OBS_SPEED)
    gameState = 'start'

end

---------------------------------------------------

function love.update(dt)

    observer:move(dt)

   

------------------ GEN TEST

 -- Check for collision between the observer and cubes
 for _, cube in ipairs(cubes) do

    

    if checkCollision(observer, cube) then
        -- If collision detected, 





        if  cube.spawnIndex == 1 or cube.spawnIndex == 2 or cube.spawnIndex == 3 then
        spawnCount = math.random(4, 6)

         disappearSpawnPoint(cube)

        elseif cube.spawnIndex == 4 or cube.spawnIndex == 5 or cube.spawnIndex == 6 then
        spawnCount = math.random(1, 3)
        disappearSpawnPoint(cube)

        end

        --despawn current cube, and 
        --update spawnCount and then we render IG



        resetObserver()
    end
end
-----------------


end



function love.draw()
    -- begin rendering at virtual resolution
    push:apply('start')
    observer:render()

   

    if spawnCount == 1  then
        renderSpawnPoint(1)
        randomNumber = math.random(4, 6)

    elseif spawnCount == 2 then
        renderSpawnPoint(2)
        randomNumber = math.random(4, 6)

    elseif spawnCount == 3 then
        renderSpawnPoint(3)
        randomNumber = math.random(4, 6)
        
    elseif spawnCount == 4 then
        renderSpawnPoint(4)
        randomNumber = math.random(1, 3)
    elseif spawnCount == 5 then
        renderSpawnPoint(5)
        randomNumber = math.random(1, 3)

    elseif spawnCount == 6 then
        renderSpawnPoint(6)
        randomNumber = math.random(1, 3)
    end



 
    -- end rendering at virtual resolution
    push:apply('end')
end

---------------------------------------------------

function renderSpawnPoint(index)
    local spawnPoint = spawnPoints[index]

    love.graphics.rectangle('fill', spawnPoint.x, spawnPoint.y, Cube.CUBE_SIZE, Cube.CUBE_SIZE)
    local tempCube = Cube(spawnPoint.x,spawnPoint.y,index)
    tempCube.spawned = true
    return tempCube
end


function disappearSpawnPoint(cube)
    cube.x = -1000  -- Off-screen x position
    cube.y = -1000  -- Off-screen y position
    cube.spawned = false  -- Update the spawned attribute
end




--ChatGen ------------------------------------

function checkCollision(observer, cube)
    -- Check if the observer and the cube overlap
    if observer.x + 4 > cube.x + Cube.CUBE_SIZE or cube.x > observer.x + 4 then
        return false
    end

    if observer.y + 4 > cube.y + Cube.CUBE_SIZE or cube.y > observer.y + 4 then
        return false
    end

    return true
end
---------------------



-- Function to reset the observer's position to the center
function resetObserver()
    observer.x = VIRTUAL_WIDTH / 2 - 2
    observer.y = VIRTUAL_HEIGHT / 2 - 2
end















