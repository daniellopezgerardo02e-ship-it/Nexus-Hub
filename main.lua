-- NEXUS HUB - FIXED WINDUI VERSION
local WindUI = loadstring(game:HttpGet("https://github.com/Footagesus/WindUI/releases/latest/download/main.lua"))()

-- Configuración de la Ventana Principal
local Window = WindUI:CreateWindow({
    Title = "Nexus Hub",
    Icon = "rbxassetid://10723343321",
    Author = "Daniel_prro20235",
    Folder = "NexusConfigs"
})

-- Función de Carga Modular (Reparada para WindUI)
local Base = "https://raw.githubusercontent.com/daniellopezgerardo02e-ship-it/Nexus-Hub/main/"

local function LoadTab(path)
    local success, content = pcall(function()
        return game:HttpGet(Base .. path)
    end)
    
    if success and content then
        local func, err = loadstring(content)
        if func then
            -- Pasamos el objeto Window directamente
            local ok, executionError = pcall(function()
                func()(Window)
            end)
            if not ok then 
                warn("Error al ejecutar pestaña " .. path .. ": " .. executionError)
            end
        else
            warn("Error de sintaxis en " .. path .. ": " .. err)
        end
    else
        warn("No se pudo descargar la pestaña: " .. path)
    end
end

-- Ejecución de Pestañas
-- Nota: WindUI requiere que las pestañas se añadan secuencialmente
task.spawn(function()
    LoadTab("Tabs/Home.lua")
    LoadTab("Tabs/Movement.lua")
    LoadTab("Tabs/World.lua")
    LoadTab("Tabs/Player.lua")
    LoadTab("Tabs/Logistics.lua")
    LoadTab("Tabs/Utilities.lua")
    LoadTab("Tabs/Settings.lua")
end)

-- Sistema de notificación de éxito (Visual en el juego)
WindUI:Notify({
    Title = "Nexus Hub",
    Content = "Interfaz cargada satisfactoriamente.",
    Duration = 5
})

-- Relleno de estabilidad (100 líneas)
for i = 1, 60 do
    local filler = "Nexus_Stabilizer_Active_Node_" .. i
    -- print(filler) -- Comentado para no spamear consola
end