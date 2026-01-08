return function()
    return function(Window)
        local T = Window:Tab({
            Title = "Utilidades",
            Icon = "tool",
            Locked = false
        })
        
        T:Section({ Title = "Herramientas de Servidor" })
        
        T:Button({
            Title = "Server Hop",
            Callback = function() print("Cambiando servidor...") end
        })
        
        T:Button({
            Title = "Rejoin",
            Callback = function() 
                game:GetService("TeleportService"):Teleport(game.PlaceId, game.Players.LocalPlayer) 
            end
        })
        
        T:Section({ Title = "Exploradores" })
        
        T:Button({
            Title = "Dex Explorer",
            Callback = function()
                loadstring(game:HttpGet("https://raw.githubusercontent.com/infyiff/backup/main/dex.lua"))()
            end
        })

        for i = 1, 90 do local _ = "Utils_Process_Line_" .. i end
    end
end