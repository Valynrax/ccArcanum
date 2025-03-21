local ecnet2 = require "ecnet2"
local arcanumAPI = require "arcanumAPI" -- Required to find Arcanum dynamically
local character = require "apothisCharacter"
local identity = ecnet2.Identity(".identity")

local usersPath = ".apothis_users"
local modem = peripheral.find("modem")
local authCheckInterval = 3600 -- Re-Auth once an hour
local arcanumServer = nil
local tokenCache = {} -- Validated Arcanum tokens & last verification time

setArcanumServer()

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
            local data = message
            local token = data.token
            local command = data.command

            if not token or not users[token] then
                local isValid, msg = verifyToken(token)
                if not isValid then
                    sender:send({ type = "error", message = msg or "Invalid session" })
                    goto continue
                end
                users[token] = character.new()
                saveUsers(users)
            end

            -- Handle Commands
            if command == "heal" then
                local user = users[token]
                user.health = user.health + 1
                saveUsers(users)
                sender:send({ type = "success", health = user.health })
            elseif command == "updatePosition" then
                users[token].position = data.position
                saveUsers(users)
                sender:send({ type = "success", position = users[token].position })
            elseif command == "getStats" then
                local character = users[token]
                sender:send({ type = "sendClientData", clientData = { health = character.health, maxHealth = character.maxHealth })
            else if command == "tokenFromArcanum" then

            else
                sender:send({ type = "error", message = "Unknown command" })
            end

            ::continue::
        end
    end
end

main()