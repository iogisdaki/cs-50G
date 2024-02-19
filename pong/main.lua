WINDOW_WIDTH = 1700
WINDOW_HEIGHT = 1500

-- override load
function love.load()
    love.window.setMode(WINDOW_WIDTH, WINDOW_HEIGHT, {
        fullscreen = false,
        resizable = false,
        vsync = true -- (vertical sync) synced to monitor refresh rate
    })
end

-- override draw
function love.draw()
    love.graphics.printf(
        'Hello Pong!', -- text to render
        0, -- starting x
        WINDOW_HEIGHT / 2 - 6, -- starting y (default font in 12 pixels)
        WINDOW_WIDTH, -- align with the full window
        'center' -- alignment mode
    )
end