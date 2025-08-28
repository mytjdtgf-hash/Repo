-- Load Rayfield UI Library
local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

-- Create Main Window
local Window = Rayfield:CreateWindow({
    Name = "Enhanced ESP",
    LoadingTitle = "Loading ESP...",
    LoadingSubtitle = "by YourName",
    Theme = "Default",
    KeySystem = true,
    KeySettings = {
        Title = "ESP Key",
        Subtitle = "Enter key to continue",
        Note = "Type '1' to proceed",
        FileName = "ESPKey",
        Key = {"1"}
    }
})

-- Create Tab for ESP Settings
local Tab = Window:CreateTab("ESP Settings", 4483362458)

-- Variables to store ESP settings
local espData = {}
local friendESP = true
local playerColors = {}

-- Function to create or update ESP for a player
local function createESP(player)
    if player == game.Players.LocalPlayer then return end
    local character = player.Character
    if character then
        local hrp = character:FindFirstChild("HumanoidRootPart")
        if hrp then
            if not espData[player] then
                local highlight = Instance.new("Highlight")
                highlight.Adornee = character
                highlight.FillColor = playerColors[player] or Color3.fromRGB(255, 0, 0)
                highlight.OutlineColor = playerColors[player] or Color3.fromRGB(255, 0, 0)
                highlight.Parent = workspace
                espData[player] = highlight
            end
        end
    end
end

-- Function to update ESP colors based on settings
local function updateESPColors()
    for player, highlight in pairs(espData) do
        if friendESP and game.Players.LocalPlayer:IsFriendsWith(player.UserId) then
            highlight.FillColor = Color3.fromRGB(0, 0, 255)
            highlight.OutlineColor = Color3.fromRGB(0, 0, 255)
        else
            highlight.FillColor = playerColors[player] or Color3.fromRGB(255, 0, 0)
            highlight.OutlineColor = playerColors[player] or Color3.fromRGB(255, 0, 0)
        end
    end
end

-- Create Toggle for Friend ESP
Tab:CreateToggle({
    Name = "Friend ESP",
    CurrentValue = friendESP,
    Flag = "friendESP",
    Callback = function(value)
        friendESP = value
        updateESPColors()
    end
})

-- Create Color Picker for Player Colors
Tab:CreateColorPicker({
    Name = "Player Color",
    Flag = "playerColor",
    Callback = function(value)
        local selectedPlayer = game.Players.LocalPlayer -- Replace with actual player selection logic
        playerColors[selectedPlayer] = value
        updateESPColors()
    end
})

-- Function to apply ESP to all players
for _, player in pairs(game.Players:GetPlayers()) do
    createESP(player)
end

-- Update ESP colors periodically
game:GetService("RunService").Heartbeat:Connect(function()
    updateESPColors()
end)
