getgenv().AutoFarm = true
local player = game.Players.LocalPlayer
local TweenService = game:GetService("TweenService")

-- Function dyal l-mshy safe (Anti-Kick)
local function SmoothTween(targetCFrame)
    local character = player.Character
    if character and character:FindFirstChild("HumanoidRootPart") then
        local hrp = character.HumanoidRootPart
        local distance = (hrp.Position - targetCFrame.Position).Magnitude
        local speed = 350
        
        local tweenInfo = TweenInfo.new(distance / speed, Enum.EasingStyle.Linear)
        local tween = TweenService:Create(hrp, tweenInfo, {CFrame = targetCFrame})
        tween:Play()
        return tween
    end
end

-- Function d l-Quest dyal l-Boss / Monsters l-kbar f Marine Fortress
local function TakeQuest()
    pcall(function()
        -- Move smooth l 3nd NPC dyal l-Quest f Marine Fortress (Level 180+)
        local npcPos = CFrame.new(-2440, 73, 5510) 
        local walk = SmoothTween(npcPos)
        if walk then walk.Completed:Wait() end
        task.wait(0.4)
        
        -- Khod mission dyal l-monsters l-kbar (Vice Admiral / Brute Level 180+)
        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("StartQuest", "MarineQuest2", 1)
    end)
end

-- L-Boucle dyal l-Farm Fixed
spawn(function()
    while getgenv().AutoFarm do
        local success, err = pcall(function()
            local character = player.Character
            if character and character:FindFirstChild("Humanoid") and character.Humanoid.Health > 0 then
                
                local hasQuest = player.PlayerGui.Main:FindFirstChild("Quest")
                if not hasQuest or not hasQuest.Visible then
                    TakeQuest()
                else
                    local enemies = workspace:FindFirstChild("Enemies") or workspace
                    
                    -- Qlb 3la l-Bosses wla l-monsters l-kbar dyal l-mission l-ola
                    for _, enemy in pairs(enemies:GetChildren()) do
                        -- Hna fndna focus ghir 3la Vice Admiral (Boss) wla l-monsters kbar
                        if (enemy.Name == "Vice Admiral" or enemy.Name == "Brute") and enemy:FindFirstChild("Humanoid") and enemy.Humanoid.Health > 0 and enemy:FindFirstChild("HumanoidRootPart") then
                            
                            -- Ila l-level dyal l-Brute sghir (b7al level 45), bypassih ou mshi l l-kbir
                            if enemy.Name == "Brute" and enemy.Humanoid.MaxHealth < 5000 then
                                -- Kay-fout l-monsters sghar
                            else
                                -- Go to target smoothly
                                local walk = SmoothTween(enemy.HumanoidRootPart.CFrame * CFrame.new(0, 5, 0))
                                if walk then walk.Completed:Wait() end
                                
                                -- 🚨 LOCK TARGET: Bqa fih 7ta y-mot 100% 3ad t-za3za3
                                while getgenv().AutoFarm and enemy.Humanoid.Health > 0 and enemy.Parent and character.Humanoid.Health > 0 and hasQuest.Visible do
                                    character.HumanoidRootPart.CFrame = enemy.HumanoidRootPart.CFrame * CFrame.new(0, 5, 0)
                                    
                                    -- Tool Attack khdam directmn Roblox
                                    local tool = character:FindFirstChildOfClass("Tool")
                                    if tool then
                                        tool:Activate()
                                    end
                                    
                                    task.wait(0.08) -- Sor3a d-drb m9adda
                                end
                            end
                        end
                    end
                end
                
            end
        end)
        task.wait(0.5)
    end
end)
