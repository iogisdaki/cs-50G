-- Creates randomized levels for our Breakout game. Returns a table of
-- bricks that the game can render, based on the current level we're at
-- in the game.

LevelMaker = Class{}

function LevelMaker.createBricks(level)
    local bricks = {}

    -- randomize the number of rows and cols
    local numberOfRows = math.random(1, 5)
    local numberOfCols = math.random(7, 13)
     -- ensure cols are odd or else it'll be asymetric
     numberOfCols = numberOfCols % 2 == 0 and (numberOfCols + 1) or numberOfCols


    -- create the bricks table
    for y = 1, numberOfRows do
        for x = 1, numberOfCols do
            -- calculate the position of the brick and same padding on the side and center them since they are randomized
            b = Brick((x - 1) * 32 + 8 + (13 - numberOfCols) * 16, y * 16)
            b.colour = math.random(1, 4)
            table.insert(bricks, b) -- TODO
        end
    end
    return bricks
end

-- more analytically for the calculation of the position
-- decrement x by 1 because tables are 1-indexed but the coords are 0
-- multiply by 32, the brick width
-- the screen should have 8 pixels of padding; we can fit 13 cols + 16 pixels total
-- left-side padding for when there are fewer than 13 columns
-- just use y * 16, since we need top padding anyway