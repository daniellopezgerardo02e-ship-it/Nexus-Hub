return function(Window)
    local Tab = Window:Tab({
        Title = "Settings",
        Icon  = "settings",
    })

    Tab:Toggle({
        Title = "UI Visible",
        Default = true,
        Callback = function(state)
            print("UI Visible:", state)
        end
    })
end