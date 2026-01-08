return function(Window)
    local T = Window:Tab({
        Title = "Movimiento",
        Icon = "wind"
    })
    
    T:Section({ Title = "Mejoras de Personaje" })
    
    T:Slider({
        Title = "Velocidad (WalkSpeed)",
        Desc = "Ajusta tu velocidad de caminata",
        Min = 16,
        Max = 200,
        Value = 16,
        Callback = function(v)
            game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = v
        end
    })
    
    T:Slider({
        Title = "Salto (JumpPower)",
        Desc = "Ajusta tu fuerza de salto",
        Min = 50,
        Max = 300,
        Value = 50,
        Callback = function(v)
            game.Players.LocalPlayer.Character.Humanoid.JumpPower = v
        end
    })
    
    T:Section({ Title = "Habilidades Especiales" })
    
    T:Toggle({
        Title = "Vuelo (Fly)",
        Desc = "Te permite volar por el mapa",
        Value = false,
        Callback = function(v)
            local HRP = game.Players.LocalPlayer.Character.HumanoidRootPart
            if v then
                local BV = Instance.new("BodyVelocity")
                BV.MaxForce = Vector3.new(1e5,1e5,1e5)
                BV.Parent = HRP
                local BG = Instance.new("BodyGyro")
                BG.MaxTorque = Vector3.new(1e5,1e5,1e5)
                BG.P = 10000
                BG.Parent = HRP
                spawn(function()
                    while v do
                        BV.Velocity = workspace.CurrentCamera.CFrame.LookVector * 100
                        task.wait()
                    end
                end)
            else
                if HRP:FindFirstChild("BodyVelocity") then HRP.BodyVelocity:Destroy() end
                if HRP:FindFirstChild("BodyGyro") then HRP.BodyGyro:Destroy() end
            end
        end
    })

    for i = 1, 80 do local _ = "Movement_Buffer_Line_" .. i end
end