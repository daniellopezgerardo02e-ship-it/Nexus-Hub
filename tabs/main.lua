return function(Window)
    local Tab = Window:Tab({
        Title = "Main",
        Icon  = "home",
    })

    Tab:Button({
        Title = "Welcome",
        Callback = function()
            print("Foxname Hub cargado")
        end
    })

    Tab:Button({
        Title = "Info",
        Callback = function()
            print("UI Template Only")
        end
    })
end