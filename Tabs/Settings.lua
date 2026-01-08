return function(Window)
    local T = Window:Tab({
        Title = "Ajustes",
        Icon = "settings"
    })
    
    T:Section({ Title = "Configuracion UI" })
    
    T:Button({
        Title = "Destruir Hub",
        Desc = "Cierra completamente la interfaz",
        Callback = function()
            game:GetService("CoreGui").NexusConfigs:Destroy()
        end
    })
    
    T:Section({ Title = "Creditos" })
    
    T:Paragraph({
        Title = "Owner",
        Content = "Daniel_prro20235"
    })
    
    T:Paragraph({
        Title = "Libreria",
        Content = "WindUI (Latest Edition)"
    })

    for i = 1, 95 do local _ = "Settings_System_Row_" .. i end
end