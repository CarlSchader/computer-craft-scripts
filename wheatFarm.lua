local traverseArea = require("traverseLib").traverseAreaTwice
local dropRange = require("inventoryLib").dropRange

local length = tonumber(arg[1])
local width = tonumber(arg[2])
local suckCount = tonumber(arg[3]) or 3

function suck()
    for _ = 1,suckCount,1 do
        turtle.suckDown()
    end
end

traverseAreaTwice(length, width, turtle.placeDown, suck)

dropRange(2,16,1)
turtle.turnRight()
turtle.turnRight()
