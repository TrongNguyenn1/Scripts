if not game:IsLoaded() then
    game.Loaded:Wait()
end

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local HttpService = game:GetService("HttpService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Stats = game:GetService("Stats")

local player = Players.LocalPlayer
while not player do
    task.wait(0.5)
    player = Players.LocalPlayer
end

player:WaitForChild("Data",9e9)
player.Data:WaitForChild("Level",9e9)

local WebhookURL = getgenv().urlwhscrolls
local UpdateInterval = getgenv().timechscrolls or 60

local FileName = "LeviID_"..player.Name..".txt"
local MessageID

if isfile and isfile(FileName) then
    MessageID = readfile(FileName)
end

local startTime = os.time()
local CommF = ReplicatedStorage:WaitForChild("Remotes"):WaitForChild("CommF_")

local function Format(n)
    return tostring(n):reverse():gsub("...","%0,",(#tostring(n)-1)/3):reverse()
end

local InventoryCache = {}

local function UpdateInventory()

    local ok,inv = pcall(function()
        return CommF:InvokeServer("getInventory")
    end)

    if ok and inv then
        table.clear(InventoryCache)

        for i=1,#inv do
            local v = inv[i]
            InventoryCache[v.Name] = v.Count
        end
    end

end

local function GetItem(name)

    local alt = name:gsub("Mythic","Mythical"):gsub("Legend","Legendary")

    local value = InventoryCache[name]
    if value then
        return value
    end

    value = InventoryCache[alt]
    if value then
        return value
    end

    return 0
end

local BUFFER = 60
local frameBuffer = table.create(BUFFER,0)

local index = 1
local count = 0
local total = 0
local fps = 0

RunService.RenderStepped:Connect(function(dt)

    total -= frameBuffer[index]
    frameBuffer[index] = dt
    total += dt

    index += 1
    if index > BUFFER then
        index = 1
    end

    if count < BUFFER then
        count += 1
    end

    if total > 0 then
        fps = math.floor(count/total)
    end

end)

local lastPingUpdate = 0
local cachedPing = 0

local function GetPing()

    local now = tick()

    if now-lastPingUpdate < 2 then
        return cachedPing
    end

    lastPingUpdate = now

    pcall(function()

        local str = Stats.Network.ServerStatsItem["Data Ping"]:GetValueString()
        local value = string.match(str,"%d+")

        if value then
            cachedPing = tonumber(value)
        end

    end)

    return cachedPing

end

local function Send()

    UpdateInventory()

    local ping = GetPing()

    local level,beli,frag = 0,0,0

    pcall(function()
        level = player.Data.Level.Value
        beli = player.Data.Beli.Value
        frag = player.Data.Fragments.Value
    end)

    local data = {
        ["embeds"] = {{
            ["title"] = "**Blox Fruits Player Overview**",
            ["description"] = "**Player:** `" .. player.Name .. "`\n**User ID:** `" .. player.UserId .. "`\n━━━━━━━━━━━━━━━━━━━━━━━━━━━━",
            ["color"] = 0x2b2d31,
            ["fields"] = {
                {
                    ["name"] = "🖥️ System",
                    ["value"] = "> **FPS:** `" .. fps .. "`\n> **Ping:** `" .. ping .. " ms`\n> **Uptime:** `" .. os.date("!%H:%M:%S", os.time() - startTime) .. "`",
                    ["inline"] = true
                },
                {
                    ["name"] = "👤 Character",
                    ["value"] = "> **Level:** `" .. Format(level) .. "`\n> **Beli:** `" .. Format(beli) .. "`\n> **Fragments:** `" .. Format(frag) .. "`",
                    ["inline"] = true
                },
                {
                    ["name"] = "📦 Inventory",
                    ["value"] =
                        "> <:Leviathan_Heart:1479139581440823327> **Heart:** `" .. GetItem("Leviathan Heart") .. "`\n" ..
                        "> <:Leviathan_Scale:1479139532522786988> **Scale:** `" .. GetItem("Leviathan Scale") .. "`\n" ..
                        "> <:Mythical_Scroll:1442773244603007106> **Mythical:** `" .. GetItem("Mythical Scroll") .. "`\n" ..
                        "> <:Legendary_Scroll:1442773297623334982> **Legendary:** `" .. GetItem("Legendary Scroll") .. "`\n" ..
                        "━━━━━━━━━━━━━━━━━━━━━━━━━━━━",
                    ["inline"] = false
                }
            },
            ["footer"] = {
                ["text"] = "Last Update: " .. os.date("%H:%M:%S"),
                ["icon_url"] = "https://cdn.jsdelivr.net/gh/TrongNguyenn1/Logo@main/H4XShop.png"
            }
        }}
    }

    local req = syn and syn.request or http and http.request or http_request or request
    if not req then
        return
    end

    local url
    local method

    if MessageID and MessageID ~= "" then
        url = WebhookURL.."/messages/"..MessageID
        method = "PATCH"
    else
        url = WebhookURL.."?wait=true"
        method = "POST"
    end

    local ok,res = pcall(function()

        return req({
            Url = url,
            Method = method,
            Headers = {
                ["Content-Type"] = "application/json"
            },
            Body = HttpService:JSONEncode(data)
        })

    end)

    if ok and res and res.Success then

        if not MessageID or MessageID == "" then

            local decodeOK,body = pcall(function()
                return HttpService:JSONDecode(res.Body)
            end)

            if decodeOK and body and body.id then
                MessageID = body.id

                if writefile then
                    writefile(FileName,MessageID)
                end
            end
        end

    elseif ok and res and not res.Success then

        MessageID = nil

        if delfile and isfile(FileName) then
            delfile(FileName)
        end

    end

end

task.spawn(function()

    while true do

        local ok = pcall(Send)

        if ok then
            task.wait(UpdateInterval)
        else
            task.wait(5)
        end

    end

end)
