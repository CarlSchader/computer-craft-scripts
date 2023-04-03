local json = require("json")
local traverseArea = require("traverseLib").traverseArea
local downMany = require("traverseLib").downMany
local forwardMany = require("traverseLib").forwardMany
local emptyDown = require("inventoryLib").emptyDown
local selectItem = require("inventoryLib").selectItem
local dropItemAll = require("inventoryLib").dropItemAll

local config = json.readFile(arg[1])
local length = config.length
local width = config.width
local sleepTime = config.sleepTime
local sparsity = config.sparsity

local saplingId = "minecraft:spruce_sapling"
local logId = "minecraft:spruce_log"
local leavesId = "minecraft:spruce_leaves"

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
        while block and (inspection.name == logId or inspection.name == leavesId) do
            turtle.digUp()
            turtle.up()
            height = height + 1
            block, inspection = turtle.inspectUp()
        end
        downMany(height, turtle.digDown)
        if selectItem(logId) then
            turtle.dropDown()
        end
        inTree = false
    end
    if 1 < i and i < width and (((i - 2) % (2 + sparsity) == 0) or ((i - 2) % (2 + sparsity) == 1)) and ((j % (2 + sparsity) == 0) or (j % (2 + sparsity) == 1)) and j < length then
        if selectItem(saplingId) then
            turtle.placeDown()
        end
    end
end

while true do
    -- refuel
    turtle.suckDown()
    turtle.refuel()
    turtle.turnRight()
    turtle.turnRight()
    turtle.drop()
    turtle.turnRight()
    turtle.turnRight()

    -- get saplings
    for _ = 1,math.ceil((length * width) / (sparsity * 64)),1 do
        turtle.suck()
    end
    turtle.turnRight()
    turtle.turnRight()

    traverseArea(length, width, forwardOp, inOp)
    emptyDown()

    -- this conditional assumes width is positive
    if width % 2 == 0 then
        turtle.forward()
        turtle.turnRight()
        forwardMany(width - 1, turtle.dig)
    else
        turtle.turnRight()
        turtle.forward()
        turtle.turnRight()
        forwardMany(length, turtle.dig)
        turtle.turnRight()
        forwardMany(width, turtle.dig)
    end
    turtle.turnLeft()

    os.sleep(sleepTime)
end
