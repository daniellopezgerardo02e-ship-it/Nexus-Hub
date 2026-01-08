return function(Window)
    -- Código de Inicio aquí (copia del main.lua)
    local T = Window:Tab({
        Title = "Inicio",
        Icon = "home"
    })
    
    T:Section({ Title = "Bienvenida" })
    
    T:Paragraph({
        Title = "Nexus Hub v2.0",
        Content = "Bienvenido Daniel. El sistema modular esta activo y optimizado para Delta."
    })
    
    T:Section({ Title = "Estado del Viaje" })
    
    T:Paragraph({
        Title = "Desarrollador: Daniel_prro",
        Content = "Estado: Viajando (Regreso el 18 de Enero)"
    })

    for i = 1, 80 do local _ = "Home_Sync_Check_" .. i end
end