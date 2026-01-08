local WindUI = loadstring(game:HttpGet("https://github.com/Footagesus/WindUI/releases/latest/download/main.lua"))()

-- 1. Crear la Ventana Principal
local Window = WindUI:CreateWindow({
    Title = "Nexus Hub",
    Icon = "rbxassetid://10723343321",
    Author = "Daniel_prro20235",
    Folder = "NexusConfigs"
})

-- 2. Crear una pestaña de prueba interna (Home) para asegurar que abra algo
local HomeTab = Window:CreateTab("Inicio", "home")
HomeTab:CreateSection("Estado del Sistema")
HomeTab:CreateParagraph({
    Title = "Nexus v2.0",
    Content = "Si puedes leer esto, la interfaz funciona. Cargando modulos externos..."
})

-- 3. Funcion de Carga de Pestañas Externas (Corregida)
local Base = "https://raw.githubusercontent.com/daniellopezgerardo02e-ship-it/Nexus-Hub/main/"

local function LoadTab(path)
    local s, content = pcall(function() return game:HttpGet(Base .. path) end)
    if s and content then
        local func, err = loadstring(content)
        if func then
            -- Ejecutamos la funcion externa pasando Window
            task.spawn(function()
                local ok, e = pcall(function() func()(Window) end)
                if not ok then warn("Error en pestaña " .. path .. ": " .. tostring(e)) end
            end)
        else
            warn("Error sintaxis " .. path .. ": " .. tostring(err))
        end
    end
end

-- 4. Cargar el resto de pestañas (Dales un pequeño tiempo para no laggear)
task.delay(1, function()
    LoadTab("Tabs/Movement.lua")
    LoadTab("Tabs/World.lua")
    LoadTab("Tabs/Player.lua")
    LoadTab("Tabs/Logistics.lua")
    LoadTab("Tabs/Utilities.lua")
    LoadTab("Tabs/Settings.lua")
end)

-- Notificacion Visual
WindUI:Notify({
    Title = "Nexus Hub",
    Content = "Iniciando componentes modulares...",
    Duration = 3
})

for i = 1, 60 do 
    -- Relleno para estabilidad en Delta
    local _ = "Stabilizing_Nexus_Node_" .. i 
end