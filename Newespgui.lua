-- Load Rayfield UI
local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

-- Create Main Window with Key System
local Window = Rayfield:CreateWindow({
    Name = "ESP + Godmode",
    LoadingTitle = "Loading ESP...",
    LoadingSubtitle = "by YourName",
    Theme = "Default",
    KeySystem = true,
    KeySettings = {
        Title = "ESP Key",
        Subtitle = "Press MM to unlock",
        Note = "Key is case sensitive",
        FileName = "ESPKey",
        Key = {"MM"}
    }
})

-- Create ESP Tab
local ESPTab = Window:CreateTab("ESP Settings", 4483362458)

-- Variables
local espData = {}
local espEnabled = true
local friendESP = true
local playerColors = {}
local godmodeEnabled = false

-- ESP Functions
local function createESP(player)
    if player == game.Players.LocalPlayer then return end
    local character = player.Character
    if character then
        local hrp = character:FindFirstChild("HumanoidRootPart")
        if hrp and espEnabled then
            if not espData[player] then
                local highlight = Instance.new("Highlight")
                highlight.Adornee = character
                highlight.FillColor = playerColors[player] or Color3.fromRGB(255,0,0)
                highlight.OutlineColor = playerColors[player] or Color3.fromRGB(255,0,0)
                highlight.Parent = workspace
                espData[player] = highlight
            end
        elseif espData[player] then
            espData[player]:Destroy()
            espData[player] = nil
        end
    end
end

local function updateESPColors()
    for player, highlight in pairs(espData) do
        if friendESP and game.Players.LocalPlayer:IsFriendsWith(player.UserId) then
            highlight.FillColor = Color3.fromRGB(0,0,255)
            highlight.OutlineColor = Color3.fromRGB(0,0,255)
        else
            highlight.FillColor = playerColors[player] or Color3.fromRGB(255,0,0)
            highlight.OutlineColor = playerColors[player] or Color3.fromRGB(255,0,0)
        end
    end
end

-- Godmode Function
local function enableGodmode()
    local player = game.Players.LocalPlayer
    local character = player.Character or player.CharacterAdded:Wait()
    local humanoid = character:WaitForChild("Humanoid")
    
    humanoid.HealthChanged:Connect(function()
        if godmodeEnabled and humanoid.Health < humanoid.MaxHealth then
            humanoid.Health = humanoid.MaxHealth
        end
    end)
end

-- GUI Elements
ESPTab:CreateToggle({
    Name = "ESP Enabled",
    CurrentValue = espEnabled,
    Callback = function(value)
        espEnabled = value
    end
})

ESPTab:CreateToggle({
    Name = "Friend ESP",
    CurrentValue = friendESP,
    Callback = function(value)
        friendESP = value
        updateESPColors()
    end
})

ESPTab:CreateColorPicker({
    Name = "Player Color",
    Callback = function(value)
        local player = game.Players.LocalPlayer -- replace with selection logic
        playerColors[player] = value
        updateESPColors()
    end
})

ESPTab:CreateToggle({
    Name = "Godmode / Unkillable",
    CurrentValue = godmodeEnabled,
    Callback = function(value)
        godmodeEnabled = value
        if godmodeEnabled then
            enableGodmode()
        end
    end
})

-- Apply ESP for all players
for _, player in pairs(game.Players:GetPlayers()) do
    createESP(player)
end

-- Real-time updates every frame
game:GetService("RunService").Heartbeat:Connect(function()
    for _, player in pairs(game.Players:GetPlayers()) do
        createESP(player)
    end
    updateESPColors()
end)

-- Apply ESP to new players joining
game.Players.PlayerAdded:Connect(function(player)
    player.CharacterAdded:Connect(function()
        createESP(player)
    end)
end)
