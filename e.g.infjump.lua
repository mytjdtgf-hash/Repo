	game:GetService("UserInputService").JumpRequest:connect(function()
		game:GetService"Players".LocalPlayer.Character:FindFirstChildOfClass'Humanoid':ChangeState("Jumping")		
	end)    end
end

function ESP:disableESP()
    if self.espEnabled then
        self.espEnabled = false
        for _, player in ipairs(self.players:GetPlayers()) do
            if player.Character and player.Character:FindFirstChild("Head") then
                local billboardGui = player.Character.Head:FindFirstChildOfClass("BillboardGui")
                if billboardGui then
                    billboardGui:Destroy
                    
