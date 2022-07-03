local lib = {}

lib.traverseArea = function(length, width, operationFunc)
    local traversed = 0
    local total = length * width
    local direction = 1

    while traversed < total - 1 do
        operationFunc()
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
    operationFunc()
end

return lib