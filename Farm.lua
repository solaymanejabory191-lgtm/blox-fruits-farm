getgenv().AutoFarm = true
local player = game.Players.LocalPlayer

-- Function bash y-sîft d-drb direct l l-server (Remote Attack - Anti-Cheat Bypass)
local function DoDamage(enemyHumanoid)
    pcall(function()
        -- Sîft d-drba nish-an l l-Server bla kliker f l-shasha
        local combatRemote = game:GetService("ReplicatedStorage").Remotes.CommF_
        combatRemote:InvokeServer("RegisterAttack")
        combatRemote:InvokeServer("Attack")
    end)
end

-- Function dyal l-Quests automatic l level 183 (Pirate Village / Marine)
local function TakeQuest()
    pcall(function()
        local myLevel = player.Data.Level.Value
        local args = {}
        
        if myLevel >= 150 and myLevel < 190 then
            -- Mission dyal Level 150-190 (Pirate Village - Brute)
            game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("StartQuest", "BuggyQuest1", 2)
        elseif myLevel >= 190 then
            -- Mission dyal Level 190+
            game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("StartQuest", "MarineQuest2", 1)
        end
    end)
end

-- L-Boucle dyal l-Farm + Quest + Damage Direct
spawn(function()
    while getgenv().AutoFarm do
        local success, err = pcall(function()
            local character = player.Character
            if character and character:FindFirstChild("HumanoidRootPart") and character.Humanoid.Health > 0 then
                
                -- Check l-Quest
                local hasQuest = player.PlayerGui.Main:FindFirstChild("Quest")
                if not hasQuest or not hasQuest.Visible then
                    -- Teleport direct l l-NPC dyal l-Quest bash y-akhodha
                    character.HumanoidRootPart.CFrame = CFrame.new(-1137, 5, 3843) -- Position NPC f Pirate Village
                    task.wait(0.3)
                    TakeQuest()
                else
                    -- Ila 3ndek l-Quest, mshi farmi direct l-monsters
                    local enemies = workspace:FindFirstChild("Enemies") or workspace
                    local foundEnemy = false
                    
                    for _, enemy in pairs(enemies:GetChildren()) do
                        -- Qlb 3la Brute (Monsters dyal level 180+)
                        if (enemy.Name == "Brute" or enemy.Name == "Pirate") and enemy:FindFirstChild("Humanoid") and enemy.Humanoid.Health > 0 then
                            foundEnemy = true
                            while getgenv().AutoFarm and enemy.Humanoid.Health > 0 and enemy.Parent and character.Humanoid.Health > 0 and hasQuest.Visible do
                                -- Teleport safely fawq l-monster
                                character.HumanoidRootPart.CFrame = enemy.HumanoidRootPart.CFrame * CFrame.new(0, 5, 0)
                                
                                -- DRB DIRECT MN L-SERVER (Damage 100%)
                                DoDamage(enemy.Humanoid)
                                
                                task.wait(0.05) -- Fast Attack asra3 bzzaf
                            end
                        end
                    end
                    
                    -- Ila ma-lqash monsters khdamين, y-mshi l-blasa fin kay-bano
                    if not foundEnemy then
                        character.HumanoidRootPart.CFrame = CFrame.new(-1200, 30, 3900) -- Blasa d l-monsters
                    end
                end
                
            end
        end)
        task.wait(0.3)
    end
end)
