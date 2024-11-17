-- functions for the spreadsheet

-- Given an sprite sheet, a width and a height for the tiles, split the texture into all of the quads by dividing it evenly.
function GenerateQuads(sheet, tileWidth, tileHeight)
    local numberOfTilesInWidth = sheet:getWidth() / tileWidth -- the number of tiles that can fit across the width of the sprite sheet
    local numberOfTilesInHeight = sheet:getHeight() / tileHeight -- the number of tiles that can fit across the height of the sprite sheet

    local tileCounter = 1
    local tiles = {}

    -- iterate through each tile and save it in an array as a quad
    for y = 0, numberOfTilesInHeight - 1 do 
        for x = 0, numberOfTilesInWidth - 1 do
            tiles[tileCounter] = love.graphics.newQuad(x * tileWidth, y * tileHeight, tileWidth, tileHeight, sheet:getDimensions())
            tileCounter = tileCounter + 1
        end
    end
    return tiles
end

-- returns a specified segment of the table
function table.slice(tbl, first, last, step)
    local sliced = {}

    -- by default first is 1 last is the size of the table and step is 1
    for i = first or 1, last or #tbl, step or 1 do
        -- number of sliced(size of the table) plus 1 so the next position in the array
        sliced[#sliced+1] = tbl[i]
    end
    return sliced
end

function GenerateBricks(sheet)
    -- divide sheet 32 by 16 pieces(first 21 bricks)
    return table.slice(GenerateQuads(sheet, 32, 16), 1, 21)
end

function GeneratePaddles(sheet)
    -- every quad has a height of 16
    local x = 0
    local y = 64

    local quadsCounter = 1
    local quads = {}

    for i = 0, 3 do -- four colours
        -- smallest
        quads[quadsCounter] = love.graphics.newQuad(x, y, 32, 16, sheet:getDimensions())
        quadsCounter = quadsCounter + 1
        -- medium
        quads[quadsCounter] = love.graphics.newQuad(x + 32, y, 64, 16, sheet:getDimensions())
        quadsCounter = quadsCounter + 1
        -- large
        quads[quadsCounter] = love.graphics.newQuad(x + 96, y, 96, 16, sheet:getDimensions())
        quadsCounter = quadsCounter + 1
        -- huge
        quads[quadsCounter] = love.graphics.newQuad(x, y + 16, 128, 16, sheet:getDimensions())
        quadsCounter = quadsCounter + 1

        -- prepare x and y for the next set of paddles
        x = 0
        y = y + 32
    end
    return quads
end

function GenerateBalls(sheet)
    -- offset for the 4 top ball sprites
    local x = 96
    local y = 48

    local counter = 1
    local quads = {}

    for i = 0, 3 do
        -- the balls are 8 pixels wide and tall
        quads[counter] = love.graphics.newQuad(x, y, 8, 8, sheet:getDimensions())
        x = x + 8
        counter = counter + 1
    end

    -- offset for the 3 bottom balls
    x = 96
    y = 56

    for i = 0, 2 do
        quads[counter] = love.graphics.newQuad(x, y, 8, 8, sheet:getDimensions())
        x = x + 8
        counter = counter + 1
    end
    
    return quads
end
