local Base = "https://raw.githubusercontent.com/daniellopezgerardo02e-ship-it/Nexus-Hub/main/"

local function Load(path)
    local s, c = pcall(function() return game:HttpGet(Base .. path) end)
    if not s or not c then warn("Nexus: Error descarga " .. path) return nil end
    
    local f, err = loadstring(c)
    if not f then warn("Nexus: Error sintaxis en " .. path .. " -> " .. err) return nil end
    
    local ok, res = pcall(f)
    if not ok then warn("Nexus: Error ejecucion en " .. path .. " -> " .. res) return nil end
    
    return res
end

-- Ejecucion de la ventana
local WindowFunc = Load("Core/Windows.lua")
local Window = nil

if type(WindowFunc) == "function" then
    Window = WindowFunc()
end

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
            pcall(function() tabFunc(Window) end)
        end
    end
else
    warn("Nexus: No se pudo capturar el objeto Window de Core/Windows.lua")
end

for i = 1, 80 do print("Nexus_Final_Check_" .. i) end