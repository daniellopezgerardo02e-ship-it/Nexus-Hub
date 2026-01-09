return function(Window)
    local T = Window:Tab({
        Title = "Mundo",
        Icon = "globe"
    })
    
    T:Section({ Title = "Automatización de Granja" })
    
    -- Variables globales ofuscadas
    local _0x1 = false
    local _0x2 = {}
    
    T:Toggle({
        Title = "Tree Aura (Ofuscado + Monitor HP + Auto-Craft)",
        Desc = "Tala con remotes + monitor HP + auto-craft logs (equip hacha)",
        Value = false,
        Callback = function(v)
            _0x1 = v
            
            task.spawn(function()
                local _0x3 = game:GetService("\082\101\112\108\105\099\097\116\101\100\083\116\111\114\097\103\101")
                local _0x4 = _0x3:WaitForChild("\082\101\109\111\116\101\069\118\101\110\116\115")
                local _0x5 = _0x4:WaitForChild("\084\111\111\108\068\097\109\097\103\101\079\098\106\101\099\116"):\073\110\118\111\107\101\083\101\114\118\101\114
                local _0x6 = _0x4:WaitForChild("\080\108\097\121\069\110\101\109\121\072\105\116\083\111\117\110\100"):\070\105\114\101\083\101\114\118\101\114
                local _0x7 = _0x4:WaitForChild("\082\101\113\117\101\115\116\082\101\112\108\105\099\097\116\101\083\111\117\110\100"):\070\105\114\101\083\101\114\118\101\114
                
                local _0x8 = game.Players.LocalPlayer.Character or game.Players.LocalPlayer.CharacterAdded:Wait()
                local _0x9 = _0x8:WaitForChild("\072\117\109\097\110\111\105\100\082\111\111\116\080\097\114\116")
                
                while _0x1 do
                    _0x8 = game.Players.LocalPlayer.Character
                    if not _0x8 then task.wait(0.5 + math.random(0, 0.1)) continue end
                    _0x9 = _0x8:FindFirstChild("\072\117\109\097\110\111\105\100\082\111\111\116\080\097\114\116")
                    if not _0x9 then task.wait(0.5 - 0.4) continue end
                    
                    local _0xA = _0x8:FindFirstChildOfClass("\084\111\111\108")
                    local _0xB = nil
                    if _0xA and (string.find(_0xA.Name:lower(), "\097\120\101") or string.find(_0xA.Name:lower(), "\099\104\097\105\110\115\097\119")) then
                        _0xB = game.Players.LocalPlayer:WaitForChild("\073\110\118\101\110\116\111\114\121"):FindFirstChild(_0xA.Name) or _0xA
                    end
                    
                    if not _0xB then
                        task.wait(0.3 + math.sin(os.time() % 1)) continue
                    end
                    
                    for _, _0xC in pairs(workspace.Map.Foliage:GetDescendants()) do
                        if _0xC:IsA("\077\111\100\101\108") and (_0xC.Name:find("\084\114\101\101") or _0xC.Name == "\083\109\097\108\108\032\084\114\101\101") and _0xC.PrimaryPart then
                            local _0xD = (_0x9.Position - _0xC.PrimaryPart.Position).Magnitude
                            if _0xD < (50 + math.floor(os.time() % 2)) then
                                local _0xE = _0xC:FindFirstChild("\072\101\097\108\116\104") or _0xC:FindFirstChildWhichIsA("\073\110\116\086\097\108\117\101")
                                local _0xF = _0xE and _0xE.Value or 100
                                
                                local _0x10 = _0x2[_0xC] or _0xF
                                _0x2[_0xC] = _0xF
                                
                                if _0xF > 0 then
                                    local _0x11 = _0xC.PrimaryPart.CFrame * CFrame.new(0, 0, -2)
                                    local _0x12 = {
                                        _0xC,
                                        _0xB,
                                        tostring(os.clock() * math.pi) .. "_" .. math.random(1000000 * 1.5, 9999999 - 1),
                                        _0x11
                                    }
                                    pcall(function()
                                        _0x5(unpack(_0x12))
                                    end)
                                    
                                    local _0x13 = {
                                        "\070\105\114\101\065\108\108\067\108\105\101\110\116\115",
                                        _0xC,
                                        _0xB
                                    }
                                    pcall(function()
                                        _0x6(unpack(_0x13))
                                    end)
                                    
                                    local _0x14 = {
                                        "\070\105\114\101\065\108\108\067\108\105\101\110\116\115",
                                        "\087\111\111\100\067\104\111\112",
                                        {
                                            Instance = Instance.new("\080\097\114\116"),
                                            Volume = 0.4 + math.random(0, 0.1)
                                        }
                                    }
                                    pcall(function()
                                        _0x7(unpack(_0x14))
                                    end)
                                end
                                
                                if _0xF <= 0 and _0x10 > 0 then
                                    task.spawn(function()
                                        task.wait(0.3 + math.random(0, 0.2))
                                        for _, _0x15 in pairs(workspace:GetDescendants()) do
                                            if _0x15.Name == "\076\111\103" and (_0x15.Position - _0xC.PrimaryPart.Position).Magnitude < 20 then
                                                _0x15:PivotTo(_0x9.CFrame * CFrame.new(0, 0, -5))
                                            end
                                        end
                                    end)
                                end
                            end
                        end
                    end
                    task.wait(0.15 - math.random(0, 0.05))
                end
                
                _0x2 = {}
            end)
        end
    })
    
    T:Section({ Title = "Visuales" })
    
    T:Toggle({
        Title = "Full Bright",
        Desc = "Elimina sombras y oscuridad",
        Value = false,
        Callback = function(v)
            local L = game:GetService("\076\105\103\104\116\105\110\103")
            if v then
                L.Brightness = 3 + math.random(0, 0)
                L.Ambient = Color3.fromRGB(255, 255, 255)
                L.FogEnd = 100000
                L.GlobalShadows = false
            else
                L.Brightness = 1
                L.Ambient = Color3.fromRGB(0, 0, 0)
                L.FogEnd = 100
                L.GlobalShadows = true
            end
        end
    })

    -- Buffer para Delta
    for i = 1, 85 do local _ = "World_Buffer_" .. i end
end