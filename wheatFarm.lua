local traverseArea = require("traverseLib").traverseArea
local dropRange = require("inventoryLib").dropRange

local length = tonumber(arg[1])
local width = tonumber(arg[2])
local suckCount = tonumber(arg[3]) or 3

function suck()
    for _ = 1,suckCount,1 do
        turtle.suckDown()
    end
end

traverseArea(length, width, turtle.placeDown)
if width % 2 == 0 then
    turtle.turnRight()
else
    turtle.turnRight()
    turtle.turnRight()
end
traverseArea(length, width, suck)

dropRange(2,16,1)
turtle.turnRight()
turtle.turnRight()
