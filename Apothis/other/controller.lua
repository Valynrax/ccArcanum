local ecnet2 = require "ecnet2"
local arcanumAPI = require "arcanumAPI"
local identity = ecnet2.Identity(".identity")

local modem = peripheral.find("modem")
local checkInterval = 0.1
local clientAddressFile = ".clientAddress.txt" -- address of the Client (turtle)
local clientAddress = nil
local clientAccountFile = ".clientAccount.txt" -- username of the Arcanum account that this controller links. i.e. "valynrax"
local clientAccount = nil

local function getModemSide()
    local sides = peripheral.getNames()
    for _, side in ipairs(sides) do
        if peripheral.getType(side) == "modem" then
            return side
        end
    end
    return nil
end

local function loadFiles()
    if fs.exists(clientAddressFile) then
        local file = fs.open(clientAddressFile, "r")
        clientAddress = file.readAll()
        file.close()
    else
        printError("Client address file not found! Create " .. clientAddressFile)
    end

    if fs.exists(clientAccountFile) then
        local file = fs.open(clientAccountFile, "r")
        clientAccount = file.readAll()
        file.close()
    else
        printError("Client account file not found! Create " .. clientAccountFile)
    end
end

local redstoneMap = {
    left = "moveLeft",
    right = "moveRight",
    front = "moveForward",
    back = "moveBackward",
    bottom = "interact"
}

local previousState = {}
local function checkRedstoneSignals()
    while true do
        if clientAccount then
            for side, command in pairs(redstoneMap) do
                local isPowered = redstone.getInput(side)

                -- Only send command if state has changed
                if previousState[side] ~= isPowered then
                    previousState[side] = isPowered

                    if isPowered then
                        print("Sending command:", command)
                        -- WIP
                    end
                end
            end
        end

        sleep(checkInterval)
    end
end

local connections = {}
local function main()
    loadFiles()

    local api = identity:Protocol {
        name = "apothisController_" .. clientAccount,
        serialize = textutils.serialize,
        deserialize = textutils.unserialize
    }

    local apiListener = api:listen()
    
    while true do
        local event, id, p2, p3, ch, dist = os.pullEvent()
        local requestTime = os.time(os.date("*t"))

        if event == "ecnet2_request" and id == apiListener.id then
            local connection = apiListener:accept("Controller Connected to Client", p2)
            connections[connection.id] = connection

        elseif event == "ecnet2_message" and connections[id] then
            local data = select(1, p3)
            local command = data['command']
        end
    end
end

print("Apothis Controller Initialized")
parallel.waitForAny(main, checkRedstoneSignals, ecnet2.daemon)