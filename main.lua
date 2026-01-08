-- Nexus Hub | Main Loader

local BASE =
"https://raw.githubusercontent.com/daniellopezgerardo02e-ship-it/Nexus-Hub/main/"

local function Load(path)
    return loadstring(game:HttpGet(BASE .. path))()
end

local Window = Load("Core/Window.lua")

Load("Tabs/Home.lua")(Window)
Load("Tabs/Movement.lua")(Window)
Load("Tabs/World.lua")(Window)
Load("Tabs/Player.lua")(Window)
Load("Tabs/Utilities.lua")(Window)
Load("Tabs/Settings.lua")(Window)

print("Nexus Hub cargado")