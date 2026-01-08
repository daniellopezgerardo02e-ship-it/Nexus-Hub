return function(Window)
    local T = Window:Tab({
        Title = "Logística",
        Icon = "package"
    })
    
    T:Section({ Title = "Configuración Bring" })
    
    -- Dropdown para destino
    T:Dropdown({
        Title = "Destino Bring",
        Values = {"Player", "Campfire", "Resource Machine"},
        Multi = false,
        Default = "Player",
        Callback = function(v)
            _G.BringDest = v
        end
    })
    
    -- Toggle para modo
    T:Toggle({
        Title = "Modo Fast (1x1)",
        Desc = "Trae uno por uno (lento, anti-lag). OFF = Instant (todos)",
        Value = true,
        Callback = function(v)
            _G.BringFast = v
        end
    })
    
    T:Section({ Title = "Auto Bring" })
    
    T:Toggle({
        Title = "Auto Bring Items",
        Desc = "Trae items auto según config",
        Value = false,
        Callback = function(v)
            _G.BringAuto = v
            task.spawn(function()
                while _G.BringAuto do
                    local Char = game.Players.LocalPlayer.Character
                    local HRP = Char:FindFirstChild("HumanoidRootPart")
                    if HRP then
                        local delay = _G.BringFast and 0.5 or 0.05  -- Fast: lento, Instant: rápido
                        for _, item in pairs(workspace:GetDescendants()) do
                            if item:IsA("Model") and item.PrimaryPart and item.Size.Magnitude < 100 and not item:FindFirstChild("Humanoid") then
                                local destPos
                                if _G.BringDest == "Player" then
                                    destPos = HRP.CFrame * CFrame.new(0, 0, -5)
                                elseif _G.BringDest == "Campfire" then
                                    local Campfire = workspace:FindFirstChild("Campfire")
                                    destPos = Campfire.PrimaryPart.CFrame if Campfire else HRP.CFrame
                                elseif _G.BringDest == "Resource Machine" then
                                    local Materials = workspace:FindFirstChild("Materials")
                                    destPos = Materials.CraftingBench.CFrame if Materials and Materials:FindFirstChild("CraftingBench") else HRP.CFrame
                                end
                                item:PivotTo(destPos)
                            end
                        end
                        task.wait(delay)
                    end
                end
            end)
        end
    })
    
    T:Section({ Title = "Bring Específico (Lista)" })
    
    T:Button({
        Title = "Log",
        Callback = function()
            local HRP = game.Players.LocalPlayer.Character.HumanoidRootPart
            for _, obj in pairs(workspace:GetDescendants()) do
                if obj.Name == "Log" then
                    local destPos = getDestPos(HRP)  -- Función helper abajo
                    obj:PivotTo(destPos)
                end
            end
        end
    })
    
    T:Button({
        Title = "Screw",
        Callback = function()
            local HRP = game.Players.LocalPlayer.Character.HumanoidRootPart
            for _, obj in pairs(workspace:GetDescendants()) do
                if obj.Name == "Screw" then
                    local destPos = getDestPos(HRP)
                    obj:PivotTo(destPos)
                end
            end
        end
    })
    
    T:Button({
        Title = "Nail",
        Callback = function()
            local HRP = game.Players.LocalPlayer.Character.HumanoidRootPart
            for _, obj in pairs(workspace:GetDescendants()) do
                if obj.Name == "Nail" then
                    local destPos = getDestPos(HRP)
                    obj:PivotTo(destPos)
                end
            end
        end
    })
    
    T:Button({
        Title = "Coin",
        Callback = function()
            local HRP = game.Players.LocalPlayer.Character.HumanoidRootPart
            for _, obj in pairs(workspace:GetDescendants()) do
                if obj.Name == "Coin" then
                    local destPos = getDestPos(HRP)
                    obj:PivotTo(destPos)
                end
            end
        end
    })
    
    T:Button({
        Title = "Flower",
        Callback = function()
            local HRP = game.Players.LocalPlayer.Character.HumanoidRootPart
            for _, obj in pairs(workspace:GetDescendants()) do
                if obj.Name == "Flower" then
                    local destPos = getDestPos(HRP)
                    obj:PivotTo(destPos)
                end
            end
        end
    })
    
    T:Button({
        Title = "Diamond",
        Callback = function()
            local HRP = game.Players.LocalPlayer.Character.HumanoidRootPart
            for _, obj in pairs(workspace:GetDescendants()) do
                if obj.Name == "Diamond" then
                    local destPos = getDestPos(HRP)
                    obj:PivotTo(destPos)
                end
            end
        end
    })

    -- Helper función para destino (local en tab)
    local function getDestPos(HRP)
        if _G.BringDest == "Player" then
            return HRP.CFrame * CFrame.new(0, 0, -5)
        elseif _G.BringDest == "Campfire" then
            local Campfire = workspace:FindFirstChild("Campfire")
            return Campfire.PrimaryPart.CFrame if Campfire and Campfire.PrimaryPart else HRP.CFrame
        elseif _G.BringDest == "Resource Machine" then
            local Materials = workspace:FindFirstChild("Materials")
            if Materials and Materials:FindFirstChild("CraftingBench") then
                return Materials.CraftingBench.CFrame
            end
            return HRP.CFrame
        end
        return HRP.CFrame
    end

    -- Buffer
    for i = 1, 80 do local _ = "Logistics_Buffer_" .. i end
end