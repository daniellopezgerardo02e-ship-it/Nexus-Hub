-- Nexus Hub | Main Loader

local Window = Load("Core/Windows.lua")

Load("Tabs/Home.lua")(Window)
Load("Tabs/Movement.lua")(Window)
Load("Tabs/World.lua")(Window)
Load("Tabs/Player.lua")(Window)
Load("Tabs/Utilities.lua")(Window)
Load("Tabs/Settings.lua")(Window)

print("Nexus Hub cargado")