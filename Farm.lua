-- Anti-Kick Smooth Auto Farm & Auto Quest (Level 180+)
getgenv().AutoFarm = true
local player = game.Players.LocalPlayer
local Vim = game:GetService("VirtualInputManager")
local TweenService = game:GetService("TweenService")

-- Anti-Idle (Bypass Kick 20 Mins)
player.Idled:Connect(function()
    Vim:SendMouseButtonEvent(0, 0, 0, true, game, 1)
    task.wait(0.1)
    Vim:SendMouseButtonEvent(0, 0, 0, false, game, 1)
end)

-- Function dyal l-mshy smooth (Anti-Kick)
local function SmoothTween(targetCFrame)
    local character = player.Character
    if character and character:FindFirstChild("HumanoidRootPart") then
        local hrp = character.HumanoidRootPart
        local distance = (hrp.Position - targetCFrame.Position).Magnitude
        local speed = 300 -- Sor3a safe bzzaf 3la l-Anti-cheat
        
        local tweenInfo = TweenInfo.new(distance / speed, Enum.EasingStyle.Linear)
        local tween = TweenService:Create(hrp, tweenInfo, {CFrame = targetCFrame})
        tween:Play()
        return tween
    end
end

-- Function dyal l-Mission (Pirate Village - Level 183)
local function TakeQuest()
    pcall(function()
        -- 1. Tween smooth l 3nd l-NPC dyal l-Quest
        local questNPCpos = CFrame.new(-1137, 4.7, 3843)
        local walk = SmoothTween(questNPCpos)
        if walk then walk.Completed:Wait() end
        task.wait(0.3)
        
        -- 2. Khod l-mission dyal l-Brutes direct
        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("StartQuest", "BuggyQuest1", 2)
    end)
end

-- L-Boucle dyal l-Farm & Quest
spawn(function()
    while getgenv().AutoFarm do
        local success, err = pcall(function()
            local character = player.Character
            if character and character:FindFirstChild("Humanoid") and character.Humanoid.Health > 0 then
                
                -- Check wash 3ndek mission khdama
                local hasQuest = player.PlayerGui.Main:FindFirstChild("Quest")
                if not hasQuest or not hasQuest.Visible then
                    TakeQuest()
                else
                    -- Ila 3ndek mission, mshi l l-monsters smoothly
                    local enemies = workspace:FindFirstChild("Enemies") or workspace
                    for _, enemy in pairs(enemies:GetChildren()) do
                        -- Qlb 3la Brute f Pirate Village
                        if enemy.Name == "Brute" and enemy:FindFirstChild("Humanoid") and enemy.Humanoid.Health > 0 and enemy:FindFirstChild("HumanoidRootPart") then
                            
                            -- Move to monster position
                            local walk = SmoothTween(enemy.HumanoidRootPart.CFrame * CFrame.new(0, 5, 0))
                            if walk then walk.Completed:Wait() end
                            
                            -- Attack loop
                            while getgenv().AutoFarm and enemy.Humanoid.Health > 0 and enemy.Parent and character.Humanoid.Health > 0 and hasQuest.Visible do
                                character.HumanoidRootPart.CFrame = enemy.HumanoidRootPart.CFrame * CFrame.new(0, 5, 0)
                                
                                -- Send Clicks normal dyal mouse f Windows
                                Vim:SendMouseButtonEvent(0, 0, 0, true, game, 1)
                                task.wait(0.05)
                                Vim:SendMouseButtonEvent(0, 0, 0, false, game, 1)
                                
                                task.wait(0.1)
                            end
                        end
                    end
                end
                
            end
        end)
        task.wait(0.5)
    end
end)
