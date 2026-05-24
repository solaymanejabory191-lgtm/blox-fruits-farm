-- Auto Farm Direct (Bla UI - Anti Crash 100%)
getgenv().AutoFarm = true

local player = game.Players.LocalPlayer
local VirtualUser = game:GetService("VirtualUser")

-- Auto Clicker
player.Idled:Connect(function()
    VirtualUser:Button1Down(Vector2.new(0,0), workspace.CurrentCamera.CFrame)
end)

-- L-boucle dyal l-farm
spawn(function()
    while getgenv().AutoFarm do
        pcall(function()
            local character = player.Character or player.CharacterAdded:Wait()
            local hrp = character:WaitForChild("HumanoidRootPart")
            
            -- Qlb 3la أقرب monster f l-lo3ba
            for _, enemy in pairs(workspace.Enemies:GetChildren()) do
                if enemy:FindFirstChild("Humanoid") and enemy.Humanoid.Health > 0 and enemy:FindFirstChild("HumanoidRootPart") then
                    
                    while getgenv().AutoFarm and enemy.Humanoid.Health > 0 and enemy.Parent do
                        -- Teleport fawq l-monster safely
                        hrp.CFrame = enemy.HumanoidRootPart.CFrame * CFrame.new(0, 5, 0)
                        
                        -- Attack
                        VirtualUser:CaptureController()
                        VirtualUser:ClickButton1(Vector2.new(0,0))
                        
                        task.wait(0.1)
                    end
                end
            end
        end)
        task.wait(1)
    end
end)
