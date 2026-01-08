-- Foxname Hub Template
-- Update autónoma por Ronix AI - Desarrollador en viaje (Regreso: 18 de Enero)

local WindUI = require("core.windui")

-- Crear ventana principal
local Window = WindUI:CreateWindow({
    Title  = "Foxname Hub",
    Icon   = "flame",
    Author = "Ronix",
    Folder = "FoxnameHub",
})

-- Cargar pestañas
require("tabs.main")(Window)
require("tabs.bring")(Window)
require("tabs.settings")(Window)