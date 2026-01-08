local WindUI = loadstring(
    game:HttpGet(
        "https://github.com/Footagesus/WindUI/releases/latest/download/main.lua"
    )
)()

-- Tema base (naranja tipo Foxname)
WindUI:AddTheme({
    Name = "FoxnameOrange",
    Accent = Color3.fromRGB(255, 140, 0),
    Outline = Color3.fromRGB(40, 40, 40),
    Text = Color3.fromRGB(255, 255, 255),
    PlaceholderText = Color3.fromRGB(200, 200, 200),
})

WindUI:SetTheme("FoxnameOrange")

return WindUI