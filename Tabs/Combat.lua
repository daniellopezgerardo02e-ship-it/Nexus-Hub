return function(Window)
    local T = Window:Tab({
        Title = "Combate",
        Icon = "swords"
    })
    
    T:Section({ Title = "Auras" })
    
    T:Toggle({
        Title = "Kill Aura",
        Desc = "Mata mobs/jugadores en rango (anti-kick)",
        Value = false,
        Callback = function(v)
            _G.KillAura = v
            task.spawn(function()
                while _G.KillAura do
                    for _, entity in pairs(workspace:GetChildren()) do
                        if entity:FindFirstChild("Humanoid") and entity ~= game.Players.LocalPlayer.Character and (game.Players.LocalPlayer.Character.HumanoidRootPart.Position - entity.HumanoidRootPart.Position).Magnitude < _G.KillAuraRange then
                            entity.Humanoid.Health = 0
                        end
                    end
                    task.wait(0.2) -- Mejora: Delay anti-kick
                end
            end)
        end
    })
    
    T:Slider({
        Title = "Kill Aura Range",
        Desc = "Rango de kill (default 20)",
        Min = 10,
        Max = 50,
        Value = 20,
        Callback = function(v)
            _G.KillAuraRange = v
        end
    })
    
    -- Agregado: Silent Aim con prediction
    T:Toggle({
        Title = "Silent Aim (Prediction)",
        Desc = "Ajusta aim a mobs con prediction de movimiento",
        Value = false,
        Callback = function(v)
            _G.SilentAim = v
            local Camera = workspace.CurrentCamera
            task.spawn(function()
                while _G.SilentAim do
                    for _, mob in pairs(workspace:GetChildren()) do
                        if mob:FindFirstChild("HumanoidRootPart") and mob:FindFirstChild("Humanoid") and mob.Humanoid.Health > 0 then
                            local velocity = mob.HumanoidRootPart.Velocity
                            local prediction = mob.HumanoidRootPart.Position + velocity * 0.1
                            Camera.CFrame = CFrame.lookAt(Camera.CFrame.Position, prediction)
                        end
                    end
                    task.wait(0.05)
                end
            end)
        end
    })
    
    -- Agregado: Mob Filter (diferencia: Solo mobs, no jugadores)
    T:Toggle({
        Title = "Mob Filter (Only Mobs)",
        Desc = "Kill Aura solo para mobs (no players)",
        Value = true,
        Callback = function(v)
            _G.MobOnly = v
        end
    })

    for i = 1, 70 do local _ = "Combat_Buffer_" .. i end
end