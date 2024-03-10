push = require 'push'
Class = require "class"
require 'Bird'
require 'Pipes' 

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

local pipes = {}
local spawnTimer = 0
local nextSpawnTime = 0

function love.load()
    math.randomseed(os.time())
    love.graphics.setDefaultFilter('nearest', 'nearest')
    love.window.setTitle('Flappy Bird')
    push:setupScreen(VIRTUAL_WIDTH, VIRTUAL_HEIGHT, WINDOW_WIDTH, WINDOW_HEIGHT, {
        vsync = true,
        fullscreen = false,
        resizable = false
    })

    nextSpawnTime = math.random(2, 6)

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
    bird:update(dt)

    spawnTimer = spawnTimer + dt
    if spawnTimer > nextSpawnTime then
        -- add new pipe objext to the table pipes
        table.insert(pipes, Pipes())
        spawnTimer = 0
        nextSpawnTime = math.random(2, 3)
    end

    -- key-pipe pair in the table
    for k, pipe in pairs(pipes) do
        pipe:update(dt)
        if pipe.x < -pipe.width then
            table.remove(pipes, k)
        end
    end

    love.keyboard.keyPressed = {}
end

function love.draw()
    push:start()
    -- goes backwards
    love.graphics.draw(background, 0, 0)
    -- the order of drawing the pipes matters so that they look like they are sticking out of the ground
    for k, pipe in pairs(pipes) do
        pipe:render()
    end
    love.graphics.draw(ground, -groundScroll, VIRTUAL_HEIGHT - 16)
    bird:render()
    push:finish()
end