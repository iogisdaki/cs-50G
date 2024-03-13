PlayState = Class{__includes = BaseState}

function PlayState:init()
    self.bird = Bird()
    self.pipes = {}
    self.spawnTimer = 0
    self.nextSpawnTime = math.random(2, 6)
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
            gStateMachine:change('title')
        end
    end

     -- if self.bird touches the ground
     if self.bird.y > VIRTUAL_HEIGHT - 15 then
        gStateMachine:change('title')
    end
end

function PlayState:render()
    for k, pipe in pairs(self.pipes) do
        pipe:render()
    end
    self.bird:render()
end