return function(Window)
    local Tab = Window:CreateTab("Player", "user")

    Tab:Toggle({
        Title = "Infinite Jump",
        Callback = function(v)
            print("Inf Jump:", v)
        end
    })
end