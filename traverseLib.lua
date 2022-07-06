local lib = {}

local function emptyFunc()
    return
end

-- Old traverse area
-- -- Turtle must be on the first block in the area.
-- -- It will traverse the area length in front of it and width to the right.
-- -- It does not come back.
-- lib.traverseArea = function(length, width, operationFunc)
--     local traversed = 0
--     local total = length * width
--     local direction = 1

--     while traversed < total - 1 do
--         operationFunc(traversed)
--         traversed = traversed + 1
--         if traversed % length == 0 then
--             if (traversed / length) % 2 == 1 then
--                 turtle.turnRight()
--                 turtle.forward()
--                 turtle.turnRight()
--             else
--                 turtle.turnLeft()
--                 turtle.forward()
--                 turtle.turnLeft()
--             end
--             direction = direction * (-1)
--         else
--             turtle.forward()
--         end
--     end
--     operationFunc(traversed)
-- end

-- Turtle starts facing first block of area and traverses 
-- length in front and width to the right. 
-- Each op is meant to be done on the block in front of it.
lib.traverseArea = function(length, width, forwardOp, inSquareOp)
    forwardOp = forwardOp or emptyFunc
    inSquareOp = inSquareOp or emptyFunc
    local absWidth = math.abs(width)
    local right = true
    if width < 1 then
        right = false
    end
    for i = 1,absWidth,1 do
        for j = 1,length,1 do
            forwardOp(i, j)
            turtle.forward()
            inSquareOp(i, j)
            if j == 1 and not(i == 1) then
                if right then
                    turtle.turnRight()
                else
                    turtle.turnLeft()
                end
                right = not right
            end
        end
        if not(i == absWidth) then
            if right then
                turtle.turnRight()
            else
                turtle.turnLeft()
            end
        end
    end
end

-- TraverseArea and traverseArea back to original start.
-- (Will be facing backwards when done)
lib.traverseAreaTwice = function(length, width, fop1, iop1, fop2, iop2)
    lib.traverseArea(length, width, fop1, iop1)
    turtle.forward()
    turtle.turnRight()
    turtle.turnRight()
    if width % 2 == 0 then
        lib.traverseArea(length, -width, fop2, iop2)
    else
        lib.traverseArea(length, width, fop2, iop2)
    end
end

lib.forwardMany = function(count)
    for _ = 1,count,1 do
        turtle.forward()
    end
end

lib.backMany = function(count)
    for _ = 1,count,1 do
        turtle.back()
    end
end

lib.downMany = function(count)
    for _ = 1,count,1 do
        turtle.down()
    end
end

return lib