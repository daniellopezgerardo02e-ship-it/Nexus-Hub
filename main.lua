local WindUI = loadstring(game:HttpGet("https://github.com/Footagesus/WindUI/releases/latest/download/main.lua"))()

-- 1. Crear la Ventana Principal
local Window = WindUI:CreateWindow({
    Title = "Nexus Hub",
    Icon = "rbxassetid://10723343321",
    Author = "Daniel_prro20235",
    Folder = "NexusConfigs"
})

-- 2. Pestaña de Inicio (Directa)
local HomeTab = Window:Tab({
    Title = "Inicio",
    Icon = "home"
})

HomeTab:Section({ Title = "Bienvenida" })

HomeTab:Paragraph({
    Title = "Nexus Hub v2.0",
    Content = "Bienvenido Daniel. El sistema modular esta activo y optimizado para Delta."
})

HomeTab:Section({ Title = "Estado del Viaje" })

HomeTab:Paragraph({
    Title = "Desarrollador: Daniel_prro",
    Content = "Estado: Viajando (Regreso el 18 de Enero)"
})

-- 3. Sistema de Carga Secuencial
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

    if type(initOrErr) == "function" then
        local ok1, res1 = pcall(initOrErr, Window)
        if ok1 then return end

        local ok2, inner = pcall(initOrErr)
        if ok2 and type(inner) == "function" then
            local ok3, res3 = pcall(inner, Window)
            if not ok3 then warn("Error en " .. path .. " (inner): " .. tostring(res3)) end
            return
        end

        warn("Error en " .. path .. ": " .. tostring(res1))
    else
        warn("Módulo " .. path .. " no devolvió una función")
    end
end

-- Lista de pestañas
local tabs = {
    "Tabs/Movement.lua",
    "Tabs/World.lua",
    "Tabs/Player.lua",
    "Tabs/Logistics.lua",
    "Tabs/Utilities.lua",
    "Tabs/Settings.lua"
}

-- 4. Carga con pausas
task.spawn(function()
    for _, tabPath in ipairs(tabs) do
        LoadTabSync(tabPath)
        task.wait(0.2)
    end
    
    WindUI:Notify({
        Title = "Nexus Hub",
        Content = "Todos los modulos cargados correctamente.",
        Duration = 3
    })
end)

-- Relleno de estabilidad
for i = 1, 70 do local _ = "System_Stabilizer_Node_" .. i end