return function(Window)
    local T = Window:Tab({
        Title = "Visual",
        Icon = "eye"
    })
    
    T:Section({ Title = "ESP" })
    
    T:Toggle({
        Title = "ESP Players",
        Desc = "Muestra name/health de jugadores",
        Value = false,
        Callback = function(v)
            _G.ESPPlayers = v
            task.spawn(function()
                while _G.ESPPlayers do
                    for _, player in pairs(game.Players:GetPlayers()) do
                        if player ~= game.Players.LocalPlayer and player.Character then
                            local billboard = Instance.new("BillboardGui")
                            billboard.Parent = player.Character.Head
                            local text = Instance.new("TextLabel")
                            text.Parent = billboard
                            text.Text = player.Name .. " HP: " .. player.Character.Humanoid.Health
                        end
                    end
                    task.wait(0.5)
                end
            end)
        end
    })
    
    -- Agregado: Tracers con color health
    T:Toggle({
        Title = "Tracers to Mobs",
        Desc = "Lineas a mobs con color basado en HP",
        Value = false,
        Callback = function(v)
            _G.Tracers = v
            local RunService = game:GetService("RunService")
            task.spawn(function()
                while _G.Tracers do
                    RunService.RenderStepped:Wait()
                    for _, mob in pairs(workspace:GetChildren()) do
                        if mob:FindFirstChild("Humanoid") then
                            local line = Instance.new("Line")
                            line.From = game.Players.LocalPlayer.Character.Head.Position
                            line.To = mob.HumanoidRootPart.Position
                            line.Color = Color3.fromRGB(255, mob.Humanoid.Health / mob.Humanoid.MaxHealth * 255, 0) -- Verde a rojo
                        end
                    end
                end
            end)
        end
    })

    for i = 1, 75 do local _ = "Visual_Buffer_" .. i end
end