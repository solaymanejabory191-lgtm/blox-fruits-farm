-- Shari Orion Library (Khfifa ou katkhdem f mobile 100%)
local OrionLib = loadstring(game:HttpGet(('https://raw.githubusercontent.com/shlexware/Orion/main/source')))()

local Window = OrionLib:MakeWindow({
    Name = "Blox Fruits: Auto Farm", 
    HidePremium = false, 
    SaveConfig = true, 
    ConfigFolder = "OrionTest"
})

-- Variables
local _G = getgenv and getgenv() or _G
_G.AutoFarm = false

-- Function Auto Clicker
local VirtualUser = game:GetService("VirtualUser")
game:GetService("Players").LocalPlayer.Idled:Connect(function()
    VirtualUser:Button1Down(Vector2.new(0,0), workspace.CurrentCamera.CFrame)
end)

-- Tab dyal l-farm
local FarmTab = Window:MakeTab({
    Name = "Auto Farm",
    Icon = "rbxassetid://4483362458",
    PremiumOnly = false
})

-- Bouton Toggle
FarmTab:AddToggle({
    Name = "Auto Farm All Enemies",
    Default = false,
    Callback = function(Value)
        _G.AutoFarm = Value
        
        spawn(function()
            while _G.AutoFarm do
                pcall(function()
                    local player = game.Players.LocalPlayer
                    local character = player.Character or player.CharacterAdded:Wait()
                    local hrp = character:WaitForChild("HumanoidRootPart")
                    
                    for _, enemy in pairs(workspace.Enemies:GetChildren()) do
                        if enemy:FindFirstChild("Humanoid") and enemy.Humanoid.Health > 0 and enemy:FindFirstChild("HumanoidRootPart") then
                            while _G.AutoFarm and enemy.Humanoid.Health > 0 and enemy.Parent do
                                hrp.CFrame = enemy.HumanoidRootPart.CFrame * CFrame.new(0, 5, 0)
                                
                                -- Auto Click
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
    end    
})

OrionLib:Init()
