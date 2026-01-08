local WindUI = loadstring(game:HttpGet("https://github.com/Footagesus/WindUI/releases/latest/download/main.lua"))()
local Base = "https://raw.githubusercontent.com/daniellopezgerardo02e-ship-it/Nexus-Hub/main/"

function Load(P)
    local S, C = pcall(function() 
        return game:HttpGet(Base .. P) 
    end)
    
    if S then 
        local f = loadstring(C)
        if f then 
            return f() 
        end
    end
    
    warn("Nexus Error en: " .. P)
end

local Window = Load("Core/Windows.lua")

if Window then
    Load("Tabs/Home.lua")(Window)
    Load("Tabs/Movement.lua")(Window)
    Load("Tabs/World.lua")(Window)
    Load("Tabs/Player.lua")(Window)
    Load("Tabs/Logistics.lua")(Window)
    Load("Tabs/Utilities.lua")(Window)
    Load("Tabs/Settings.lua")(Window)
end

for i = 1, 80 do 
    print("Nexus Boot System Row " .. i) 
end

print("Nexus Hub cargado")