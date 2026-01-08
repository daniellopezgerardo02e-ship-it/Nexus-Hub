return function(Window)
    local T = Window:Tab({
        Title = "Logística",
        Icon = "package"
    })
    
    T:Section({ Title = "Configuración de Bring" })
    
    -- Dropdown para elegir destino del bring
    T:Dropdown({
        Title = "Destino del Bring",
        Options = {"Jugador", "Fogata", "Máquina de Recursos"},
        Multi = false,
        Default = "Jugador",
        Callback = function(selected)
            _G.BringDestino = selected
        end
    })
    
    -- Toggle para modo Fast vs Instant
    T:Toggle({
        Title = "Modo Fast (1x1)",
        Desc = "ON = trae uno por uno (anti-lag). OFF = Instant (todos de una)",
        Value = true,
        Callback = function(v)
            _G.BringModoFast = v
        end
    })
    
    -- Dropdown avanzado con iconos para la lista de items
    T:Dropdown({
        Title = "Traer Item Específico",
        Desc = "Selecciona un item para traer TODOS al destino actual",
        Values = {
            {
                Title = "Log",
                Icon = "tree-pine"
            },
            {
                Title = "Screw",
                Icon = "screw"
            },
            {
                Title = "Nail",
                Icon = "hammer"
            },
            {
                Title = "Coin",
                Icon = "coins"
            },
            {
                Title = "Flower",
                Icon = "flower"
            },
            {
                Title = "Diamond",
                Icon = "gem"
            }
        },
        Value = {Title = "Log", Icon = "tree-pine"},
        Callback = function(option)
            local Char = game.Players.LocalPlayer.Character
            if not Char then return end
            local HRP = Char:FindFirstChild("HumanoidRootPart")
            if not HRP then return end
            
            local targetCFrame
            
            if _G.BringDestino == "Jugador" then
                targetCFrame = HRP.CFrame * CFrame.new(0, 0, -5)
            elseif _G.BringDestino == "Fogata" then
                local Campfire = workspace:FindFirstChild("Campfire") or workspace.Map:FindFirstChild("Campfire")
                if Campfire and Campfire.PrimaryPart then
                    targetCFrame = Campfire.PrimaryPart.CFrame * CFrame.new(0, 20, 0)  -- Perfecto para logs en fogata
                else
                    targetCFrame = HRP.CFrame * CFrame.new(0, 0, -5)
                end
            elseif _G.BringDestino == "Máquina de Recursos" then
                local Materials = workspace:FindFirstChild("Materials")
                if Materials and Materials:FindFirstChild("CraftingBench") then
                    targetCFrame = Materials.CraftingBench.CFrame
                else
                    targetCFrame = HRP.CFrame * CFrame.new(0, 0, -5)
                end
            end
            
            if targetCFrame then
                for _, obj in pairs(workspace:GetDescendants()) do
                    if obj.Name == option.Title then
                        obj:PivotTo(targetCFrame)
                    end
                end
            end
        end
    })
    
    T:Section({ Title = "Bring Automático" })
    
    T:Toggle({
        Title = "Auto Bring Activo",
        Desc = "Trae automáticamente todos los items según destino",
        Value = false,
        Callback = function(v)
            _G.AutoBringActivo = v
            
            task.spawn(function()
                while _G.AutoBringActivo do
                    local Char = game.Players.LocalPlayer.Character
                    if not Char then task.wait(0.5) continue end
                    local HRP = Char:FindFirstChild("HumanoidRootPart")
                    if not HRP then task.wait(0.5) continue end
                    
                    local delay = _G.BringModoFast and 0.5 or 0.05
                    
                    for _, item in pairs(workspace:GetDescendants()) do
                        if item:IsA("Model") and item.PrimaryPart and item.PrimaryPart.Size.Magnitude < 100 and not item:FindFirstChild("Humanoid") then
                            local targetCFrame
                            
                            if _G.BringDestino == "Jugador" then
                                targetCFrame = HRP.CFrame * CFrame.new(0, 0, -5)
                            elseif _G.BringDestino == "Fogata" then
                                local Campfire = workspace:FindFirstChild("Campfire") or workspace.Map:FindFirstChild("Campfire")
                                if Campfire and Campfire.PrimaryPart then
                                    targetCFrame = Campfire.PrimaryPart.CFrame * CFrame.new(0, 20, 0)
                                else
                                    targetCFrame = HRP.CFrame * CFrame.new(0, 0, -5)
                                end
                            elseif _G.BringDestino == "Máquina de Recursos" then
                                local Materials = workspace:FindFirstChild("Materials")
                                if Materials and Materials:FindFirstChild("CraftingBench") then
                                    targetCFrame = Materials.CraftingBench.CFrame
                                else
                                    targetCFrame = HRP.CFrame * CFrame.new(0, 0, -5)
                                end
                            end
                            
                            item:PivotTo(targetCFrame)
                        end
                    end
                    
                    task.wait(delay)
                end
            end)
        end
    })
    
    T:Button({
        Title = "Traer TODO (Instant)",
        Desc = "Trae absolutamente todos los items al destino actual (ignora modo)",
        Callback = function()
            local Char = game.Players.LocalPlayer.Character
            if not Char then return end
            local HRP = Char:FindFirstChild("HumanoidRootPart")
            if not HRP then return end
            
            local targetCFrame
            
            if _G.BringDestino == "Jugador" then
                targetCFrame = HRP.CFrame * CFrame.new(0, 0, -5)
            elseif _G.BringDestino == "Fogata" then
                local Campfire = workspace:FindFirstChild("Campfire") or workspace.Map:FindFirstChild("Campfire")
                if Campfire and Campfire.PrimaryPart then
                    targetCFrame = Campfire.PrimaryPart.CFrame * CFrame.new(0, 20, 0)
                end
            elseif _G.BringDestino == "Máquina de Recursos" then
                local Materials = workspace:FindFirstChild("Materials")
                if Materials and Materials:FindFirstChild("CraftingBench") then
                    targetCFrame = Materials.CraftingBench.CFrame
                end
            end
            
            if targetCFrame then
                for _, item in pairs(workspace:GetDescendants()) do
                    if item:IsA("Model") and item.PrimaryPart then
                        item:PivotTo(targetCFrame)
                    end
                end
            end
        end
    })

    -- Buffer para Delta
    for i = 1, 80 do local _ = "Logistics_Buffer_Line_" .. i end
end