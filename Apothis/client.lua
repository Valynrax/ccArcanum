local apothisAPI = require "apothisAPI"
local ecnet2 = require "ecnet2"
local util = require "utilities"
local identity = ecnet2.Identity(".identity")

local disableLogging = true
local clientData = { health = nil, maxHealth = nil }

-- Function to process commands from controller
local function handleCommand(command)
    if string.find(command, "move") ~= nil then
        apothisAPI.Movement(command)
    elseif command == "interact" then
        apothisAPI.Interact("interact")
    else
        util.log("Unknown command from controller: " .. command)
    end
end

-- Function to listen for commands from the controller
local function listenForCommands()
    
    -- Wait until the user has logged in to connect to their designated controller
    local clientUsername = nil
    while true do
        local hasLogin, user = apothisAPI.Command("checkLoginStatus")

        if hasLogin == false then
            os.sleep(5) -- Wait 5 seconds between checks
        else
            clientUsername = user.login
            break
        end
    end

    local api = identity:Protocol {
        name = "apothisController_" .. clientUsername,
        serialize = textutils.serialize,
        deserialize = textutils.unserialize,
    }

    local apiListener = api:listen()
    print("Awaiting connection to Controller...")

    while true do
        local event, id, p2, p3, ch, dist = os.pullEvent()
        local requestTime = os.time(os.date("*t"))

        if event == "ecnet2_request" and id == apiListener.id then
            -- Accept the request and send a greeting message.
            local connection = apiListener:accept("Connected to Controller", p2)
            connections[connection.id] = connection

        elseif event == "ecnet2_message" and connections[id] then
            local data = select(1, p3)
            local command = data['command']

            if command == "close" then
                connections[id] = nil -- Close Connection

            elseif data and command then
                print("Received command: " .. command)
                handleCommand(command)
            end
        end
    end
end

--[[
local function listenForMessages()
    local api = identity:Protocol {
        name = "apothisAPI",
        serialize = textutils.serialize,
        deserialize = textutils.unserialize,
    }

    local apiListener = api:listen()
    print("Listening for ApothisAPI messages")

    while true do
        local event, id, p2, p3, ch, dist = os.pullEvent()
        local requestTime = os.time(os.date("*t"))
        if event == "ecnet2_request" and id == apiListener.id then
            -- Accept the request and send a greeting message.
            local connection = apiListener:accept("Connected to Apothis API", p2)
            connections[connection.id] = connection

        elseif event == "ecnet2_message" and connections[id] then
            local data = select(1, p3)
            local command = data['command']

            if data and command then
                print("Received command: " .. command)
            end
        end
    end  
end
]]--

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

-- Main function to initialize everything
local function main()    
    if not fs.exists(".addresses.txt") then
        local arcanumAPI = require "arcanumAPI"
        local apothisServers = apothisAPI.getRunningServers(util.getModemSide())
        -- local availableControllers = apothisAPI.getAvailableControllers(util.getModemSide())
        local arcanumServers = arcanumAPI.getRunningServers(util.getModemSide())
        
        if #apothisServers == 0 or #arcanumServers == 0 or #availableControllers == 0 then
            print("No Apothis or Arcanum Servers found")
            return
        end

        if #apothisServers == 0 then print("No Apothis Servers found") return end
        if #arcanumServers == 0 then print("No Arcanum Servers found") return end
        if #availableControllers == 0 then print("No Apothis Controllers available") return end

        -- TODO: Inform the selected Controller that it has a client now
        -- Send the clients address for sending redstone signal purposes

        -- FUTURE: Allow selection of server (for "Realms" of sort)
        -- Might need a UI framework for that
        local file = fs.open(".addresses.txt", "w")
        local addresses = {
            ["apothis"] = apothisServers[1].address,
            ["arcanum"] = arcanumServers[1].address,
            ["controller"] = availableControllers[1].address
        }
        
        file.write(textutils.serialize(addresses))
        file.close()
    end
    
    local apothisServer = util.getServer("apothis")

    if not apothisServer then
        printError("Could not retrieve server addresses")
        return
    end

    local isInitiatedApothis = apothisAPI.init(apothisServer, util.getModemSide(), util.log)

    if isInitiatedApothis == false then
        printError("Apothis API failed to initialize")
        return
    end

    os.setComputerLabel("[Name] - AC v" .. util.getVersion())
    print("Client Initialized")
end

main()
-- Re-add listenForMessages to parallel at a later date
parallel.waitForAny(listenForCommands, handleUserInput)