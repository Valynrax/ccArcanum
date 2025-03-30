local ecnet2 = require "ecnet2"
local arcanumAPI = require "arcanumAPI" -- Required to find Arcanum dynamically
local character = require "character"
local identity = ecnet2.Identity(".identity")

local usersPath = ".apothis_users"
local modem = peripheral.find("modem")
local authCheckInterval = 3600 -- Re-Auth once an hour
local arcanumServer = nil
local tokenCache = {} -- Validated Arcanum tokens & last verification time

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

-- Function to find and store server addresses
local function setArcanumServer()
    local arcanumServers = arcanumAPI.getRunningServers(peripheral.getName(modem))
    
    if #arcanumServers == 0 then
        printError("No Arcanum Server found!")
        return false
    end

    -- FUTURE: Allow selection of a specific server
    local file = fs.open(".addresses.txt", "w")
    file.write(textutils.serialize(arcanumServers[1].address))
    file.close()

    arcanumServer = arcanumServers[1].address
end

setArcanumServer()

local function getServer()
    if not fs.exists(".addresses.txt") then
        printError(".addresses.txt not found")
        return nil
    end

    local file = fs.open(".addresses.txt", "r")
    local data = textutils.unserialize(file.readAll())
    file.close()

    return data
end

-- Load users from file
local function loadUsers()
    if not fs.exists(usersPath) then return {} end
    local file = fs.open(usersPath, "r")
    local data = textutils.unserialize(file.readAll())
    file.close()
    return data
end

-- Save users to file
local function saveUsers(users)
    local file = fs.open(usersPath, "w")
    file.write(textutils.serialize(users))
    file.close()
end

-- Verify token with Arcanum, but only if it has expired from the cache
local function verifyToken(token)
    local currentTime = os.epoch("utc") / 1000 -- Current Time in Seconds

    -- Check cache first
    if tokenCache[token] and (currentTime - tokenCache[token].timestamp) < authCheckInterval then
        return true -- Token is still valid, no need to revalidate
    end

    -- Otherwise, check with Arcanum
    if not arcanumServer then
        return false, "Arcanum server unavailable"
    end

    local api = identity:Protocol {
        name = "arcanumAPI",
        serialize = textutils.serialize,
        deserialize = textutils.unserialize,
    }

    local connection = api:connect(arcanumServer, peripheral.getName(modem))
    if not connection then return false, "Cannot reach Arcanum" end

    connection:send({ command = "checkToken", token = token })
    local response = select(2, connection:receive(2))

    connection:send({ command = "close" })

    if response.type == "success" then
        tokenCache[token] = { timestamp = currentTime } -- Cache token validation time
    end

    return response == true, response
end

local connections = {}
local function main()
    if not arcanumServer then
        printError("Arcanum server not found, exiting.")
        return
    end

    local api = identity:Protocol {
        name = "apothisAPI",
        serialize = textutils.serialize,
        deserialize = textutils.unserialize,
    }

    local listener = api:listen()
    local users = loadUsers()
    
    while true do
        local event, id, p2, p3, ch, dist = os.pullEvent()
        local requestTime = os.time(os.date("*t"))
        if event == "ecnet2_request" and id == apiListener.id then
            local connection = apiListener:accept("Connected to APOTHIS API", p2)
            connections[connection.id] = connection
        elseif event == "ecnet2_message" and connections[id] then
            local data = select(1, p3)
            local command = data['command']
            local token = data['token']

            if not token or not users[token] then
                local isValid, msg = verifyToken(token)
                if not isValid then
                    connections[id]:send({ type = "error", message = msg or "Invalid session" })
                    goto continue
                end
                users[token] = character.new()
                saveUsers(users)
            end

            if command == "close" then
                connections[id] = nil

            elseif command == "heal" then
                local user = users[token]
                user.health = user.health + 1
                saveUsers(users)
                connections[id]:send({ type = "success", health = user.health })

            elseif command == "updatePosition" then
                users[token].position = data.position
                saveUsers(users)
                connections[id]:send({ type = "success", position = users[token].position })

            elseif command == "getStats" then
                local character = users[token]
                connections[id]:send({ type = "sendClientData", clientData = { health = character.health, maxHealth = character.maxHealth }})

            elseif command == "tokenFromArcanum" then

            else
                connections[id]:send({ type = "error", message = "Unknown command" })
            end

            ::continue::
        end
    end
end

print("Apothis Master Server Initilaized on " .. getVersion())
parallel.waitForAny(main, ecnet2.daemon)
