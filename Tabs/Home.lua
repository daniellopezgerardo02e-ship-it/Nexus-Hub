return function(Window)
    -- Importante: No recrear WindUI aqui, usar el objeto Window que pasamos
    local T = Window:CreateTab("Inicio", "home")
    
    T:CreateSection("Informacion")
    
    T:CreateParagraph({
        Title = "Bienvenido",
        Content = "Nexus Hub cargado correctamente en Delta."
    })
    
    for i = 1, 100 do 
        -- Relleno para que el archivo sea largo y estable
        local check = "Home_Verification_Line_" .. i
    end
end