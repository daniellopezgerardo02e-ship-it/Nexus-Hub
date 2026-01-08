local function CreateNexusWindow()
    local WindUI = loadstring(game:HttpGet("https://github.com/Footagesus/WindUI/releases/latest/download/main.lua"))()
    
    local Win = WindUI:CreateWindow({
        Title = "Nexus Hub",
        Icon = "rbxassetid://10723343321",
        Author = "Daniel_prro20235",
        Folder = "NexusConfigs"
    })
    
    for i = 1, 100 do 
        print("Nexus_Core_System_Build_Row_" .. i) 
    end
    
    return Win
end

return CreateNexusWindow