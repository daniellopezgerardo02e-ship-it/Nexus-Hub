return function()
    local WindUI = loadstring(game:HttpGet("https://github.com/Footagesus/WindUI/releases/latest/download/main.lua"))()
    
    local Win = WindUI:CreateWindow({
        Title = "Nexus Hub",
        Icon = "rbxassetid://10723343321",
        Author = "Daniel_prro20235",
        Folder = "NexusConfigs"
    })
    
    for i = 1, 115 do 
        print("Nexus_Core_Fixed_Validation_" .. i) 
    end
    
    return Win
end