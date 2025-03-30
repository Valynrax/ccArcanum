local apothisAPI = require "apothisAPI"
local ecnet2 = require "ecnet2"

local disableLogging = true
local modemSide = "top"
local clientData = { health = nil, maxHealth = nil }

local function log(message)
    if not disableLogging then
        print("[Apothis Client] " .. message)
    end
end

local function getServer(serverType)
    if not fs.exists(".addresses.txt") then
        printError(".addresses.txt not found")
        return nil
    end

    local file = fs.open(".addresses.txt", "r")
    local data = textutils.unserialize(file.readAll())
    file.close()

    print(data)
    print(data[serverType])
    return data and data[serverType] or nil
end

local function getVersion()
    local currentDirectory = fs.getDir(shell.getRunningProgram())
    local versionFile = fs.open(currentDirectory .. "/version.txt", "r")
    if not versionFile then
        return "0.0.0"
    end
    local version = versionFile.readAll()
    versionFile.close()
    return version
end

-- Function to process commands from controller
local function handleCommand(command)
    if string.find(command, "move") ~= nil then
        apothisAPI.Movement(command)
    elseif command == "interact" then
        apothisAPI.Interact("interact")
    else
        log("Unknown command from controller: " .. command)
    end
end

-- Function to listen for commands from the controller
local function listenForCommands()
    local identity = ecnet2.Identity(".identity")

    local api = identity:Protocol {
        name = "apothisController",
        serialize = textutils.serialize,
        deserialize = textutils.unserialize,
    }

    local listener = api:listen()
    print("Listening for controller commands...")

    while true do
        local event, id, p2, p3, ch, dist = os.pullEvent()
        local requestTime = os.time(os.date("*t"))
        if event == "ecnet2_request" and id == apiListener.id then
            local data = message
            if data and data.command then
                print("Received command: " .. data.command)
                handleCommand(data.command)
            end
        end
    end
end

local function listenForMessages()
    local identity = ecnet2.Identity(".identity")

    local api = identity:Protocol {
        name = "apothisAPI",
        serialize = textutils.serialize,
        deserialize = textutils.unserialize,
    }

    local listener = api:listen()
    print("Listening for ApothisAPI messages")

    while true do
        local event, id, p2, p3, ch, dist = os.pullEvent()
        local requestTime = os.time(os.date("*t"))
        if event == "ecnet2_request" and id == apiListener.id then
            local data = message
            if data and data.command then
                print(data.command)
            end
        end
    end  
end

local function redraw()
    term.clear()
    term.setCursorPos(1,1)
    
    local limit = math.min(#notifications, 5)
    for i = 1, limit do
        print(notifications[#notifications - limit + i])
    end
    
    -- Re-display user input
    term.write("> " .. inputBuffer)
end

local function handleUserInput()
    while true do
        term.setCursorPos(3, select(2, term.getCursorPos())) -- Move cursor after "> "
        local event, key = os.pullEvent("key")
        if key == keys.enter then
            if #inputBuffer > 0 then
                print("") -- Move to new line after command
                apothisAPI.Command(inputBuffer)
                inputBuffer = "" -- Reset input buffer
            end
        elseif key == keys.backspace then
            if #inputBuffer > 0 then
                inputBuffer = inputBuffer:sub(1, -2)
            end
        else
            local char = keys.getName(key)
            if char and #char == 1 then
                inputBuffer = inputBuffer .. char
            end
        end
        redraw()
    end
end

local function getModemSide()
    local sides = peripheral.getNames()
    for _, side in ipairs(sides) do
        if peripheral.getType(side) == "modem" then
            return side
        end
    end
    return nil
end

-- Main function to initialize everything
local function main()
    if not fs.exists(".addresses.txt") then
        local arcanumAPI = require "arcanumAPI"

        local modemSide = getModemSide()
        if not modemSide then
            printError("No modem found.")
            return false
        end
        
        local apothisServers = apothisAPI.getRunningServers(modemSide)
        local arcanumServers = arcanumAPI.getRunningServers(modemSide)
        if #apothisServers == 0 or #arcanumServers == 0 then
            print("No Apothis or Arcanum Servers found")
            return
        end

        -- FUTURE: Allow selection of server (for "Realms" of sort)
        -- Might need a UI framework for that
        --local apothsServerName = apothisServers[1].name:sub(1, 16) -- Strip to 16 Symbols
        local file = fs.open(".addresses.txt", "w")
        --serverName = arcanumServers[1].name:sub(1, 16) -- Strip to 16 Symbols
        print("Apothis Server Found: " .. apothisServers[1].address)
        print("Arcanum Server Found: " .. arcanumServers[1].address)
        local addresses = {
            ["apothis"] = apothisServers[1].address,
            ["arcanum"] = arcanumServers[1].address
        }
        file.write(textutils.serialize(addresses))
        file.close()
    end
    
    local apothisServer = getServer("apothis")

    if not apothisServer then
        printError("Could not retrieve server addresses")
        return
    end

    os.setComputerLabel("Apothis Client v" .. getVersion())

    local isInitiatedApothis = apothisAPI.init(apothisServer, modemSide, log)

    if not isInitiatedApothis then
        printError("Apothis API failed to initialize")
        return
    end

    print("Client initialized successfully")
end

parallel.waitForAny(main, listenForCommands, listenForMessages, handleUserInput)
