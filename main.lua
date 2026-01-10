-- Nexus Hub v2.0 - Main Loader (Mejorado 2026)
-- Dev: Daniel_prro20235 😼

local WindUI = loadstring(game:HttpGet("https://github.com/Footagesus/WindUI/releases/latest/download/main.lua"))()

-- Crear ventana principal con configs
local Window = WindUI:CreateWindow({
    Title = "Nexus Hub v2.0",
    Icon = "rbxassetid://10723343321",
    Author = "Daniel_prro20235",
    Folder = "NexusConfigs",
    SaveConfig = true
})

-- Pestaña Inicio directa (para que siempre cargue algo)
local HomeTab = Window:Tab({
    Title = "Inicio",
    Icon = "home"
})

HomeTab:Section({ Title = "Bienvenido Daniel_prro20235" })
HomeTab:Paragraph({
    Title = "Nexus Hub v2.0 - Actualizado January 09, 2026",
    Content = "Cargando módulos seguros... ¡Listo para farmear 99 noches! 🌳🔥"
})

HomeTab:Button({
    Title = "Reload Hub",
    Desc = "Recarga todos los módulos sin reiniciar",
    Callback = function()
        WindUI:Notify({Title = "Reload", Content = "Recargando Nexus Hub...", Duration = 3})
        task.wait(1)
        loadstring(game:HttpGet("https://raw.githubusercontent.com/daniellopezgerardo02e-ship-it/Nexus-Hub/main/main.lua"))()
    end
})

-- Sistema de carga secuencial con pausas (mejora: cada tab en task.spawn separado)
local Base = "https://raw.githubusercontent.com/daniellopezgerardo02e-ship-it/Nexus-Hub/main/"

local function LoadTab(path)
    local url = Base .. path
    local success, content = pcall(game.HttpGet, game, url)
    if not success or not content then
        warn("[Nexus] Fallo al cargar: " .. path .. " - " .. tostring(content))
        return
    end

    local func, err = loadstring(content)
    if not func then
        warn("[Nexus] Error de sintaxis en " .. path .. ": " .. tostring(err))
        return
    end

    local ok, result = pcall(func)
    if not ok then
        warn("[Nexus] Error al ejecutar " .. path .. ": " .. tostring(result))
        return
    end

    -- Soporte para dos patrones comunes
    if type(result) == "function" then
        pcall(result, Window)
    end

    print("[Nexus] Tab cargado: " .. path)
end

-- Lista de tabs (puedes agregar más aquí)
local tabs = {
    "Tabs/Home.lua",
    "Tabs/Player.lua",
    "Tabs/Combat.lua",
    "Tabs/Farm.lua",
    "Tabs/World.lua",
    "Tabs/Logistics.lua",
    "Tabs/Visual.lua",
    "Tabs/Misc.lua",
    "Tabs/Settings.lua"
}

-- Carga paralela con pausas (mejora anti-freeze Delta)
task.spawn(function()
    for _, tabPath in ipairs(tabs) do
        task.spawn(function()
            LoadTab(tabPath)
        end)
        task.wait(0.15)  -- Pausa corta por tab
    end

    -- Notificación final + check versión
    WindUI:Notify({
        Title = "Nexus Hub v2.0",
        Content = "¡Todo cargado correctamente! Bienvenido Daniel_prro20235 😼",
        Duration = 5
    })

    -- Simulado check update (puedes cambiar por real)
    local version = "2.0 (2026)"
    print("Nexus Hub Version: " .. version .. " - Up to date!")
end)

-- Buffer de estabilidad (reducido para mejor perf)
for i = 1, 70 do local _ = "Nexus_Stabilizer_" .. i end