local apothisAPI = {}
local ecnet2 = require "ecnet2"
local arcanumAPI = require "arcanumAPI"
local random = require "ccryptolib.random"
local serversChannel = 58235

local clientData = {} -- This is only read from

local id = ecnet2.Identity(".identity")

local api = id:Protocol {
	-- Programs will only see packets sent on the same protocol.
    -- Only one active listener can exist at any time for a given protocol name.
    name = "apothisAPI",

    -- Objects must be serialized before they are sent over.
    serialize = textutils.serialize,
    deserialize = textutils.unserialize,
}

local server = nil
local timeout = 5
local side = 'back'
local isPocket = false
if pocket then
    isPocket = true
end

local function log(message)
    print("[ApothisAPI] " .. message)
end

function apothisAPI.init(serverId, modemSide, logFunction)
    if serverId == nil then
        printError("Server is not set")
        return false
    elseif modemSide == nil then
        printError("Modem side is not set")
        return false
    end

    local modemType = peripheral.getType(modemSide)
    if modemType == nil then
        printError("Modem not found")
        return false
    elseif modemType ~= "modem" then
        printError("It is not a modem on the \"" .. modemSide .. "\" side")
        return false
    end
    if logFunction ~= nil then
        log = logFunction
    end
    server = serverId
    side = modemSide
    ecnet2.open(side)
end

function apothisAPI.start(main)
    parallel.waitForAny(main, ecnet2.daemon)
end

local function waitResponse(connection, timeout)
    local response = select(2, connection:receive(timeout))
    if response == nil then
        log("Response timeout")
        return nil
    end

    return response
end

local function readToken()
    if not fs.exists(".token") then
        log("Token not found")
        return nil
    end
    local tokenFile = fs.open(".token", "r")
    local token = tokenFile.readAll()
    tokenFile.close()
    if token == nil or token == "" then
        log("Token is empty")
        return nil
    end

    return token
end

local function connectToApothis()
    -- Create a connection to the server.
    log("Connecting to \"" .. server .. "\"")
    local connection = api:connect(server, "back")
    -- Wait for the greeting.
    local response = waitResponse(connection, timeout)
    if response == nil then
        log("Can't connect to the server")
        return nil
    end
    return connection
end

local function ensureOnGround()
    while true do
        local blockDownFound, _ = turtle.inspectDown()
        if blockDownFound then break end
        turtle.down()
    end
end

function apothisAPI.Command(cmd)
    local connection = createConnection()
    if connection == nil then
        return false, "Cannot connect to Apothis Server"
    end

    if cmd == "login" then
        write("Username: ") local username = read()
        write("Password: ") local password = read("*")

        local success, user, token = arcanumAPI.login(username, password)

        if success then
            local tokenFile = fs.open(".token", "w")
            tokenFile.write(token)
            tokenFile.close()
        end
    end
    
    local token = readToken()
    if not token then
       connection:send({command = "close"})
        return false, "Missing authentication token"
    end
    
    if cmd == "stats" then
        connection:send({command = "getStats", token = token})
        local response = waitResponse(connection, timeout)
        if response == nil then
            connection:send({command = "close"})
            return
        end

        local type = response['type']
        local data = response['clientData']

        if type == nil or data == nil then
            log("Invalid Response")
            connection:send({command = "close"})
            return
        end

        print("Health: " .. data.health .. "/" .. data.maxHealth)
        -- TODO: Skills

        connection:send({command = "close"})
    end
end

function apothisAPI.Movement(moveType)
    local success = false

    if moveType == "moveLeft" then
        success = turtle.turnLeft()
    elseif moveType == "moveRight" then
        success = turtle.turnRight()
    elseif moveType == "moveForward" then
        local blockFrontFound, _ = turtle.inspect()
        local blockUpFound, _ = turtle.inspectUp()

        if blockFrontFound and not blockUpFound then
            turtle.up()
            local nextBlockFound, _ = turtle.inspect()

            if nextBlockFound then
                turtle.down() -- Go back down if blocked
            else
                success = turtle.forward()
            end
        else
            success = turtle.forward()
        end

        if success then ensureOnGround() end
    elseif moveType == "moveBackward" then
        success = turtle.back()
        if success then ensureOnGround() end
    else
        log("Invalid Movement -> '" .. moveType .. "'")
    end

    if success then
        -- FUTURE: Log movements to server to allow the creation of a live player map in towns/hub

        if clientData.health == nil or clientData.maxHealth == nil then
            local connection = connectToApothis()
            if connection == nil then
                return false, "Cannot connect to Apothis Server"
            end

            local token = readToken()
            if not token then
                connection:send({command = "close"})
                return false, "Missing authentication token"
            end

            connection:send({command = "getClientData", token = token})

            local response = waitResponse(connection, timeout)

            if response == nil then
                connection:send({command = "close"})
                return false, "Request timeout"
            end

            clientData = response.clientData
            connection:send({command = "close"})
        end

        if clientData.health ~= clientData.maxHealth then
            local connection = connectToApothis()
            if connection == nil then
                return false, "Cannot connect to Apothis Server"
            end

            local token = readToken()
            if not token then
                connection:send({command = "close"})
                return false, "Missing authentication token"
            end

            connection:send({command = "heal", token = token})
            local response = waitResponse(connection, timeout)

            if response == nil then
                connection:send({command = "close"})
                return false, "Request timeout"
            end

            if response.health then
                clientData.health = response.health
            end

            connection:send({command = "close"})
        end
    end
end

function apothisAPI.Interact()
    local connection = connectToApothis()
    if connection == nil then
        return false, "Cannot connect to Apothis Server"
    end

    local token = readToken()
    if not token then
        connection:send({command = "close"})
        return false, "Missing authentication token"
    end

    local blockExists, data = turtle.inspect()

    if blockExists then
        connection:send({command = "interact", token = token, block = data})
        local response = waitResponse(connection, timeout)
        if response == nil then
            connection:send({command = "close"})
        end
    end
end

function apothisAPI.getRunningServers(modemSide)
    local modem = peripheral.wrap(modemSide)
    local replyChannel = math.random(1, 65535)
    local stopSearch = false
    local servers = {}
    os.startTimer(2)
    
    modem.open(replyChannel)
    modem.transmit(serversChannel, replyChannel, "getServers")
    while true do
        local event, side, channel, _, message, distance
        repeat
            event, side, channel, _, message, distance = os.pullEvent()
            if event == "timer" then
                stopSearch = true
                break
            end
        until event == "modem_message" and channel == replyChannel
        if stopSearch then
            modem.close(replyChannel)
            return servers
        end
        if message ~= nil then
            if message:sub(1, 15) == "serverAvailable" then
                local serverData = textutils.unserialize(message:sub(16))
                table.insert(servers, serverData)
            end
        end
    end
end

return apothisAPI
