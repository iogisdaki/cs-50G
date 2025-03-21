PlayState = Class { __includes = BaseState }

-- We now initialize what's in our PlayState via a state table that we pass between states as we go from playing to serving.
function PlayState:enter(params)
    self.paddle = params.paddle
    self.bricks = params.bricks
    self.heartNumber = params.heartNumber
    self.score = params.score
    self.ball = params.ball

    -- give ball random starting velocity
    self.ball.dx = math.random(-200, 200)
    self.ball.dy = math.random(-50, -60)
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
        -- position ball above paddle (in case it goes below)
        self.ball.y = self.paddle.y - 8
        -- reverse velocity to bounce
        self.ball.dy = -self.ball.dy

        -- tweaking angle of bounce based on where it hits the paddle
        -- if the ball hits on the left side of the paddle and the paddle is moving left
        if self.ball.x < self.paddle.x + (self.paddle.width / 2) and self.paddle.dx < 0 then
            -- whatever the difference is of the position of the ball and the center of the paddle multiply it by 8 and add a starting value
            self.ball.dx = -50 + -(8 * (self.paddle.x + self.paddle.width / 2 - self.ball.x))
            -- if the ball hits on the right side of the paddle and the paddle is moving right
        elseif self.ball.x > self.paddle.x + (self.paddle.width / 2) and self.paddle.dx > 0 then
            -- knowing that the ball.x is greater then the center of the paddle we make the result absolute so its positive
            self.ball.dx = 50 + (8 * math.abs(self.paddle.x + self.paddle.width / 2 - self.ball.x))
        end

        gSounds['paddle-hit']:play()
    end

    for k, brick in pairs(self.bricks) do
        if brick.shouldBeRendered and self.ball:collides(brick) then
            brick:hit()
            -- add to score based on tier and colour
            self.score = self.score + (brick.tier * 200 + brick.colour * 25)
            
            -- determine velocity and position of the ball
            -- if the ball hits on the left side of the brick and its moving right
            if self.ball.x + 2 < brick.x and self.ball.dx > 0 then
                -- flip x velocity and reset position outside of brick
                self.ball.dx = -self.ball.dx
                self.ball.x = brick.x - 8
                -- if it hits on the right edge of the bridge moving left
            elseif self.ball.x + 6 > brick.x + brick.width and self.ball.dx < 0 then
                self.ball.dx = -self.ball.dx
                self.ball.x = brick.x + 32
                -- if it hits on the top (only if no x collision)
            elseif self.ball.y < brick.y then
                self.ball.dy = -self.ball.dy
                self.ball.y = brick.y - 8
                -- if it hits from the bottom
            else
                self.ball.dy = -self.ball.dy
                self.ball.y = brick.y + 16
            end

            -- slightly scale the y velocity to speed up the game after every bricks hit
            self.ball.dy = self.ball.dy * 1.02
            -- only allow colliding with one brick
            break
        end
    end

    -- if ball goes below bounds, decrease health and go to serve state
    if self.ball.y >= VIRTUAL_HEIGHT then
        self.heartNumber = self.heartNumber - 1
        gSounds['hurt']:play()

        if self.heartNumber == 0 then
            gStateMachine:change('game-over', {
                score = self.score
            })
        else
            gStateMachine:change('serve', {
                paddle = self.paddle,
                bricks = self.bricks,
                heartNumber = self.heartNumber,
                score = self.score
            })
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

    self.paddle:render()
    self.ball:render()

    renderScore(self.score)
    renderHealth(self.heartNumber)

    -- if paused print paused text
    if self.paused then
        love.graphics.setFont(gFonts['large'])
        love.graphics.printf("PAUSED", 0, VIRTUAL_HEIGHT / 2 - 16, VIRTUAL_WIDTH, 'center')
    end
end
