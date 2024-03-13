PlayState = Class{__includes = BaseState}

function PlayState:init()
    self.bird = Bird()
    self.pipes = {}
    self.spawnTimer = 0
    self.nextSpawnTime = math.random(2, 6)
    self.score = 0
end

function PlayState:update(dt)
    self.spawnTimer = self.spawnTimer + dt
    if self.spawnTimer > self.nextSpawnTime then
        -- add new pipe objext to the table pipes
        table.insert(self.pipes, Pipes())
        self.spawnTimer = 0
        self.nextSpawnTime = math.random(2, 3)
    end
    -- key-pipe pair in the table
    for k, pipePair in pairs(self.pipes) do
        if not pipePair.scored then
            if pipePair.x + pipePair.width < self.bird.x then
                self.score = self.score + 1
                pipePair.scored = true
            end
        end
        pipePair:update(dt)
    end
    -- we need this second loop, rather than deleting in the previous loop, because
    -- modifying the table in-place without explicit keys will result in skipping the
    -- next pipe, since all implicit keys (numerical indices) are automatically shifted
    -- down after a table removal
    for k, pipePair in pairs(self.pipes) do
        if pipePair.x < -pipePair.width then
            table.remove(self.pipes, k)
        end
    end

    self.bird:update(dt)

    for k, pipePair in pairs(self.pipes) do
        if self.bird:collides(pipePair) then
            gStateMachine:change('score', {
                score = self.score
            })
        end
    end

     -- if bird touches the ground
     if self.bird.y > VIRTUAL_HEIGHT - 15 then
        gStateMachine:change('score', {
            score = self.score
        })
    end
end

function PlayState:render()
    for k, pipe in pairs(self.pipes) do
        pipe:render()
    end
    love.graphics.setFont(flappyFont)
    love.graphics.print('Score: ' .. tostring(self.score), 8, 8)
    self.bird:render()
end