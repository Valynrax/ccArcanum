local ecnet2 = require "ecnet2"
local interactableID = os.getComputerID()

local centerX, centerY, centerZ = 0, 0, 0
local maxDistance = 7
local moveDelay = 5

local interactableData = {}

local function canMove(newX, newY, newZ)
    local dist = math.sqrt((newX - centerX)^2 + (newY - centerY)^2 + (newZ - centerZ)^2)
    return dist <= maxDistance
end

local function getCurrentPosition()
    return gps.locate() -- Returns x, y, z
end

local function listenForMessages()
    local identity = ecnet2.Identity(".identity")

    local api = identity:Protocol {
        name = "apothisAPI",
        serialize = textutils.serialize,
        deserialize = textutils.unserialize,
    }

    local listener = api:listen()
    print("Listening for ApothisAPI messages")

    while true do
        local event, id, p2, p3, ch, dist = os.pullEvent()
        local requestTime = os.time(os.date("*t"))
        if event == "ecnet2_request" and id == apiListener.id then
            local data = message
            if data and data.command then
                if data.command = "fetchData" then
                    sender:send({ type = "sendClientData", interactableData = interactableData)
                else
                    print("Command Received: " .. data.command)
                end
            end
        end
    end  
end

local function randomMovement()
    while true do
        local directions = {turtle.forward, turtle.turnLeft, turtle.turnRight}
        local selectedMove = directions[math.random(1, #directions)]

        local x, y, z = getCurrentPosition()
        if not x then
            print("GPS Unavailable")
            return
        end

        local newX, newY, newZ = x, y, z

        if selectedMove == turtle.forward then newZ = newZ + 1
        elseif selectedMove == turtle.turnLeft then newX = newX - 1
        elseif selectedMove == turtle.turnRight then newX = newX + 1
        end

        if canMove(newX, newY, newZ) and refuel() then
            if selectedMove == turtle.forward then turtle.forward()
            elseif selectedMove == turtle.turnLeft then turtle.left()
            elseif selectedMove == turtle.turnRight then turtle.right()
            end
        end

        os.sleep(moveDelay)
    end
end

parallel.waitForAny(randomMovement, listenForMessages)