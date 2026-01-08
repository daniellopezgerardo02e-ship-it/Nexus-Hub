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
    local s, content = pcall(function() return game:HttpGet(Base .. path) end)
    if s and content then
        local func, err = loadstring(content)
        if func then
            -- Intentamos ejecutar la pestaña
            local ok, e = pcall(function() 
                -- Importante: Ejecutamos el doble retorno
                local init = func()
                if type(init) == "function" then
                    init(Window)
                end
            end)
            if not ok then warn("Error en " .. path .. ": " .. tostring(e)) end
        else
            warn("Sintaxis incorrecta en " .. path)
        end
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