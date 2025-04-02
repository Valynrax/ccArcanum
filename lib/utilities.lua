-- Collection of commonly used functions within Arcanum & related programs

local Util = {}

function Util:log(message)
    print("[Debug] " .. message)
end

function Util:bin2Hex(binary)
    return (binary:gsub(".", function(c)
      return ("%02x"):format(c:byte())
    end))
end

-- Returns the side of the modem, or nil
function Util:getModemSide()
    local sides = peripheral.getNames()

    for _, side in ipairs(sides) do
        if peripheral.getType(side) == "modem" then
            return side
        end
    end

    printError("No modem found")
    return nil
end

-- Returns the version of the version.txt, or 0.0.0
function Util:getVersion()
    local currentDirectory = fs.getDir(shell.getRunningProgram())
    local versionFile = fs.open(currentDirectory .. "/version.txt", "r")

    if not versionFile then
        return "0.0.0"
    end

    local version = versionFile.readAll()
    versionFile.close()

    return version
end

-- Returns the address of the requested serverType, or nil
function Util:getServer(serverType)
    if not fs.exists(".addresses.txt") then
        printError(".addresses.txt not found")
        return nil
    end

    local file = fs.open(".addresses.txt", "r")
    local data = textutils.unserialize(file.readAll())
    file.close()

    return data and data[serverType] or nil
end

-- Returns a wrapped peripheral of a modem
function Util:getModem()
    local modemSide = Utilities:getModemSide()
    return peripheral.wrap(modemSide)
 end
    
return Util