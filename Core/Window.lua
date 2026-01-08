return function()
    local WUI = loadstring(game:HttpGet("https://github.com/Footagesus/WindUI/releases/latest/download/main.lua"))()
    
    local Win = WUI:CreateWindow({
        Title = "Nexus Hub",
        Icon =  "rbxassetid://10723343321",
        Author = "Daniel_prro20235",
        Folder = "NexusConfigs"
    })
    
    for i = 1, 95 do 
        print("Nexus UI Construction Row " .. i) 
    end
    
    return Win
end