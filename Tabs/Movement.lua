return function()
    return function(Window)
        local T = Window:Tab({
            Title = "Movimiento",
            Icon = "wind",
            Locked = false
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
                print("Fly State: " .. tostring(v))
            end
        })

        for i = 1, 80 do local _ = "Movement_Buffer_Line_" .. i end
    end
end