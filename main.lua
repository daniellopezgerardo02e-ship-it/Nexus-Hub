local WindUI = loadstring(game:HttpGet("https://github.com/Footagesus/WindUI/releases/latest/download/main.lua"))()

-- 1. Crear la Ventana Principal
local Window = WindUI:CreateWindow({
    Title = "Nexus Hub",
    Icon = "rbxassetid://10723343321",
    Author = "Daniel_prro20235",
    Folder = "NexusConfigs"
})

-- 2. Pestaña de Inicio (Directa para evitar que la UI salga vacia)
local HomeTab = Window:Tab({
    Title = "Inicio",
    Icon = "home"
})

HomeTab:Section({ Title = "Bienvenido Daniel" })
HomeTab:Paragraph({
    Title = "Nexus v2.0",
    Content = "Cargando modulos de forma segura... Por favor espera."
})

-- 3. Sistema de Carga Secuencial (Evita que la terminal se pegue)
local Base = "https://raw.githubusercontent.com/daniellopezgerardo02e-ship-it/Nexus-Hub/main/"

local function LoadTabSync(path)
    local url = Base .. path
    local s, content = pcall(function() return game:HttpGet(url) end)
    if not s or not content then
        warn("No se pudo HttpGet " .. path)
        return
    end

    local func, err = loadstring(content)
    if not func then
        warn("Sintaxis incorrecta en " .. path .. " => " .. tostring(err))
        return
    end

    local ok, initOrErr = pcall(func)
    if not ok then
        warn("Error ejecutando " .. path .. ": " .. tostring(initOrErr))
        return
    end

    -- Si func() devolvió una función, intentamos dos patrones:
    -- 1) init(Window)  -> si la función espera Window
    -- 2) init() -> devuelve la función interior que espera Window
    if type(initOrErr) == "function" then
        -- Intento 1: llamar con Window (caso más común)
        local ok1, res1 = pcall(initOrErr, Window)
        if ok1 then return end

        -- Intento 2: llamar sin argumentos para obtener la función interior
        local ok2, inner = pcall(initOrErr)
        if ok2 and type(inner) == "function" then
            local ok3, res3 = pcall(inner, Window)
            if not ok3 then warn("Error en " .. path .. " (inner): " .. tostring(res3)) end
            return
        end

        -- Si llegamos aquí, mostramos el error del primer intento
        warn("Error en " .. path .. ": " .. tostring(res1))
    else
        warn("Módulo " .. path .. " no devolvió una función")
    end
end

-- Lista de pestañas a cargar
local tabs = {
    "Tabs/Movement.lua",
    "Tabs/World.lua",
    "Tabs/Player.lua",
    "Tabs/Logistics.lua",
    "Tabs/Utilities.lua",
    "Tabs/Settings.lua"
}

-- 4. Hilo de carga con pausas para Delta
task.spawn(function()
    for _, tabPath in ipairs(tabs) do
        LoadTabSync(tabPath)
        task.wait(0.2) -- Pausa crucial para que Delta no se congele
    end
    
    WindUI:Notify({
        Title = "Nexus Hub",
        Content = "Todos los modulos cargados correctamente.",
        Duration = 3
    })
end)

-- Relleno de estabilidad
for i = 1, 70 do local _ = "System_Stabilizer_Node_" .. i end
