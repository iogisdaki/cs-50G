TitleScreenState = Class{__includes = BaseState} -- this is the way to inherite the base class

function TitleScreenState:update(dt)
    -- if enter is pressed from title screen state change state to play
    if love.keyboard.wasPressed('enter') or love.keyboard.wasPressed('return') then
        gStateMachine:change('play')
    end
end

function TitleScreenState:render()
    love.graphics.setFont(flappyFont)
    love.graphics.printf('Flappy Bird', 0, 64, VIRTUAL_WIDTH, 'center')
    
    love.graphics.setFont(mediumFont)
    love.graphics.printf('Press Enter', 0, 100, VIRTUAL_WIDTH, 'center')
end