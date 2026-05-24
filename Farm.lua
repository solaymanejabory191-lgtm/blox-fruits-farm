-- Shari l-UI Library (Rayfield)
local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

local Window = Rayfield:CreateWindow({
   Name = "Blox Fruits: Auto Farm",
   LoadingTitle = "Loading Script...",
   LoadingSubtitle = "by CustomCoder",
})

local Tab = Window:CreateTab("Farm", 4483362458) -- Icon ID

-- Variables l-asasiya
local _G = getgenv and getgenv() or _G
_G.AutoFarm = false

-- Function bash y-cliki l-script automatic (Auto Clicker)
local VirtualUser = game:GetService("VirtualUser")
game:GetService("Players").LocalPlayer.Idled:Connect(function()
    VirtualUser:Button1Down(Vector2.new(0,0), workspace.CurrentCamera.CFrame)
end)

-- L-bouton li ghadi y-khdem l-Auto Farm
local Toggle = Tab:CreateToggle({
   Name = "Auto Farm All Enemies",
   CurrentValue = false,
   Flag = "AutoFarmFlag", 
   Callback = function(Value)
       _G.AutoFarm = Value
       
       -- L-boucle dyal l-farm
       spawn(function()
           while _G.AutoFarm do
               pcall(function()
                   local player = game.Players.LocalPlayer
                   local character = player.Character or player.CharacterAdded:Wait()
                   local hrp = character:WaitForChild("HumanoidRootPart")
                   
                   -- Kay-qlb 3la أقرب monster f l-lo3ba
                   for _, enemy in pairs(workspace.Enemies:GetChildren()) do
                       if enemy:FindFirstChild("Humanoid") and enemy.Humanoid.Health > 0 and enemy:FindFirstChild("HumanoidRootPart") then
                           
                           -- T-teleporta fawq l-monster b 5 dyal l-steps bash t-farih safely
                           while _G.AutoFarm and enemy.Humanoid.Health > 0 do
                               hrp.CFrame = enemy.HumanoidRootPart.CFrame * CFrame.new(0, 5, 0)
                               
                               -- Hna fin kat-cliki (khassek tkon haz l-Combat wla l-Sword f ydik)
                               VirtualUser:CaptureController()
                               VirtualUser:ClickButton1(Vector2.new(0,0))
                               
                               task.wait(0.1) -- Sor3a dyal l-cliks
                           end
                       end
                   end
               end)
               task.wait(1)
           end
       end)
   end,
})
