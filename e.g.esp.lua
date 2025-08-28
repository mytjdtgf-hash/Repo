-- Simple ESP Script
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local LocalPlayer = Players.LocalPlayer

-- Function to create a Box/Highlight
local function createESP(player)
    if player == LocalPlayer then return end -- skip yourself
    local character = player.Character
    if character and character:FindFirstChild("HumanoidRootPart") then
        local highlight = Instance.new("Highlight")
        highlight.Adornee = character
        highlight.FillColor = Color3.fromRGB(0, 255, 0) -- green highlight
        highlight.OutlineColor = Color3.fromRGB(0, 255, 0)
        highlight.Parent = workspace
    end
end

-- Run for all players
for _, player in pairs(Players:GetPlayers()) do
    createESP(player)
end

-- Add ESP to new players
Players.PlayerAdded:Connect(function(player)
    player.CharacterAdded:Connect(function()
        createESP(player)
    end)
end)
