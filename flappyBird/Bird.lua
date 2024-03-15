Bird = Class{}

local GRAVITY = 20
local ANTIGRAVITY = -5

function Bird:init()
    self.image = love.graphics.newImage('sprites/bird.png')
    self.width = self.image:getWidth()
    self.height = self.image:getHeight()
    self.x = VIRTUAL_WIDTH / 2 - (self.width / 2)
    self.y = VIRTUAL_HEIGHT / 2 - (self.height / 2)
    self.dy = 0
end

function Bird:render()
    love.graphics.draw(self.image, self.x , self.y)
end

function Bird:update(dt)
    self.dy = self.dy + GRAVITY * dt
    self.y = self.y + self.dy

    if love.keyboard.wasPressed('space') then
        self.dy = ANTIGRAVITY
        sounds['jump']:play()
    end
end

function Bird:collides(pipePair)
    -- both offsets are used to shrink the bounding box to give the player a little bit of freedom with the collision
    if (self.x + 2) + (self.width - 4) >= pipePair.x and self.x + 2 <= pipePair.x + pipePair.width then
        if (self.y + 2) + (self.height - 4) >= pipePair.bottom_y and self.y + 2 <= pipePair.bottom_y + pipePair.height or
        (self.y + 2) + (self.height - 4) >= pipePair.top_y and self.y + 2 <= pipePair.top_y + pipePair.height then  
        return true
        end
    end
    return false
end