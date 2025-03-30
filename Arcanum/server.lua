local ecnet2 = require "ecnet2"
local random = require "ccryptolib.random"
local sha256 = require "ccryptolib.sha256"
local config = require "config"

--local apothisCharacter = nil
--if config["apothis"] then apothisCharacter = require "character" end

--local bankAccount = nil
--if config["banking"] then bankAccount = require "bankAccount" end

local serverName = "Arcanum Master Server"
local usersPath = '.users'
local sessionsPath = '.sessions'
local serversChannel = 58235

local identity = ecnet2.Identity(".identity")
-- Backend

local function bin_to_hex(binary)
    return (binary:gsub(".", function(c)
      return ("%02x"):format(c:byte())
    end))
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

local User = {}
function User.new(login, password)
    local self = {}
    self.login = login
    self.password = bin_to_hex(sha256.pbkdf2(password, identity.address, 5))
    self.history = {}

    --if config["apothis"] then self.apothisCharacter = apothisCharacter.new() end
    --if config["banking"] then self.bankAccount = bankAccount.new() end
    
    return self
end

local function loadUsers()
    if not fs.exists(usersPath) then
        print("No users file found")
        return {}
    end

    local file = fs.open(usersPath, "r")
    local data = file.readAll()
    file.close()
    return textutils.unserialize(data)
end

local function writeUsers(users)
    local file = fs.open(usersPath, "w")
    file.write(textutils.serialize(users))
    file.close()
end

local Session = {}
function Session.new(login, deviceId, isPocket)
    local self = {
        login = login,
        deviceId = deviceId,
        isPocket = isPocket,
        token = bin_to_hex(sha256.digest(login .. deviceId .. os.time())),
        created = os.time(os.date("*t"))
    }

    return self
end

local function loadSessions()
    if not fs.exists(sessionsPath) then
        print("No sessions file found")
        return {}
    end

    local file = fs.open(sessionsPath, "r")
    local data = file.readAll()
    file.close()
    return textutils.unserialize(data)
end

local function writeSessions(sessions)
    local file = fs.open(sessionsPath, "w")
    file.write(textutils.serialize(sessions))
    file.close()
end

local function addSession(session)
    if sessions[session.token] ~= nil then        
        return false
    end
    sessions[session.token] = session:serialize()
    writeSessions(sessions)
    
    return true
end

local function isSessionExpired(session)
    local created = session.created
    local now = os.time(os.date("*t"))
    if created + 86400 - now < 0 then
        return true
    end
    return false
end


local function checkToken(token)
    if token == nil then return "Please provide token" end

    local sessions = loadSessions()
    if sessions[token] == nil then return "Session not found" end

    local session = sessions[token]
    if isSessionExpired(session) then
        sessions[token] = nil
        writeSessions(sessions)
        return "Session expired"
    end

    return true
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

local function getModem()
    local modemSide = getModemSide()
    return peripheral.wrap(modemSide)
 end

