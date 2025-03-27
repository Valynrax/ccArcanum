local ecnet2 = require "ecnet2"
local interactableID = os.getComputerID()

local interactableData = {}

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

listenForMessages()