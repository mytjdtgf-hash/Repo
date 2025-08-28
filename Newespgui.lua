-- Services
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local LocalPlayer = Players.LocalPlayer

-- Variables
local espData = {}
local espEnabled = true
local friendESP = true
local godmodeEnabled = false

-- Custom GUI
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "CustomESP_GUI"
screenGui.ResetOnSpawn = false
screenGui.Parent = LocalPlayer:WaitForChild("PlayerGui")

local frame = Instance.new("Frame")
frame.Size = UDim2.new(0, 220, 0, 180)
frame.Position = UDim2.new(0, 20, 0, 20)
frame.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
frame.Parent = screenGui

local function createButton(text, pos, callback)
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(0, 200, 0, 30)
    btn.Position = pos
    btn.Text = text
    btn.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
    btn.TextColor3 = Color3.fromRGB(255, 255, 255)
    btn.Parent = frame
    btn.MouseButton1Click:Connect(callback)
end

-- Buttons
createButton("Toggle ESP", UDim2.new(0, 10, 0, 10), function() espEnabled = not espEnabled end)
createButton("Toggle Friend ESP", UDim2.new(0, 10, 0, 50), function() friendESP = not friendESP end)
createButton("Toggle Godmode", UDim2.new(0, 10, 0, 90), function() godmodeEnabled = not godmodeEnabled end)

-- ESP Function
local function createESP(player)
    if player == LocalPlayer then return end
    local char = player.Character
    if char then
        local hrp = char:FindFirstChild("HumanoidRootPart")
        if hrp and espEnabled then
            if not espData[player] then
                local highlight = Instance.new("Highlight")
                highlight.Adornee = char
                highlight.FillColor = friendESP and (LocalPlayer:IsFriendsWith(player.UserId) and Color3.fromRGB(0,0,255) or Color3.fromRGB(255,0,0)) or Color3.fromRGB(255,0,0)
                highlight.OutlineColor = highlight.FillColor
                highlight.Parent = workspace
                espData[player] = highlight
            end
        elseif espData[player] then
            espData[player]:Destroy()
            espData[player] = nil
        end
    end
end

-- Godmode
local function enableGodmode()
    local character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
    local humanoid = character:WaitForChild("Humanoid")
    humanoid.HealthChanged:Connect(function()
        if godmodeEnabled and humanoid.Health < humanoid.MaxHealth then
            humanoid.Health = humanoid.MaxHealth
        end
    end)
end

-- Apply ESP to all players
for _, player in pairs(Players:GetPlayers()) do
    createESP(player)
end

-- Update loop
RunService.Heartbeat:Connect(function()
    for _, player in pairs(Players:GetPlayers()) do
        createESP(player)
    end
    if godmodeEnabled then enableGodmode() end
end)

-- New players
Players.PlayerAdded:Connect(function(player)
    player.CharacterAdded:Connect(function()
        createESP(player)
    end)
end)        godmodeEnabled = value
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
