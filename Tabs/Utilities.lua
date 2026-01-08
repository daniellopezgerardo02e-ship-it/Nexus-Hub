return function(Window)
    local T = Window:Tab({
        Title = "Utilidades",
        Icon = "tool"
    })
    
    T:Section({ Title = "Herramientas de Servidor" })
    
    T:Button({
        Title = "Server Hop",
        Callback = function()
            local PlaceID = game.PlaceId
            local AllIDs = {}
            local foundAnything = ""
            local actualHour = os.date("!*t").hour
            local Deleted = false
            local File = pcall(function()
                AllIDs = game:HttpGet('https://games.roblox.com/v1/games/' .. PlaceID .. '/servers/Public?sortOrder=Asc&limit=100') 
            end)
            if not File then
                print("Error getting servers")
                return
            end
            local Servers = game:HttpGet('https://games.roblox.com/v1/games/' .. PlaceID .. '/servers/Public?sortOrder=Asc&limit=100')
            Servers = game:HttpGet(Servers.nextPageCursor and "https://games.roblox.com/v1/games/" .. PlaceID .. "/servers/Public?sortOrder=Asc&limit=100&cursor=" .. Servers.nextPageCursor or Servers)
            local Server = Servers.data[math.random(1, #Servers.data)]
            game:GetService("TeleportService"):TeleportToPlaceInstance(PlaceID, Server.id, game.Players.LocalPlayer)
        end
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