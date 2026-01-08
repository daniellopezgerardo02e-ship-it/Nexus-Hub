return function(Window)
    local T = Window:Tab({
        Title = "Mundo",
        Icon = "globe"
    })
    
    T:Section({ Title = "Automatización de Granja" })
    
    T:Toggle({
        Title = "Tree Aura (Auto Tala)",
        Desc = "Tala árboles solo si tienes hacha/motosierra equipada (rango 45)",
        Value = false,
        Callback = function(v)
            _G.TreeAura = v
            task.spawn(function()
                while _G.TreeAura do
                    local Char = game.Players.LocalPlayer.Character
                    local HRP = Char:FindFirstChild("HumanoidRootPart")
                    local Tool = Char:FindFirstChildOfClass("Tool")
                    
                    -- Detecta hacha/motosierra equipada
                    if Tool and (string.find(Tool.Name:lower(), "axe") or string.find(Tool.Name:lower(), "chainsaw")) then
                        for _, tree in pairs(workspace:GetDescendants()) do
                            if tree.Name == "Tree" or tree:HasTag("Tree") or tree.Name:find("Log") then
                                local dist = (HRP.Position - (tree.PrimaryPart or tree).Position).Magnitude
                                if dist < 45 then
                                    firetouchinterest(HRP, tree.PrimaryPart or tree, 0)
                                    firetouchinterest(HRP, tree.PrimaryPart or tree, 1)
                                    -- Trae log a ti
                                    if tree.PrimaryPart then
                                        tree:PivotTo(HRP.CFrame * CFrame.new(0, 0, -5))
                                    end
                                end
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
        Desc = "Elimina sombras y oscuridad",
        Value = false,
        Callback = function(v)
            local Lighting = game:GetService("Lighting")
            if v then
                Lighting.Brightness = 3
                Lighting.Ambient = Color3.fromRGB(255, 255, 255)
                Lighting.FogEnd = 100000
                Lighting.GlobalShadows = false
            else
                Lighting.Brightness = 1
                Lighting.Ambient = Color3.fromRGB(0, 0, 0)
                Lighting.FogEnd = 100
                Lighting.GlobalShadows = true
            end
        end
    })

    -- Buffer para Delta
    for i = 1, 85 do local _ = "World_Buffer_" .. i end
end