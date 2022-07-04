local traverseAreaTwice = require("traverseLib").traverseAreaTwice
local downMany = require("traverseLib").downMany
local empty = require("inventoryLib").empty
local selectItem = require("inventoryLib").selectItem

local length = tonumber(arg[1])
local width = tonumber(arg[2])
local suckCount = tonumber(arg[3]) or 3

local saplingId = "minecraft:birch_sapling"
local logId = "minecraft:birch_log"
local leavesId = "minecraft:birch_leaves"

local inTree = false

function farmBirch(traversed)
    local block, inspection
    if inTree then
        local height = 0
        block, inspection = turtle.inspectUp()
        turtle.digDown()
        while block and inspection.name == logId do
            turtle.digUp()
            turtle.up()
            height = height + 1
            block, inspection = turtle.inspectUp()
        end
        downMany(height)
        inTree = false
    else
        block, inspection = turtle.inspect()
        if block and (inspection.name == logId or inspection.name == leavesId) then
            turtle.dig()
            if inspection.name == logId then
                inTree = true
            end
        end
    end
end

function suckAndPlant(traversed)
    for _ = 1,suckCount,1 do
        turtle.suckDown()
    end
    if traversed % 2 == 0 then
        selectItem(saplingId)
        turtle.placeDown()
    end
end

traverseAreaTwice(length, width, farmBirch, suckAndPlant)
empty()
turtle.turnRight()
turtle.turnRight()
