-- The state in which we are waiting to serve the ball

ServeState = Class { __includes = BaseState }

function ServeState:enter(params)
    self.paddle = params.paddle
    self.bricks = params.bricks
    self.heartNumber = params.heartNumber
    self.score = params.score

    self.ball = Ball()
    self.ball.skin = math.random(7) -- TODO
end

function ServeState:update(dt)
    -- have the ball track the player for initialization
    self.paddle:update(dt)
    self.ball.x = self.paddle.x + (self.paddle.width / 2) - 4
    self.ball.y = self.paddle.y - 8

    if love.keyboard.wasPressed('enter') or love.keyboard.wasPressed('return') then
        gStateMachine:change('play', {
            paddle = self.paddle,
            bricks = self.bricks,
            heartNumber = self.heartNumber,
            score = self.score,
            ball = self.ball
        })
    end

    if love.keyboard.wasPressed('escape') then
        love.event.quit()
    end
end

function ServeState:render()
    self.paddle:render()
    self.ball:render()

    for k, brick in pairs(self.bricks) do
        brick:render()
    end

    renderScore(self.score)
    renderHealth(self.heartNumber)

    love.graphics.setFont(gFonts['medium'])
    love.graphics.printf('Press Enter to serve!', 0, VIRTUAL_HEIGHT / 2,
        VIRTUAL_WIDTH, 'center')
end