local connections = {}
local function main()
    local currentVersion = getVersion()
    os.setComputerLabel(serverName .. " v" .. currentVersion)
    ecnet2.open(getModemSide())
    
    -- Define a protocol.
    local api = identity:Protocol {
        name = "arcanumAPI",

        serialize = textutils.serialize,
        deserialize = textutils.unserialize,
    }


    local apiListener = api:listen()

    while true do
        local event, id, p2, p3, ch, dist = os.pullEvent()
        local requestTime = os.time(os.date("*t"))
        if event == "ecnet2_request" and id == apiListener.id then
            -- Accept the request and send a greeting message.
            local connection = apiListener:accept("Connected to ARCANUM API", p2)
            connections[connection.id] = connection

        elseif event == "ecnet2_message" and connections[id] then
            local data = select(1, p3)
            local command = data['command']

            if command == "close" then
                -- Close the connection.
                connections[id] = nil

            elseif command == "getUser" then
                local users = loadUsers()
                local sessions = loadSessions()
                local token = data['token']

                local checkResult = checkToken(token)
                if  checkResult ~= true then
                    connections[id]:send({type='error', message=checkResult})
                else
                    local session = sessions[token]
                    local clearedUser = {
                        login = session.login
                    }
                    connections[id]:send({type='success', user=clearedUser})
                end

            elseif command == "getRegisteredUsers" then
                local users = loadUsers()
                local sessions = loadSessions()
                local token = data['token']

                local checkResult = checkToken(token)
                if  checkResult ~= true then
                    connections[id]:send({type='error', message=checkResult})
                else
                    local clearedUsers = {}
                    for login, user in pairs(users) do
                        table.insert(clearedUsers, login)
                    end
                    connections[id]:send({type='success', users=clearedUsers})
                end

            
            elseif command == "register" then
                local users = loadUsers()
                local login = data['login']
                local password = data['password']

                if login == nil or password == nil then
                    connections[id]:send({type='error', message="Please provide login and password"})
                else
                    if users[login] ~= nil then
                        connections[id]:send({type='error', message="User \"" .. login .."\" already exists"})
                    else
                        local newUser = User.new(login, password)
                        connections[id]:send({type='success', message="User created"})

                        users[login] = newUser
                        table.insert(users[login].history, {deviceId = p2, device=isPocket, success=true, time=requestTime, message="User registered"})
                        writeUsers(users)
                        print("User \"" .. login .. "\" registered")
                    end
                end

            elseif command == "login" then
                local users = loadUsers()
                local sessions = loadSessions()
                local login = data['login']
                local password = data['password']
                local isPocket = data['isPocket']

                if login == nil or password == nil then
                    connections[id]:send({type='error', message="Please provide login and password"})
                else
                    if users[login] == nil then
                        print("User \"" .. login .. "\" not found")
                        connections[id]:send({type='error', message="Bad login or password"})
                    else
                        local hashedPassword = bin_to_hex(sha256.pbkdf2(password, identity.address, 5))
                        if users[login].password == hashedPassword then
                            local newSession = Session.new(login, p2, isPocket)
                            sessions[newSession.token] = newSession
                            writeSessions(sessions)

                            table.insert(users[login].history, {deviceId = p2, device=isPocket, success=true, time=requestTime, message="Logged in"})
                            writeUsers(users)

                            connections[id]:send({type='success', token=newSession['token']})
                            print("User \"" .. login .. "\" logged in")
                            
                            
                        else
                            logging.info("User \"" .. login .. "\" provided wrong password")                            
                            table.insert(users[login].history, {deviceId = p2, device=isPocket, success=false, time=requestTime, message="Wrong password"})
                            writeUsers(users)
                            connections[id]:send({type='error', message="Bad login or password"})
                        end
                    end
                end

            elseif command == 'logout' then
                local sessions = loadSessions()
                local token = data['token']

                local checkResult = checkToken(token)

                if "Session not found" == checkResult then
                    connections[id]:send({type='success', message="Logged out"})
                elseif checkResult ~= true then
                    connections[id]:send({type='error', message=checkResult})
                else
                    local session = sessions[token]
                    sessions[token] = nil
                    writeSessions(sessions)

                    local users = loadUsers()
                    table.insert(users[session.login].history, {deviceId = session.deviceId, device=session.isPocket, success=true, time=requestTime, message="Logged out"})
                    writeUsers(users)
                    connections[id]:send({type='success', message="Logged out"})
                    print("User \"" .. session.login .. "\" logged out")
                end

            elseif command == 'checkToken' then
                local token = data['token']
                if not token then
                    connections[id]:send({type='failure', message="No token provided"})
                end

                local sessions = loadSessions() -- Load active session data
                local session = sessions[token]

                if not session then
                    connections[id]:send({type='failure', message="Invalid session token"})
                end

                -- Check if session has expired
                if isSessionExpired(session) then
                    sessions[token] = nil -- Remove expired session
                    writeSessions(sessions) -- Save updated session data
                    connections[id]:send({type='failure', message="Session expired"})
                end

                connections[id]:send({type='success', message="Token Verified"})

            else
                connections[id]:send({type='error', message="Bad request"})
            end
        end
    end
end

local function getRunningServers()
    print("Getting other running servers...")
    local modem = getModem()
    local replyChannel = math.random(1, 65535)
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

local function broadcastServerName()
    local modem = getModem()
    modem.open(serversChannel)
    modem.transmit(serversChannel, 65535 , "serverConnected " .. serverName)

    while true do
        local event, side, channel, replyChannel, message, distance
        repeat
            event, side, channel, replyChannel, message, distance = os.pullEvent("modem_message")
        until channel == serversChannel

        if message == "serverConnected" then
            
        elseif message == "getServers" then
            local serverData = {
                name = serverName,
                address = identity.address
            }
            modem.transmit(replyChannel,  65535, "serverAvailable " .. textutils.serialize(serverData))
            print("Serer requested from " .. replyChannel)
        end
    end
end

local checkModem = getModemSide()
if checkModem == nil then
    printError("Unable to find Modem")
    return
end

local runningServers = getRunningServers()
for _, Sdata in ipairs(runningServers) do
    if Sdata["name"] == serverName then
        return
    end
end

parallel.waitForAny(main, broadcastServerName, ecnet2.daemon)
