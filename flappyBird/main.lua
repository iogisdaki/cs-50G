push = require 'push'
Class = require "class"
require 'Bird'
require 'Pipes'

require 'StateMachine'
require 'states/BaseState'
require 'states/PlayState'
require 'states/ScoreState'
require 'states/TitleScreenState'

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

function love.load()
    math.randomseed(os.time())
    love.graphics.setDefaultFilter('nearest', 'nearest')
    love.window.setTitle('Flappy Bird')

    smallFont = love.graphics.newFont('font.ttf', 8)
    mediumFont = love.graphics.newFont('flappy.ttf', 14)
    flappyFont = love.graphics.newFont('flappy.ttf', 28)
    hugeFont = love.graphics.newFont('flappy.ttf', 56)
    love.graphics.setFont(flappyFont)


    push:setupScreen(VIRTUAL_WIDTH, VIRTUAL_HEIGHT, WINDOW_WIDTH, WINDOW_HEIGHT, {
        vsync = true,
        fullscreen = false,
        resizable = false
    })

    -- g is a convention for global
    -- stateMachine takes in a table with keys that map to functions that return the states 
    gStateMachine = StateMachine {
        ['title'] = function() return TitleScreenState() end,
        ['play'] = function () return PlayState() end,
        ['score'] = function() return ScoreState() end
    }
    gStateMachine:change('title')


    -- adding a key pressed table to keyboard
    love.keyboard.keyPressed = {}
end

function love.resize(w, h)
    push:resize(w, h)
end

function love.keypressed(key)
    love.keyboard.keyPressed[key] = true
    if key == 'escape' then
        love.event.quit()
    end
end

function love.keyboard.wasPressed(key)
    if love.keyboard.keyPressed[key] then
        return true
    else
        return false
    end
end

function love.update(dt)
    -- calculate ground scroll amount
    -- times dt to stay framerate independent
    -- modulus to loop back around
    groundScroll = (groundScroll + GROUND_SPEED * dt) % GROUND_LOOPING_POINT
    gStateMachine:update(dt)
    love.keyboard.keyPressed = {}
end

function love.draw()
    push:start()
    -- goes backwards
    love.graphics.draw(background, 0, 0)
    -- the order of drawing matters
    gStateMachine:render()
    love.graphics.draw(ground, -groundScroll, VIRTUAL_HEIGHT - 16)
    push:finish()
end