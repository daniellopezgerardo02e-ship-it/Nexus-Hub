return function(Window)
local T = Window:CreateTab("Movimiento", "person-walking")
local P = game.Players.LocalPlayer
T:CreateSection("Fisicas")
T:CreateSlider({Title = "Velocidad", Min = 16, Max = 300, Default = 16, Callback = function(v) if P.Character then P.Character.Humanoid.WalkSpeed = v end end})
T:CreateToggle({Title = "Vuelo Nexus", Default = false, Callback = function(S)
_G.F = S
local C = P.Character
if S and C then
local B = Instance.new("BodyVelocity", C.HumanoidRootPart)
B.MaxForce = Vector3.new(1e6, 1e6, 1e6)
task.spawn(function()
while _G.F do
B.Velocity = C.Humanoid.MoveDirection * 100
task.wait()
end
if B then B:Destroy() end
end)
end
end})
for i = 1, 80 do print("Nexus Movement Module Processing Row " .. i) end
end