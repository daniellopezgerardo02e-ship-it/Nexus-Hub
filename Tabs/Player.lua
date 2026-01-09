return function(Window)
    local T = Window:Tab({
        Title = "Jugador",
        Icon = "user"
    })
    
    T:Section({ Title = "Supervivencia" })
    
    -- Editado: God Mode con loop anti-reset y respawn handler
    T:Toggle({
        Title = "God Mode (Anti-Reset)",
        Desc = "Invulnerable con loop y re-apply al respawn",
        Value = false,
        Callback = function(v)
            _G.GodMode = v
            local function applyGod()
                local Char = game.Players.LocalPlayer.Character
                if Char then
                    local Humanoid = Char:FindFirstChild("Humanoid")
                    if Humanoid then
                        Humanoid.MaxHealth = math.huge
                        Humanoid.Health = math.huge
                    end
                end
            end
            if v then
                applyGod()
                task.spawn(function()
                    while _G.GodMode do
                        applyGod()
                        task.wait()
                    end
                end)
                -- Mejora: Respawn handler
                game.Players.LocalPlayer.CharacterAdded:Connect(applyGod)
            end
        end
    })
    
    T:Toggle({
        Title = "Anti-AFK",
        Desc = "Evita kick por inactividad",
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
    
    -- Agregado: NoClip Advanced con wall bypass
    T:Toggle({
        Title = "NoClip Advanced",
        Desc = "Bypass colisiones con walls y self ESP",
        Value = false,
        Callback = function(v)
            _G.NoClip = v
            if v then
                task.spawn(function()
                    while _G.NoClip do
                        for _, part in pairs(game.Players.LocalPlayer.Character:GetDescendants()) do
                            if part:IsA("BasePart") then
                                part.CanCollide = false
                            end
                        end
                        task.wait()
                    end
                end)
                -- Mejora: Self ESP (billboard con tu health)
                local billboard = Instance.new("BillboardGui")
                billboard.Parent = game.Players.LocalPlayer.Character.Head
                billboard.Adornee = game.Players.LocalPlayer.Character.Head
                billboard.Size = UDim2.new(0, 100, 0, 50)
                local text = Instance.new("TextLabel")
                text.Parent = billboard
                text.Text = "HP: " .. game.Players.LocalPlayer.Character.Humanoid.Health
                text.BackgroundTransparency = 1
                task.spawn(function()
                    while _G.NoClip do
                        text.Text = "HP: " .. game.Players.LocalPlayer.Character.Humanoid.Health
                        task.wait(0.5)
                    end
                end)
            else
                if game.Players.LocalPlayer.Character.Head:FindFirstChild("BillboardGui") then
                    game.Players.LocalPlayer.Character.Head.BillboardGui:Destroy()
                end
            end
        end
    })
    
    -- Agregado: Slider Gravity Adjust (diferencia: Para fly/jump combos)
    T:Slider({
        Title = "Ajuste de Gravedad",
        Desc = "Cambia la gravedad del mundo para saltos altos o low gravity",
        Min = 0,
        Max = 196,
        Value = 196,
        Callback = function(v)
            workspace.Gravity = v
        end
    })

    for i = 1, 80 do local _ = "Player_Logic_Segment_" .. i end
end