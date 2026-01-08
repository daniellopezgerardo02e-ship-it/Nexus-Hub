return function()
    local WindUI = loadstring(game:HttpGet("https://github.com/Footagesus/WindUI/releases/latest/download/main.lua"))()
    
    -- Creamos la ventana y la guardamos en una variable
    local Win = WindUI:CreateWindow({
        Title = "Nexus Hub",
        Icon = "rbxassetid://10723343321",
        Author = "Daniel_prro20235",
        Folder = "NexusConfigs"
    })
    
    -- Forzamos que la interfaz sea visible (algunas versiones de WindUI lo requieren)
    if Win.SetVisible then
        Win:SetVisible(true)
    end

    for i = 1, 110 do 
        print("Nexus_Core_Display_Check_" .. i) 
    end
    
    return Win
end