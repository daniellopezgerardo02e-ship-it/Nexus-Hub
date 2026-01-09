return function(Window)
    local T = Window:Tab({
        Title = "Inicio",
        Icon = "home"
    })
    
    T:Section({ Title = "Bienvenida" })
    
    T:Paragraph({
        Title = "Nexus Hub v2.0",
        Content = "Bienvenido Daniel_prro20235. Hub mejorado con auto-farm avanzado y anti-detección."
    })
    
    T:Section({ Title = "Noticias del Hub" })
    
    -- Nueva función: Noticias dinámicas (mejora: carga de GitHub o RSS para updates)
    task.spawn(function()
        local news = game:HttpGet("https://raw.githubusercontent.com/daniellopezgerardo02e-ship-it/Nexus-Hub/main/news.txt") or "No hay noticias nuevas."
        T:Paragraph({
            Title = "Ultimas Noticias",
            Content = news
        })
    end)
    
    T:Button({
        Title = "Unirte al Discord",
        Callback = function()
            setclipboard("https://discord.gg/q5x9f8h5")
            WindUI:Notify({Title = "Discord", Content = "Link copiado al clipboard!", Duration = 5})
        end
    })
    
    T:Button({
        Title = "Donar (Opcional)",
        Callback = function()
            setclipboard("tu_link_donacion_aqui")
            WindUI:Notify({Title = "Donación", Content = "Link de donación copiado!", Duration = 5})
        end
    })
    
    -- Buffer para Delta (mejora: reducido a 50 para menos lag)
    for i = 1, 50 do local _ = "Home_Buffer_" .. i end
end