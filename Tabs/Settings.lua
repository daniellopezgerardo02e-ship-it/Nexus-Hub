return function(Window)
    local Tab = Window:CreateTab("Settings", "settings")

    Tab:Button({
        Title = "Rejoin",
        Callback = function()
            game:GetService("TeleportService"):Teleport(game.PlaceId)
        end
    })
end