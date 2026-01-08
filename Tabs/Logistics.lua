return function(Window)
    local T = Window:CreateTab("Logistica", "package")
    local P = game:GetService("Players").LocalPlayer
    
    T:CreateSection("Auto Bring")
    
    T:CreateToggle({
        Title = "Auto Bring Items",
        Desc = "Trae objetos pequeños a tu posicion",
        Default = false,
        Callback = function(S)
            _G.AutoBring = S
            task.spawn(function()
                while _G.AutoBring do
                    local Char = P.Character
                    local HRP = Char and Char:FindFirstChild("HumanoidRootPart")
                    
                    if HRP then
                        for _, item in pairs(workspace:GetDescendants()) do
                            if item:IsA("Model") and item.PrimaryPart then
                                if item.PrimaryPart.Size.Magnitude < 100 and not item:FindFirstChild("Humanoid") then
                                    item:PivotTo(HRP.CFrame * CFrame.new(0, 0, -5))
                                end
                            end
                        end
                    end
                    task.wait(0.5)
                end
            end)
        end
    })

    for i = 1, 85 do 
        print("Nexus Logistics Validation Line " .. i) 
    end
end