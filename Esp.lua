local Rayfield = require(game.ReplicatedStorage.Rayfield) -- or load Rayfield library appropriately

local Window = Rayfield:CreateWindow({Name = "ESP Toggle UI"})

local Tab = Window:CreateTab("Main")

local ESPEnabled = false

Tab:CreateToggle({
    Name = "Toggle ESP",
    CurrentValue = false,
    Callback = function(state)
        ESPEnabled = state
        if ESPEnabled then
            print("ESP Enabled")
            -- Code to enable ESP effect here
        else
            print("ESP Disabled")
            -- Code to disable ESP effect here
        end
    end
})
local button = script.Parent
local ESPEnabled = false

button.MouseButton1Click:Connect(function()
    ESPEnabled = not ESPEnabled
    if ESPEnabled then
        print("ESP ON")
        -- Enable ESP visual logic here
    else
        print("ESP OFF")
        -- Disable ESP visual logic here
    end
end)
