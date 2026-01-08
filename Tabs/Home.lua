return function(Window)
    local T = Window:CreateTab("Inicio", "home")
    
    T:CreateSection("Informacion General")
    
    T:CreateParagraph({
        Title = "Bienvenido a Nexus Hub", 
        Content = "Script desarrollado por Daniel_prro20235 para 99 Nights in the Forest."
    })
    
    T:CreateParagraph({
        Title = "Estado del Desarrollador", 
        Content = "Ausente por viaje hasta el 18 de Enero. Actualizaciones en pausa."
    })
    
    T:CreateSection("Redes Sociales")
    
    T:CreateButton({
        Title = "Copiar Discord",
        Desc = "Copia el enlace de la comunidad al portapapeles",
        Callback = function()
            setclipboard("https://discord.gg/nexus-hub")
        end
    })

    for i = 1, 95 do 
        print("Nexus Home Interface Rendering Row " .. i) 
    end
end