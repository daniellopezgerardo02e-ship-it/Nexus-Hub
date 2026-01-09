return function(Window)
    local T = Window:Tab({
        Title = "Logística",
        Icon = "package"
    })
    
    T:Section({ Title = "Configuración de Bring" })
    
    T:Dropdown({
        Title = "Destino del Bring",
        Desc = "Elige a dónde quieres que vayan los items",
        Values = {
            "Jugador",
            "Fogata",
            "Máquina de Recursos"
        },
        Value = "Jugador",
        Multi = false,
        Callback = function(selected)
            _G.BringDestino = selected
        end
    })
    
    T:Toggle({
        Title = "Modo Fast (1x1)",
        Desc = "ON = trae uno por uno (anti-lag). OFF = Instant (todos de una)",
        Value = true,
        Callback = function(v)
            _G.BringModoFast = v
        end
    })
    
    _G.SelectedBringItems = {}
    
    T:Dropdown({
        Title = "Seleccionar Items para Bring",
        Desc = "Marca los items que quieres traer. La selección se guarda.",
        Values = {
            {Title = "Log", Icon = "tree-pine"},
            {Title = "Screw", Icon = "screw"},
            {Title = "Nail", Icon = "hammer"},
            {Title = "Coin", Icon = "coins"},
            {Title = "Flower", Icon = "flower"},
            {Title = "Diamond", Icon = "gem"}
        },
        Value = {},
        Multi = true,
        Callback = function(selectedOptions)
            _G.SelectedBringItems = {}
            for _, option in pairs(selectedOptions) do
                table.insert(_G.SelectedBringItems, option.Title)
            end
            WindUI:Notify({Title = "Items Seleccionados", Content = #_G.SelectedBringItems .. " items listos", Duration = 2})
        end
    })
    
    T:Button({
        Title = "¡TRAER ITEMS SELECCIONADOS!",
        Desc = "Trae TODOS los items marcados al destino elegido",
        Color = Color3.fromHex("#00ff88"),
        Callback = function()
            if #_G.SelectedBringItems == 0 then
                WindUI:Notify({Title = "Error", Content = "No has seleccionado ningún item", Duration = 3})
                return
            end
            
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
                targetCFrame = CFrame.new(22.242820739746094, 26.810789108276367, -2.1091952323913574) * CFrame.new(0, -5, 0)  -- Offset abajo para que caigan
            end
            
            if not targetCFrame then return end
            
            local totalTraidos = 0
            
            for _, itemName in pairs(_G.SelectedBringItems) do
                for _, obj in pairs(workspace:GetDescendants()) do
                    if obj.Name == itemName then
                        if itemName == "Log" then
                            local mainPart = obj:FindFirstChild("Main")
                            if mainPart then mainPart:PivotTo(targetCFrame) end
                            local cylinder = obj:FindFirstChild("Meshes/log_Cylinder")
                            if cylinder then cylinder:PivotTo(targetCFrame) end
                        else
                            obj:PivotTo(targetCFrame)
                        end
                        totalTraidos = totalTraidos + 1
                    end
                end
            end
            
            WindUI:Notify({Title = "Bring Completado", Content = "Traídos " .. totalTraidos .. " items al destino: " .. _G.BringDestino, Duration = 4})
        end
    })
    
    T:Section({ Title = "Bring Automático" })
    
    T:Toggle({
        Title = "Auto Bring Activo",
        Desc = "Trae automáticamente todos los items pequeños al destino",
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
                        targetCFrame = CFrame.new(22.242820739746094, 26.810789108276367, -2.1091952323913574) * CFrame.new(0, -5, 0)
                    end
                    
                    for _, item in pairs(workspace:GetDescendants()) do
                        if item:IsA("Model") and item.PrimaryPart and item.PrimaryPart.Size.Magnitude < 100 and not item:FindFirstChild("Humanoid") then
                            if item.Name == "Log" then
                                local mainPart = item:FindFirstChild("Main")
                                if mainPart then mainPart:PivotTo(targetCFrame) end
                                local cylinder = item:FindFirstChild("Meshes/log_Cylinder")
                                if cylinder then cylinder:PivotTo(targetCFrame) end
                            else
                                item:PivotTo(targetCFrame)
                            end
                        end
                    end
                    
                    task.wait(delay)
                end
            end)
        end
    })
    
    T:Button({
        Title = "Traer TODO (Instant)",
        Desc = "Trae absolutamente todos los items al destino actual",
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
                targetCFrame = CFrame.new(22.242820739746094, 26.810789108276367, -2.1091952323913574) * CFrame.new(0, -5, 0)
            end
            
            if targetCFrame then
                local total = 0
                for _, item in pairs(workspace:GetDescendants()) do
                    if item:IsA("Model") and item.PrimaryPart then
                        if item.Name == "Log" then
                            local mainPart = item:FindFirstChild("Main")
                            if mainPart then mainPart:PivotTo(targetCFrame) end
                            local cylinder = item:FindFirstChild("Meshes/log_Cylinder")
                            if cylinder then cylinder:PivotTo(targetCFrame) end
                        else
                            item:PivotTo(targetCFrame)
                        end
                        total = total + 1
                    end
                end
                WindUI:Notify({Title = "Bring Total", Content = "Traídos " .. total .. " items", Duration = 4})
            end
        end
    })

    -- Buffer para Delta
    for i = 1, 80 do local _ = "Logistics_Buffer_Line_" .. i end
end