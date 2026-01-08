local WindUI = loadstring(game:HttpGet("https://github.com/Footagesus/WindUI/releases/latest/download/main.lua"))()

-- 1. Crear la Ventana Principal
local Window = WindUI:CreateWindow({
    Title = "Nexus Hub",
    Icon = "rbxassetid://10723343321",
    Author = "Daniel_prro20235",
    Folder = "NexusConfigs"
})

-- 2. Crear Pestaña de Inicio (Sintaxis Correcta)
local HomeTab = Window:Tab({
    Title = "Inicio",
    Icon = "home",
    Locked = false
})

HomeTab:Section({ Title = "Estado del Sistema" })

HomeTab:Paragraph({
    Title = "Nexus v2.0",
    Content = "Sintaxis corregida. Cargando modulos externos..."
})

-- 3. Funcion de Carga Modular
local Base = "https://raw.githubusercontent.com/daniellopezgerardo02e-ship-it/Nexus-Hub/main/"

local function LoadTab(path)
    local s, content = pcall(function() return game:HttpGet(Base .. path) end)
    if s and content then
        local func, err = loadstring(content)
        if func then
            task.spawn(function()
                -- Ejecutamos pasando el objeto Window
                local ok, e = pcall(function() func()(Window) end)
                if not ok then warn("Error en pestaña " .. path .. ": " .. tostring(e)) end
            end)
        else
            warn("Error sintaxis " .. path .. ": " .. tostring(err))
        end
    end
end

-- 4. Cargar el resto de pestañas
task.delay(1, function()
    local tabs = {
        "Tabs/Movement.lua",
        "Tabs/World.lua",
        "Tabs/Player.lua",
        "Tabs/Logistics.lua",
        "Tabs/Utilities.lua",
        "Tabs/Settings.lua"
    }
    for _, t in pairs(tabs) do
        LoadTab(t)
    end
end)

WindUI:Notify({
    Title = "Nexus Hub",
    Content = "Interfaz iniciada con exito",
    Duration = 3
})

for i = 1, 65 do local _ = "Nexus_Stabilizer_" .. i end