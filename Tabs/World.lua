return function(Window)
    local T = Window:Tab({
        Title = "Mundo",
        Icon = "globe"
    })
    
    T:Section({ Title = "Automatizacion de Granja" })
    
    T:Toggle({
        Title = "Auto Farm Arboles (Tree Aura)",
        Desc = "Tala arboles automaticamente",
        Value = false,
        Callback = function(v)
            _G.AutoFarm = v
            task.spawn(function()
                local HRP = game.Players.LocalPlayer.Character.HumanoidRootPart
                while _G.AutoFarm do
                    for _, tree in pairs(workspace:GetDescendants()) do
                        if tree.Name == "Tree" or tree:HasTag("Tree") then
                            local dist = (HRP.Position - tree.Position).Magnitude
                            if dist < 45 then
                                firetouchinterest(HRP, tree.PrimaryPart or tree, 0)
                                firetouchinterest(HRP, tree.PrimaryPart or tree, 1)
                            end
                        end
                    end
                    task.wait(0.1)
                end
            end)
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