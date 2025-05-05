
local allowedGames = {
    7971857341, -- replace with your actual game IDs
    9876543210,
    1122334455,
}

local DiscordLib = loadstring(game:HttpGet"https://raw.githubusercontent.com/dawid-scripts/UI-Libs/main/discord%20lib.txt")()
local win = DiscordLib:Window("Mars Hub")
local serv = win:Server("Universal", "78050293459991")
local gravityChannel = serv:Channel("Gravity Controller")

gravityChannel:Slider("Gravity Force", 0, 500, 196, function(value)
    workspace.Gravity = value
end)

gravityChannel:Toggle("Enable Anti-Gravity", false, function(state)
    if state then
        workspace.Gravity = 0
    else
        workspace.Gravity = 196.2
    end
end)
local universalChannel = serv:Channel("Universal Tools")

universalChannel:Textbox("Change Skybox", "Enter Image ID", true, function(value)
    local skyboxId = "rbxassetid://" .. tostring(value)
    for _, obj in ipairs(game.Lighting:GetChildren()) do
        if obj:IsA("Sky") then
            obj:Destroy()
        end
    end
    local newSkybox = Instance.new("Sky")
    newSkybox.Name = "CustomSkybox"
    newSkybox.SkyboxBk = skyboxId
    newSkybox.SkyboxDn = skyboxId
    newSkybox.SkyboxFt = skyboxId
    newSkybox.SkyboxLf = skyboxId
    newSkybox.SkyboxRt = skyboxId
    newSkybox.SkyboxUp = skyboxId
    newSkybox.Parent = game.Lighting
end)

universalChannel:Button("Remove Skybox", function()
    for _, obj in pairs(game:GetService("Lighting"):GetChildren()) do
        if obj:IsA("Sky") then
            obj:Destroy()
        end
    end
end)

universalChannel:Slider("Time of Day", 0, 24, 12, function(value)
    game:GetService("Lighting").ClockTime = value
end)
universalChannel:Slider("Light Range", 0, 100, 30, function(range)
    local speaker = game.Players.LocalPlayer
    local character = speaker.Character
    if not character then return end

    local root = character:FindFirstChild("HumanoidRootPart")
    if not root then return end

    -- Clear existing light
    local existing = root:FindFirstChildOfClass("PointLight")
    if existing then existing:Destroy() end

    -- Create new light
    local light = Instance.new("PointLight")
    light.Name = "PointLight"
    light.Parent = root
    light.Range = range
    light.Brightness = 5
end)
universalChannel:Button("Unnamed-ESP", function()
    pcall(function()
        loadstring(game:HttpGet('https://raw.githubusercontent.com/ic3w0lf22/Unnamed-ESP/master/UnnamedESP.lua'))()
    end)
end)

universalChannel:Textbox("Set New Name", "Enter new name...", false, function(inputText)
    getgenv().name = inputText
    local Plr = game.Players.LocalPlayer
    for _, Value in ipairs(game:GetDescendants()) do
        if Value:IsA("TextLabel") then
            if string.find(Value.Text, Plr.Name) then
                Value.Text = Value.Text:gsub(Plr.Name, name)
            end
            Value:GetPropertyChangedSignal("Text"):Connect(function()
                Value.Text = Value.Text:gsub(Plr.Name, name)
            end)
        end
    end
    game.DescendantAdded:Connect(function(Value)
        if Value:IsA("TextLabel") then
            if string.find(Value.Text, Plr.Name) then
                Value.Text = Value.Text:gsub(Plr.Name, name)
            end
            Value:GetPropertyChangedSignal("Text"):Connect(function()
                Value.Text = Value.Text:gsub(Plr.Name, name)
            end)
        end
    end)
end)

universalChannel:Button("Rejoin Server", function()
    local TeleportService = game:GetService("TeleportService")
    local Players = game:GetService("Players")
    local LocalPlayer = Players.LocalPlayer
    TeleportService:TeleportToPlaceInstance(game.PlaceId, game.JobId, LocalPlayer)
end)

local Scriptchannel = serv:Channel("GUIS/Scripts")
Scriptchannel:Button("Animation Hub", function()
    pcall(function()
loadstring(game:HttpGet('https://raw.githubusercontent.com/RubyBoo4life/Scripts/main/animations.vis'))()
    end)
end)
Scriptchannel:Button("Infinite Yield", function()
    pcall(function()
loadstring(game:HttpGet("https://raw.githubusercontent.com/EdgeIY/infiniteyield/master/source"))()
    end)
end)



