lib = {}

lib.readFile = function(filePath)
    local file = fs.open(filePath, "r")
    local obj = textutils.unserializeJSON(file.readAll())
    file.close()
    return obj
end

return lib