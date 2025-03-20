local ecnet2 = require "ecnet2"

local modemSide = "top" -- Change this to the side where the modem is attached
local checkInterval = 0.1 -- How often to check redstone signals (in seconds)
local clientAddressFile = ".client_address.txt"
local clientAddress = nil

-- Function to load the client address from file
local function loadClientAddress()
    if fs.exists(clientAddressFile) then
        local file = fs.open(clientAddressFile, "r")
        clientAddress = file.readAll()
        file.close()
    else
        printError("Client address file not found! Create " .. clientAddressFile)
    end
end

-- Ensure client address is loaded
loadClientAddress()
if not clientAddress then
    return
end

-- Initialize ecnet2 and create protocol
ecnet2.open(modemSide)
local identity = ecnet2.Identity(".identity")

local api = identity:Protocol {
    name = "apothisController",
    serialize = textutils.serialize,
    deserialize = textutils.unserialize,
}

-- Create a secure connection to the client
local connection = api:connect(clientAddress, modemSide)
if not connection then
    printError("Failed to connect to client!")
    return
end
print("Connected to client at: " .. clientAddress)

-- Mapping of redstone directions to commands
local redstoneMap = {
    left = "moveLeft",
    right = "moveRight",
    front = "moveForward",
    back = "moveBackward",
    bottom = "interact"
}

-- Track previous redstone states to prevent spam
local previousState = {}

-- Function to check redstone inputs and send commands
local function checkRedstoneSignals()
    while true do
        for side, command in pairs(redstoneMap) do
            local isPowered = redstone.getInput(side)

            -- Only send command if state has changed
            if previousState[side] ~= isPowered then
                previousState[side] = isPowered

                if isPowered then
                    print("Sending command:", command)
                    connection:send({ command = command })
                end
            end
        end

        sleep(checkInterval)
    end
end

-- Run the script
checkRedstoneSignals()