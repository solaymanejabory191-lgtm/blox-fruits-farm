getgenv().AutoFarm = true
local player = game.Players.LocalPlayer
local VirtualUser = game:GetService("VirtualUser")

-- Anti-Idle (Bypass Kick)
player.Idled:Connect(function()
    VirtualUser:Button1Down(Vector2.new(0,0), workspace.CurrentCamera.CFrame)
end)

-- 1. SISTIM DYAL L-QUEST AUTOMATIC
local function TakeQuest()
    local playerLevel = player.Data.Level.Value
    
    -- Hna khtar l-Quest 3la 7sab l-level dyalk (Mital: Level 1-10 Bandits)
    -- L-iscript ghadi y-mshi automatic l l-NPC dyal l-mission
    if playerLevel >= 1 and playerLevel < 10 then
        local questNPC = workspace.NPCs:FindFirstChild("Quest Giver") -- Qlb 3la NPC
        if questNPC and player:DistanceFromCharacter(questNPC.HumanoidRootPart.Position) > 10 then
            player.Character.HumanoidRootPart.CFrame = questNPC.HumanoidRootPart.CFrame * CFrame.new(0, 0, -3)
            task.wait(0.5)
        end
        -- Kod dyal l-akhd dyal l-Quest mn l-lo3ba
        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("StartQuest", "BanditQuest1", 1)
    end
end

-- 2. FAST ATTACK + AUTO CLICK
spawn(function()
    while getgenv().AutoFarm do
        pcall(function()
            if player.Character and player.Character:FindFirstChild("Humanoid") and player.Character.Humanoid.Health > 0 then
                VirtualUser:CaptureController()
                VirtualUser:ClickButton1(Vector2.new(0,0))
            end
        end)
        task.wait(0.05) -- Sor3a d-drb fast attack safe l PC
    end
end)

-- 3. L-BOUCLE L-ASLIYA DYAL L-FARM
spawn(function()
    while getgenv().AutoFarm do
        local success, err = pcall(function()
            local character = player.Character
            if character and character:FindFirstChild("HumanoidRootPart") and character.Humanoid.Health > 0 then
                
                -- Check wash 3ndek mission khdama, ila ma-3ndsh khodha
                local hasQuest = player.PlayerGui.Main:FindFirstChild("Quest")
                if not hasQuest or not hasQuest.Visible then
                    TakeQuest()
                else
                    -- Ila 3ndek l-mission, mshi direct farmi l-monsters dyalha
                    local enemies = workspace:FindFirstChild("Enemies") or workspace
                    for _, enemy in pairs(enemies:GetChildren()) do
                        -- Qlb 3la l-monster dyal l-mission (Mital: Bandit)
                        if enemy.Name == "Bandit" and enemy:FindFirstChild("Humanoid") and enemy.Humanoid.Health > 0 then
                            while getgenv().AutoFarm and enemy.Humanoid.Health > 0 and enemy.Parent and character.Humanoid.Health > 0 and hasQuest.Visible do
                                -- Teleport direct fawq l-monster
                                character.HumanoidRootPart.CFrame = enemy.HumanoidRootPart.CFrame * CFrame.new(0, 5, 0)
                                task.wait()
                            end
                        end
                    end
                end
                
            end
        end)
        task.wait(0.5)
    end
end)
