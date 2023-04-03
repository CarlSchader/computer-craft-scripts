local lib = {}

local SLOT_COUNT = 16

lib.selectItem = function(itemId)
    local slot = turtle.getSelectedSlot() - 1
    local detail

    for _ = 1,16,1 do
        detail = turtle.getItemDetail(slot + 1)
        if type(detail) == "table" and detail.name and detail.name == itemId then
            turtle.select(slot  + 1)
            return true
        end
        slot = (slot + 1) % SLOT_COUNT
    end
    return false
end

lib.empty = function()
    for i = 1,SLOT_COUNT,1 do
        turtle.select(i)
        turtle.drop()
    end
    turtle.select(1)
end

lib.emptyDown = function()
    for i = 1,SLOT_COUNT,1 do
        turtle.select(i)
        turtle.dropDown()
    end
    turtle.select(1)
end


lib.dropRange = function(start, limit, increment)
    increment = increment or 1
    for i = start,limit,increment do
        turtle.select(i)
        turtle.drop()
    end
    turtle.select(1)
end

lib.dropItemAll = function(itemId)
    while lib.selectItem(itemId) do
        turtle.drop()
    end
end

lib.findEmptySlot = function()
    for i = 1,16,1 do
        if turtle.getItemCount(i) == 0 then
            return i
        end
    end
    return nil
end

return lib
