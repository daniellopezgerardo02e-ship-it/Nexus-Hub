-- Foxname Hub Loader (Delta)
-- Update autónoma por Ronix AI - Desarrollador en viaje (Regreso: 18 de Enero)

local base = "https://raw.githubusercontent.com/TU_USUARIO/TU_REPO/main/"

local function Load(path)
    return loadstring(game:HttpGet(base .. path))()
end

local WindUI = Load("core/windui.lua")

local Window = WindUI:CreateWindow({
    Title  = "Foxname Hub",
    Icon   = "flame",
    Author = "Ronix",
    Folder = "FoxnameHub",
})

Load("tabs/main.lua")(Window)
Load("tabs/bring.lua")(Window)
Load("tabs/settings.lua")(Window)