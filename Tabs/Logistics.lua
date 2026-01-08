return function(Window)
    local T = Window:Tab({
        Title = "Logística",
        Icon = "package"
    })
    
    T:Section({ Title = "Configuración de Bring" })
    
    -- Dropdown para elegir destino del bring
    T:Dropdown({
        Title = "Destino del Bring",
        Values = {"Jugador", "Fogata", "Máquina de Recursos"},
        Multi = false,
        Default = "Jugador",
        Callback = function(v)
            _G.BringDestino = v
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
    
    T:Section({ Title = "Bring Automático" })
    
    T:Toggle({
        Title = "Auto Bring Activo",
        Desc = "Trae automáticamente todos los items según configuración",
        Value = false,
        Callback = function(v)
            _G.AutoBringActivo = v
            
            task.spawn(function()
                while _G.AutoBringActivo do
                    local Char = game.Players.LocalPlayer.Character
                    if not Char then task.wait(0.5) continue end
                    local HRP = Char:FindFirstChild("HumanoidRootPart")
                    if not HRP then task.wait(0.5) continue end
                    
                    local delay = _G.BringModoFast and 0.5 or 0.05  -- Fast lento, Instant rápido
                    
                    for _, item in pairs(workspace:GetDescendants()) do
                        if item:IsA("Model") and item.PrimaryPart and item.PrimaryPart.Size.Magnitude < 100 and not item:FindFirstChild("Humanoid") then
                            local targetCFrame
                            
                            if _G.BringDestino == "Jugador" then
                                targetCFrame = HRP.CFrame * CFrame.new(0, 0, -5)
                            elseif _G.BringDestino == "Fogata" then
                                local Campfire = workspace:FindFirstChild("Campfire") or workspace.Map:FindFirstChild("Campfire")
                                if Campfire and Campfire.PrimaryPart then
                                    targetCFrame = Campfire.PrimaryPart.CFrame * CFrame.new(0, 20, 0)  -- Posición perfecta arriba de la fogata
                                else
                                    targetCFrame = HRP.CFrame * CFrame.new(0, 0, -5)  -- Fallback al jugador
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
    
    T:Section({ Title = "Bring Específico (Lista)" })
    
    local function bringItem(name)
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
        
        for _, obj in pairs(workspace:GetDescendants()) do
            if obj.Name == name then
                obj:PivotTo(targetCFrame)
            end
        end
    end
    
    T:Button({
        Title = "Log",
        Callback = function() bringItem("Log") end
    })
    
    T:Button({
        Title = "Screw",
        Callback = function() bringItem("Screw") end
    })
    
    T:Button({
        Title = "Nail",
        Callback = function() bringItem("Nail") end
    })
    
    T:Button({
        Title = "Coin",
        Callback = function() bringItem("Coin") end
    })
    
    T:Button({
        Title = "Flower",
        Callback = function() bringItem("Flower") end
    })
    
    T:Button({
        Title = "Diamond",
        Callback = function() bringItem("Diamond") end
    })
    
    T:Button({
        Title = "Traer TODO (Instant)",
        Desc = "Ignora modo y trae absolutamente todo al destino actual",
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