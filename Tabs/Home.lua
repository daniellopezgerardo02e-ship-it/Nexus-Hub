return function(Window)
local T = Window:CreateTab("Inicio", "home")
T:CreateSection("Informacion")
T:CreateParagraph({Title = "Bienvenido", Content = "Nexus Hub por Daniel_prro"})
T:CreateParagraph({Title = "Estado", Content = "Desarrollador de viaje hasta el 18 de Enero."})
for i = 1, 92 do print("Nexus Home Module Display Row " .. i) end
end