local NAME = "Apothis Client Installer"

local DOWNLOADS = {}
local argStr = table.concat({...}, " ")

DOWNLOADS[#DOWNLOADS + 1] = "https://raw.githubusercontent.com/Valynrax/ccArcanum/refs/heads/main/Apothis/version.txt"
DOWNLOADS[#DOWNLOADS + 1] = "https://raw.githubusercontent.com/Valynrax/ccArcanum/refs/heads/main/Apothis/client.lua"
DOWNLOADS[#DOWNLOADS + 1] = "https://raw.githubusercontent.com/Valynrax/ccArcanum/refs/heads/main/lib/apothisAPI.lua"
DOWNLOADS[#DOWNLOADS + 1] = "https://raw.githubusercontent.com/Valynrax/ccArcanum/refs/heads/main/lib/arcanumAPI.lua"
DOWNLOADS[#DOWNLOADS + 1] = "https://raw.githubusercontent.com/Valynrax/ccArcanum/refs/heads/main/lib/ecnet2.lua"
-- DOWNLOADS[#DOWNLOADS + 1] = ""

local disableComputerValidation = false
local width, height = term.getSize()
local totalDownloaded = 0
local barLine = 6
local line = 8
local installFolder = "apothisClient"
local isTurtle = false
if turtle then
    isTurtle = true
end

local function update(text)
    term.setBackgroundColor(colors.black)
    term.setTextColor(colors.white)
    term.setCursorPos(1, line)
    write(text)
    line = line + 1
end

local function bar(ratio)
    term.setBackgroundColor(colors.gray)
    term.setTextColor(colors.lime)
    term.setCursorPos(1, barLine)
    for i = 1, width do
        if (i / width < ratio) then write("|") else write(" ") end
    end
end

local function checkRemoteVersion(attempt)
    local rawData = http.get(DOWNLOADS[1])
    if not rawData then
        if attempt == 3 then error("Failed to check version after 3 attempts!") end
        return checkRemoteVersion(attempt + 1)
    end
    return rawData.readAll()
end

local function download(path, attempt)
    local rawData = http.get(path)
    local fileName = path:match("^.+/(.+)$")
    update("Downloaded " .. fileName .. "!")
    if not rawData then
        if attempt == 3 then error("Failed to download " .. path .. " after 3 attempts!") end
        update("Failed to download " .. path .. ". Trying again (attempt " .. (attempt + 1) .. "/3)")
        return download(path, attempt + 1)
    end
    local data = rawData.readAll()

    local file = fs.open(installFolder .. '/' .. fileName, "w")
    file.write(data)
    file.close()
end

local function downloadAll(downloads, total)
    local nextFile = table.remove(downloads, 1)
    if nextFile then
        sleep(0.3)
        parallel.waitForAll(function() downloadAll(downloads, total) end, function()
            download(nextFile, 1)
            totalDownloaded = totalDownloaded + 1
            bar(totalDownloaded / total)
        end)
    end
end

local function rewriteStartup()
    local file = fs.open("startup", "w")

    file.writeLine("shell.run(\"".. installFolder .. "/clientInstaller.lua\")")
    file.writeLine("while (true) do")
    file.writeLine("	shell.run(\"" .. installFolder .. "/client.lua\")")
    file.writeLine("	sleep(1)")
    file.writeLine("end")
    file.close()
end

local function checkCurrentVersion()
    if fs.exists(installFolder .. "/version.txt") then
        local file = fs.open(installFolder .. "/version.txt", "r")
        local version = file.readAll()
        file.close()
        return version
    end
    return nil
end

local function createInstallationFolder()
    if not fs.exists(installFolder) then
        fs.makeDir(installFolder)
    end
end

local function removeOldVersion()
    if fs.exists(installFolder) then
        fs.delete(installFolder)
    end
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

local function validateComputer()
    if disableComputerValidation then
        return true
    end

    if not isTurtle then
        printError("This installer is only for Turtles!")
        return false
    end
    local modemSide = getModemSide()
    if not modemSide then
        printError("No modem found.")
        return false
    end
    --local modem = peripheral.wrap(modemSide)
    --if not modem.isWireless() then
    --    printError("This installer is only for Pocket Computers with a wireless modem!")
    --    return false
    --end    
    return true
end

local function install()
    local canInstall = validateComputer()
    if not canInstall then
        return
    end

    -- Check version first without writing to file
    local newVersion = checkRemoteVersion(1)
    local currentVersion = checkCurrentVersion()
    
    if currentVersion == newVersion then
        return
    end

    term.setBackgroundColor(colors.black)
    term.setTextColor(colors.yellow)
    term.clear()

    term.setCursorPos(math.floor(width / 2 - #NAME / 2 + 0.5), 2)
    write(NAME)

    term.setTextColor(colors.white)
    term.setCursorPos(1, barLine - 2)
    if currentVersion then
        term.write("Updating from " .. currentVersion .. " to " .. newVersion .. "...")
    else
        term.write("Installing version " .. newVersion .. "...")
    end

    bar(0)
    totalDownloaded = 0

    removeOldVersion()
    downloadAll(DOWNLOADS, #DOWNLOADS)

    term.setCursorPos(1, line)

    term.setTextColor(colors.green)
    term.setBackgroundColor(colors.black)
    if currentVersion then
        update("Updated to version " .. newVersion .. "!")
    else
        update("Installed version " .. newVersion .. "!")
    end
    
    rewriteStartup()

    if not fs.exists(".addresses.txt") then
        local arcanumAPI = require "arcanumAPI"
        local apothisAPI = require "apothisAPI"

        update("Finding server...")
        term.setTextColor(colors.black)
        term.setBackgroundColor(colors.black)
        term.setCursorPos(1, line + 1)

        update("Searching for Apothis & Arcanum servers...")
        local apothisServers = apothisAPI.getRunningServers(peripheral.getName(modem))
        local arcanumServers = arcanumAPI.getRunningServers(peripheral.getName(modem))
        if #apothisServers == 0 or #arcanumServers == 0 then
            print("No Apothis or Arcanum Servers found")
            return
        end

        -- FUTURE: Allow selection of server (for "Realms" of sort)
        -- Might need a UI framework for that
        local serverName = apothisServers[1].name:sub(1, 16) -- Strip to 16 Symbols
        local file = fs.open(".addresses.txt")
        file.write(apothisServers[1].address)
        file.close()

        serverName = arcanumServers[1].name:sub(1, 16) -- Strip to 16 Symbols
        file = fs.open(".address.txt")
        local addresses = {
            ["apothis"] = file.readAll(),
            ["arcanum"] = arcanumServers[1].address
        }
        file.write(addresses)
        file.close()

        update("Apothis & Arcanum Servers set")
    end


    for i = 1, 3 do
        term.setCursorPos(1, line)
        term.clearLine()
        term.write("Rebooting in " .. (4 - i) .. " seconds...")
        sleep(1)
    end
    
    term.setBackgroundColor(colors.black)
    term.setTextColor(colors.white)
    term.clear()
    os.reboot()
end

install()
