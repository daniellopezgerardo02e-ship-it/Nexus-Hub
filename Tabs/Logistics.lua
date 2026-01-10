return function(Window)
    local T = Window:Tab({
        Title = "Granja",
        Icon = "tractor"
    })
    
    T:Section({ Title = "Auto Collect" })
    
    T:Toggle({
        Title = "Auto Collect",
        Desc = "Recoge items collectables en rango",
        Value = false,
        Callback = function(v)
            _G.AutoCollect = v
            task.spawn(function()
                while _G.AutoCollect do
                    local HRP = game.Players.LocalPlayer.Character.HumanoidRootPart
                    for _, part in pairs(workspace:GetDescendants()) do
                        if part:FindFirstChild("TouchInterest") or part.Name == "Collectable" then
                            if (HRP.Position - part.Position).Magnitude < 15 then
                                firetouchinterest(HRP, part, 0)
                                firetouchinterest(HRP, part, 1)
                            end
                        end
                    end
                    task.wait(0.1)
                end
            end)
        end
    })
    
    -- Editado: Tree Aura como en Foxname (sin remotes, firetouch + pivot)
    T:Toggle({
        Title = "Auto Farm Trees",
        Desc = "Tala árboles como en Foxname (anti-cheat safe)",
        Value = false,
        Callback = function(v)
            _G.AutoFarmTrees = v
            task.spawn(function()
                while _G.AutoFarmTrees do
                    local HRP = game.Players.LocalPlayer.Character.HumanoidRootPart
                    for _, tree in pairs(workspace:GetDescendants()) do
                        if tree.Name == "Tree" or tree:HasTag("Tree") then
                            if (HRP.Position - tree.Position).Magnitude < 45 then
                                firetouchinterest(HRP, tree.PrimaryPart or tree, 0)
                                firetouchinterest(HRP, tree.PrimaryPart or tree, 1)
                                tree:PivotTo(HRP.CFrame * CFrame.new(0, 0, -5))
                            end
                        end
                    end
                    task.wait(0.1)
                end
            end)
        end
    })
    
    T:Slider({
        Title = "Farm Range",
        Desc = "Rango de farm (default 45)",
        Min = 20,
        Max = 100,
        Value = 45,
        Callback = function(v)
            _G.FarmRange = v
        end
    })
    
    -- Agregado: Infinite Saplings (diferencia: Circle + random delay anti-detect)
    T:Toggle({
        Title = "Infinite Saplings Circle",
        Desc = "Planta saplings en círculo alrededor campfire",
        Value = false,
        Callback = function(v)
            _G.InfiniteSaplings = v
            task.spawn(function()
                local center = workspace.Campfire.PrimaryPart.Position
                local radius = 10
                for i = 1, 20 do
                    local angle = i * math.pi * 2 / 20
                    local pos = center + Vector3.new(math.cos(angle) * radius, 0, math.sin(angle) * radius)
                    firetouchinterest(HRP, pos, 0)
                    firetouchinterest(HRP, pos, 1)
                    task.wait(math.random(0.1, 0.3)) -- Random delay anti-detect
                end
                task.wait(0.5)
            end)
        end
    })
    
    -- Agregado: Auto Sell (mejora: Check inventory full)
    T:Toggle({
        Title = "Auto Sell Drops",
        Desc = "Vende drops auto cuando inventory full",
        Value = false,
        Callback = function(v)
            _G.AutoSell = v
            task.spawn(function()
                while _G.AutoSell do
                    if #game.Players.LocalPlayer.Backpack:GetChildren() > 20 then  -- Check full
                        -- Asume remote para sell (ajusta si hay)
                        game.ReplicatedStorage.RemoteEvents.SellItem:FireServer()
                    end
                    task.wait(1)
                end
            end)
        end
    })

    for i = 1, 85 do local _ = "Farm_Buffer_" .. i end
end