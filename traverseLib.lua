local lib = {}

local function emptyFunc()
    return
end

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
            local currLen = j
            if i % 2 == 0 then 
                currLen = length - j + 1
            end
            forwardOp(i, currLen)
            turtle.forward()
            inSquareOp(i, currLen)
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

lib.forwardMany = function(count, obstructedOp)
    obstructedOp = obstructedOp or emptyFunc
    for _ = 1,count,1 do
        if turtle.detect() then
            obstructedOp()
        end
        turtle.forward()
    end
end

lib.backMany = function(count)
    for _ = 1,count,1 do
        turtle.back()
    end
end

lib.downMany = function(count, obstructedOp)
    obstructedOp = obstructedOp or emptyFunc
    for _ = 1,count,1 do
        if turtle.detectDown() then
            obstructedOp()
        end
        turtle.down()
    end
end

return lib