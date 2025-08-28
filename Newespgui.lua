-- Services
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local LocalPlayer = Players.LocalPlayer

-- Table to store highlights
local espData = {}

-- Function to create/update ESP
local function createESP(player)
    if player == LocalPlayer then return end
    local character = player.Character
    if character then
        local hrp = character:FindFirstChild("HumanoidRootPart")
        if hrp then
            -- If no highlight exists, create one
            if not espData[player] then
                local highlight = Instance.new("Highlight")
                highlight.Adornee = character
                highlight.FillTransparency = 0.5
                highlight.Parent = workspace
                espData[player] = highlight
            end
            -- Set color based on friend or not
            if LocalPlayer:IsFriendsWith(player.UserId) then
                espData[player].FillColor = Color3.fromRGB(0, 0, 255) -- Blue for friends
                espData[player].OutlineColor = Color3.fromRGB(0, 0, 255)
            else
                espData[player].FillColor = Color3.fromRGB(0, 255, 0) -- Green for others
                espData[player].OutlineColor = Color3.fromRGB(0, 255, 0)
            end
        end
    end
end

-- Apply ESP to all players initially
for _, player in pairs(Players:GetPlayers()) do
    createESP(player)
end

-- Update ESP every frame
RunService.Heartbeat:Connect(function()
    for _, player in pairs(Players:GetPlayers()) do
        createESP(player)
    end
end)

-- Apply ESP to new players joining
Players.PlayerAdded:Connect(function(player)
    player.CharacterAdded:Connect(function()
        createESP(player)
    end)
end)
