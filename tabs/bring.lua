return function(Window, Bring)
    local Tab = Window:Tab({
        Title = "Bring",
        Icon  = "box",
    })

    Tab:Dropdown({
        Title = "Bring Items",
        Values = {
            "Wood",
            "Stone",
            "Food",
            "Tools"
        },
        Callback = function(item)
            Bring:Item(item)
        end
    })
end