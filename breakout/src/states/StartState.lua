StartState = Class { __includes = BaseState } --inherites from BaseState

-- which of the options (start or high score) is highlighted
local highlightedOption = 1

function StartState:update(dt)
    if love.keyboard.wasPressed('up') or love.keyboard.wasPressed('down') then
        -- behaves like a ternary operator
        highlightedOption = highlightedOption == 1 and 2 or 1
        gSounds['paddle-hit']:play()
    end

    -- it sees enter key as return
    if love.keyboard.wasPressed('enter') or love.keyboard.wasPressed('return') then
        gSounds['confirm']:play()

        if highlightedOption == 1 then
            gStateMachine:change('serve', {
                paddle = Paddle(1),
                bricks = LevelMaker.createBricks(),
                heartNumber = 3,
                score = 0
            })
        end
    end

    if love.keyboard.wasPressed('escape') then
        love.event.quit()
    end
end

function StartState:render()
    -- title
    love.graphics.setFont(gFonts['large'])
    love.graphics.printf("BREAKOUT", 0, VIRTUAL_HEIGHT / 3, VIRTUAL_WIDTH, 'center')

    -- instrunctions
    love.graphics.setFont(gFonts['medium'])
    --if we're highlighting option 1 then set colour to blue
    if highlightedOption == 1 then
        --expects the color values to be in the range of 0 to 1
        love.graphics.setColor(103 / 255, 1, 1, 1)
    end
    love.graphics.printf("START", 0, VIRTUAL_HEIGHT / 2 + 70, VIRTUAL_WIDTH, 'center')
    --reset colour
    love.graphics.setColor(1, 1, 1, 1)

    if highlightedOption == 2 then
        love.graphics.setColor(103 / 255, 1, 1, 1)
    end
    love.graphics.printf("HIGH SCORES", 0, VIRTUAL_HEIGHT / 2 + 90, VIRTUAL_WIDTH, 'center')
    love.graphics.setColor(1, 1, 1, 1)
end
