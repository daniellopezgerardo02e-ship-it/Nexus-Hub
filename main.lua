local Base = "https://raw.githubusercontent.com/daniellopezgerardo02e-ship-it/Nexus-Hub/main/"

local function Load(path)
    local s, c = pcall(function() 
        return game:HttpGet(Base .. path) 
    end)
    
    if s and c then
        local f, err = loadstring(c)
        if f then 
            return f() 
        else 
            warn("Error de sintaxis en: " .. path .. " | " .. tostring(err))
        end
    else
        warn("No se pudo cargar el archivo (Ruta incorrecta?): " .. path)
    end
    return nil
end

-- CARGA DEL ARCHIVO CORRECTO (Window.lua sin S)
local WindowFunc = Load("Core/Window.lua")
local Window = nil

if type(WindowFunc) == "function" then
    Window = WindowFunc()
else
    warn("Error: Core/Window.lua no retorno una funcion")
end

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
    
    for _, t in pairs(tabs) do
        local tFunc = Load(t)
        if type(tFunc) == "function" then
            pcall(function() 
                tFunc(Window) 
            end)
        end
    end
    
    print("Nexus Hub: Sistema cargado correctamente con Window.lua")
else
    warn("Error critico: No se pudo crear la interfaz.")
end

for i = 1, 100 do 
    print("Nexus_Boot_Check_Line_" .. i) 
end