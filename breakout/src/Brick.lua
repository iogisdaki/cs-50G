Brick = Class{}

function Brick:init(x, y)
    -- for score calculation
    self.tier = 0
    self.color = 1
    self.x = x
    self.y = y
    self.width = 32
    self.height = 16
    self.shouldBeRendered = true
end

function Brick:hit()
    gSounds['brick-hit-2']:play()
    self.shouldBeRendered = false
end

function Brick:render()
    if self.shouldBeRendered then
        love.graphics.draw(gTextures['main'],
        -- 5 colours, four tiers(the triped ones)
        -- so multiply by four to get an offset for the colours and add the tier to get the tier offset
        gFrames['bricks'][1 + ((self.color - 1) * 4) + self.tier],
        self.x, self.y)
    end
end