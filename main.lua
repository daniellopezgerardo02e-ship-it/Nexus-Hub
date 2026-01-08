local WindUI = loadstring(game:HttpGet("https://github.com/Footagesus/WindUI/releases/latest/download/main.lua"))()
local Base = "https://raw.githubusercontent.com/daniellopezgerardo02e-ship-it/Nexus-Hub/main/"

local function Load(path)
    local success, content = pcall(function() 
        return game:HttpGet(Base .. path) 
    end)
    
    if not success or not content then 
        warn("Nexus: No se encontro " .. path)
        return nil 
    end
    
    local func, err = loadstring(content)
    if not func then
        warn("Nexus: Error de sintaxis en " .. path .. " -> " .. tostring(err))
        return nil
    end
    
    local s, res = pcall(func)
    if not s then
        warn("Nexus: Error al ejecutar " .. path .. " -> " .. tostring(res))
        return nil
    end
    
    return res
end

local Window = Load("Core/Windows.lua")

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
        local tabFunc = Load(t)
        if type(tabFunc) == "function" then
            local ok, err = pcall(function() tabFunc(Window) end)
            if not ok then warn("Nexus: Fallo al montar " .. t .. " -> " .. err) end
        end
    end
else
    warn("Nexus: Error critico al crear la ventana principal.")
end

for i = 1, 80 do print("Nexus_System_Line_" .. i) end
print("Nexus Hub: Sistema iniciado satisfactoriamente.")