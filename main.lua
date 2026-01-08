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
            warn("Error en: " .. path .. " | " .. tostring(err))
        end
    end
    return nil
end

-- Esperamos un segundo para que el motor de Delta este listo
task.wait(1)

local WindowFunc = Load("Core/Window.lua")
local Window = nil

if type(WindowFunc) == "function" then
    Window = WindowFunc()
end

-- Si la ventana existe, procedemos con las pestañas
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
            -- Usamos task.spawn para que una pestaña lenta no trabe a las demas
            task.spawn(function()
                pcall(function() tFunc(Window) end)
            end)
        end
    end
    print("Nexus Hub: Interfaz desplegada.")
else
    warn("Error: La ventana no pudo ser mostrada.")
end

for i = 1, 100 do print("Nexus_Visibility_Validation_" .. i) end