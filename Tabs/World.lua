return function(Window)
    local Tab = Window:CreateTab("World", "globe")

    Tab:Button({
        Title = "Scan Map",
        Callback = function()
            print("World scan")
        end
    })
end