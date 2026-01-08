return function(Window)
    local Tab = Window:CreateTab("Utilities", "box")

    Tab:Dropdown({
        Title = "Select Resource",
        Values = {
            "Tree",
            "Food",
            "Scrap",
            "Chest"
        },
        Callback = function(v)
            print("Selected:", v)
        end
    })

    Tab:Button({
        Title = "Bring Selected",
        Callback = function()
            print("Bring executed")
        end
    })
end