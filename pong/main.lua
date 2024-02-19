-- requirring library push
-- push helps take a window and turn in into virtual resolution window
push = require 'push'

WINDOW_WIDTH = 1700
WINDOW_HEIGHT = 1500

VIRTUAL_WIDTH = 432
VIRTUAL_HEIGHT = 243

function love.load()
    love.graphics.setDefaultFilter('nearest', 'nearest') -- nearest neighbour filtering

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

    love.graphics.printf(
        'Hello Pong!', -- text to render
        0, -- starting x
        VIRTUAL_HEIGHT / 2 - 6, -- starting y (default font in 12 pixels)
        VIRTUAL_WIDTH, -- align with the full window
        'center' -- alignment mode
    )

    push:apply('end')
end