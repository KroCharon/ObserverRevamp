-- Observer.lua
Observer = Class{}

function Observer:init(x, y, speed)
    self.x = x
    self.y = y
    self.speed = speed
end

function Observer:move(dt)
    -- Check for WASD keys
    if love.keyboard.isDown('w') or love.keyboard.isDown('up') then
        self.y = math.max(0, self.y - self.speed * dt)  -- Move up
    end
    if love.keyboard.isDown('s') or love.keyboard.isDown('down') then
        self.y = math.min(WINDOW_HEIGHT - VIRTUAL_HEIGHT, self.y + self.speed * dt)  -- Move down
    end
    if love.keyboard.isDown('a') or love.keyboard.isDown('left') then
        self.x = math.max(0, self.x - self.speed * dt)  -- Move left
    end
    if love.keyboard.isDown('d') or love.keyboard.isDown('right') then
        self.x = math.min(WINDOW_WIDTH - VIRTUAL_WIDTH, self.x + self.speed * dt)  -- Move right
    end

    --contsrain movement
    self.x = math.max(0, math.min(VIRTUAL_WIDTH - 4, observer.x))
    self.y = math.max(0, math.min(VIRTUAL_HEIGHT - 4, observer.y))

end


function Observer:render()
    love.graphics.rectangle('fill', self.x, self.y, 4, 4)
end
