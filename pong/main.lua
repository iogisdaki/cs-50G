-- requirring library push
-- push helps take a window and turn in into virtual resolution window
push = require 'push'

WINDOW_WIDTH = 1700
WINDOW_HEIGHT = 1500

VIRTUAL_WIDTH = 432
VIRTUAL_HEIGHT = 243

function love.load()
    love.graphics.setDefaultFilter('nearest', 'nearest') -- nearest neighbour filtering

    smallFont = love.graphics.newFont('font.ttf', 8)

    love.graphics.setFont(smallFont)

    push:setupScreen(VIRTUAL_WIDTH, VIRTUAL_HEIGHT, WINDOW_WIDTH, WINDOW_HEIGHT, {
        fullscreen = false,
        resizable = false,
        vsync = true -- (vertical sync) synced to monitor refresh rate
    })
end

function love.keypressed(key)
    if key == 'escape' then
        love.event.quit()
    end
end

function love.draw()
    -- begin rendering at virtual resolution
    push:apply('start')

    -- clear the screen with this colour
    love.graphics.clear(40/255, 45/255, 52/255, 255/255)
    
    love.graphics.printf('Hello Pong!', 0, 20, VIRTUAL_WIDTH, 'center')

    --left puddle
    love.graphics.rectangle('fill', 10, 30, 5, 20)
    -- right paddle
    love.graphics.rectangle('fill', VIRTUAL_WIDTH - 10, VIRTUAL_HEIGHT - 50, 5, 20)
    -- ball
    love.graphics.rectangle('fill', VIRTUAL_WIDTH / 2 - 2, VIRTUAL_HEIGHT / 2, 4, 4)

    push:apply('end')
end