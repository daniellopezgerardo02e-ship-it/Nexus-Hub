return function(Window)
    local Tab = Window:CreateTab("Movement", "run")

    Tab:Slider({
        Title = "WalkSpeed",
        Min = 16,
        Max = 120,
        Default = 16,
        Callback = function(v)
            local hum = game.Players.LocalPlayer.Character
            and game.Players.LocalPlayer.Character:FindFirstChild("Humanoid")
            if hum then hum.WalkSpeed = v end
        end
    })
end