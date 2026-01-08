return function(Window)
    local Tab = Window:CreateTab("Home", "info")

    Tab:Paragraph({
        Title = "Welcome",
        Content = "Nexus Hub loaded\nUI Template Only"
    })
end