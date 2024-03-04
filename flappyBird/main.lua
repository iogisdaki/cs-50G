push = require 'push'
Class = require "class"
require 'Bird'

WINDOW_WIDTH = 2700
WINDOW_HEIGHT = 1512

VIRTUAL_WIDTH = 900
VIRTUAL_HEIGHT = 504

-- scope is the file
local background = love.graphics.newImage('sprites/background.png')

local ground = love.graphics.newImage('sprites/ground.png')
local groundScroll = 0
local GROUND_SPEED = 60
local GROUND_LOOPING_POINT = 200

local bird = Bird()

function love.load()
    love.graphics.setDefaultFilter('nearest', 'nearest')
    love.window.setTitle('Flappy Bird')
    push:setupScreen(VIRTUAL_WIDTH, VIRTUAL_HEIGHT, WINDOW_WIDTH, WINDOW_HEIGHT, {
        vsync = true,
        fullscreen = false,
        resizable = false
    })
end

function love.resize(w, h)
    push:resize(w, h)
end

function love.keypressed(key)
    if key == 'escape' then
        love.event.quit()
    end
end

function love.update(dt)
    -- calculate ground scroll amount
    -- times dt to stay framerate independent
    -- modulus to loop back around
    groundScroll = (groundScroll + GROUND_SPEED * dt) % GROUND_LOOPING_POINT

end

function love.draw()
    push:start()
    -- goes backwards
    love.graphics.draw(background, 0, 0)
    love.graphics.draw(ground, -groundScroll, VIRTUAL_HEIGHT - 16)
    bird:render()
    push:finish()
end