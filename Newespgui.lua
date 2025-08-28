-- Services
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local LocalPlayer = Players.LocalPlayer

-- Config
local refreshTime = 1 -- seconds
local espData = {} -- store player highlights
local friendESP = true -- default friends toggle

-- GUI Setup
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "ESP_GUI"
screenGui.ResetOnSpawn = false
screenGui.Parent = LocalPlayer:WaitForChild("PlayerGui")

-- Simple toggle button
local toggleButton = Instance.new("TextButton")
toggleButton.Size = UDim2.new(0, 150, 0, 50)
toggleButton.Position = UDim2.new(0, 20, 0, 20)
toggleButton.Text = "Toggle Friends ESP"
toggleButton.BackgroundColor3 = Color3.fromRGB(50,50,50)
toggleButton.TextColor3 = Color3.fromRGB(255,255,255)
toggleButton.Parent = screenGui

toggleButton.MouseButton1Click:Connect(function()
    friendESP = not friendESP
end)

-- Function to create or update ESP
local function applyESP(player)
    if player == LocalPlayer then return end
    local character = player.Character
    if character then
        local hrp = character:FindFirstChild("HumanoidRootPart")
        if hrp then
            if not espData[player] then
                local highlight = Instance.new("Highlight")
                highlight.Adornee = character
                highlight.FillColor = Color3.fromRGB(0,255,0)
                highlight.OutlineColor = Color3.fromRGB(0,255,0)
                highlight.Parent = workspace
                espData[player] = highlight
            end
        end
    end
end

-- Function to update colors dynamically
local function updateColors()
    for player, highlight in pairs(espData) do
        if friendESP and LocalPlayer:IsFriendsWith(player.UserId) then
            highlight.FillColor = Color3.fromRGB(0,0,255) -- blue for friends
            highlight.OutlineColor = Color3.fromRGB(0,0,255)
        else
            highlight.FillColor = Color3.fromRGB(255,0,0) -- red for others
            highlight.OutlineColor = Color3.fromRGB(255,0,0)
        end
    end
end

-- Refresh loop every second
while true do
    for _, player in pairs(Players:GetPlayers()) do
        applyESP(player)
    end
    updateColors()
    wait(refreshTime)
end
