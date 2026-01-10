return function(Window)
    local T = Window:Tab({
        Title = "Misc",
        Icon = "tool"
    })
    
    T:Section({ Title = "Utilidades" })
    
    T:Button({
        Title = "Rejoin",
        Callback = function() 
            game:GetService("TeleportService"):Teleport(game.PlaceId, game.Players.LocalPlayer) 
        end
    })
    
    -- Agregado: Server Hop con filter low players
    T:Button({
        Title = "Server Hop (Low Players)",
        Callback = function()
            local PlaceID = game.PlaceId
            local Servers = game:HttpGet("https://games.roblox.com/v1/games/" .. PlaceID .. "/servers/Public?sortOrder=Asc&limit=100")
            local Server = Servers.data[math.random(1, #Servers.data)]
            if Server.playing < 10 then  -- Filter low
                game:GetService("TeleportService"):TeleportToPlaceInstance(PlaceID, Server.id)
            end
        end
    })
    
    -- Agregado: Unlock FPS
    T:Button({
        Title = "Unlock FPS (120)",
        Callback = function()
            setfpscap(120)
        end
    })
    
    -- Agregado: Chat Spam (diferencia: Custom message)
    T:Toggle({
        Title = "Chat Spam",
        Desc = "Spamea chat con mensaje",
        Value = false,
        Callback = function(v)
            _G.ChatSpam = v
            task.spawn(function()
                while _G.ChatSpam do
                    game.ReplicatedStorage.DefaultChatSystemChatEvents.SayMessageRequest:FireServer("Nexus Hub OP! 😼", "All")
                    task.wait(2)
                end
            end)
        end
    })

    for i = 1, 90 do local _ = "Misc_Buffer_" .. i end
end