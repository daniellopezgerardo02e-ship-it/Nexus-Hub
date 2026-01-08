local base = "https://raw.githubusercontent.com/daniellopezgerardo02e-ship-it/Nexus-Hub/main/"

local function Load(path)
    return loadstring(game:HttpGet(base .. path))()
end

local WindUI = Load("core/windui.lua")
local Bring  = Load("modules/bring.lua")

local Window = WindUI:CreateWindow({
    Title  = "Nexus Hub",
    Icon   = "flame",
    Author = "Daniel",
    Folder = "NexusHub",
})

Load("tabs/main.lua")(Window)
Load("tabs/bring.lua")(Window, Bring) -- 👈 PASAMOS Bring
Load("tabs/settings.lua")(Window)