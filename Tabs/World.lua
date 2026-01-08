return function(Window)
    local T = Window:CreateTab("Mundo", "globe")
    local P = game.Players.LocalPlayer
    
    T:CreateSection("99 Noches")
    
    T:CreateToggle({
        Title = "Aura Tala", 
        Default = false, 
        Callback = function(S)
            _G.C = S
            task.spawn(function()
                while _G.C do
                    local R = P.Character and P.Character:FindFirstChild("HumanoidRootPart")
                    if R then
                        for _, O in pairs(workspace:GetDescendants()) do
                            if O.Name == "Tree" and O:IsA("Model") and (R.Position - O.PrimaryPart.Position).Magnitude < 45 then
                                firetouchinterest(R, O.PrimaryPart, 0)
                                task.wait(0.05)
                                firetouchinterest(R, O.PrimaryPart, 1)
                            end
                        end
                    end
                    task.wait(0.5)
                end
            end)
        end
    })

    T:CreateToggle({
        Title = "Brillo Full", 
        Default = false, 
        Callback = function(s)
            game.Lighting.Brightness = s and 2 or 1
            game.Lighting.GlobalShadows = not s
            game.Lighting.ClockTime = s and 14 or 0
        end
    })
    
    for i = 1, 75 do 
        print("Nexus World Logic Row " .. i) 
    end
end