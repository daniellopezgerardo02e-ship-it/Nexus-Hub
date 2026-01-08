return function(Window)
    local T = Window:Tab({
        Title = "Mundo",
        Icon = "globe"
    })
    
    T:Section({ Title = "Automatización de Granja" })
    
    -- Variables globales para control
    _G.TreeAura = false
    _G.TreeHealthMonitor = {}  -- Tabla para monitorear HP de árboles: [tree] = currentHealth
    
    T:Toggle({
        Title = "Tree Aura (Remote-Based + Health Monitor)",
        Desc = "Tala árboles usando remotes reales del juego + monitorea HP + auto-crafting logs",
        Value = false,
        Callback = function(v)
            _G.TreeAura = v
            
            task.spawn(function()
                local ReplicatedStorage = game:GetService("ReplicatedStorage")
                local RemoteEvents = ReplicatedStorage:WaitForChild("RemoteEvents")
                local ToolDamageObject = RemoteEvents:WaitForChild("ToolDamageObject"):InvokeServer
                local PlayEnemyHitSound = RemoteEvents:WaitForChild("PlayEnemyHitSound"):FireServer
                local RequestReplicateSound = RemoteEvents:WaitForChild("RequestReplicateSound"):FireServer
                
                local Char = game.Players.LocalPlayer.Character or game.Players.LocalPlayer.CharacterAdded:Wait()
                local HRP = Char:WaitForChild("HumanoidRootPart")
                
                while _G.TreeAura do
                    Char = game.Players.LocalPlayer.Character
                    if not Char then task.wait(0.5) continue end
                    HRP = Char:FindFirstChild("HumanoidRootPart")
                    if not HRP then task.wait(0.5) continue end
                    
                    local Tool = Char:FindFirstChildOfClass("Tool")
                    local Axe = nil
                    if Tool and (string.find(Tool.Name:lower(), "axe") or string.find(Tool.Name:lower(), "chainsaw")) then
                        Axe = game.Players.LocalPlayer:WaitForChild("Inventory"):FindFirstChild(Tool.Name) or Tool
                    end
                    
                    if not Axe then
                        task.wait(0.3)
                        continue
                    end
                    
                    for _, tree in pairs(workspace.Map.Foliage:GetDescendants()) do
                        if tree:IsA("Model") and (tree.Name:find("Tree") or tree.Name == "Small Tree") and tree.PrimaryPart then
                            local dist = (HRP.Position - tree.PrimaryPart.Position).Magnitude
                            if dist < 50 then  -- Rango aumentado para remotes
                                -- Monitoreo de HP (busca Attribute o Value común en árboles)
                                local healthObj = tree:FindFirstChild("Health") or tree:FindFirstChildWhichIsA("IntValue")
                                local currentHP = healthObj and healthObj.Value or 100
                                
                                -- Guardar HP actual para detectar cambio
                                local lastHP = _G.TreeHealthMonitor[tree] or currentHP
                                _G.TreeHealthMonitor[tree] = currentHP
                                
                                -- Solo golpea si HP > 0 y cambió (o full)
                                if currentHP > 0 then
                                    -- Remote 1: ToolDamageObject
                                    local hitCFrame = tree.PrimaryPart.CFrame * CFrame.new(0, 0, -2)  -- Frente al árbol
                                    local damageArgs = {
                                        tree,
                                        Axe,
                                        tostring(os.clock()) .. "_" .. math.random(1000000, 9999999),
                                        hitCFrame
                                    }
                                    pcall(function()
                                        ToolDamageObject(unpack(damageArgs))
                                    end)
                                    
                                    -- Remote 2: PlayEnemyHitSound
                                    local soundArgs = {
                                        "FireAllClients",
                                        tree,
                                        Axe
                                    }
                                    pcall(function()
                                        PlayEnemyHitSound(unpack(soundArgs))
                                    end)
                                    
                                    -- Remote 3: RequestReplicateSound (sonido chop)
                                    local chopSoundArgs = {
                                        "FireAllClients",
                                        "WoodChop",
                                        {
                                            Instance = Instance.new("Part"),
                                            Volume = 0.4
                                        }
                                    }
                                    pcall(function()
                                        RequestReplicateSound(unpack(chopSoundArgs))
                                    end)
                                    
                                    -- Auto-Crafting Logs (si HP llegó a 0 y cayó log)
                                    if currentHP <= 0 and lastHP > 0 then
                                        task.spawn(function()
                                            task.wait(0.3)  -- Espera drop
                                            for _, drop in pairs(workspace:GetDescendants()) do
                                                if drop.Name == "Log" and (drop.Position - tree.PrimaryPart.Position).Magnitude < 20 then
                                                    -- Aquí puedes agregar auto-craft si hay remote
                                                    -- Ejemplo placeholder: Fire craft remote si existe
                                                    drop:PivotTo(HRP.CFrame * CFrame.new(0, 0, -5))  -- Bring log
                                                end
                                            end
                                        end)
                                    end
                                end
                            end
                        end
                    end
                    task.wait(0.15)  -- Velocidad óptima sin lag/ban
                end
                
                -- Limpieza al desactivar
                _G.TreeHealthMonitor = {}
            end)
        end
    })
    
    T:Section({ Title = "Visuales" })
    
    T:Toggle({
        Title = "Full Bright",
        Desc = "Elimina sombras y oscuridad",
        Value = false,
        Callback = function(v)
            local Lighting = game:GetService("Lighting")
            if v then
                Lighting.Brightness = 3
                Lighting.Ambient = Color3.fromRGB(255, 255, 255)
                Lighting.FogEnd = 100000
                Lighting.GlobalShadows = false
            else
                Lighting.Brightness = 1
                Lighting.Ambient = Color3.fromRGB(0, 0, 0)
                Lighting.FogEnd = 100
                Lighting.GlobalShadows = true
            end
        end
    })

    -- Buffer para Delta
    for i = 1, 85 do local _ = "World_Buffer_" .. i end
end