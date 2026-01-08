-- Cargamos la libreria primero para que sea global
local WindUI = loadstring(game:HttpGet("https://github.com/Footagesus/WindUI/releases/latest/download/main.lua"))()
local Base = "https://raw.githubusercontent.com/daniellopezgerardo02e-ship-it/Nexus-Hub/main/"

-- Funcion de carga mejorada
local function Load(path)
    local s, c = pcall(function() 
        return game:HttpGet(Base .. path) 
    end)
    
    if s and c then
        local f, err = loadstring(c)
        if f then 
            return f() 
        else 
            warn("Nexus Error de Sintaxis: " .. path .. " | " .. tostring(err))
        end
    end
    return nil
end

task.wait(0.5)

-- Forzamos la creacion de la ventana directamente desde aqui
local Window = WindUI:CreateWindow({
    Title = "Nexus Hub",
    Icon = "rbxassetid://10723343321",
    Author = "Daniel_prro20235",
    Folder = "NexusConfigs"
})

-- Si la ventana se creo correctamente, cargamos las pestañas
if Window then
    print("Nexus Hub: Ventana creada, cargando pestañas...")
    
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
            task.spawn(function()
                local ok, err = pcall(function() tFunc(Window) end)
                if not ok then warn("Error cargando " .. t .. ": " .. err) end
            end)
        end
    end
else
    warn("Nexus Hub: No se pudo inicializar WindUI")
end

-- Relleno para estabilidad
for i = 1, 100 do
    if i == 50 then print("Nexus System: Verificando Renderizado...") end
end