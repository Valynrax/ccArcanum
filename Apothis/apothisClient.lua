local arcanumAPI = require "arcanumAPI"
local apothisAPI = require "apothisAPI"
local ecnet2 = require "ecnet2"

local disableLogging = true
local modemSide = "left"

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

local function handleCommand(command)
    if string.find(command, "move") ~= nil then
        apothisAPI.Movement(command)
    elseif command == "interact" then
        apothisAPI.Interact("interact")
    else
        log("Unknown command from controller: " .. command)
    end
end

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