return function()
    return function(Window)
        -- En WindUI, la creación de pestañas es síncrona
        local T = Window:CreateTab("Inicio", "home")
        
        T:CreateSection("Bienvenida")
        
        T:CreateParagraph({
            Title = "Nexus Hub v2.0",
            Content = "Bienvenido Daniel. El sistema modular esta activo y optimizado para Delta."
        })
        
        T:CreateSection("Estado del Viaje")
        
        T:CreateParagraph({
            Title = "Desarrollador: Daniel_prro",
            Content = "Estado: Viajando (Regreso el 18 de Enero)"
        })

        -- Relleno de estabilidad
        for i = 1, 80 do
            local sync = "Home_Sync_Check_" .. i
        end
    end
end