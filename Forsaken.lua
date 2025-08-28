-- Sigma-style Forsaken Script
-- LocalScript

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local Workspace = game:GetService("Workspace")
local LocalPlayer = Players.LocalPlayer

-- Table to store highlights
local espData = {}

-- ESP Function
local function createESP(player)
    if player == LocalPlayer then return end
    local char = player.Character
    if char then
        local hrp = char:FindFirstChild("HumanoidRootPart")
        if hrp then
            if not espData[player] then
                local highlight = Instance.new("Highlight")
                highlight.Adornee = char
                highlight.FillTransparency = 0.5
                highlight.Parent = Workspace
                espData[player] = highlight
            end
            -- Color: friends blue, others green
            if LocalPlayer:IsFriendsWith(player.UserId) then
                espData[player].FillColor = Color3.fromRGB(0, 0, 255)
                espData[player].OutlineColor = Color3.fromRGB(0, 0, 255)
            else
                espData[player].FillColor = Color3.fromRGB(0, 255, 0)
                espData[player].OutlineColor = Color3.fromRGB(0, 255, 0)
            end
        end
    end
end

-- Auto ESP Refresh
spawn(function()
    while true do
        for _, player in pairs(Players:GetPlayers()) do
            createESP(player)
        end
        wait(1)
    end
end)

-- Godmode
local function enableGodmode()
    local char = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
    local humanoid = char:WaitForChild("Humanoid")
    humanoid.HealthChanged:Connect(function()
        if humanoid.Health < humanoid.MaxHealth then
            humanoid.Health = humanoid.MaxHealth
