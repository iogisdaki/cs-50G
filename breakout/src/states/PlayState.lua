PlayState = Class{__includes = BaseState}

function PlayState:init()
    -- initiate paddle object
    self.paddle = Paddle()
    self.paused = false
end

function PlayState:update(dt)
    if self.paused then
        if love.keyboard.wasPressed('space') then
            self.paused = false
            gSounds['pause']:play()
        else -- if paused dont continue the commands
            return
        end
    elseif love.keyboard.wasPressed('space') then -- if not paused and the space was pressed
        self.paused = true
        gSounds['pause']:play()
        return
    end

    self.paddle:update(dt)

    if love.keyboard.wasPressed('escape') then
        love.event.quit()
    end
end

function PlayState:render()
    self.paddle:render()

    -- if paused print paused text 
    if self.paused then
        love.graphics.setFont(gFonts['large'])
        love.graphics.printf("PAUSED", 0, VIRTUAL_HEIGHT / 2 - 16, VIRTUAL_WIDTH, 'center')
    end
end