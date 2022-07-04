local lib = {}

lib.traverseArea = function(length, width, operationFunc)
    local traversed = 0
    local total = length * width
    local direction = 1

    while traversed < total - 1 do
        operationFunc(traversed)
        traversed = traversed + 1
        if traversed % length == 0 then
            if (traversed / length) % 2 == 1 then
                turtle.turnRight()
                turtle.forward()
                turtle.turnRight()
            else
                turtle.turnLeft()
                turtle.forward()
                turtle.turnLeft()
            end
            direction = direction * (-1)
        else
            turtle.forward()
        end
    end
    operationFunc(traversed)
end

lib.traverseAreaTwice = function(length, width, op1, op2)
    lib.traverseArea(length, width, op1)
    if width % 2 == 0 then
        turtle.turnRight()
    else
        turtle.turnRight()
        turtle.turnRight()
    end
    lib.traverseArea(length, width, op2)
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