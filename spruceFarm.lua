local traverseArea = require("traverseLib").traverseArea
local downMany = require("traverseLib").downMany
local forwardMany = require("traverseLib").forwardMany
local emptyDown = require("inventoryLib").emptyDown
local selectItem = require("inventoryLib").selectItem
local dropItemAll = require("inventoryLib").dropItemAll

local length = tonumber(arg[1])
local width = tonumber(arg[2])
local sleepTime = tonumber(arg[3])

local saplingId = "minecraft:spruce_sapling"
local logId = "minecraft:spruce_log"
local leavesId = "minecraft:spruce_leaves"
local saplingOffset = 3
local sleepTime = sleepTime or 150 -- default 2.5 minutes

local inTree = false

function forwardOp()
    local block, inspection = turtle.inspect()
    if block and (inspection.name == logId or inspection.name == leavesId) then
        turtle.dig()
        if inspection.name == logId then
            inTree = true
        end
    end
end

function inOp(i, j)
    if inTree then
        local height = 0
        turtle.digDown()
        local block, inspection = turtle.inspectUp()
        while block and inspection.name == logId do
            turtle.digUp()
            turtle.up()
            height = height + 1
            block, inspection = turtle.inspectUp()
        end
        downMany(height)
        if selectItem(logId) then
            turtle.dropDown()
        end
        inTree = false
    end
    if (((i - 1) * length) + j) % saplingOffset == 0 then
        if selectItem(saplingId) then
            turtle.placeDown()
        end
    end
end

while true do
    -- refuel
    turtle.suckDown()
    turtle.refuel()
    turtle.dropDown()

    -- get saplings
    turtle.suck(math.floor((length * width) / saplingOffset))
    turtle.turnRight()
    turtle.turnRight()

    traverseArea(length, width, forwardOp, inOp)
    emptyDown()

    -- this conditional assumes width is positive
    if width % 2 == 0 then
        turtle.forward()
        turtle.turnRight()
        forwardMany(width - 1)
    else
        turtle.turnRight()
        turtle.forward()
        turtle.turnRight()
        forwardMany(length)
        turtle.turnRight()
        forwardMany(width)
    end
    turtle.turnLeft()

    os.sleep(sleepTime)
end
