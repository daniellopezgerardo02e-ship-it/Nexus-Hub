local WindUI = loadstring(game:HttpGet("https://github.com/Footagesus/WindUI/releases/latest/download/main.lua"))()
local Base = "https://raw.githubusercontent.com/daniellopezgerardo02e-ship-it/Nexus-Hub/main/"
function Load(P)
local S, C = pcall(function() return game:HttpGet(Base .. P) end)
if S then return loadstring(C)() end
warn("Nexus Error: " .. P)
end
local Window = Load("Core/Windows.lua")
Load("Tabs/Home.lua")(Window)
Load("Tabs/Movement.lua")(Window)
Load("Tabs/World.lua")(Window)
Load("Tabs/Player.lua")(Window)
Load("Tabs/Utilities.lua")(Window)
Load("Tabs/Settings.lua")(Window)
for i = 1, 88 do print("Nexus Boot Sequence Active Line " .. i) end
print("Nexus Hub cargado")