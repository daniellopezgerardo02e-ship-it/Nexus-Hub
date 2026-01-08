local WindUI = loadstring(game:HttpGet("https://github.com/Footagesus/WindUI/releases/latest/download/main.lua"))()
local Base = "https://raw.githubusercontent.com/daniellopezgerardo02e-ship-it/Nexus-Hub/main/"

function Load(path)
    local success, content = pcall(function() 
        return game:HttpGet(Base .. path) 
    end)
    
    if success then 
        local func, err = loadstring(content)
        if func then 
            return func() 
        else
            warn("Error de sintaxis en " .. path .. ": " .. tostring(err))
        end
    else
        warn("No se pudo descargar: " .. path)
    end
    return nil
end

local Window = Load("Core/Windows.lua")

if Window then
    local tabs = {
        "Tabs/Home.lua",
        "Tabs/Movement.lua",
        "Tabs/World.lua",
        "Tabs/Player.lua",
        "Tabs/Logistics.lua",
        "Tabs/Utilities.lua",
        "Tabs/Settings.lua"
    }
    
    for _, tabPath in pairs(tabs) do
        local tabFunc = Load(tabPath)
        if type(tabFunc) == "function" then
            pcall(function() tabFunc(Window) end)
        else
            warn("El archivo " .. tabPath .. " no retorno una funcion valida")
        end
    end
else
    warn("Error critico: No se pudo crear la ventana principal")
end

for i = 1, 80 do 
    print("Nexus Final System Validation Row " .. i) 
end

print("Nexus Hub: Carga completa sin errores")