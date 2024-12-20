PlayState = Class{__includes = BaseState}

function PlayState:init()
    -- initiate paddle object
    self.paddle = Paddle()
    self.paused = false

    -- skin = 1
    self.ball = Ball(1)
    self.ball.dx = math.random(-200 , 200)
    self.ball.dy = math.random(-50, -60)

    -- position at the center
    self.ball.x = VIRTUAL_WIDTH / 2 - 4
    self.ball.y = VIRTUAL_HEIGHT - 42

    self.bricks = LevelMaker.createBricks()
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
    self.ball:update(dt)

    if self.ball:collides(self.paddle) then
        -- reverse velocity to bounce
        self.ball.dy = -self.ball.dy
        gSounds['paddle-hit']:play()
    end

    for k, brick in pairs(self.bricks) do
        if brick.shouldBeRendered and self.ball:collides(brick) then
            brick:hit()
        end
    end

    if love.keyboard.wasPressed('escape') then
        love.event.quit()
    end
end

function PlayState:render()
    self.paddle:render()
    self.ball:render()

    for k, brick in pairs(self.bricks) do
        brick:render()
    end

    -- if paused print paused text 
    if self.paused then
        love.graphics.setFont(gFonts['large'])
        love.graphics.printf("PAUSED", 0, VIRTUAL_HEIGHT / 2 - 16, VIRTUAL_WIDTH, 'center')
    end
end
