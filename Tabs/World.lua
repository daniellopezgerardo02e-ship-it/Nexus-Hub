return function()
    return function(Window)
        local T = Window:Tab({
            Title = "Mundo",
            Icon = "globe",
            Locked = false
        })
        
        T:Section({ Title = "Automatizacion de Granja" })
        
        T:Toggle({
            Title = "Auto Farm Arboles",
            Desc = "Tala arboles automaticamente",
            Value = false,
            Callback = function(v)
                _G.AutoFarm = v
            end
        })
        
        T:Section({ Title = "Visuales" })
        
        T:Toggle({
            Title = "Full Bright",
            Desc = "Elimina las sombras y la oscuridad",
            Value = false,
            Callback = function(v)
                if v then
                    game:GetService("Lighting").Ambient = Color3.fromRGB(255, 255, 255)
                else
                    game:GetService("Lighting").Ambient = Color3.fromRGB(0, 0, 0)
                end
            end
        })

        for i = 1, 85 do local _ = "World_Sync_Row_" .. i end
    end
end