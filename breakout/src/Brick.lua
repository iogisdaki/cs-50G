Brick = Class {}

function Brick:init(x, y)
    -- for score calculation
    self.tier = 0
    self.colour = 1
    self.x = x
    self.y = y
    self.width = 32
    self.height = 16
    self.shouldBeRendered = true
end

function Brick:hit()
    -- if higher than base tier
    if self.tier > 0 then
        -- and colour is the lowest go down a tier else just decrease colour
        if self.colour == 1 then
            self.tier = self.tier - 1
            self.colour = 5
        else
            self.colour = self.colour - 1
        end
        gSounds['brick-hit-2']:stop()
        gSounds['brick-hit-2']:play()
        -- else if tier is the base
    else
        -- if colour is the lowest stop rendering aelse just decrease colour
        if self.colour == 1 then
            self.shouldBeRendered = false
            -- play a different sound if the brick is destroyed
            gSounds['brick-hit-1']:stop()
            gSounds['brick-hit-1']:play()
        else
            self.colour = self.colour - 1
            gSounds['brick-hit-2']:stop()
            gSounds['brick-hit-2']:play()
        end
    end
end

function Brick:render()
    if self.shouldBeRendered then
        love.graphics.draw(gTextures['main'],
            -- 5 colours, four tiers(the triped ones)
            -- so multiply by four to get an offset for the colours and add the tier to get the tier offset
            gFrames['bricks'][1 + ((self.colour - 1) * 4) + self.tier],
            self.x, self.y)
    end
end
