-- The paddle that the player can move left and right and use it to deflect the ball
-- It can have different skins which tthe player chooses when starting the game

Paddle = Class{}

function Paddle:init()
    -- x in the middle
    self.x = VIRTUAL_WIDTH / 2 - 32

    -- y a little above the bottom edge of the screen
    self.y = VIRTUAL_HEIGHT - 32

    -- starts with no velocity
    self.dx = 0
    self.width = 64
    self.height = 16


    self.skinIndex = 1 -- choose beetwen 4 skins
    self.sizeIndex = 2 -- choose between 4 sizes
end

function Paddle:update(dt)
    if love.keyboard.isDown('left') then
        self.dx = -PADDLE_SPEED
    elseif love.keyboard.isDown('right') then
        self.dx = PADDLE_SPEED
    else 
        self.dx = 0
    end

    -- ensure when we move to the left we dont go further from the screen 
    if self.dx < 0 then 
        self.x = math.max(0, self.x + self.dx * dt) -- if max is 0 then x is 0
    -- ensure when we move to the right we dont go further from the screen minus the paddles width
    else
        self.x = math.min(VIRTUAL_WIDTH - self.width, self.x + self.dx * dt) -- if min is screen minus width then x is that
    end
end

function Paddle:render()
    -- calculate the type of paddle from the array usng the skin and the size selected
    love.graphics.draw(gTextures['main'], gFrames['paddles'][self.sizeIndex + 4 * (self.skinIndex - 1)], self.x, self.y)
end