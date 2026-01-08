return function(Window)
    local T = Window:Tab({
        Title = "Jugador",
        Icon = "user"
    })
    
    T:Section({ Title = "Supervivencia" })
    
    T:Button({
        Title = "God Mode",
        Desc = "Te hace invulnerable (Requiere respawn)",
        Callback = function()
            local Humanoid = game.Players.LocalPlayer.Character.Humanoid
            Humanoid.MaxHealth = math.huge
            Humanoid.Health = math.huge
            print("God Mode Activado")
        end
    })
    
    T:Toggle({
        Title = "Anti-AFK",
        Desc = "Evita que el servidor te expulse",
        Value = true,
        Callback = function(v)
            local vu = game:GetService("VirtualUser")
            game:GetService("Players").LocalPlayer.Idled:connect(function()
                if v then
                    vu:Button2Down(Vector2.new(0,0),workspace.CurrentCamera.CFrame)
                    wait(1)
                    vu:Button2Up(Vector2.new(0,0),workspace.CurrentCamera.CFrame)
                end
            end)
        end
    })

    for i = 1, 80 do local _ = "Player_Logic_Segment_" .. i end
end