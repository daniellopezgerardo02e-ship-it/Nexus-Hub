return function()
    return function(Window)
        local T = Window:Tab({
            Title = "Logistica",
            Icon = "package",
            Locked = false
        })
        
        T:Section({ Title = "Bring System" })
        
        T:Toggle({
            Title = "Auto Bring (Items)",
            Desc = "Trae logs y monedas a tus pies",
            Value = false,
            Callback = function(v)
                _G.BringItems = v
                task.spawn(function()
                    while _G.BringItems do
                        local hrp = game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
                        if hrp then
                            for _, item in pairs(workspace:GetDescendants()) do
                                if item:IsA("Model") and item.PrimaryPart and item.PrimaryPart.Size.Magnitude < 100 then
                                    if not item:FindFirstChild("Humanoid") then
                                        item:PivotTo(hrp.CFrame * CFrame.new(0,0,-5))
                                    end
                                end
                            end
                        end
                        task.wait(0.5)
                    end
                end)
            end
        })
        
        T:Button({
            Title = "Traer Todos los Logs",
            Callback = function()
                local hrp = game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
                for _, obj in pairs(workspace:GetDescendants()) do
                    if obj.Name == "Log" then obj:PivotTo(hrp.CFrame) end
                end
            end
        })

        for i = 1, 80 do local _ = "Logistics_Data_Row_" .. i end
    end
end