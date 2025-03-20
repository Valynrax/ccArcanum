local arcanumAPI = require "arcanumAPI"
local apothisAPI = require "apothisAPI"
local ecnet2 = require "ecnet2"

local disableLogging = true
local modemSide = "left"
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

-- Function to request healing if needed
local function requestHeal()
    if clientData.health and clientData.maxHealth and clientData.health ~= clientData.maxHealth then
        local token = arcanumAPI.readToken()
        if not token then
            log("No valid authentication token")
            return
        end

        local connection = apothisAPI.createConnection()
        if connection == nil then
            log("Cannot connect to Apothis Server")
            return
        end

        connection:send({ command = "heal", token = token })
        local response = apothisAPI.waitResponse(connection, 2)

        if response == nil then
            log("Heal request timeout")
        elseif response.health then
            clientData.health = response.health
            log("Healed to: " .. clientData.health)
        end

        connection:send({ command = "close" })
    end
end

-- Function to process commands from controller
local function handleCommand(command)
    if string.find(command, "move") ~= nil then
        local success = apothisAPI.Movement(command)
        if success then
            requestHeal() -- Check for healing only if movement was successful
        end
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
    log("Listening for controller commands...")

    while true do
        local event, id, sender, message = os.pullEvent("ecnet2_message")

        if id == listener.id then
            local data = message
            if data and data.command then
                log("Received command: " .. data.command)
                handleCommand(data.command)
            end
        end
    end
end

-- Main function to initialize everything
local function main()
    local apothisServer = getServer("apothis")
    local arcanumServer = getServer("arcanum")

    if not apothisServer or not arcanumServer then
        printError("Could not retrieve server addresses")
        return
    end

    os.setComputerLabel("Apothis Client v" .. getVersion())

    local isInitiatedApothis = apothisAPI.init(apothisServer, modemSide, log)
    local isInitiatedArcanum = arcanumAPI.init(arcanumServer, modemSide, log)

    if not isInitiatedApothis or not isInitiatedArcanum then
        printError("Apothis or Arcanum APIs failed to initialize")
        return
    end

    log("Client initialized successfully")
    
    -- Start listening for commands in parallel with the APIs
    parallel.waitForAny(listenForCommands, function() arcanumAPI.start(main) end)
end

main()