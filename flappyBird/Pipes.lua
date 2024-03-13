Pipes = Class{}

local BOTTOM_PIPE_IMAGE = love.graphics.newImage('sprites/bottom_pipe.png')
local TOP_PIPE_IMAGE = love.graphics.newImage('sprites/top_pipe.png') 
local PIPE_SCROLL = -60

function Pipes:init()
    self.width = BOTTOM_PIPE_IMAGE:getWidth()
    self.height = BOTTOM_PIPE_IMAGE:getHeight()
    self.x = VIRTUAL_WIDTH
    self.bottom_y = math.random(self.height, self.height * 1.39)
    self.top_y = self.bottom_y - self.height - 100
    self.scored = false
end

function Pipes:update(dt)
    self.x = self.x + PIPE_SCROLL * dt
end

function Pipes:render()
    love.graphics.draw(BOTTOM_PIPE_IMAGE, self.x, self.bottom_y)
    love.graphics.draw(TOP_PIPE_IMAGE, self.x, self.top_y)
end