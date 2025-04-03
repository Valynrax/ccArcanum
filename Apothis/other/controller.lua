local ecnet2 = require "ecnet2"
local util = require "utilities"
local identity = ecnet2.Identity(".identity")

local controllerInternalID = 0 -- Used to identify the controllers in the world (to allow grabbing the correct controller)

local controllerChannel = 83492
local controllerName = "APOTHIS_CONTROLLER_" .. controllerInternalID
local checkInterval = 0.1
local clientAddressFile = ".clientAddress.txt" -- address of the Client (turtle)
local clientAddress = nil

local redstoneMap = {
    left = "moveLeft",
    right = "moveRight",
    front = "moveForward",
    back = "moveBackward",
    bottom = "interact"
}

local function createConnection()
    -- Create a connection to the server.
    util.log("Connecting to Controller \"" .. clientAddress .. "\"")
    local connection = api:connect(clientAddress, util.getModemSide())
    -- Wait for the greeting.
    local response = waitResponse(connection, timeout)
    if response == nil then
        util.log("Cannot connect to controller")
        return nil
    end
    return connection
end

local previousState = {}
local function checkRedstoneSignals()
    while true do
        if clientAddress ~= nil then -- Only watch for signals if there is a valid client
            for side, command in pairs(redstoneMap) do
                local isPowered = redstone.getInput(side)

                -- Only send command if state has changed
                if previousState[side] ~= isPowered then
                    previousState[side] = isPowered

                    if isPowered then
                        print("Sending command:", command)
                        local connection = createConnection()
                        connection:send({command = command})
                        connection:send({command = "close"}) -- May not be quite correct
                    end
                end
            end
        end

        sleep(checkInterval)
    end
end

local function broadcastControllerAvailable()
    local modem = util.getModem()
    modem.open(controllerChannel)
    modem.transmit(controllerChannel, 65535, "Showing " .. controllerName .. " Available")

    -- Only Broadcast while there is no client associated with this controller
    while clientAddress == nil do
        local event, side, channel, replyChannel, message, distance
        repeat
            event, side, channel, replyChannel, message, distance = os.pullEvent("modem_message")
        until channel == controllerChannel

        if message == "getControllers" then
            local controllerData = {
                name = controllerName,
                address = identity.address
            }
            modem.transmit(replyChannel,  65535, "controllerAvailable " .. textutils.serialize(serverData))
        end
    end
end

local connections = {}
local function main()
    if not fs.exists(".clientAddress.txt") then
        print("Awaiting request for connection from a client")

        local api = identity:Protocol {
            name = "apothisController_" .. controllerInternalID,
            serialize = textutils.serialize,
            deserialize = textutils.unserialize
        }

        local apiListener = api:listen()

        -- Wait to get a request from a client needing a controller
        while clientAddress == nil do
            local event, id, p2, p3, ch, dist = os.pullEvent()
            local requestTime = os.time(os.date("*t"))

            if event == "ecnet2_request" and id == apiListener.id then
                local connection = apiListener:accept("Controller connected to Client", p2)
                connections[id] = connection
            elseif event == "ecnet2_message" and connections[id] then
                local data = select(1, p3)
                local command = data['command']

                if command == "close" then
                    connections[id] = nil
                elseif command == "connect" then
                    clientAddress = data['address']

                    local file = fs.open(clientAddressFile, "w")
                    file.write(textutils.serialize(data['address']))
                    file.close()

                    connections[id] = nil
                end
            end
        end
    else
        local file = fs.open(clientAddressFile, "r")
        clientAddress = file.readAll()
        file.close()
    end

    checkRedstoneSignals()
end

print("Controller Initializing...")
parallel.waitForAny(main, broadcastControllerAvailable)