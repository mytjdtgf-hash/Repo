local ESP = {}
ESP.__index = ESP

function ESP.new()
    local self = setmetatable({}, ESP)
    self.players = game:GetService("Players")
    self.localPlayer = self.players.LocalPlayer
    self.espEnabled = true
    return self
end

function ESP:createESPBox(player)
    if player.Character and player.Character:FindFirstChild("Head") then
        local billboardGui = Instance.new("BillboardGui")
        billboardGui.Adornee = player.Character.Head
        billboardGui.Size = UDim2.new(1, 0, 1, 0)
        billboardGui.AlwaysOnTop = true

        local espBox = Instance.new("Frame")
        espBox.Size = UDim2.new(1, 0, 1, 0)
        espBox.BackgroundColor3 = Color3.new(1, 0, 0) -- Red color
        espBox.BackgroundTransparency = 0.5 -- Semi-transparent
        espBox.Parent = billboardGui

        billboardGui.Parent = player.Character.Head
    end
end

function ESP:enableESP()
    if not self.espEnabled then
        self.espEnabled = true
        for _, player in ipairs(self.players:GetPlayers()) do
            if player ~= self.localPlayer and player.Character and player.Character:FindFirstChild("Head") then
                self:createESPBox(player)
            end
        end
    end
end

function ESP:disableESP()
    if self.espEnabled then
        self.espEnabled = false
        for _, player in ipairs(self.players:GetPlayers()) do
            if player.Character and player.Character:FindFirstChild("Head") then
                local billboardGui = player.Character.Head:FindFirstChildOfClass("BillboardGui")
                if billboardGui then
                    billboardGui:Destroy
                    
