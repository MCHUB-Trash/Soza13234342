_G.AutoFarm = true
join = game.Players.localPlayer.Neutral == false
if _G.Team == nil then
    _G.Team = "Pirates"
end
if (_G.Team == "Pirates" or _G.Team == "Marines") and not join then
    repeat wait()
        pcall(function()
            join = game.Players.localPlayer.Neutral == false
            if _G.Team == "Pirates" then
                for i,v in pairs(getconnections(game:GetService("Players").LocalPlayer.PlayerGui.Main.ChooseTeam.Container.Pirates.Frame.ViewportFrame.TextButton.MouseButton1Click)) do
                    v.Function()
                end
            elseif _G.Team == "Marines" then
                for i,v in pairs(getconnections(game:GetService("Players").LocalPlayer.PlayerGui.Main.ChooseTeam.Container.Marines.Frame.ViewportFrame.TextButton.MouseButton1Click)) do
                    v.Function()
                end
            else
                for i,v in pairs(getconnections(game:GetService("Players").LocalPlayer.PlayerGui.Main.ChooseTeam.Container.Pirates.Frame.ViewportFrame.TextButton.MouseButton1Click)) do
                    v.Function()
                end
            end
        end)
    until join == true
    game:GetService("Players").LocalPlayer.PlayerGui.Main.ChooseTeam.Visible = false
end
wait(1)
task.spawn(function()
	pcall(function()
		if not game:IsLoaded() then repeat wait() until game:IsLoaded() end
		if hookfunction and setreadonly then
			local mt = getrawmetatable(game)
			local old = mt.__newindex
			setreadonly(mt, false)
			local sda
			sda = hookfunction(old, function(t, k, v)
				if k == "Material" then
					if v ~= Enum.Material.Neon and v ~= Enum.Material.Plastic and v ~= Enum.Material.ForceField then v = Enum.Material.Plastic end
				elseif k == "TopSurface" then v = "Smooth"
				elseif k == "Reflectance" or k == "WaterWaveSize" or k == "WaterWaveSpeed" or k == "WaterReflectance" then v = 0
				elseif k == "WaterTransparency" then v = 1
				elseif k == "GlobalShadows" then v = false end
				return sda(t, k, v)
			end)
			setreadonly(mt, true)
		end
		local g = game
		local w = g.Workspace
		local l = g:GetService"Lighting"
		local t = w:WaitForChild"Terrain"
		t.WaterWaveSize = 0
		t.WaterWaveSpeed = 0
		t.WaterReflectance = 0
		t.WaterTransparency = 1
		l.GlobalShadows = false
		
		function change(v)
			pcall(function()
				if v.Material ~= Enum.Material.Neon and v.Material ~= Enum.Material.Plastic and v.Material ~= Enum.Material.ForceField then
					pcall(function() v.Reflectance = 0 end)
					pcall(function() v.Material = Enum.Material.Plastic end)
					pcall(function() v.TopSurface = "Smooth" end)
				end
			end)
		end
		
		game.DescendantAdded:Connect(function(v)
			pcall(function()
				if v:IsA"Part" then change(v)
				elseif v:IsA"MeshPart" then change(v)
				elseif v:IsA"TrussPart" then change(v)
				elseif v:IsA"UnionOperation" then change(v)
				elseif v:IsA"CornerWedgePart" then change(v)
				elseif v:IsA"WedgePart" then change(v) end
			end)
		end)
		for i, v in pairs(game:GetDescendants()) do
			pcall(function()
				if v:IsA"Part" then change(v)
				elseif v:IsA"MeshPart" then change(v)
				elseif v:IsA"TrussPart" then change(v)
				elseif v:IsA"UnionOperation" then change(v)
				elseif v:IsA"CornerWedgePart" then change(v)
				elseif v:IsA"WedgePart" then change(v) end
			end)
		end
		local decalsyeeted = true -- Leaving this on makes games look shitty but the fps goes up by at least 20.
		local g = game
		local w = g.Workspace
		local l = g.Lighting
		local t = w.Terrain
		sethiddenproperty(l,"Technology",2)
		sethiddenproperty(t,"Decoration",false)
		t.WaterWaveSize = 0
		t.WaterWaveSpeed = 0
		t.WaterReflectance = 0
		t.WaterTransparency = 0
		l.GlobalShadows = false
		l.FogEnd = 9e9
		l.Brightness = 0
		settings().Rendering.QualityLevel = "Level01"
		for i, v in pairs(g:GetDescendants()) do
			if v:IsA("Part") or v:IsA("Union") or v:IsA("CornerWedgePart") or v:IsA("TrussPart") then
				v.Material = "Plastic"
				v.Reflectance = 0
			elseif v:IsA("Decal") or v:IsA("Texture") and decalsyeeted then
				v.Transparency = 1
			elseif v:IsA("ParticleEmitter") or v:IsA("Trail") then
				v.Lifetime = NumberRange.new(0)
			elseif v:IsA("Explosion") then
				v.BlastPressure = 1
				v.BlastRadius = 1
			elseif v:IsA("Fire") or v:IsA("SpotLight") or v:IsA("Smoke") or v:IsA("Sparkles") then
				v.Enabled = false
			elseif v:IsA("MeshPart") then
				v.Material = "Plastic"
				v.Reflectance = 0
				v.TextureID = 10385902758728957
			end
		end
		for i, e in pairs(l:GetChildren()) do
			if e:IsA("BlurEffect") or e:IsA("SunRaysEffect") or e:IsA("ColorCorrectionEffect") or e:IsA("BloomEffect") or e:IsA("DepthOfFieldEffect") then
				e.Enabled = false
			end
		end
	end)
end)
InvetoryWeaponList = {}
local args = {
    [1] = "getInventoryWeapons"
}
game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer(unpack(args))
game:GetService("Players").LocalPlayer.PlayerGui.Main.Inventory.Visible = true
game:GetService("Players").LocalPlayer.PlayerGui.Main.Inventory.Title.Visible = false
game:GetService("Players").LocalPlayer.PlayerGui.Main.Inventory.Container.Visible = false
game:GetService("Players").LocalPlayer.PlayerGui.Main.Inventory.Info.Visible = false
game:GetService("Players").LocalPlayer.PlayerGui.Main.Inventory.Size = UDim2.new(0,0,0,0)
game:GetService("Players").LocalPlayer.PlayerGui.Main.Inventory.BackgroundTransparency = 1
wait(2.5)
for _i, v in pairs(game:GetService("Players").LocalPlayer.PlayerGui.Main.Inventory.Container.Current.ScrollingFrame.Frame:GetChildren()) do
    if v:IsA('ImageButton') then
        if  v.Name == 'Template' then
            else
            table.insert(InvetoryWeaponList, v.Name)    
        end
    end
end
for _i, v in pairs(game:GetService("Players").LocalPlayer.PlayerGui.Main.Inventory.Container.Stored.ScrollingFrame.Frame:GetChildren()) do
    if v:IsA('ImageButton') then
        if  v.Name == 'Template' then
        else
            table.insert(InvetoryWeaponList, v.Name)    
        end
    end
end
local library = loadstring(game:HttpGet("https://raw.githubusercontent.com/naypramx/Ui__Project/Script/XeNonUi", true))()
local CenterHubNo1 = library:CreateWindow("Rezy Hub - Kaitun",Enum.KeyCode.RightControl)
local Tab = CenterHubNo1:CreateTab("Stats")
local Sector1 = Tab:CreateSector("Main","left")
BlackLeg2 = Sector1:AddLabel("N/A")
spawn(function()
	while wait() do
		pcall(function()
			local args = {
				[1] = "BuyBlackLeg",
				[2] = true
			}
			BlackLeg = game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer(unpack(args))
			if BlackLeg == 1 then
				BlackLeg2:Set("BlackLeg : ✅")
			else
				BlackLeg2:Set("BlackLeg : ❌")
			end
		end)
	end
end)
Electro2 = Sector1:AddLabel("N/A")
spawn(function()
	while wait() do
		pcall(function()
			local args = {
				[1] = "BuyElectro",
				[2] = true
			}
			
			Electro = game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer(unpack(args))
			if Electro == 1 then
				Electro2:Set("Electro : ✅")
			else
				Electro2:Set("Electro : ❌")
			end
		end)
	end
end)
FishmanKarate2 = Sector1:AddLabel("N/A")
spawn(function()
	while wait() do
		pcall(function()
			local args = {
				[1] = "BuyFishmanKarate",
				[2] = true
			}
			
			FishmanKarate = game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer(unpack(args))
			if FishmanKarate == 1 then
				FishmanKarate2:Set("FishmanKarate : ✅")
			else
				FishmanKarate2:Set("FishmanKarate : ❌")
			end
		end)
	end
end)
DragonClaw2 = Sector1:AddLabel("N/A")
spawn(function()
	while wait() do
		pcall(function()
			local args = {
				[1] = "BlackbeardReward",
				[2] = "DragonClaw",
				[3] = "1",
				[4] = true
			}
			
			DragonClaw3 = game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer(unpack(args))
			if DragonClaw3 == 1 then
				DragonClaw2:Set("DragonClaw : ✅")
			else
				DragonClaw2:Set("DragonClaw : ❌")
			end
		end)
	end
end)
Superhuman2 = Sector1:AddLabel("N/A")
spawn(function()
	while wait() do
		pcall(function()
			local args = {
				[1] = "BuySuperhuman",
				[2] = true
			}
			
			Superhuman = game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer(unpack(args))
			if Superhuman == 1 then
				Superhuman2:Set("Superhuman : ✅")
			else
				Superhuman2:Set("Superhuman : ❌")
			end
		end)
	end
end)
local Sector2 = Tab:CreateSector("Sword","Reft")
Saber = Sector2:AddLabel("N/A")
spawn(function()
    pcall(function()
        while wait() do
            if game:GetService("Players").LocalPlayer.PlayerGui.Main.Inventory.Container.Stored.ScrollingFrame.Frame:FindFirstChild('Saber') then
                Saber:Set("Saber : ✅")
            else
                Saber:Set("Saber : ❌")
            end
        end
    end)
end)
Canvander = Sector2:AddLabel("N/A")
spawn(function()
    pcall(function()
        while wait() do
            if game:GetService("Players").LocalPlayer.PlayerGui.Main.Inventory.Container.Stored.ScrollingFrame.Frame:FindFirstChild('Canvander') then
                Canvander:Set("Canvander : ✅")
            else
                Canvander:Set("Canvander : ❌")
            end
        end
    end)
end)
Yama = Sector2:AddLabel("N/A")
spawn(function()
    pcall(function()
        while wait() do
            if game:GetService("Players").LocalPlayer.PlayerGui.Main.Inventory.Container.Stored.ScrollingFrame.Frame:FindFirstChild('Yama') then
                Yama:Set("Yama : ✅")
            else
                Yama:Set("Yama : ❌")
            end
        end
    end)
end)

Buddy = Sector2:AddLabel("N/A")
spawn(function()
    pcall(function()
        while wait() do
            if game:GetService("Players").LocalPlayer.PlayerGui.Main.Inventory.Container.Stored.ScrollingFrame.Frame:FindFirstChild('Buddy Sword') then
                Buddy:Set("Buddy : ✅")
            else
                Buddy:Set("Buddy : ❌")
            end
        end
    end)
end)
Magnet = true
local placeId = game.PlaceId
if placeId == 2753915549 then
	OldWorld = true
elseif placeId == 4442272183 then
	NewWorld = true
elseif placeId == 7449423635 then
	ThreeWorld = true
else
	game.Players.LocalPlayer:Kick("รันผิดเกม อย่า เล่น เก")
end
spawn(function()
	game_pid = game.PlaceId
	asiufdl = 0
	repeat wait(1)
		print("Is GAME LOADED CHEKER : "..tostring(asiufdl))
		asiufdl += 1
	until asiufdl > 240 or game:IsLoaded()
	repeat wait()
		if not game:IsLoaded() then
			if game_pid == nil then
				game_pid = game.PlaceId
			end
			pcall(function()
				print("re - joining 1")
				game:GetService('TeleportService'):TeleportToPlaceInstance(game_pid, game.JobId, game.Players.LocalPlayer)
				print("rejoined 1")
			end)
			pcall(function()
				print("re - joining 2")
				game:GetService('TeleportService'):Teleport(game_pid)
				print("rejoined 2")
			end)
			wait(2)
		end
	until game:IsLoaded()
end)
joingame_timr = 0
repeat 
	wait(0.1)
	joingame_timr += 0.1
until game:IsLoaded()
spawn(function()
	while wait(1) do
		pcall(function()
			game_pid = game.PlaceId
			repeat wait() until game.CoreGui:FindFirstChild('RobloxPromptGui')
			local lp,po,ts = game:GetService('Players').LocalPlayer,game.CoreGui.RobloxPromptGui.promptOverlay,game:GetService('TeleportService')
			po.ChildAdded:connect(function(a)
				if a.Name == 'ErrorPrompt' then
					gujaef = 0
					repeat wait(1)
						print("waiting to rejoin if  found ErrorPrompt "..tostring(gujaef))
						gujaef += 1
					until gujaef > 40
					if a.Name == 'ErrorPrompt' then
						while wait() do
							--ts:Teleport(game.PlaceId)
							if game_pid == nil then
								game_pid = game.PlaceId
							end
							pcall(function()
								print("re - joining 1")
								game:GetService('TeleportService'):TeleportToPlaceInstance(game.PlaceId, game.JobId, game.Players.LocalPlayer)
								print("rejoined 1")
							end)
							pcall(function()
								print("re - joining 2")
								game:GetService('TeleportService'):Teleport(game.PlaceId)
								print("rejoined 2")
							end)
							wait(2)
						end
					end
				end
			end)
		end)
	end
end)
function Click()
	game:GetService'VirtualUser':CaptureController()
	game:GetService'VirtualUser':Button1Down(Vector2.new(1280, 672))
end
local a = Instance.new('Part',workspace)
local a = Instance.new("Part")
a.Name = "BIGDICK"
a.Parent = game.Workspace
a.Anchored = true 
a.Transparency = 1
a.Size = Vector3.new(40,0.5,40)
game:GetService("RunService").Heartbeat:Connect(function()
	pcall(function()
	if not game:GetService("Workspace"):FindFirstChild("BIGDICK") then
	local a = Instance.new("Part")
	a.Name = "ez"
	a.Parent = game.Workspace
	a.Anchored = true 
	a.Transparency = 1
	a.Size = Vector3.new(40,0.5,40)
	end
	--[[if x then
	changestate()
	end]]
	end)
end)
function changestate()
	game.Workspace["BIGDICK"].CFrame = CFrame.new(game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame.X,-4,game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame.Z)
end
function CheckQuest()
	local MyLevel = game.Players.LocalPlayer.Data.Level.Value
	if OldWorld then
		if MyLevel == 1 or MyLevel <= 9 then -- Bandit
			Ms = "Bandit [Lv. 5]"
			NaemQuest = "BanditQuest1"
			LevelQuest = 1
			NameMon = "Bandit"
			ISLANDPOS = CFrame.new(1211.88525, 36.7203407, 1500.03467, 0.615429699, -0.788191795, -6.02006912e-06, 6.02006912e-06, 1.23977661e-05, -1, 0.788191795, 0.615429759, 1.23977661e-05)
			CFrameQuest = CFrame.new(1061.66699, 16.5166187, 1544.52905, -0.942978859, -3.33851502e-09, 0.332852632, 7.04340497e-09, 1, 2.99841325e-08, -0.332852632, 3.06188177e-08, -0.942978859)
			CFrameMon = CFrame.new(1158.19287, 16.7761078, 1598.75024, 0.728623271, -2.60434244e-05, -0.684914768, 5.54633402e-07, 1, -3.74343144e-05, 0.684914768, 2.68956283e-05, 0.728623271)
			if _G.AutoFarm and (CFrameMon.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude > 600 then
				game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = ISLANDPOS
			end
		-- elseif MyLevel == 10 or MyLevel <= 14 then -- Monkey
		-- 	Ms = "Monkey [Lv. 14]"
		-- 	NaemQuest = "JungleQuest"
		-- 	LevelQuest = 1
		-- 	NameMon = "Monkey"
		-- 	ISLANDPOS = CFrame.new(-1180.99561, 21.0006905, 187.688171, -0.866141438, -2.23321149e-05, -0.499799222, 2.23321149e-05, 1, -8.33832528e-05, 0.499799222, -8.33832528e-05, -0.866141438)
		-- 	CFrameQuest = CFrame.new(-1604.12012, 36.8521118, 154.23732, 0.0648873374, -4.70858913e-06, -0.997892559, 1.41431883e-07, 1, -4.70933674e-06, 0.997892559, 1.64442184e-07, 0.0648873374)
		-- 	CFrameMon = CFrame.new(-1612.77039, 37.1953545, 150.217361, -0.325320244, 5.01602138e-09, -0.945603907, -1.28536748e-09, 1, 5.74677994e-09, 0.945603907, 3.08499248e-09, -0.325320244)
		-- 	if _G.AutoFarm and (CFrameMon.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude > 600 then
		-- 		game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = ISLANDPOS
		-- 	end
		-- elseif MyLevel == 15 or MyLevel <= 29 then -- Gorilla
		-- 	Ms = "Gorilla [Lv. 20]"
		-- 	NaemQuest = "JungleQuest"
		-- 	LevelQuest = 2
		-- 	NameMon = "Gorilla"
		-- 	ISLANDPOS = CFrame.new(-1180.99561, 21.0006905, 187.688171, -0.866141438, -2.23321149e-05, -0.499799222, 2.23321149e-05, 1, -8.33832528e-05, 0.499799222, -8.33832528e-05, -0.866141438)
		-- 	CFrameQuest = CFrame.new(-1604.12012, 36.8521118, 154.23732, 0.0648873374, -4.70858913e-06, -0.997892559, 1.41431883e-07, 1, -4.70933674e-06, 0.997892559, 1.64442184e-07, 0.0648873374)
		-- 	CFrameMon = CFrame.new(-1223.52808, 6.27936459, -502.292664, 0.310949147, -5.66602516e-08, 0.950426519, -3.37275488e-08, 1, 7.06501808e-08, -0.950426519, -5.40241736e-08, 0.310949147)
		-- 	if _G.AutoFarm and (CFrameMon.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude > 1000 then
		-- 		game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = ISLANDPOS
		-- 	end
		elseif MyLevel == 30 or MyLevel <= 39 then -- Pirate
			Ms = "Pirate [Lv. 35]"
			NaemQuest = "BuggyQuest1"
			LevelQuest = 1
			NameMon = "Pirate"
			ISLANDPOS = CFrame.new(-825.657349, 3.63657403, 4123.30811, -0.138172507, 0.0225743353, -0.990150809, 0.0865087882, 0.996194243, 0.0106400847, 0.98662281, -0.0841865838, -0.139599562)
			CFrameQuest = CFrame.new(-1139.59717, 4.75205183, 3825.16211, -0.959730506, -7.5857054e-09, 0.280922383, -4.06310328e-08, 1, -1.11807175e-07, -0.280922383, -1.18718916e-07, -0.959730506)
			CFrameMon = CFrame.new(-1169.5365, 5.09531212, 3933.84082, -0.971822679, -3.73200315e-09, 0.235713184, -4.16762763e-10, 1, 1.41145424e-08, -0.235713184, 1.3618596e-08, -0.971822679)
			if _G.AutoFarm and (CFrameMon.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude > 600 then
				game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = ISLANDPOS
			end
		elseif MyLevel == 40 or MyLevel <= 59 then -- Brute
			Ms = "Brute [Lv. 45]"
			NaemQuest = "BuggyQuest1"
			LevelQuest = 2
			NameMon = "Brute"
			ISLANDPOS = CFrame.new(-825.657349, 3.63657403, 4123.30811, -0.138172507, 0.0225743353, -0.990150809, 0.0865087882, 0.996194243, 0.0106400847, 0.98662281, -0.0841865838, -0.139599562)
			CFrameQuest = CFrame.new(-1139.59717, 4.75205183, 3825.16211, -0.959730506, -7.5857054e-09, 0.280922383, -4.06310328e-08, 1, -1.11807175e-07, -0.280922383, -1.18718916e-07, -0.959730506)
			CFrameMon = CFrame.new(-1165.09985, 15.1531372, 4363.51514, -0.962800264, 1.17564889e-06, 0.270213336, 2.60172015e-07, 1, -3.4237969e-06, -0.270213336, -3.22613073e-06, -0.962800264)
			if _G.AutoFarm and (CFrameMon.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude > 1000 then
				game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = ISLANDPOS
			end
		elseif MyLevel == 60 or MyLevel <= 74 then -- Desert Bandit
			Ms = "Desert Bandit [Lv. 60]"
			NaemQuest = "DesertQuest"
			LevelQuest = 1
			NameMon = "Desert Bandit"
			ISLANDPOS = CFrame.new(921.289673, 6.45703602, 4334.47803, -0.207233012, 8.06497269e-08, 0.978291631, 3.10611412e-08, 1, -7.58596244e-08, -0.978291631, 1.46662362e-08, -0.207233012)
			CFrameQuest = CFrame.new(897.031128, 6.43846416, 4388.97168, -0.804044724, 3.68233266e-08, 0.594568789, 6.97835176e-08, 1, 3.24365246e-08, -0.594568789, 6.75715199e-08, -0.804044724)
			CFrameMon = CFrame.new(932.788818, 6.8503746, 4488.24609, -0.998625934, 3.08948351e-08, 0.0524050146, 2.79967303e-08, 1, -5.60361286e-08, -0.0524050146, -5.44919629e-08, -0.998625934)
			if _G.AutoFarm and (CFrameMon.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude > 1000 then
				game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = ISLANDPOS
			end
		elseif MyLevel == 75 or MyLevel <= 89 then -- Desert Officre
			Ms = "Desert Officer [Lv. 70]"
			NaemQuest = "DesertQuest"
			LevelQuest = 2
			NameMon = "Desert Officer"
			ISLANDPOS = CFrame.new(1658.85876, 4.64293623, 4318.07129, -0.0864315033, -0.000185585552, 0.996257842, -6.89026783e-05, 1, 0.000180304938, -0.996257842, -5.30608231e-05, -0.0864315033)
			CFrameQuest = CFrame.new(897.031128, 6.43846416, 4388.97168, -0.804044724, 3.68233266e-08, 0.594568789, 6.97835176e-08, 1, 3.24365246e-08, -0.594568789, 6.75715199e-08, -0.804044724)
			CFrameMon = CFrame.new(1617.07886, 1.5542295, 4295.54932, -0.997540116, -2.26287735e-08, -0.070099175, -1.69377223e-08, 1, -8.17798806e-08, 0.070099175, -8.03913949e-08, -0.997540116)
			if _G.AutoFarm and (CFrameMon.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude > 1000 then
				game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = ISLANDPOS
			end
		elseif MyLevel == 90 or MyLevel <= 99 then -- Snow Bandits
			Ms = "Snow Bandit [Lv. 90]"
			NaemQuest = "SnowQuest"
			LevelQuest = 1
			NameMon = "Snow Bandits"
			ISLANDPOS = CFrame.new(1336.02625, 34.1970673, -1331.23267, 0.671367824, 0.741124272, -1.77025795e-05, 1.77025795e-05, -3.9935112e-05, -1, -0.741124272, 0.671367764, -3.9935112e-05)
			CFrameQuest = CFrame.new(1384.14001, 87.272789, -1297.06482, 0.348555952, -2.53947841e-09, -0.937287986, 1.49860568e-08, 1, 2.86358204e-09, 0.937287986, -1.50443711e-08, 0.348555952)
			CFrameMon = CFrame.new(1328.92578, 87.6160507, -1374.14551, -0.548407137, 5.60746427e-09, 0.836211503, 2.07008033e-09, 1, -5.34818945e-09, -0.836211503, -1.2019602e-09, -0.548407137)
			if _G.AutoFarm and (CFrameMon.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude > 1000 then
				game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = ISLANDPOS
			end
		elseif MyLevel == 100 or MyLevel <= 119 then -- Snowman
			Ms = "Snowman [Lv. 100]"
			NaemQuest = "SnowQuest"
			LevelQuest = 2
			NameMon = "Snowman"
			ISLANDPOS = CFrame.new(1336.02625, 34.1970673, -1331.23267, 0.671367824, 0.741124272, -1.77025795e-05, 1.77025795e-05, -3.9935112e-05, -1, -0.741124272, 0.671367764, -3.9935112e-05)
			CFrameQuest = CFrame.new(1384.14001, 87.272789, -1297.06482, 0.348555952, -2.53947841e-09, -0.937287986, 1.49860568e-08, 1, 2.86358204e-09, 0.937287986, -1.50443711e-08, 0.348555952)
			CFrameMon = CFrame.new(1046.19983, 106.109909, -1486.0741, 0.455472827, -1.03902529e-07, -0.89024967, 1.33861127e-08, 1, -1.09863016e-07, 0.89024967, 3.81226357e-08, 0.455472827)
			if _G.AutoFarm and (CFrameMon.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude > 1000 then
				game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = ISLANDPOS
			end
		elseif MyLevel == 120 or MyLevel <= 149 then -- Chief Petty Officer
			Ms = "Chief Petty Officer [Lv. 120]"
			NaemQuest = "MarineQuest2"
			LevelQuest = 1
			NameMon = "Chief Petty Officer"
			ISLANDPOS = CFrame.new(-5138.81104, 23.1043854, 4103.9624, -0.499959469, 0, 0.866048813, 0, 1, 0, -0.866048813, 0, -0.499959469)
			CFrameQuest = CFrame.new(-5035.0835, 28.6520386, 4325.29443, 0.0243340395, -7.08064647e-08, 0.999703884, -6.36926814e-08, 1, 7.23777944e-08, -0.999703884, -6.54350671e-08, 0.0243340395)
			CFrameMon = CFrame.new(-4850.8623, 21.0520386, 4390.53516, 0.273695946, -5.40380647e-08, -0.96181643, 4.37720793e-08, 1, -4.37274998e-08, 0.96181643, -3.01326679e-08, 0.273695946)
			if _G.AutoFarm and (CFrameMon.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude > 1000 then
				game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = ISLANDPOS
			end
		elseif MyLevel == 150 or MyLevel <= 174 then -- Sky Bandit
			Ms = "Sky Bandit [Lv. 150]"
			NaemQuest = "SkyQuest"
			LevelQuest = 1
			NameMon = "Sky Bandit"
			ISLANDPOS = CFrame.new(-4899.46777, 723.834229, -2575.20142, 0.933587551, 0, 0.358349502, 0, -1.00000048, 0, 0.358349502, 0, -0.933587909)
			CFrameQuest = CFrame.new(-4841.83447, 717.669617, -2623.96436, -0.875942111, 5.59710216e-08, -0.482416272, 3.04023082e-08, 1, 6.08195947e-08, 0.482416272, 3.86078725e-08, -0.875942111)
			CFrameMon = CFrame.new(-4996.53906, 278.410187, -2828.92822, -0.984909654, 0, 0.173069984, 0, 1, 0, -0.173069984, 0, -0.984909654)
			if _G.AutoFarm and (CFrameMon.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude > 1000 then
				game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = ISLANDPOS
			end
		elseif MyLevel == 175 or MyLevel <= 249 then 
			Ms = "Dark Master [Lv. 175]"
			NaemQuest = "SkyQuest"
			LevelQuest = 2
			NameMon = "Dark Master"
			ISLANDPOS = CFrame.new(-4899.46777, 723.834229, -2575.20142, 0.933587551, 0, 0.358349502, 0, -1.00000048, 0, 0.358349502, 0, -0.933587909)
			CFrameQuest = CFrame.new(-4841.83447, 717.669617, -2623.96436)
			CFrameMon = CFrame.new(-5220.58594, 430.693298, -2278.17456)
			if _G.AutoFarm and (CFrameMon.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude > 1000 then
				game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = ISLANDPOS
			end
		elseif MyLevel == 250 or MyLevel <= 274 then 
			Ms = "Toga Warrior [Lv. 250]"
			NaemQuest = "ColosseumQuest"
			LevelQuest = 1
			NameMon = "Toga Warrior"
			ISLANDPOS = CFrame.new(-1690.47278, 10.2532501, -3086.04272, 0.74314785, -0, -0.669127226, 0, 1, -0, 0.669127226, 0, 0.74314785)
			CFrameQuest = CFrame.new(-1576.11743, 7.38933945, -2983.30762)
			CFrameMon = CFrame.new(-1779.97583, 44.6077499, -2736.35474)
			if _G.AutoFarm and (CFrameMon.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude > 1000 then
				game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = ISLANDPOS
			end
		elseif MyLevel == 275 or MyLevel <= 299 then -- Gladiato
			Ms = "Gladiator [Lv. 275]"
			NaemQuest = "ColosseumQuest"
			LevelQuest = 2
			NameMon = "Gladiato"
			ISLANDPOS = CFrame.new(-1690.47278, 10.2532501, -3086.04272, 0.74314785, -0, -0.669127226, 0, 1, -0, 0.669127226, 0, 0.74314785)
			CFrameQuest = CFrame.new(-1576.11743, 7.38933945, -2983.30762, 0.576966345, 1.22114863e-09, 0.816767931, -3.58496594e-10, 1, -1.24185606e-09, -0.816767931, 4.2370063e-10, 0.576966345)
			CFrameMon = CFrame.new(-1279.38416, 7.78580666, -3268.23047, -0.385674238, -3.25503358e-08, -0.922634542, 5.95089811e-10, 1, -3.55285259e-08, 0.922634542, -1.42514862e-08, -0.385674238)
			if _G.AutoFarm and (CFrameMon.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude > 1000 then
				game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = ISLANDPOS
			end
		elseif MyLevel == 300 or MyLevel <= 324 then -- Military Soldier
			Ms = "Military Soldier [Lv. 300]"
			NaemQuest = "MagmaQuest"
			LevelQuest = 1
			NameMon = "Military Soldier"
			ISLANDPOS = CFrame.new(-5213.3374, 3.3397336, 8443.05957, 0.927179396, 0, 0.374617696, 0, 1, 0, -0.374617696, 0, 0.927179396)
			CFrameQuest = CFrame.new(-5316.55859, 12.2370615, 8517.2998, 0.588437557, -1.37880001e-08, -0.808542669, -2.10116209e-08, 1, -3.23446478e-08, 0.808542669, 3.60215964e-08, 0.588437557)
			CFrameMon = CFrame.new(-5483.29248, 9.33393669, 8413.07031, 0.909917235, -1.46153933e-09, -0.414789826, -6.77904288e-10, 1, -5.01067277e-09, 0.414789826, 4.84048535e-09, 0.909917235)
			if _G.AutoFarm and (CFrameMon.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude > 1000 then
				game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = ISLANDPOS
			end
		elseif MyLevel == 325 or MyLevel <= 374 then -- Military Spy
			Ms = "Military Spy [Lv. 325]"
			NaemQuest = "MagmaQuest"
			LevelQuest = 2
			NameMon = "Military Spy"
			ISLANDPOS = CFrame.new(-5213.3374, 3.3397336, 8443.05957, 0.927179396, 0, 0.374617696, 0, 1, 0, -0.374617696, 0, 0.927179396)
			CFrameQuest = CFrame.new(-5316.55859, 12.2370615, 8517.2998, 0.588437557, -1.37880001e-08, -0.808542669, -2.10116209e-08, 1, -3.23446478e-08, 0.808542669, 3.60215964e-08, 0.588437557)
			CFrameMon = CFrame.new(-5883.50049, 77.5739212, 8823.88965, 0.983678341, -1.19359456e-08, 0.179935962, -8.52669757e-09, 1, 1.12948371e-07, -0.179935962, -1.12639128e-07, 0.983678341)
			if _G.AutoFarm and (CFrameMon.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude > 1000 then
				game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = ISLANDPOS
			end
		elseif MyLevel == 375 or MyLevel <= 399 then -- Fishman Warrior
			Ms = "Fishman Warrior [Lv. 375]"
			NaemQuest = "FishmanQuest"
			LevelQuest = 1
			NameMon = "Fishman Warrior"
			CFrameQuest = CFrame.new(61122.5625, 18.4716396, 1568.16504, 0.893533468, 3.95251609e-09, 0.448996574, -2.34327455e-08, 1, 3.78297464e-08, -0.448996574, -4.43233645e-08, 0.893533468)
			CFrameMon = CFrame.new(60889.6328, 18.8148994, 1432.98425, 0.345049709, 0, -0.938584328, 0, 1, 0, 0.938584328, 0, 0.345049709)
			if _G.AutoFarm and (CFrameMon.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude > 3000 then
				game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("requestEntrance",Vector3.new(61163.8515625, 11.6796875, 1819.7841796875))
			end
		elseif MyLevel == 400 or MyLevel <= 449 then -- Fishman Commando
			Ms = "Fishman Commando [Lv. 400]"
			NaemQuest = "FishmanQuest"
			LevelQuest = 2
			NameMon = "Fishman Commando"
			CFrameQuest = CFrame.new(61122.5625, 18.4716396, 1568.16504, 0.893533468, 3.95251609e-09, 0.448996574, -2.34327455e-08, 1, 3.78297464e-08, -0.448996574, -4.43233645e-08, 0.893533468)
			CFrameMon = CFrame.new(61885.5039, 18.4828243, 1504.17896, 0.577502489, 0, -0.816389024, -0, 1.00000012, -0, 0.816389024, 0, 0.577502489)
			if _G.AutoFarm and (CFrameMon.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude > 3000 then
				game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("requestEntrance",Vector3.new(61163.8515625, 11.6796875, 1819.7841796875))
			end
		elseif MyLevel == 450 or MyLevel <= 474 then -- God's Guards
			Ms = "God's Guard [Lv. 450]"
			NaemQuest = "SkyExp1Quest"
			LevelQuest = 1
			NameMon = "God's Guards"
			CFrameQuest = CFrame.new(-4721.71436, 845.277161, -1954.20105, -0.999277651, -5.56969759e-09, 0.0380011722, -4.14751478e-09, 1, 3.75035256e-08, -0.0380011722, 3.73188307e-08, -0.999277651)
			CFrameMon = CFrame.new(-4720.3291, 845.620422, -1859.63074, 0.712942302, 0, -0.701222718, -0, 1, -0, 0.701222718, 0, 0.712942302)
			if _G.AutoFarm and (CFrameMon.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude > 1000 then
				game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("requestEntrance",Vector3.new(-4607.82275, 872.54248, -1667.55688))
			end
		elseif MyLevel == 475 or MyLevel <= 524 then -- Shandas
			Ms = "Shanda [Lv. 475]"
			NaemQuest = "SkyExp1Quest"
			LevelQuest = 2
			NameMon = "Shandas"
			CFrameQuest = CFrame.new(-7863.63672, 5545.49316, -379.826324, 0.362120807, -1.98046344e-08, -0.93213129, 4.05822291e-08, 1, -5.48095125e-09, 0.93213129, -3.58431969e-08, 0.362120807)
			CFrameMon = CFrame.new(-7636.17285, 5545.83643, -551.851685, 0.995675743, 0, -0.0928966552, 0, 1, 0, 0.0928966552, 0, 0.995675743)
			if _G.AutoFarm and (CFrameMon.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude > 1000 then
				game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("requestEntrance",Vector3.new(-7894.6176757813, 5547.1416015625, -380.29119873047))
			end
		elseif MyLevel == 525 or MyLevel <= 549 then -- Royal Squad
			Ms = "Royal Squad [Lv. 525]"
			NaemQuest = "SkyExp2Quest"
			LevelQuest = 1
			NameMon = "Royal Squad"
			CFrameQuest = CFrame.new(-7902.66895, 5635.96387, -1411.71802, 0.0504222959, 2.5710392e-08, 0.998727977, 1.12541557e-07, 1, -3.14249675e-08, -0.998727977, 1.13982921e-07, 0.0504222959)
			CFrameMon = CFrame.new(-7654.80615, 5607.22168, -1497.61304, 0.655299842, -1.01422131e-07, -0.75536871, 8.79199114e-09, 1, -1.26641098e-07, 0.75536871, 7.63466659e-08, 0.655299842)
			if _G.AutoFarm and (CFrameMon.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude > 1000 then
				game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("requestEntrance",Vector3.new(-7894.6176757813, 5547.1416015625, -380.29119873047))
			end
		elseif MyLevel == 550 or MyLevel <= 624 then -- Royal Soldier
			Ms = "Royal Soldier [Lv. 550]"
			NaemQuest = "SkyExp2Quest"
			LevelQuest = 2
			NameMon = "Royal Soldier"
			CFrameQuest = CFrame.new(-7902.66895, 5635.96387, -1411.71802, 0.0504222959, 2.5710392e-08, 0.998727977, 1.12541557e-07, 1, -3.14249675e-08, -0.998727977, 1.13982921e-07, 0.0504222959)
			CFrameMon = CFrame.new(-7966.58252, 5637.42529, -1744.18347, 0.116254926, -8.58390649e-07, -0.99321878, 2.4797064e-08, 1, -8.61348838e-07, 0.99321878, 7.55070602e-08, 0.116254926)
			if _G.AutoFarm and (CFrameMon.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude > 1000 then
				game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("requestEntrance",Vector3.new(-7894.6176757813, 5547.1416015625, -380.29119873047))
			end
		elseif MyLevel == 625 or MyLevel <= 649 then -- Galley Pirate
			Ms = "Galley Pirate [Lv. 625]"
			NaemQuest = "FountainQuest"
			LevelQuest = 1
			NameMon = "Galley Pirate"
			ISLANDPOS = CFrame.new(5454.30957, 136.634079, 4622.60059, 0.74314785, 0, -0.669127226, 0, -1, -0, -0.669127226, 0, -0.74314785)
			CFrameQuest = CFrame.new(5254.60156, 38.5011406, 4049.69678, -0.0504891425, -3.62066501e-08, -0.998724639, -9.87921389e-09, 1, -3.57534553e-08, 0.998724639, 8.06145284e-09, -0.0504891425)
			CFrameMon = CFrame.new(5684.73096, 38.8443985, 3927.60498, 0.999752343, -6.81844494e-06, -0.0222478025, 5.87542536e-06, 1, -4.24524987e-05, 0.0222478025, 4.2311276e-05, 0.999752343)
			if _G.AutoFarm and (CFrameMon.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude > 1000 then
				game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = ISLANDPOS
			end
		elseif MyLevel >= 650 then -- Galley Captain
			Ms = "Galley Captain [Lv. 650]"
			NaemQuest = "FountainQuest"
			LevelQuest = 2
			NameMon = "Galley Captain"
			ISLANDPOS = CFrame.new(5454.30957, 136.634079, 4622.60059, 0.74314785, 0, -0.669127226, 0, -1, -0, -0.669127226, 0, -0.74314785)
			CFrameQuest = CFrame.new(5254.60156, 38.5011406, 4049.69678, -0.0504891425, -3.62066501e-08, -0.998724639, -9.87921389e-09, 1, -3.57534553e-08, 0.998724639, 8.06145284e-09, -0.0504891425)
			CFrameMon = CFrame.new(5658.5752, 38.5361786, 4928.93506, -0.996873081, 2.12391046e-06, -0.0790185928, 2.16989656e-06, 1, -4.96097414e-07, 0.0790185928, -6.66008248e-07, -0.996873081)
			if _G.AutoFarm and (CFrameMon.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude > 1000 then
				game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = ISLANDPOS
			end
		end
	end
	
	if NewWorld then
		Nonquest = false
		if MyLevel == 700 or MyLevel <= 724 then -- Raider [Lv. 700]
			Ms = "Raider [Lv. 700]"
			NaemQuest = "Area1Quest"
			LevelQuest = 1
			NameMon = "Raider"
			CFrameQuest = CFrame.new(-429.543518, 71.7699966, 1836.18188, -0.22495985, 0, -0.974368095, 0, 1, 0, 0.974368095, 0, -0.22495985)
			CFrameMon = CFrame.new(-737.026123, 10.1748352, 2392.57959, 0.272128761, 0, -0.962260842, -0, 1, -0, 0.962260842, 0, 0.272128761)
		elseif MyLevel == 725 or MyLevel <= 774 then -- Mercenary [Lv. 725]
			Ms = "Mercenary [Lv. 725]"
			NaemQuest = "Area1Quest"
			LevelQuest = 2
			NameMon = "Mercenary"
			CFrameQuest = CFrame.new(-429.543518, 71.7699966, 1836.18188, -0.22495985, 0, -0.974368095, 0, 1, 0, 0.974368095, 0, -0.22495985)
			CFrameMon = CFrame.new(-1022.21271, 72.9855194, 1891.39148, -0.990782857, 0, -0.135460541, 0, 1, 0, 0.135460541, 0, -0.990782857)
		elseif MyLevel == 775 or MyLevel <= 799 then -- Swan Pirate [Lv. 775]
			Ms = "Swan Pirate [Lv. 775]"
			NaemQuest = "Area2Quest"
			LevelQuest = 1
			NameMon = "Swan Pirate"
			CFrameQuest = CFrame.new(638.43811, 71.769989, 918.282898, 0.139203906, 0, 0.99026376, 0, 1, 0, -0.99026376, 0, 0.139203906)
			CFrameMon = CFrame.new(976.467651, 111.174057, 1229.1084, 0.00852567982, -4.73897828e-08, -0.999963999, 1.12251888e-08, 1, -4.7295778e-08, 0.999963999, -1.08215579e-08, 0.00852567982)
		elseif MyLevel == 800 or MyLevel <= 874 then -- Factory Staff [Lv. 800]
			Ms = "Factory Staff [Lv. 800]"
			NaemQuest = "Area2Quest"
			LevelQuest = 2
			NameMon = "Factory Staff"
			CFrameQuest = CFrame.new(638.43811, 71.769989, 918.282898, 0.139203906, 0, 0.99026376, 0, 1, 0, -0.99026376, 0, 0.139203906)
			CFrameMon = CFrame.new(336.74585, 73.1620483, -224.129272, 0.993632793, 3.40154607e-08, 0.112668738, -3.87658332e-08, 1, 3.99718729e-08, -0.112668738, -4.40850592e-08, 0.993632793)
		elseif MyLevel == 875 or MyLevel <= 899 then -- Marine Lieutenant [Lv. 875]
			Ms = "Marine Lieutenant [Lv. 875]"
			NaemQuest = "MarineQuest3"
			LevelQuest = 1
			NameMon = "Marine Lieutenant"
			CFrameQuest = CFrame.new(-2440.79639, 71.7140732, -3216.06812, 0.866007268, 0, 0.500031412, 0, 1, 0, -0.500031412, 0, 0.866007268)
			CFrameMon = CFrame.new(-2842.69922, 72.9919434, -2901.90479, -0.762281299, 0, -0.64724648, 0, 1.00000012, 0, 0.64724648, 0, -0.762281299)
		elseif MyLevel == 900 or MyLevel <= 949 then -- Marine Captain [Lv. 900]
			Ms = "Marine Captain [Lv. 900]"
			NaemQuest = "MarineQuest3"
			LevelQuest = 2
			NameMon = "Marine Captain"
			CFrameQuest = CFrame.new(-2440.79639, 71.7140732, -3216.06812, 0.866007268, 0, 0.500031412, 0, 1, 0, -0.500031412, 0, 0.866007268)
			CFrameMon = CFrame.new(-1814.70313, 72.9919434, -3208.86621, -0.900422215, 7.93464423e-08, -0.435017526, 3.68856199e-08, 1, 1.06050372e-07, 0.435017526, 7.94441988e-08, -0.900422215)
		elseif MyLevel == 950 or MyLevel <= 974 then -- Zombie [Lv. 950]
			Ms = "Zombie [Lv. 950]"
			NaemQuest = "ZombieQuest"
			LevelQuest = 1
			NameMon = "Zombie"
			CFrameQuest = CFrame.new(-5497.06152, 47.5923004, -795.237061, -0.29242146, 0, -0.95628953, 0, 1, 0, 0.95628953, 0, -0.29242146)
			CFrameMon = CFrame.new(-5649.23438, 126.0578, -737.773743, 0.355238914, -8.10359282e-08, 0.934775114, 1.65461245e-08, 1, 8.04023372e-08, -0.934775114, -1.3095117e-08, 0.355238914)
		elseif MyLevel == 975 or MyLevel <= 999 then -- Vampire [Lv. 975]
			Ms = "Vampire [Lv. 975]"
			NaemQuest = "ZombieQuest"
			LevelQuest = 2
			NameMon = "Vampire"
			CFrameQuest = CFrame.new(-5497.06152, 47.5923004, -795.237061, -0.29242146, 0, -0.95628953, 0, 1, 0, 0.95628953, 0, -0.29242146)
			CFrameMon = CFrame.new(-6030.32031, 0.4377408, -1313.5564, -0.856965423, 3.9138893e-08, -0.515373945, -1.12178942e-08, 1, 9.45958547e-08, 0.515373945, 8.68467822e-08, -0.856965423)
		elseif MyLevel == 1000 or MyLevel <= 1049 then -- Snow Trooper [Lv. 1000] **
			Ms = "Snow Trooper [Lv. 1000]"
			NaemQuest = "SnowMountainQuest"
			LevelQuest = 1
			NameMon = "Snow Trooper"
			CFrameQuest = CFrame.new(609.858826, 400.119904, -5372.25928, -0.374604106, 0, 0.92718488, 0, 1, 0, -0.92718488, 0, -0.374604106)
			CFrameMon = CFrame.new(621.003418, 391.361053, -5335.43604, 0.481644779, 0, 0.876366913, 0, 1, 0, -0.876366913, 0, 0.481644779)
		elseif MyLevel == 1050 or MyLevel <= 1099 then -- Winter Warrior [Lv. 1050]
			Ms = "Winter Warrior [Lv. 1050]"
			NaemQuest = "SnowMountainQuest"
			LevelQuest = 2
			NameMon = "Winter Warrior"
			CFrameQuest = CFrame.new(609.858826, 400.119904, -5372.25928, -0.374604106, 0, 0.92718488, 0, 1, 0, -0.92718488, 0, -0.374604106)
			CFrameMon = CFrame.new(1295.62683, 429.447784, -5087.04492, -0.698032081, -8.28980049e-08, -0.71606636, -1.98835952e-08, 1, -9.63858184e-08, 0.71606636, -5.30424877e-08, -0.698032081)
		elseif MyLevel == 1100 or MyLevel <= 1124 then -- Lab Subordinate [Lv. 1100]
			Ms = "Lab Subordinate [Lv. 1100]"
			NaemQuest = "IceSideQuest"
			LevelQuest = 1
			NameMon = "Lab Subordinate"
			CFrameQuest = CFrame.new(-6064.06885, 15.2422857, -4902.97852, 0.453972578, -0, -0.891015649, 0, 1, -0, 0.891015649, 0, 0.453972578)
			CFrameMon = CFrame.new(-5769.2041, 37.9288292, -4468.38721, -0.569419742, -2.49055017e-08, 0.822046936, -6.96206541e-08, 1, -1.79282633e-08, -0.822046936, -6.74401548e-08, -0.569419742)
		elseif MyLevel == 1125 or MyLevel <= 1174 then -- Horned Warrior [Lv. 1125]
			Ms = "Horned Warrior [Lv. 1125]"
			NaemQuest = "IceSideQuest"
			LevelQuest = 2
			NameMon = "Horned Warrior"
			CFrameQuest = CFrame.new(-6064.06885, 15.2422857, -4902.97852, 0.453972578, -0, -0.891015649, 0, 1, -0, 0.891015649, 0, 0.453972578)
			CFrameMon = CFrame.new(-6401.27979, 15.9775667, -5948.24316, 0.388303697, 0, -0.921531856, 0, 1, 0, 0.921531856, 0, 0.388303697)
		elseif MyLevel == 1175 or MyLevel <= 1199 then -- Magma Ninja [Lv. 1175]
			Ms = "Magma Ninja [Lv. 1175]"
			NaemQuest = "FireSideQuest"
			LevelQuest = 1
			NameMon = "Magma Ninja"
			CFrameQuest = CFrame.new(-5428.03174, 15.0622921, -5299.43457, -0.882952213, 0, 0.469463557, 0, 1, 0, -0.469463557, 0, -0.882952213)
			CFrameMon = CFrame.new(-5466.06445, 57.6952019, -5837.42822, -0.988835871, 0, -0.149006829, 0, 1, 0, 0.149006829, 0, -0.988835871)
		elseif MyLevel == 1200 or MyLevel <= 1249 then 
			Ms = "Lava Pirate [Lv. 1200]"
			NaemQuest = "FireSideQuest"
			LevelQuest = 2
			NameMon = "Lava Pirate"
			CFrameQuest = CFrame.new(-5431.09473, 15.9868021, -5296.53223, 0.831796765, 1.15322464e-07, -0.555080295, -1.10814341e-07, 1, 4.17010995e-08, 0.555080295, 2.68240168e-08, 0.831796765)
			CFrameMon = CFrame.new(-5169.71729, 34.1234779, -4669.73633, -0.196780294, 0, 0.98044765, 0, 1.00000012, -0, -0.98044765, 0, -0.196780294)
		elseif MyLevel == 1250 or MyLevel <= 1274 then 
			Ms = "Ship Deckhand [Lv. 1250]"
			NaemQuest = "ShipQuest1"
			LevelQuest = 1
			NameMon = "Ship Deckhand"
			CFrameQuest = CFrame.new(1037.80127, 125.092171, 32911.6016, -0.244533166, -0, -0.969640911, -0, 1.00000012, -0, 0.96964103, 0, -0.244533136)
			CFrameMon = CFrame.new(1163.80872, 138.288452, 33058.4258, -0.998580813, 5.49076979e-08, -0.0532564968, 5.57436763e-08, 1, -1.42118655e-08, 0.0532564968, -1.71604082e-08, -0.998580813)
		elseif MyLevel == 1275 or MyLevel <= 1299 then 
			Ms = "Ship Engineer [Lv. 1275]"
			NaemQuest = "ShipQuest1"
			LevelQuest = 2
			NameMon = "Ship Engineer"
			CFrameQuest = CFrame.new(1037.80127, 125.092171, 32911.6016, -0.244533166, -0, -0.969640911, -0, 1.00000012, -0, 0.96964103, 0, -0.244533136)
			CFrameMon = CFrame.new(921.30249023438, 125.400390625, 32937.34375)
		elseif MyLevel == 1300 or MyLevel <= 1324 then 
			Ms = "Ship Steward [Lv. 1300]"
			NaemQuest = "ShipQuest2"
			LevelQuest = 1
			NameMon = "Ship Steward"
			CFrameQuest = CFrame.new(968.80957, 125.092171, 33244.125, -0.869560242, 1.51905191e-08, -0.493826836, 1.44108379e-08, 1, 5.38534195e-09, 0.493826836, -2.43357912e-09, -0.869560242)
			CFrameMon = CFrame.new(917.96057128906, 136.89932250977, 33343.4140625)
		elseif MyLevel == 1325 or MyLevel <= 1349 then 
			Ms = "Ship Officer [Lv. 1325]"
			NaemQuest = "ShipQuest2"
			LevelQuest = 2
			NameMon = "Ship Officer"
			CFrameQuest = CFrame.new(968.80957, 125.092171, 33244.125, -0.869560242, 1.51905191e-08, -0.493826836, 1.44108379e-08, 1, 5.38534195e-09, 0.493826836, -2.43357912e-09, -0.869560242)
			CFrameMon = CFrame.new(944.44964599609, 181.40081787109, 33278.9453125)
		elseif MyLevel == 1350 or MyLevel <= 1374 then 
			Ms = "Arctic Warrior [Lv. 1350]"
			NaemQuest = "FrostQuest"
			LevelQuest = 1
			NameMon = "Arctic Warrior"
			CFrameQuest = CFrame.new(5667.6582, 26.7997818, -6486.08984, -0.933587909, 0, -0.358349502, 0, 1, 0, 0.358349502, 0, -0.933587909)
			CFrameMon = CFrame.new(5878.23486, 81.3886948, -6136.35596, -0.451037169, 2.3908234e-07, 0.892505825, -1.08168464e-07, 1, -3.22542007e-07, -0.892505825, -2.4201924e-07, -0.451037169)
		elseif MyLevel == 1375 or MyLevel <= 1424 then -- Snow Lurker [Lv. 1375]
			Ms = "Snow Lurker [Lv. 1375]"
			NaemQuest = "FrostQuest"
			LevelQuest = 2
			NameMon = "Snow Lurker"
			CFrameQuest = CFrame.new(5667.6582, 26.7997818, -6486.08984, -0.933587909, 0, -0.358349502, 0, 1, 0, 0.358349502, 0, -0.933587909)
			CFrameMon = CFrame.new(5513.36865, 60.546711, -6809.94971, -0.958693981, -1.65617333e-08, 0.284439981, -4.07668654e-09, 1, 4.44854642e-08, -0.284439981, 4.14883701e-08, -0.958693981)
		elseif MyLevel == 1425 or MyLevel <= 1449 then -- Sea Soldier [Lv. 1425]
			Ms = "Sea Soldier [Lv. 1425]"
			NaemQuest = "ForgottenQuest"
			LevelQuest = 1
			NameMon = "Sea Soldier"
			CFrameQuest = CFrame.new(-3054.44458, 235.544281, -10142.8193, 0.990270376, -0, -0.13915664, 0, 1, -0, 0.13915664, 0, 0.990270376)
			CFrameMon = CFrame.new(-3115.78223, 63.8785706, -9808.38574, -0.913427353, 3.11199457e-08, 0.407000452, 7.79564235e-09, 1, -5.89660658e-08, -0.407000452, -5.06883708e-08, -0.913427353)
		elseif MyLevel >= 1450 then -- Water Fighter [Lv. 1450]
			Ms = "Water Fighter [Lv. 1450]"
			NaemQuest = "ForgottenQuest"
			LevelQuest = 2
			NameMon = "Water Fighter"
			CFrameQuest = CFrame.new(-3054.44458, 235.544281, -10142.8193, 0.990270376, -0, -0.13915664, 0, 1, -0, 0.13915664, 0, 0.990270376)
			CFrameMon = CFrame.new(-3212.99683, 263.809296, -10551.8799, 0.742111444, -5.59139615e-08, -0.670276582, 1.69155214e-08, 1, -6.46908234e-08, 0.670276582, 3.66697037e-08, 0.742111444)
		end
	end
	--w3q
	if ThreeWorld then
		if MyLevel == 1500 or MyLevel <= 1524 then
			Ms = "Pirate Millionaire [Lv. 1500]"
			NaemQuest = "PiratePortQuest"
			LevelQuest = 1
			NameMon = "Pirate Millionaire"
			ISLANDPOS = CFrame.new(-627.095825, 68.8230591, 5444.96973, 1.2755394e-05, 0.965938866, 0.258770198, -0.99999994, 1.2755394e-05, 1.66893005e-06, -1.66893005e-06, -0.258770198, 0.965938926)
			CFrameQuest = CFrame.new(-288.5224, 43.8218307, 5580.43408, -0.999959528, -8.31576159e-08, 0.0089966096, -8.37007832e-08, 1, -5.99984915e-08, -0.0089966096, -6.07490875e-08, -0.999959528)
			CFrameMon = CFrame.new(-30.9287148, 44.1632271, 5626.03564, -0.984395564, 6.69860825e-08, 0.175970018, 6.64483224e-08, 1, -8.94841801e-09, -0.175970018, 2.88413116e-09, -0.984395564)
			if _G.AutoFarm and (CFrameMon.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude > 3000 then
				game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = ISLANDPOS
			end
		elseif MyLevel == 1525 or MyLevel <= 1624 then
			Ms = "Pistol Billionaire [Lv. 1525]"
			NaemQuest = "PiratePortQuest"
			LevelQuest = 2
			NameMon = "Pistol Billionaire"
			ISLANDPOS = CFrame.new(-627.095825, 68.8230591, 5444.96973, 1.2755394e-05, 0.965938866, 0.258770198, -0.99999994, 1.2755394e-05, 1.66893005e-06, -1.66893005e-06, -0.258770198, 0.965938926)
			CFrameQuest = CFrame.new(-288.5224, 43.8218307, 5580.43408, -0.999959528, -8.31576159e-08, 0.0089966096, -8.37007832e-08, 1, -5.99984915e-08, -0.0089966096, -6.07490875e-08, -0.999959528)
			CFrameMon = CFrame.new(-27.2507839, 73.7850037, 6110.73438, 0.94821614, 2.10991633e-08, -0.317625821, -1.09169083e-08, 1, 3.3837221e-08, 0.317625821, -2.86175066e-08, 0.94821614)
			if _G.AutoFarm and (CFrameMon.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude > 3000 then
				game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = ISLANDPOS
			end
		elseif MyLevel == 1625 or MyLevel <= 1649 then
			Ms = "Female Islander [Lv. 1625]"
			NaemQuest = "AmazonQuest2"
			LevelQuest = 1
			NameMon = "Female Islander"
			ISLANDPOS = CFrame.new(5406.33643, 655.403625, 594.461853, -0.417002439, -0.417307526, -0.807442605, -0.388651222, 0.884923458, -0.256633431, 0.821619928, 0.206796795, -0.531202316)
			CFrameQuest = CFrame.new(5447.18555, 601.684814, 750.161804, -0.0492943414, 5.47278347e-08, -0.998784304, 1.11371856e-10, 1, 5.4788952e-08, 0.998784304, 2.5895488e-09, -0.0492943414)
			CFrameMon = CFrame.new(5635.42676, 782.124878, 857.546997, -0.990593493, 2.96959286e-07, 0.136837229, 1.91843185e-07, 1, -7.81369522e-07, -0.136837229, -7.47768354e-07, -0.990593493)
			if _G.AutoFarm and (CFrameMon.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude > 3000 then
				game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = ISLANDPOS
			end
		elseif MyLevel == 1650 or MyLevel <= 1724 then
			Ms = "Giant Islander [Lv. 1650]"
			NaemQuest = "AmazonQuest2"
			LevelQuest = 2
			NameMon = "Giant Islander"
			ISLANDPOS = CFrame.new(5406.33643, 655.403625, 594.461853, -0.417002439, -0.417307526, -0.807442605, -0.388651222, 0.884923458, -0.256633431, 0.821619928, 0.206796795, -0.531202316)
			CFrameQuest = CFrame.new(5447.18555, 601.684814, 750.161804, -0.0492943414, 5.47278347e-08, -0.998784304, 1.11371856e-10, 1, 5.4788952e-08, 0.998784304, 2.5895488e-09, -0.0492943414)
			CFrameMon = CFrame.new(4803.53516, 601.884644, 21.1627445, -0.945538223, -9.67994662e-09, -0.3255108, 9.0386223e-09, 1, -5.59929489e-08, 0.3255108, -5.58856534e-08, -0.945538223)
			if _G.AutoFarm and (CFrameMon.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude > 3000 then
				game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = ISLANDPOS
			end
		elseif MyLevel == 1700 or MyLevel <= 1724 then
			Ms = "Marine Commodore [Lv. 1700]"
			NaemQuest = "MarineTreeIsland"
			LevelQuest = 1
			NameMon = "Marine Commodore"
			ISLANDPOS = CFrame.new(2661.02368, 42.0330811, -6470.3667, 0.365655482, 0.720300019, 0.589461029, -0.890152395, 0.455640078, -0.00459471345, -0.271891713, -0.523029923, 0.807783842)
			CFrameQuest = CFrame.new(2181.47559, 29.3805466, -6739.75488, 0.972898781, 3.13111634e-08, -0.231231317, -4.68299923e-08, 1, -6.1625208e-08, 0.231231317, 7.07836563e-08, 0.972898781)
			CFrameMon = CFrame.new(2879.39746, 73.1276932, -7823.78613, 0.987131357, 2.83766557e-08, -0.159911677, -3.10919681e-08, 1, -1.4477993e-08, 0.159911677, 1.92636502e-08, 0.987131357)
			if _G.AutoFarm and (CFrameMon.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude > 3000 then
				game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = ISLANDPOS
			end
		elseif MyLevel >= 1725 and MyLevel <= 1774 then
			Ms = "Marine Rear Admiral [Lv. 1725]"
			NaemQuest = "MarineTreeIsland"
			LevelQuest = 2
			NameMon = "Marine Rear Admiral"
			ISLANDPOS = CFrame.new(2661.02368, 42.0330811, -6470.3667, 0.365655482, 0.720300019, 0.589461029, -0.890152395, 0.455640078, -0.00459471345, -0.271891713, -0.523029923, 0.807783842)
			CFrameQuest = CFrame.new(2180.54126, 27.8156815, -6741.5498, -0.965929747, 0, 0.258804798, 0, 1, 0, -0.258804798, 0, -0.965929747)
			CFrameMon = CFrame.new(3684.00586, 160.514099, -7128.87354, -0.570743263, 0, 0.821128547, 0, 1, -0, -0.821128547, 0, -0.570743)
			if _G.AutoFarm and (CFrameMon.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude > 3000 then
				game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = ISLANDPOS
			end
		elseif MyLevel >= 1775 and MyLevel <= 1799 then
			Ms = "Fishman Raider [Lv. 1775]"
			NaemQuest = "DeepForestIsland3"
			LevelQuest = 1
			NameMon = "Fishman Raider"
			ISLANDPOS = CFrame.new(-11478.541, 333.637207, -10379.043, 0.939700544, -0, -0.341998369, 0, 1, -0, 0.341998369, 0, 0.939700544)
			CFrameQuest = CFrame.new(-10581.6563, 330.872955, -8761.18652, -0.882952213, 0, 0.469463557, 0, 1, 0, -0.469463557, 0, -0.882952213)
			CFrameMon = CFrame.new(-10364.5967, 332.095978, -8353.88672, 0.923343658, 1.48868907e-07, -0.383972943, -5.46038343e-08, 1, 2.56400227e-07, 0.383972943, -2.15779068e-07, 0.923343658)
			if _G.AutoFarm and (CFrameMon.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude > 3000 then
				game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = ISLANDPOS
			end
		elseif MyLevel >= 1800 and MyLevel <= 1824 then
			Ms = "Fishman Captain [Lv. 1800]"
			NaemQuest = "DeepForestIsland3"
			LevelQuest = 2
			NameMon = "Fishman Captain"
			ISLANDPOS = CFrame.new(-11478.541, 333.637207, -10379.043, 0.939700544, -0, -0.341998369, 0, 1, -0, 0.341998369, 0, 0.939700544)
			CFrameQuest = CFrame.new(-10581.6563, 330.872955, -8761.18652, -0.882952213, 0, 0.469463557, 0, 1, 0, -0.469463557, 0, -0.882952213)
			CFrameMon = CFrame.new(-10973.4004, 331.752991, -8883.54004, 0.678526163, 1.54081761e-08, 0.734575987, 4.41213963e-08, 1, -6.17304465e-08, -0.734575987, 7.42963024e-08, 0.678526163)
			if _G.AutoFarm and (CFrameMon.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude > 3000 then
				game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = ISLANDPOS
			end
		elseif MyLevel >= 1825 and MyLevel <= 1849 then
			Ms = "Forest Pirate [Lv. 1825]"
			NaemQuest = "DeepForestIsland"
			LevelQuest = 1
			NameMon = "Forest Pirate"
			ISLANDPOS = CFrame.new(-12550.3164, 332.712402, -7492.83398, 1, 0, 0, 0, 1, 0, 0, 0, 1)
			CFrameQuest = CFrame.new(-13234.04, 331.488495, -7625.40137, 0.707134247, -0, -0.707079291, 0, 1, -0, 0.707079291, 0, 0.707134247)
			CFrameMon = CFrame.new(-13594.2119, 332.368225, -7930.59912, 0.955262423, 2.26471002e-08, -0.295761019, -1.30703626e-08, 1, 3.43570647e-08, 0.295761019, -2.89543038e-08, 0.955262423)
			if _G.AutoFarm and (CFrameMon.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude > 3000 then
				game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = ISLANDPOS
			end
		elseif MyLevel == 1850 or MyLevel <= 1899 then
			Ms = "Mythological Pirate [Lv. 1850]"
			NaemQuest = "DeepForestIsland"
			LevelQuest = 2
			NameMon = "Mythological Pirate"
			ISLANDPOS = CFrame.new(-12550.3164, 332.712402, -7492.83398, 1, 0, 0, 0, 1, 0, 0, 0, 1)
			CFrameQuest = CFrame.new(-13230.9658, 332.413177, -7624.93457, 0.455187887, -8.75483792e-08, 0.890395403, -4.99329189e-10, 1, 9.85805499e-08, -0.890395403, -4.53172717e-08, 0.455187887)
			CFrameMon = CFrame.new(-13654.9893, 469.822784, -6970.78369, 0.952340543, 2.57623842e-08, -0.305036813, 8.97913299e-09, 1, 1.1248995e-07, 0.305036813, -1.09867713e-07, 0.952340543)
			if _G.AutoFarm and (CFrameMon.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude > 3000 then
				game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = ISLANDPOS
			end
		elseif MyLevel == 1900 or MyLevel <= 1924 then
			Ms = "Jungle Pirate [Lv. 1900]"
			NaemQuest = "DeepForestIsland2"
			LevelQuest = 1
			NameMon = "Jungle Pirate"
			ISLANDPOS = CFrame.new(-11478.541, 333.637207, -10379.043, 0.939700544, -0, -0.341998369, 0, 1, -0, 0.341998369, 0, 0.939700544)
			CFrameQuest = CFrame.new(-12680.3818, 389.971039, -9902.01953, -0.0871315002, 0, 0.996196866, 0, 1, 0, -0.996196866, 0, -0.0871315002)
			CFrameMon = CFrame.new(-11775.0195, 332.071625, -10628.4648, 0.0879710168, 3.94232338e-05, 0.996122956, 6.06110871e-06, 1, -4.01119505e-05, -0.996122956, 9.56629265e-06, 0.0879710168)
			if _G.AutoFarm and (CFrameMon.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude > 3000 then
				game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = ISLANDPOS
			end
		elseif MyLevel <= 1974 then
			Ms = "Musketeer Pirate [Lv. 1925]"
			NaemQuest = "DeepForestIsland2"
			LevelQuest = 2
			NameMon = "Musketeer Pirate"
			ISLANDPOS = CFrame.new(-11478.541, 333.637207, -10379.043, 0.939700544, -0, -0.341998369, 0, 1, -0, 0.341998369, 0, 0.939700544)
			CFrameQuest = CFrame.new(-12680.3818, 389.971039, -9902.01953, -0.0871315002, 0, 0.996196866, 0, 1, 0, -0.996196866, 0, -0.0871315002)
			CFrameMon = CFrame.new(-13305.2227, 391.878998, -9774.5791, 0.373675853, 1.90769788e-05, 0.927559018, 7.93608251e-07, 1, -2.08865713e-05, -0.927559018, 8.54091832e-06, 0.373675853)
			if _G.AutoFarm and (CFrameMon.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude > 3000 then
				game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = ISLANDPOS
			end
		elseif MyLevel <= 1999 then
			Ms = "Reborn Skeleton [Lv. 1975]"
			NaemQuest = "HauntedQuest1"
			LevelQuest = 1
			NameMon = "Reborn Skeleton"
			ISLANDPOS = CFrame.new(-9538.98145, 140.898499, 5513.27588, 0.998163939, 0, -0.0605702288, 0, 1, 0, 0.0605702288, 0, 0.998163939)
			CFrameQuest = CFrame.new(-9480.87012, 142.43811, 5566.2002, -0.00248356303, -5.78340327e-08, -0.999996901, -2.37339948e-09, 1, -5.78283164e-08, 0.999996901, 2.2297717e-09, -0.00248356303)
			CFrameMon = CFrame.new(-8759.74316, 142.43811, 6018.50879, 0.995956361, 1.53021293e-08, -0.089838393, -1.4131051e-08, 1, 1.3671424e-08, 0.089838393, -1.23466313e-08, 0.995956361)
			if _G.AutoFarm and (CFrameMon.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude > 3000 then
				game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = ISLANDPOS
			end
		elseif MyLevel <= 2024 then
			Ms = "Living Zombie [Lv. 2000]"
			NaemQuest = "HauntedQuest1"
			LevelQuest = 2
			NameMon = "Living Zombie"
			ISLANDPOS = CFrame.new(-9538.98145, 140.898499, 5513.27588, 0.998163939, 0, -0.0605702288, 0, 1, 0, 0.0605702288, 0, 0.998163939)
			CFrameQuest = CFrame.new(-9480.87012, 142.43811, 5566.2002, -0.00248356303, -5.78340327e-08, -0.999996901, -2.37339948e-09, 1, -5.78283164e-08, 0.999996901, 2.2297717e-09, -0.00248356303)
			CFrameMon = CFrame.new(-10147.8926, 139.959961, 5972.49316, 0.917640984, 0.000120363518, -0.397410452, -1.50241667e-05, 0.99999994, 0.000268177944, 0.397410452, -0.000240120396, 0.917640984)
			if _G.AutoFarm and (CFrameMon.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude > 3000 then
				game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = ISLANDPOS
			end
		elseif MyLevel <= 2049 then
			Ms = "Demonic Soul [Lv. 2025]"
			NaemQuest = "HauntedQuest2"
			LevelQuest = 1
			NameMon = "Demonic Soul"
			ISLANDPOS = CFrame.new(-9538.98145, 140.898499, 5513.27588, 0.998163939, 0, -0.0605702288, 0, 1, 0, 0.0605702288, 0, 0.998163939)
			CFrameQuest = CFrame.new(-9514.59668, 172.43811, 6077.85791, -0.025661787, -1.8103858e-08, 0.999670684, -2.63411728e-08, 1, 1.74336368e-08, -0.999670684, -2.58851198e-08, -0.025661787)
			CFrameMon = CFrame.new(-9502.1377, 172.43811, 6153.22559, 0.998965919, 8.14885152e-06, -0.0454591215, -3.61834987e-06, 1, 9.97435855e-05, 0.0454591215, -9.94759685e-05, 0.998965919)
			if _G.AutoFarm and (CFrameMon.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude > 3000 then
				game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = ISLANDPOS
			end
		elseif MyLevel <= 2074 then
			Ms = "Posessed Mummy [Lv. 2050]"
			NaemQuest = "HauntedQuest2"
			LevelQuest = 2
			NameMon = "Posessed Mummy"
			ISLANDPOS = CFrame.new(-9538.98145, 140.898499, 5513.27588, 0.998163939, 0, -0.0605702288, 0, 1, 0, 0.0605702288, 0, 0.998163939)
			CFrameQuest = CFrame.new(-9514.59668, 172.43811, 6077.85791, -0.025661787, -1.8103858e-08, 0.999670684, -2.63411728e-08, 1, 1.74336368e-08, -0.999670684, -2.58851198e-08, -0.025661787)
			CFrameMon = CFrame.new(-9579.89551, 6.1257925, 6194.25684, -0.994989395, -9.60423137e-08, -0.0999803767, -9.48566452e-08, 1, -1.66128302e-08, 0.0999803767, -7.04578706e-09, -0.994989395)
			if _G.AutoFarm and (CFrameMon.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude > 3000 then
				game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = ISLANDPOS
			end
		elseif MyLevel <= 2099 then
			Ms = "Peanut Scout [Lv. 2075]"
			NaemQuest = "NutsIslandQuest"
			LevelQuest = 1
			NameMon = "Peanut Scout"
			ISLANDPOS = CFrame.new(-2120.65259, 42.5805931, -10177.0498, 0.769644201, 0, 0.638473034, 0, 1, 0, -0.638473034, 0, 0.769644201)
			CFrameQuest = CFrame.new(-2105.16504, 38.4474411, -10193.708, 0.786417007, -1.17257759e-08, 0.617695928, -2.06460027e-09, 1, 2.16116245e-08, -0.617695928, -1.82710451e-08, 0.786417007)
			CFrameMon = CFrame.new(-2235.11646, 88.5827332, -10398.1094, -0.832571924, -2.27626842e-07, -0.553917289, -2.47123836e-07, 1, -3.94977633e-08, 0.553917289, 1.04001408e-07, -0.832571924)
			if _G.AutoFarm and (CFrameMon.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude > 3000 then
				game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = ISLANDPOS
			end
		elseif MyLevel <= 2124 then
			Ms = "Peanut President [Lv. 2100]"
			NaemQuest = "NutsIslandQuest"
			LevelQuest = 2
			NameMon = "Peanut President"
			ISLANDPOS = CFrame.new(-2120.65259, 42.5805931, -10177.0498, 0.769644201, 0, 0.638473034, 0, 1, 0, -0.638473034, 0, 0.769644201)
			CFrameQuest = CFrame.new(-2105.16504, 38.4474411, -10193.708, 0.786417007, -1.17257759e-08, 0.617695928, -2.06460027e-09, 1, 2.16116245e-08, -0.617695928, -1.82710451e-08, 0.786417007)
			CFrameMon = CFrame.new(-2235.11646, 88.5827332, -10398.1094, -0.832571924, -2.27626842e-07, -0.553917289, -2.47123836e-07, 1, -3.94977633e-08, 0.553917289, 1.04001408e-07, -0.832571924)
			if _G.AutoFarm and (CFrameMon.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude > 3000 then
				game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = ISLANDPOS
			end
		elseif MyLevel <= 2149 then
			Ms = "Ice Cream Chef [Lv. 2125]"
			NaemQuest = "IceCreamIslandQuest"
			LevelQuest = 1
			NameMon = "Ice Cream Chef"
			ISLANDPOS = CFrame.new(-779.823547, 65.9448471, -10919.1182, -0.786368072, 0, 0.617758334, 0, 1, 0, -0.617758334, 0, -0.786368072)
			CFrameQuest = CFrame.new(-820.017212, 66.1628113, -10965.9189, 0.764226615, 5.82622519e-08, -0.644947827, -5.33253548e-08, 1, 2.71488592e-08, 0.644947827, 1.36441916e-08, 0.764226615)
			CFrameMon = CFrame.new(-830.885742, 144.121704, -11091.0156, -0.329080194, 5.0881642e-08, 0.944301963, 6.449892e-08, 1, -3.14055519e-08, -0.944301963, 5.05715114e-08, -0.329080194)
			if _G.AutoFarm and (CFrameMon.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude > 3000 then
				game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = ISLANDPOS
			end
		elseif MyLevel <= 2199 then 
			Ms = "Ice Cream Commander [Lv. 2150]"
			NaemQuest = "IceCreamIslandQuest"
			LevelQuest = 2
			NameMon = "Ice Cream Commander"
			ISLANDPOS = CFrame.new(-779.823547, 65.9448471, -10919.1182, -0.786368072, 0, 0.617758334, 0, 1, 0, -0.617758334, 0, -0.786368072)
			CFrameQuest = CFrame.new(-820.017212, 66.1628113, -10965.9189, 0.764226615, 5.82622519e-08, -0.644947827, -5.33253548e-08, 1, 2.71488592e-08, 0.644947827, 1.36441916e-08, 0.764226615)
			CFrameMon = CFrame.new(-830.885742, 144.121704, -11091.0156, -0.329080194, 5.0881642e-08, 0.944301963, 6.449892e-08, 1, -3.14055519e-08, -0.944301963, 5.05715114e-08, -0.329080194)
			if _G.AutoFarm and (CFrameMon.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude > 3000 then
				game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = ISLANDPOS
			end
		elseif MyLevel <= 2224 then
			Ms = "Cookie Crafter [Lv. 2200]"
			NaemQuest = "CakeQuest1"
			LevelQuest = 1
			NameMon = "Cookie Crafter"
			ISLANDPOS = CFrame.new(-2099.33154, 66.9970703, -12128.585, 0.997561574, 0, 0.0697919354, 0, 1, 0, -0.0697919354, 0, 0.997561574)
			CFrameQuest = CFrame.new(-2021.40833, 36.5925713, -12029.417, 0.940247118, -1.22227597e-08, 0.340492785, 1.01512621e-08, 1, 7.86525867e-09, -0.340492785, -3.93885546e-09, 0.940247118)
			CFrameMon = CFrame.new(-2123.25659, 111.625145, -11933.5938, 0.908894241, 1.12659599e-07, 0.417026669, -1.22163556e-07, 1, -3.89866006e-09, -0.417026669, -4.74019899e-08, 0.908894241)
			if _G.AutoFarm and (CFrameMon.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude > 3000 then
				game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = ISLANDPOS
			end
		elseif MyLevel <= 2249 then
			Ms = "Cake Guard [Lv. 2225]"
			NaemQuest = "CakeQuest1"
			LevelQuest = 2
			NameMon = "Cake Guard"
			ISLANDPOS = CFrame.new(-2099.33154, 66.9970703, -12128.585, 0.997561574, 0, 0.0697919354, 0, 1, 0, -0.0697919354, 0, 0.997561574)
			CFrameQuest = CFrame.new(-2021.40833, 36.5925713, -12029.417, 0.940247118, -1.22227597e-08, 0.340492785, 1.01512621e-08, 1, 7.86525867e-09, -0.340492785, -3.93885546e-09, 0.940247118)
			CFrameMon = CFrame.new(-1559.19348, 89.0205154, -12584.1943, 0.843241334, -3.36266659e-08, 0.537535131, -8.12348055e-09, 1, 7.53006049e-08, -0.537535131, -6.78632404e-08, 0.843241334)
			if _G.AutoFarm and (CFrameMon.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude > 3000 then
				game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = ISLANDPOS
			end
		elseif MyLevel <= 2274 then
			Ms = "Baking Staff [Lv. 2250]"
			NaemQuest = "CakeQuest2"
			LevelQuest = 1
			NameMon = "Baking Staff"
			ISLANDPOS = CFrame.new(-2099.33154, 66.9970703, -12128.585, 0.997561574, 0, 0.0697919354, 0, 1, 0, -0.0697919354, 0, 0.997561574)
			CFrameQuest = CFrame.new(-1927.9281, 36.6931343, -12842.1777, -0.999484241, -1.02355763e-07, 0.0321136042, -1.04146537e-07, 1, -5.40911991e-08, -0.0321136042, -5.74078207e-08, -0.999484241)
			CFrameMon = CFrame.new(-1819.08472, 93.1109695, -12884.9492, -0.761556745, -7.28589171e-08, 0.64809829, -7.16595849e-08, 1, 2.82149788e-08, -0.64809829, -2.49551455e-08, -0.761556745)
			if _G.AutoFarm and (CFrameMon.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude > 1000 then
				game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = ISLANDPOS
			end
		elseif MyLevel > 2275 then
			Ms = "Head Baker [Lv. 2275]"
			NaemQuest = "CakeQuest2"
			LevelQuest = 2
			NameMon = "Head Baker"
			ISLANDPOS = CFrame.new(-2099.33154, 66.9970703, -12128.585, 0.997561574, 0, 0.0697919354, 0, 1, 0, -0.0697919354, 0, 0.997561574)
			CFrameQuest = CFrame.new(-1927.9281, 36.6931343, -12842.1777, -0.999484241, -1.02355763e-07, 0.0321136042, -1.04146537e-07, 1, -5.40911991e-08, -0.0321136042, -5.74078207e-08, -0.999484241)
			CFrameMon = CFrame.new(-2103.4707, 101.819008, -12790.4863, 0.914387882, 1.96595877e-08, 0.404839277, 1.38365364e-09, 1, -5.16866443e-08, -0.404839277, 4.78217963e-08, 0.914387882)
			if _G.AutoFarm and (CFrameMon.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude > 1000 then
				game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = ISLANDPOS
			end
		end
	end
end
function Hop()
	pcall(function()
		for count = math.random(1, math.random(40, 75)), 100 do
			local args = {
			[1] = count
		}
		TableCahce = {}
		remote = game:GetService("ReplicatedStorage").__ServerBrowser:InvokeServer(unpack(args))
			for _i ,v in pairs(remote) do
				for _i2 ,v2 in pairs(v) do
					if tonumber(v['Count']) < 12 then
						if string.find(v['Region'], 'Sing') then
							game:GetService("TeleportService"):TeleportToPlaceInstance(game.PlaceId, _i)
						end
					end
				end    
			end    
		end	
	end)
end
spawn(function()
	pcall(function()
		while wait() do
			require(game:GetService("Players").LocalPlayer, "SimulationRaxNerous", math.huge)
		end
	end)
end)
	CheckQuest()
	function EquipWeapon(SelectToolWeapon)
		pcall(function()
			if game.Players.LocalPlayer.Backpack:FindFirstChild(SelectToolWeapon) then
				local tool = game.Players.LocalPlayer.Backpack:FindFirstChild(SelectToolWeapon)
				game.Players.LocalPlayer.Character.Humanoid:EquipTool(tool)
			end
		end)
	end
	game:GetService("RunService").Heartbeat:Connect(function()
		pcall(function()
			if game:GetService("Players").LocalPlayer.Character:FindFirstChild("Humanoid") then
				if _G.AutoFarm or Noclip or raidiing or _G.AutoBuddy or getgenv().AutoNew or _G.AutoCavender or Autothird or _G.AutoTEST or statetp1 then
					setfflag("HumanoidParallelRemoveNoPhysics", "False")
					setfflag("HumanoidParallelRemoveNoPhysicsNoSimulate2", "False")
				--game:GetService("Players").LocalPlayer.Character.Humanoid:ChangeState(11)
				end
			end
		end)
	end)
function Tween(gotoCFrame)
	pcall(function()
		game.Players.LocalPlayer.Character.Humanoid.Sit = false
	end)
	if (game:GetService("Players")["LocalPlayer"].Character.HumanoidRootPart.Position - gotoCFrame.Position).Magnitude <= 200 then
		pcall(function() 
			tween:Cancel()
		end)
		game:GetService("Players")["LocalPlayer"].Character.HumanoidRootPart.CFrame = gotoCFrame
	else
		local tween_s = game:service"TweenService"
		local info = TweenInfo.new((game:GetService("Players")["LocalPlayer"].Character.HumanoidRootPart.Position - gotoCFrame.Position).Magnitude/300, Enum.EasingStyle.Linear)
		local tween, err = pcall(function()
			tween = tween_s:Create(game.Players.LocalPlayer.Character["HumanoidRootPart"], info, {CFrame = gotoCFrame})
			tween:Play()
		end)
		if not tween then return err end
	end
end
local r = game:GetService("Players").LocalPlayer
function TweenFarm(p)
    task.spawn(function()
        pcall(function()
            if r:DistanceFromCharacter(p.Position) <= 300 then 
                r.Character.HumanoidRootPart.CFrame = p
            else if not game.Players.LocalPlayer.Character:FindFirstChild("Root")then 
                local K=Instance.new("Part",game.Players.LocalPlayer.Character)
                K.Size=Vector3.new(1,0.5,1)
                K.Name = "Root"
                K.Anchored = true
                K.Transparency = 1
                K.CanCollide = false
                K.CFrame = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame * CFrame.new(0,20,0)
            end

            local U = (game.Players.LocalPlayer.Character.HumanoidRootPart.Position-p.Position).Magnitude
            local z = game:service("TweenService")
            local B = TweenInfo.new((p.Position-game.Players.LocalPlayer.Character.Root.Position).Magnitude/300,Enum.EasingStyle.Linear)
            local S,g = pcall(function()
            local q = z:Create(game.Players.LocalPlayer.Character.Root,B,{CFrame = p})
			q:Play()
			end)
			if not S then 
				return g
			end
			game.Players.LocalPlayer.Character.Root.CFrame=game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame
			if S and game.Players.LocalPlayer.Character:FindFirstChild("Root") then 
				pcall(function()
					if (game.Players.LocalPlayer.Character.HumanoidRootPart.Position-p.Position).Magnitude >= 20 then 
						spawn(function()
							pcall(function()
								if (game.Players.LocalPlayer.Character.Root.Position-game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude > 150 then 
								game.Players.LocalPlayer.Character.Root.CFrame = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame
								else 
								game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame=game.Players.LocalPlayer.Character.Root.CFrame
										end
									end)
								end)
								elseif
								(game.Players.LocalPlayer.Character.HumanoidRootPart.Position-p.Position).Magnitude >= 10 and(game.Players.LocalPlayer.Character.HumanoidRootPart.Position-p.Position).Magnitude < 20 then 
									game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = p
								elseif
								(game.Players.LocalPlayer.Character.HumanoidRootPart.Position-p.Position).Magnitude < 10 then 
									game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = p
						end
					end)
				end
			end
		end)
	end)
end
local PlaceID = game.PlaceId
local AllIDs = {}
local foundAnything = ""
local actualHour = os.date("!*t").hour
local Deleted = false
function TPReturner()
	local Site;
	if foundAnything == "" then
		Site = game.HttpService:JSONDecode(game:HttpGet('https://games.roblox.com/v1/games/' .. PlaceID .. '/servers/Public?sortOrder=Asc&limit=100'))
	else
		Site = game.HttpService:JSONDecode(game:HttpGet('https://games.roblox.com/v1/games/' .. PlaceID .. '/servers/Public?sortOrder=Asc&limit=100&cursor=' .. foundAnything))
	end
	local ID = ""
	if Site.nextPageCursor and Site.nextPageCursor ~= "null" and Site.nextPageCursor ~= nil then
		foundAnything = Site.nextPageCursor
	end
	local num = 0;
	for i,v in pairs(Site.data) do
		local Possible = true
		ID = tostring(v.id)
		if tonumber(v.maxPlayers) > tonumber(v.playing) then
			for _,Existing in pairs(AllIDs) do
				if num ~= 0 then
					if ID == tostring(Existing) then
						Possible = false
					end
				else
					if tonumber(actualHour) ~= tonumber(Existing) then
						local delFile = pcall(function()
							-- delfile("NotSameServers.json")
							AllIDs = {}
							table.insert(AllIDs, actualHour)
						end)
					end
				end
				num = num + 1
			end
			if Possible == true then
				table.insert(AllIDs, ID)
				wait()
				pcall(function()
					-- writefile("NotSameServers.json", game:GetService('HttpService'):JSONEncode(AllIDs))
					wait()
					game:GetService("TeleportService"):TeleportToPlaceInstance(PlaceID, ID, game.Players.LocalPlayer)
				end)
				wait(.1)
			end
		end
	end
end

function Teleport() 
	while wait(1) do
		pcall(function()
			TPReturner()
			if foundAnything ~= "" then
				TPReturner()
			end
		end)
	end
end
spawn(function()
	while wait() do
		if _G.AutoFarm then
			setscriptable(game.Players.LocalPlayer, "SimulationRadius", true)
			game.Players.LocalPlayer.SimulationRadius = math.huge * math.huge, math.huge * math.huge * 1 / 0 * 1 / 0 * 1 / 0 * 1 / 0 * 1 / 0
		end
	end
end)

spawn(function()
	pcall(function()
		while true do wait(0)
			if _G.EquipTool then
				for i,v in pairs(game:GetService("Players").LocalPlayer.Backpack:GetChildren()) do
					if v.ClassName == "Tool" then
						if v.ToolTip == "Melee" then
							if game.Players.LocalPlayer.Backpack:FindFirstChild(tostring(v.Name)) then
								local ToolSe = tostring(v.Name)
								local tool = game.Players.LocalPlayer.Backpack:FindFirstChild(ToolSe)
								game.Players.LocalPlayer.Character.Humanoid:EquipTool(tool)
							end
						end
					end
				end
			end
		end
	end)
end)
_G.EquipTool = true
if not game.Players.LocalPlayer.Backpack:FindFirstChild("Combat") then
	if not game.Players.LocalPlayer.Backpack:FindFirstChild("Black Leg") then
		if not game.Players.LocalPlayer.Backpack:FindFirstChild("Electro") then
			if not game.Players.LocalPlayer.Backpack:FindFirstChild("Fishman Karate") then
				if not game.Players.LocalPlayer.Backpack:FindFirstChild("Dragon Claw") then
					if not game.Players.LocalPlayer.Backpack:FindFirstChild("Superhuman") then
						local args = {
							[1] = "BuyElectro"
						}
						game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer(unpack(args))
					end
				end
			end
		end
	end
end
AutoRaids=false
SuperhumanFull = true
spawn(function()
    while task.wait() do
        if game.Players.LocalPlayer:FindFirstChild("WeaponAssetCache") then 
            if game.Players.LocalPlayer.Backpack:FindFirstChild("Combat") or game.Players.LocalPlayer.Character:FindFirstChild("Combat") then
				SelectToolWeapon = "Combat"
                local args = {
                    [1] = "BuyElectro"
                }
                game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer(unpack(args))
            end
            if game.Players.LocalPlayer.Backpack:FindFirstChild("Electro") and game.Players.LocalPlayer.Backpack:FindFirstChild("Electro").Level.Value >= 300 then
				local args = {
                    [1] = "BuyBlackLeg"
                }
                game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer(unpack(args))
            end
            if game.Players.LocalPlayer.Character:FindFirstChild("Electro") and game.Players.LocalPlayer.Character:FindFirstChild("Electro").Level.Value >= 300 then
				local args = {
                    [1] = "BuyBlackLeg"
                }
                game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer(unpack(args))
            end
            if game.Players.LocalPlayer.Backpack:FindFirstChild("Black Leg") and game.Players.LocalPlayer.Backpack:FindFirstChild("Black Leg").Level.Value >= 300 then
				local args = {
                    [1] = "BuyFishmanKarate"
                }
                game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer(unpack(args))
            end
            if game.Players.LocalPlayer.Character:FindFirstChild("Black Leg") and game.Players.LocalPlayer.Character:FindFirstChild("Black Leg").Level.Value >= 300 then
				local args = {
                    [1] = "BuyFishmanKarate"
                }
                game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer(unpack(args))
            end
            if game.Players.LocalPlayer.Backpack:FindFirstChild("Fishman Karate") and game.Players.LocalPlayer.Backpack:FindFirstChild("Fishman Karate").Level.Value >= 300  then
                local args = {
					[1] = "BlackbeardReward",
					[2] = "DragonClaw",
					[3] = "2"
				}
				HaveDragonClaw = game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer(unpack(args))
				if SuperhumanFull and game.Players.LocalPlayer.Data.Fragments.Value < 1500 and HaveDragonClaw == 0 then
                    if game.Players.LocalPlayer.Data.Level.Value > 1100 then
						RaidsSelected = "Flame"
						AutoRaids = true
						_G.AutoFarm = false
					end
                else
                    AutoRaids = false
					_G.AutoFarm = false
                    local args = {
                        [1] = "BlackbeardReward",
                        [2] = "DragonClaw",
                        [3] = "2"
                    }
                    game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer(unpack(args))
                end
            end
            if game.Players.LocalPlayer.Character:FindFirstChild("Fishman Karate") and game.Players.LocalPlayer.Character:FindFirstChild("Fishman Karate").Level.Value >= 300  then
                local args = {
					[1] = "BlackbeardReward",
					[2] = "DragonClaw",
					[3] = "2"
				}
				HaveDragonClaw = game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer(unpack(args))
				if SuperhumanFull and game.Players.LocalPlayer.Data.Fragments.Value < 1500 and HaveDragonClaw == 0 then
                    if game.Players.LocalPlayer.Data.Level.Value > 1100 then
						RaidsSelected = "Flame"
						AutoRaids = true
						_G.AutoFarm = false
					end
                else
                    AutoRaids = false
					_G.AutoFarm = true
                    local args = {
                        [1] = "BlackbeardReward",
                        [2] = "DragonClaw",
                        [3] = "2"
                    }
                    game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer(unpack(args))
                end
            end
            if game.Players.LocalPlayer.Backpack:FindFirstChild("Dragon Claw") and game.Players.LocalPlayer.Backpack:FindFirstChild("Dragon Claw").Level.Value >= 300 then
				local args = {
                    [1] = "BuySuperhuman"
                }
                game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer(unpack(args))
            end
            if game.Players.LocalPlayer.Character:FindFirstChild("Dragon Claw") and game.Players.LocalPlayer.Character:FindFirstChild("Dragon Claw").Level.Value >= 300 then
				local args = {
                    [1] = "BuySuperhuman"
                }
                game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer(unpack(args))
            end 

			if game.Players.LocalPlayer.Backpack:FindFirstChild("Combat") or game.Players.LocalPlayer.Character:FindFirstChild("Combat") then
				SelectToolWeapon = "Combat"
            end

            if game.Players.LocalPlayer.Backpack:FindFirstChild("Black Leg") or game.Players.LocalPlayer.Character:FindFirstChild("Black Leg") then
                SelectToolWeapon = "Black Leg"
            end
            if game.Players.LocalPlayer.Backpack:FindFirstChild("Electro") or game.Players.LocalPlayer.Character:FindFirstChild("Electro") then
                SelectToolWeapon = "Electro"
            end
            if game.Players.LocalPlayer.Backpack:FindFirstChild("Fishman Karate") or game.Players.LocalPlayer.Character:FindFirstChild("Fishman Karate") then
                SelectToolWeapon = "Fishman Karate"
            end
            if game.Players.LocalPlayer.Backpack:FindFirstChild("Dragon Claw") or game.Players.LocalPlayer.Character:FindFirstChild("Dragon Claw") then
                SelectToolWeapon = "Dragon Claw"
            end
            if game.Players.LocalPlayer.Backpack:FindFirstChild("Superhuman") or game.Players.LocalPlayer.Character:FindFirstChild("Superhuman") then
                SelectToolWeapon = "Superhuman"
            end
        end
    end
end)

-- spawn(
-- 	function()
-- 		pcall(function()
-- 			while true do wait()
-- 				if _G.DeathStep and game.Players.LocalPlayer:FindFirstChild("WeaponAssetCache") then
-- 					_G.AutoMelee = false
-- 					_G.EquipTool = true
-- 					fagmet8 = game:GetService("Players").localPlayer.Data.Fragments.Value
-- 					Level1 =  game.Players.localPlayer.Data.Level.Value
-- 					if game.Players.LocalPlayer.Character:FindFirstChild("Black Leg") and game.Players.LocalPlayer.Character:FindFirstChild("Black Leg").Level.Value >= 400 then
-- 						if Level1 >= 1500 then
-- 							if fagmet8 < 5000 then
-- 								_G.Chip = "Flame"
-- 								_G.autoraid = true
-- 								_G.AutoFarm = false
-- 								_G.AutoMelee = false
-- 							else
-- 								_G.AutoFarm = true
-- 								_G.AutoMelee = false
-- 								_G.autoraid = false
-- 								local args = {
-- 									[1] = "BuyDeathStep"
-- 								}
-- 								game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer(unpack(args))
-- 							end
-- 						else
-- 							_G.AutoFarm = true
-- 						end
-- 					end  
-- 					if game.Players.LocalPlayer.Backpack:FindFirstChild("Black Leg") and game.Players.LocalPlayer.Backpack:FindFirstChild("Black Leg").Level.Value < 400 then
-- 						local args = {
-- 							[1] = "BuyBlackLeg"
-- 						}
-- 						game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer(unpack(args))
-- 					end
-- 					if not game.Players.LocalPlayer.Backpack:FindFirstChild("Black Leg") then
-- 						local args = {
-- 							[1] = "BuyBlackLeg"
-- 						}
-- 						game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer(unpack(args))
-- 					end
-- 				end
-- 			end
-- 		end)
-- 	end
-- )
spawn(function()
	while wait() do 
		if AutoRaids then
			for i,v in pairs(game.Workspace.Enemies:GetChildren()) do
				if AutoRaids and v:FindFirstChild("Humanoid") and v:FindFirstChild("HumanoidRootPart") and (v.HumanoidRootPart.Position-game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.Position).magnitude <= 400 then
					pcall(function()
						repeat wait()
							v.HumanoidRootPart.Transparency = 0.75
							v.Humanoid.Health = 0
							v:BreakJoints()
						until not AutoRaids or v.Humanoid.Health <= 0 or not v.Parent
					end)
				end
			end
		end	
	end
end)

spawn(function()
    while wait() do
        if AutoRaids then
            if game.Players.LocalPlayer.Backpack:FindFirstChild("Special Microchip") or game.Players.LocalPlayer.Character:FindFirstChild("Special Microchip") or game:GetService("Workspace")["_WorldOrigin"].Locations:FindFirstChild("Island 5") or game:GetService("Workspace")["_WorldOrigin"].Locations:FindFirstChild("Island 4") or game:GetService("Workspace")["_WorldOrigin"].Locations:FindFirstChild("Island 3") or game:GetService("Workspace")["_WorldOrigin"].Locations:FindFirstChild("Island 2") or game:GetService("Workspace")["_WorldOrigin"].Locations:FindFirstChild("Island 1") then
                if game.Players.LocalPlayer.Backpack:FindFirstChild("Special Microchip") or game.Players.LocalPlayer.Character:FindFirstChild("Special Microchip") and game.Players.LocalPlayer.PlayerGui.Main.Timer.Visible == false then
                    
                    if NewWorld then
                        fireclickdetector(Workspace.Map.CircleIsland.RaidSummon2.Button.Main.ClickDetector)
                    elseif ThreeWorld then
                        fireclickdetector(Workspace.Map["Boat Castle"].RaidSummon2.Button.Main.ClickDetector)
                    end
                    wait(17)
                elseif game.Players.LocalPlayer.PlayerGui.Main.Timer.Visible == true then
                    pcall(function()
                        repeat wait()
							if game.Players.LocalPlayer.PlayerGui.Main.Timer.Visible == false then
							elseif game:GetService("Workspace")["_WorldOrigin"].Locations:FindFirstChild("Island 5") then
								game:GetService("Workspace")["_WorldOrigin"].Locations:FindFirstChild("Island 5").CFrame = CFrame.new(game:GetService("Workspace")["_WorldOrigin"].Locations:FindFirstChild("Island 5").CFrame.x,60,game:GetService("Workspace")["_WorldOrigin"].Locations:FindFirstChild("Island 5").CFrame.z)
								if (game:GetService("Workspace")["_WorldOrigin"].Locations:FindFirstChild("Island 5").Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).magnitude > 350 then
									Tween(game:GetService("Workspace")["_WorldOrigin"].Locations:FindFirstChild("Island 5").CFrame)
								elseif (game:GetService("Workspace")["_WorldOrigin"].Locations:FindFirstChild("Island 5").Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).magnitude <= 350 then
									Tween(game:GetService("Workspace")["_WorldOrigin"].Locations:FindFirstChild("Island 5").CFrame)
								end
							elseif game:GetService("Workspace")["_WorldOrigin"].Locations:FindFirstChild("Island 4") then
								game:GetService("Workspace")["_WorldOrigin"].Locations:FindFirstChild("Island 4").CFrame = CFrame.new(game:GetService("Workspace")["_WorldOrigin"].Locations:FindFirstChild("Island 4").CFrame.x,60,game:GetService("Workspace")["_WorldOrigin"].Locations:FindFirstChild("Island 4").CFrame.z)
								if (game:GetService("Workspace")["_WorldOrigin"].Locations:FindFirstChild("Island 4").Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).magnitude > 350 then
									Tween(game:GetService("Workspace")["_WorldOrigin"].Locations:FindFirstChild("Island 4").CFrame)
								elseif (game:GetService("Workspace")["_WorldOrigin"].Locations:FindFirstChild("Island 4").Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).magnitude <= 350 then
									Tween(game:GetService("Workspace")["_WorldOrigin"].Locations:FindFirstChild("Island 4").CFrame)
								end
							elseif game:GetService("Workspace")["_WorldOrigin"].Locations:FindFirstChild("Island 3") then
								game:GetService("Workspace")["_WorldOrigin"].Locations:FindFirstChild("Island 3").CFrame = CFrame.new(game:GetService("Workspace")["_WorldOrigin"].Locations:FindFirstChild("Island 3").CFrame.x,60,game:GetService("Workspace")["_WorldOrigin"].Locations:FindFirstChild("Island 3").CFrame.z)
								if (game:GetService("Workspace")["_WorldOrigin"].Locations:FindFirstChild("Island 3").Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).magnitude > 350 then
									Tween(game:GetService("Workspace")["_WorldOrigin"].Locations:FindFirstChild("Island 3").CFrame)
								elseif (game:GetService("Workspace")["_WorldOrigin"].Locations:FindFirstChild("Island 3").Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).magnitude <= 350 then
									Tween(game:GetService("Workspace")["_WorldOrigin"].Locations:FindFirstChild("Island 3").CFrame)
								end
							elseif game:GetService("Workspace")["_WorldOrigin"].Locations:FindFirstChild("Island 2") then
								game:GetService("Workspace")["_WorldOrigin"].Locations:FindFirstChild("Island 2").CFrame = CFrame.new(game:GetService("Workspace")["_WorldOrigin"].Locations:FindFirstChild("Island 2").CFrame.x,60,game:GetService("Workspace")["_WorldOrigin"].Locations:FindFirstChild("Island 2").CFrame.z)
								if (game:GetService("Workspace")["_WorldOrigin"].Locations:FindFirstChild("Island 2").Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).magnitude > 350 then
									Tween(game:GetService("Workspace")["_WorldOrigin"].Locations:FindFirstChild("Island 2").CFrame)
								elseif (game:GetService("Workspace")["_WorldOrigin"].Locations:FindFirstChild("Island 2").Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).magnitude <= 350 then
									Tween(game:GetService("Workspace")["_WorldOrigin"].Locations:FindFirstChild("Island 2").CFrame)
								end
							elseif game:GetService("Workspace")["_WorldOrigin"].Locations:FindFirstChild("Island 1") then
								game:GetService("Workspace")["_WorldOrigin"].Locations:FindFirstChild("Island 1").CFrame = CFrame.new(game:GetService("Workspace")["_WorldOrigin"].Locations:FindFirstChild("Island 1").CFrame.x,60,game:GetService("Workspace")["_WorldOrigin"].Locations:FindFirstChild("Island 1").CFrame.z)
								if (game:GetService("Workspace")["_WorldOrigin"].Locations:FindFirstChild("Island 1").Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).magnitude > 350 then
									Tween(game:GetService("Workspace")["_WorldOrigin"].Locations:FindFirstChild("Island 1").CFrame)
								elseif (game:GetService("Workspace")["_WorldOrigin"].Locations:FindFirstChild("Island 1").Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).magnitude <= 350 then
									Tween(game:GetService("Workspace")["_WorldOrigin"].Locations:FindFirstChild("Island 1").CFrame)
								end
							end
                            for i,v in pairs(game.Workspace.Enemies:GetChildren()) do
                                if AutoRaids and v:FindFirstChild("Humanoid") and v:FindFirstChild("HumanoidRootPart") and (v.HumanoidRootPart.Position-game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.Position).magnitude <= 400 then
                                    pcall(function()
                                        repeat wait()
                                            v.HumanoidRootPart.Transparency = 0.75
                                            v.Humanoid.Health = 0
											v:BreakJoints()
                                        until not AutoRaids or v.Humanoid.Health <= 0 or not v.Parent
                                    end)
                                end
                            end
							local args = {
								[1] = "Awakener",
								[2] = "Check"
							}
							game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer(unpack(args))
							local args = {
								[1] = "Awakener",
								[2] = "Awaken"
							}
							game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer(unpack(args))
                        until AutoRaids == false or not game:GetService("Workspace")["_WorldOrigin"].Locations:FindFirstChild("Island 5") or not game:GetService("Workspace")["_WorldOrigin"].Locations:FindFirstChild("Island 4") or not game:GetService("Workspace")["_WorldOrigin"].Locations:FindFirstChild("Island 3") or not game:GetService("Workspace")["_WorldOrigin"].Locations:FindFirstChild("Island 2") or not game:GetService("Workspace")["_WorldOrigin"].Locations:FindFirstChild("Island 1") or game.Players.LocalPlayer.PlayerGui.Main.Timer.Visible == false
                    end)
                end
            else
				spawn(function()
					for i,v in pairs(game:GetService("Workspace"):GetChildren()) do
						if v:IsA("Tool") and string.find(v.Name,"Fruit") then
							firetouchinterest(game.Players.LocalPlayer.Character.HumanoidRootPart,v.Handle,0)  
							wait(60)
						end
					end
				end)
				for i2,v2 in next,tablefruithave do
					if game.Players.LocalPlayer.Backpack:FindFirstChild(v2) or game.Players.LocalPlayer.Character:FindFirstChild(v2) then
						_G.LoadthisFruit = v2
					end
				end
				if _G.LoadthisFruit ~= nil then
					local args = {
						[1] = "LoadFruit",
						[2] = _G.LoadthisFruit
					}
					
					game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer(unpack(args))
				end
				local tablefruithave = {}
				HaveStore2 =false

				for i,v in next,Remote_GetFruits do
					for i1,v1 in pairs(getInventoryFruit) do
						if v.Name == v1.Name then
							HaveStore2 = true
						end
					end
					if HaveStore2 then
						table.insert(tablefruithave,v.Price,v.Name)
					end
					HaveStore2 = false
				end
                Useraids = false
                local args = {
                    [1] = "RaidsNpc",
                    [2] = "Select",
                    [3] = RaidsSelected
                }
                game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer(unpack(args))
				_G.LoadthisFruit = nil
            end
        end
    end
end)

spawn(function()
	while true do wait()
		pcall(function()
			if _G.Farm2 then
				print('100000')
			end
		end)
	end
end)
spawn(function()
	while true do wait()
		pcall(function()
			if game:GetService("Players").LocalPlayer.Data.Level.Value == 10 then
				_G.Farm2 = true
				_G.AutoFarm = false
			end
		end)
	end
end)
Type = 1
spawn(function()
	while true do wait()
		pcall(function()
			if Type == 1 then
				FRAMMON = CFrame.new(0,0,10)
			elseif Type == 2 then
				FRAMMON = CFrame.new(0,30,0) * CFrame.Angles(math.rad(-90),0,0)
			elseif Type == 3 then
				FRAMMON = CFrame.new(10,0,0)
			end
		end)
	end
end)
spawn(function()
	while task.wait() do
		Type = 1 
		task.wait(1)
		Type = 2
		task.wait(1)
		Type = 3
		task.wait(1)
	end
end)
_G.AutoFarm = true
spawn(function()
	while task.wait() do
		pcall(function()
			if _G.AutoFarm then
				_G.AutoCavender = false
				_G.AutoBuddy = false
				game.Players.LocalPlayer.Character.Humanoid.Sit = false
				if game:GetService("Players").LocalPlayer.PlayerGui.Main.Quest.Visible == false then
					StartMagnet = false
					CheckQuest()
					if game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame == ISLANDPOS then
						game.Players.LocalPlayer.Character.Humanoid.Health = 0
						task.wait(0.5)
						local args = {
							[1] = "SetSpawnPoint"
						}
						game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer(unpack(args))
					else
						TweenFarm(CFrameQuest)
					end
					if (CFrameQuest.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude <= 5 and not raidiing then
						CheckQuest()
						wait(1)
						if (CFrameQuest.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude <= 20 and not raidiing then
							game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("StartQuest", NaemQuest, LevelQuest)
							game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("SetSpawnPoint")
						else
							TweenFarm(CFrameQuest)
						end
					end
				elseif game:GetService("Players").LocalPlayer.PlayerGui.Main.Quest.Visible == true then
					pcall(function()
						CheckQuest()
						if game:GetService("Workspace").Enemies:FindFirstChild(Ms) then
							for i,v in pairs(game:GetService("Workspace").Enemies:GetChildren()) do
								if v.Name == Ms and v:FindFirstChild("Humanoid") then
									if v:WaitForChild('Humanoid').Health > 0 then
										repeat wait()
											pcall(function()
												if game:GetService("Workspace").Enemies:FindFirstChild(Ms) then
													if string.find(game:GetService("Players").LocalPlayer.PlayerGui.Main.Quest.Container.QuestTitle.Title.Text,NameMon) then
													TweenFarm(v.HumanoidRootPart.CFrame * FRAMMON)
													if not game.Players.LocalPlayer.Character:FindFirstChild("HasBuso") then
														local args = {
															[1] = "Buso"
														}
														game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer(unpack(args))
													end
													v.HumanoidRootPart.Size = Vector3.new(100, 100, 100)
													v.Humanoid.Sit = false
													v.HumanoidRootPart.CanCollide = false
													if v.Humanoid:FindFirstChild("Animator") then
														v.Humanoid.Animator:Destroy()
													end
													if game.Players.LocalPlayer.Character:FindFirstChild("Black Leg") and game.Players.LocalPlayer.Character:FindFirstChild("Black Leg").Level.Value >= 150 then
														game:service('VirtualInputManager'):SendKeyEvent(true, "V", false, game)
														game:service('VirtualInputManager'):SendKeyEvent(false, "V", false, game)
													end
													PosMon = v.HumanoidRootPart.CFrame 
													StartMagnet = true
													else
														game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("AbandonQuest")  
													end
												else
													if (CFrameMon.Position-game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.Position).magnitude >= 600 and not raidiing then
														StatrMagnet = false
														CheckQuest()
														TweenFarm(CFrameMon)
													end
												end
											end)
										until not v:FindFirstChild("Humanoid") or  not v:FindFirstChild("HumanoidRootPart") or not v.Parent or v.Humanoid.Health <= 0 or _G.AutoFarm == false or game.Players.LocalPlayer.PlayerGui.Main.Quest.Visible == false or not game:GetService("Workspace").Enemies:FindFirstChild(Ms) or not game:GetService("Workspace").Enemies:FindFirstChild(v.Name)
									end
								end
							end
						else
							if not string.find(game:GetService("Players").LocalPlayer.PlayerGui.Main.Quest.Container.QuestTitle.Title.Text,NameMon) then game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("AbandonQuest") end
							StartMagnet = false
							TweenFarm(CFrameMon)
							CheckQuest()
						end
					end)
				end
			end
		end)
	end
end)
_G.AutoStats = true
spawn(function()
	pcall(function()
		while wait() do
			if _G.AutoStats then
				if game:GetService("Players").LocalPlayer.Data.Stats.Melee.Level.Value < 2300 then
					local args = {
						[1] = "AddPoint",
						[2] = "Melee",
						[3] = 3
					}
					game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer(unpack(args))
				end
				if game:GetService("Players").LocalPlayer.Data.Stats.Melee.Level.Value == 2300 then
					local args = {
						[1] = "AddPoint",
						[2] = "Sword",
						[3] = 3
					}
					game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer(unpack(args))
				end
				if game:GetService("Players").LocalPlayer.Data.Stats.Sword.Level.Value == 2300 then
					local args = {
						[1] = "AddPoint",
						[2] = "Defense",
						[3] = 3
					}
					game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer(unpack(args))
				end
			end
		end
	end)
end)
require(game:GetService("Players").LocalPlayer.PlayerScripts.CombatFramework.Particle.SlashHit).playAt = function() return true end
coroutine.wrap(function()
	pcall(function()
		game:GetService("RunService").Heartbeat:Connect(function()
			if _G.AutoFarm or _G.AutoThird or _G.AutoBuddy or _G.AutoCavender or _G.Canvender or _G.Buddy or _G.Yamma or AutoShrakman or Auto_Bone or _G.FARMPLAYERS or _G.autoraid or getgenv().AutoNew or statetp1 or Autothird or _G.AutoTEST or _G.AutoFarmMBF or _G.AutoFarmGun or _G.KenHaki then
				if not game.Players.LocalPlayer.Character.HumanoidRootPart:FindFirstChild("BodyClip") then
					local Noclip = Instance.new("BodyVelocity")
					Noclip.Name = "BodyClip"
					Noclip.Parent = game.Players.LocalPlayer.Character.HumanoidRootPart
					Noclip.MaxForce = Vector3.new(100000,100000,100000)
					Noclip.Velocity = Vector3.new(0,0,0)
				end
			else
				if game.Players.LocalPlayer.Character.HumanoidRootPart:FindFirstChild("BodyClip") then
					game.Players.LocalPlayer.Character.HumanoidRootPart:FindFirstChild("BodyClip"):Destroy()
				end
			end
		end)
	end)
end)()
spawn(function()
	while game:GetService("RunService").Stepped:wait(10) do
		character = game.Players.LocalPlayer.Character 
		if _G.NoClip or _G.AutoThird or _G.AutoBuddy or _G.AutoCavender or _G.Canvender or _G.Buddy or Auto_Bone or _G.Yamma or _G.AutoFarm or KillPlayer or getgenv().AutoNew or Autothird or Autothird or Factory or NextIsland or TweenIsland or _G.AutoTEST or _G.AutoFarmMBF or _G.AutoFarmGun then
			pcall(function()
				for _, v in pairs(character:GetDescendants()) do
					pcall(function()
						if v:IsA("BasePart") then
							pcall(function()
							v.CanCollide = false
							end)
						end
					end)
				end
			end)
		end
	end
end)
	
spawn(function()
	pcall(function()
		while task.wait() do
			if _G.AutoFarm then
				function UseCode(Text)
					game:GetService("ReplicatedStorage").Remotes.Redeem:InvokeServer(Text)
				end
				UseCode("Sub2Fer999")
				UseCode("Enyu_is_Pro")
				UseCode("Magicbus")
				UseCode("JCWK")
				UseCode("Starcodeheo")
				UseCode("Bluxxy")
				UseCode("fudd10_v2")
				UseCode("FUDD10")
				UseCode("BIGNEWS")
				UseCode("SUB2NOOBMASTER123")
				UseCode("Sub2Daigrock")
				UseCode("Axiore")
				UseCode("TantaiGaming")
				UseCode("STRAWHATMAINE")
				UseCode("3BVISITS")
				UseCode("THEGREATACE")
				UseCode("Bignews ")
				UseCode("TantaiGaming")
				UseCode("SUB2GAMERROBOT_EXP1")
			end
		end
	end)
end)
getgenv().A = require(game:GetService("ReplicatedStorage").CombatFramework.RigLib).wrapAttackAnimationAsync 
getgenv().B = require(game.Players.LocalPlayer.PlayerScripts.CombatFramework.Particle).play
spawn(function()
    while wait() do
		pcall(function()
			if _G.AutoFarm then
				require(game:GetService("ReplicatedStorage").CombatFramework.RigLib).wrapAttackAnimationAsync =function(a1,a2,a3,a4,a5)
					local GetBladeHits = require(game:GetService("ReplicatedStorage").CombatFramework.RigLib).getBladeHits(a2,a3,a4)
					if GetBladeHits then
							require(game:GetService("ReplicatedStorage").CombatFramework.RigLib).play = function() end
						a1:Play(0.2, 0.2, 0.2)
						a5(GetBladeHits)
							require(game:GetService("ReplicatedStorage").CombatFramework.RigLib).play = getgenv().B 
						wait(.5)
						a1:Stop()
					end
				end
			end
		end)
    end
end)
local CombatFrameworkROld = require(game:GetService("Players").LocalPlayer.PlayerScripts.CombatFramework) 
local CombatFrameworkR = getupvalues(CombatFrameworkROld)[2]
local CameraShakerR = require(game.ReplicatedStorage.Util.CameraShaker)
local CombatFramework = require(game:GetService("Players").LocalPlayer.PlayerScripts.CombatFramework)
local Camera = require(game.ReplicatedStorage.Util.CameraShaker)
local Attack = 0.1
local backup = require(game:GetService("Players").LocalPlayer.PlayerScripts.CombatFramework)
local Crit = getupvalues(backup)[2]
local CombatFrameworkR = getupvalues(backup)[2]
local CameraShakerR = require(game.ReplicatedStorage.Util.CameraShaker)
local plr = game.Players.LocalPlayer
local CbFw = debug.getupvalues(require(plr.PlayerScripts.CombatFramework))
local CbFw2 = CbFw[2]
local function maxincrement()
	return #Crit.activeController.anims.basic
end
task.spawn(function()
	pcall(function()
		local old
		old = hookmetamethod(game, "__namecall",function(self,...)
			local method = getnamecallmethod() local args = {...}
			if method:lower() == "fireserver" then
				if args[1] == "hit" then
					args[3] = maxincrement()
					return old(self,unpack(args))
				end end
			return old(self,...)
		end) 
	end)
end)
do
	CameraShakerR:Stop()
end
function GetCurrentBlade() 
    local p13 = CbFw2.activeController
    local ret = p13.blades[1]
    if not ret then return end
    while ret.Parent~=game.Players.LocalPlayer.Character do 
		ret=ret.Parent 
	end
    return ret
end
function AttackNoCD() 
    local AC = CbFw2.activeController
    for i = 1, 1 do 
        local bladehit = require(game.ReplicatedStorage.CombatFramework.RigLib).getBladeHits(
            plr.Character,
            {plr.Character.HumanoidRootPart},
            60
        )
        local cac = {}
        local hash = {}
        for k, v in pairs(bladehit) do
            if v.Parent:FindFirstChild("HumanoidRootPart") and not hash[v.Parent] then
                table.insert(cac, v.Parent.HumanoidRootPart)
                hash[v.Parent] = true
            end
        end
        bladehit = cac
        if #bladehit > 0 then
            local u8 = debug.getupvalue(AC.attack, 5)
            local u9 = debug.getupvalue(AC.attack, 6)
            local u7 = debug.getupvalue(AC.attack, 4)
            local u10 = debug.getupvalue(AC.attack, 7)
            local u12 = (u8 * 798405 + u7 * 727595) % u9
            local u13 = u7 * 798405
            (function()
                u12 = (u12 * u9 + u13) % 1099511627776
                u8 = math.floor(u12 / u9)
                u7 = u12 - u8 * u9
            end)()
            u10 = u10 + 1
            debug.setupvalue(AC.attack, 5, u8)
            debug.setupvalue(AC.attack, 6, u9)
            debug.setupvalue(AC.attack, 4, u7)
            debug.setupvalue(AC.attack, 7, u10)
            pcall(function()
                for k, v in pairs(AC.animator.anims.basic) do
                    v:Play()
                end                  
            end)
            if plr.Character:FindFirstChildOfClass("Tool") and AC.blades and AC.blades[1] then 
                game:GetService("ReplicatedStorage").RigControllerEvent:FireServer("weaponChange",tostring(GetCurrentBlade()))
                game.ReplicatedStorage.Remotes.Validator:FireServer(math.floor(u12 / 1099511627776 * 16777215), u10)
                game:GetService("ReplicatedStorage").RigControllerEvent:FireServer("hit", bladehit, i, "") 
            end
        end
    end
end
local cac
if SuperFastMode then
	cac=task.wait
else
	cac=wait
end
spawn(function()
	while cac() do
		pcall(function()
			AttackNoCD()
		end)
	end
end
)
local Plr = game:GetService("Players").LocalPlayer
local VirtualUser = game:GetService('VirtualUser')
spawn(function()
    while wait() do
        if _G.autonewworld then
            if game.Players.localPlayer.Data.Level.Value >= 700 then
				_G.AutoFarm = false
				_G.AutoCavender = false
				_G.AutoBuddy = false
                if game.ReplicatedStorage.Remotes.CommF_:InvokeServer("DressrosaQuestProgress", "Dressrosa") ~= 0 then
                    if Workspace.Map.Ice.Door.Transparency == 1 then
                        if (CFrame.new(1347.7124, 37.3751602, -1325.6488).Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).magnitude > 250 then
                            if game.Players.LocalPlayer.Backpack:FindFirstChild("Key") then
                                local tool = game.Players.LocalPlayer.Backpack:FindFirstChild("Key")
                                wait(.4)
                                game.Players.LocalPlayer.Character.Humanoid:EquipTool(tool)
                            end
                            Tween(CFrame.new(1347.7124, 37.3751602, -1325.6488))
                            if (CFrame.new(1347.7124, 37.3751602, -1325.6488).Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).magnitude <= 250 then
                                Tween(CFrame.new(1347.7124, 37.3751602, -1325.6488))
                            end
                        elseif game.Workspace.Enemies:FindFirstChild("Ice Admiral [Lv. 700] [Boss]") and game.Workspace.Map.Ice.Door.CanCollide == false and game.Workspace.Map.Ice.Door.Transparency == 1 and (CFrame.new(1347.7124, 37.3751602, -1325.6488).Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).magnitude <= 350 then
                            for i,v in pairs(game.Workspace.Enemies:GetChildren()) do
                                if v.Name == "Ice Admiral [Lv. 700] [Boss]" and v:IsA("Model") and v:FindFirstChild("Humanoid") and v:FindFirstChild("HumanoidRootPart") and v.Humanoid.Health > 0 and v.Name == "Ice Admiral [Lv. 700] [Boss]" then
                                    repeat wait()
                                        if not game.Players.LocalPlayer.Character:FindFirstChild("HasBuso") then
                                            local args = {
                                                [1] = "Buso"
                                            }
                                            game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer(unpack(args))
                                        end
                                        Tween(v.HumanoidRootPart.CFrame * CFrame.new(0, 30, 0))
                                    until not v.Parent or v.Humanoid.Health <= 0 or _G.autonewworld == false
                                end
                            end
                        else
                            _G.Fastattack = false
                        end 
                    else
                        if game.Players.LocalPlayer.Backpack:FindFirstChild("Key") or game.Players.LocalPlayer.Character:FindFirstChild("Key") then
                            Tween(CFrame.new(1347.7124, 37.3751602, -1325.6488))
                            if (CFrame.new(1347.7124, 37.3751602, -1325.6488).Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).magnitude <= 250 then
                                Tween(CFrame.new(1347.7124, 37.3751602, -1325.6488))
                                local args = {
                                    [1] = "DressrosaQuestProgress",
                                    [2] = "Detective"
                                }
                                game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer(unpack(args))
                                wait(0.5)
                                if game.Players.LocalPlayer.Backpack:FindFirstChild("Key") then
                                    local tool = game.Players.LocalPlayer.Backpack:FindFirstChild("Key")
                                    wait(.4)
                                    game.Players.LocalPlayer.Character.Humanoid:EquipTool(tool)
                                end
                            end
                        else
                            Tween(CFrame.new(4849.29883, 5.65138149, 719.611877))
                            if (CFrame.new(4849.29883, 5.65138149, 719.611877).Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).magnitude <= 250 then
                                Tween(CFrame.new(4849.29883, 5.65138149, 719.611877))
                                local args = {
                                    [1] = "DressrosaQuestProgress",
                                    [2] = "Detective"
                                }
                                game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer(unpack(args))
                                wait(0.5)
                                if game.Players.LocalPlayer.Backpack:FindFirstChild("Key") then
                                    local tool = game.Players.LocalPlayer.Backpack:FindFirstChild("Key")
                                    wait(.4)
                                    game.Players.LocalPlayer.Character.Humanoid:EquipTool(tool)
                                end
                            end
                        end
                    end
                else
                    local args = {
                        [1] = "TravelDressrosa"
                    }
                    game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer(unpack(args))
                end
            end
        end
    end
end)
_G.a = true
spawn(function()
    if _G.a == true then
        local Client = game.Players.LocalPlayer
        local PC = require(Client.PlayerScripts.CombatFramework.Particle)
        local RL = require(game:GetService("ReplicatedStorage").CombatFramework.RigLib)
        if not shared.orl then shared.orl = RL.wrapAttackAnimationAsync end
        if not shared.cpc then shared.cpc = PC.play end
        RL.wrapAttackAnimationAsync = function(a,b,c,d,func)
            local Hits = RL.getBladeHits(b,c,d)
            if Hits then
                PC.play = function() end
                a:Play(0.01,0.01,0.01)
                func(Hits)
                PC.play = shared.cpc
                wait(a.length * 0.5)
                a:Stop()
            end
        end
    end
end)
_G.AutoThird = true
spawn(function()
    pcall(function()
        while wait() do
            if _G.AutoThird then
                if game:GetService("Players").LocalPlayer.Data.Level.Value >= 1500 and NewWorld then
                    _G.AutoFarm = false
					_G.AutoCavender = false
					_G.AutoBuddy = false
                    if game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("ZQuestProgress").KilledIndraBoss == false then
                        if game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BartiloQuestProgress","Bartilo") == 3 then
                            if game:GetService("Players").LocalPlayer.Data.SpawnPoint.Value == "Bar" then
                                if game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("TalkTrevor","1") == 0 then
                                    if game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("ZQuestProgress","Check") == 0 then
                                        if (CFrame.new(-1926.3221435547, 12.819851875305, 1738.3092041016).Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude <= 10 then
                                            wait(1.1)
                                            game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("ZQuestProgress","Begin")
                                        else
                                            Tween(CFrame.new(-1926.3221435547, 12.819851875305, 1738.3092041016))
                                        end
                                        if game:GetService("Workspace").Enemies:FindFirstChild("rip_indra [Lv. 1500] [Boss]") then
                                            for i,v in pairs(game:GetService("Workspace").Enemies:GetChildren()) do
                                                if v.Name == "rip_indra [Lv. 1500] [Boss]" then
                                                    repeat game:GetService("RunService").Heartbeat:wait()
                                                        pcall(function()
                                                            Tween(v.HumanoidRootPart.CFrame * CFrame.new(0,25,25))
                                                            game:GetService'VirtualUser':CaptureController()
                                                            game:GetService'VirtualUser':Button1Down(Vector2.new(1280, 672))
                                                            game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("TravelZou")
                                                            sethiddenproperty(game.Players.LocalPlayer, "SimulationRadius", math.huge)
                                                        end)
                                                    until _G.AutoThird == false or v.Humanoid.Health <= 0 or not v.Parent
                                                end
                                            end
                                        elseif not game:GetService("Workspace").Enemies:FindFirstChild("rip_indra [Lv. 1500] [Boss]") and (CFrame.new(-26880.93359375, 22.848554611206, 473.18951416016).Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude <= 1000 then
                                            Tween(CFrame.new(-26880.93359375, 22.848554611206, 473.18951416016))
                                        end
                                    elseif game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("ZQuestProgress","Check") ~= 0 then
                                        if game:GetService("Workspace").Enemies:FindFirstChild("Don Swan [Lv. 1000] [Boss]") or game:GetService("ReplicatedStorage"):FindFirstChild("Don Swan [Lv. 1000] [Boss]") then
                                            if game:GetService("Workspace").Enemies:FindFirstChild("Don Swan [Lv. 1000] [Boss]") then
                                                for i,v in pairs(game:GetService("Workspace").Enemies:GetChildren()) do
                                                    if v.Name == "Don Swan [Lv. 1000] [Boss]" then
                                                        repeat game:GetService("RunService").Heartbeat:wait()
                                                            pcall(function()
                                                                Tween(v.HumanoidRootPart.CFrame * CFrame.new(0,25,25))
                                                                game:GetService'VirtualUser':CaptureController()
                                                                game:GetService'VirtualUser':Button1Down(Vector2.new(1280, 672))
                                                                sethiddenproperty(game.Players.LocalPlayer, "SimulationRadius", math.huge)
                                                            end)
                                                        until _G.AutoThird == false or v.Humanoid.Health <= 0 or not v.Parent
                                                    end
                                                end
                                            else
                                                if (CFrame.new(2284.912109375, 15.537666320801, 905.48291015625).Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude > 1000 then
                                                    game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("requestEntrance",Vector3.new(2284.912109375, 15.537666320801, 905.48291015625))
                                                    wait()
                                                end
                                                Usefastattack = false
                                                Tween(CFrame.new(2284.912109375, 15.537666320801, 905.48291015625))
                                            end
                                        elseif _G.AutoThird and not game:GetService("Workspace").Enemies:FindFirstChild("Don Swan [Lv. 1000] [Boss]") and not game:GetService("ReplicatedStorage"):FindFirstChild("Don Swan [Lv. 1000] [Boss]") then
                                            Hop()
                                        elseif not _G.AutoThird and not game:GetService("Workspace").Enemies:FindFirstChild("Don Swan [Lv. 1000] [Boss]") and not game:GetService("ReplicatedStorage"):FindFirstChild("Don Swan [Lv. 1000] [Boss]") then
                                            if (CFrame.new(2284.912109375, 15.537666320801, 905.48291015625).Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude > 1000 then
                                                game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("requestEntrance",Vector3.new(2284.912109375, 15.537666320801, 905.48291015625))
                                                wait()
                                            end
                                            Usefastattack = false
                                            Tween(CFrame.new(2284.912109375, 15.537666320801, 905.48291015625))
                                        end
                                    end
                                elseif game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("TalkTrevor","1") ~= 0 then
                                    for i,v in pairs(game:GetService("Workspace"):GetChildren()) do
                                        if string.find(v.Name, "Fruit") then
                                            if v:IsA("Tool") then
                                                if (v.Handle.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude <= 20000 then
                                                    v.Handle.CFrame = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame
                                                end
                                            end
                                        end
                                    end
                                    if game.Players.LocalPlayer.Backpack:FindFirstChild("Quake Fruit") or game.Players.LocalPlayer.Backpack:FindFirstChild("Human: Buddha Fruit") or game.Players.LocalPlayer.Backpack:FindFirstChild("String Fruit") or game.Players.LocalPlayer.Backpack:FindFirstChild("Bird: Phoenix Fruit") or game.Players.LocalPlayer.Backpack:FindFirstChild("Rumble Fruit") or game.Players.LocalPlayer.Backpack:FindFirstChild("Paw Fruit") or game.Players.LocalPlayer.Backpack:FindFirstChild("Gravity Fruit") or game.Players.LocalPlayer.Backpack:FindFirstChild("Dough Fruit") or game.Players.LocalPlayer.Backpack:FindFirstChild("Shadow Fruit") or game.Players.LocalPlayer.Backpack:FindFirstChild("Venom Fruit") or game.Players.LocalPlayer.Backpack:FindFirstChild("Control Fruit") or game.Players.LocalPlayer.Backpack:FindFirstChild("Dragon Fruit") or game.Players.LocalPlayer.Character:FindFirstChild("Quake Fruit") or game.Players.LocalPlayer.Character:FindFirstChild("Human: Buddha Fruit") or game.Players.LocalPlayer.Character:FindFirstChild("String Fruit") or game.Players.LocalPlayer.Character:FindFirstChild("Bird: Phoenix Fruit") or game.Players.LocalPlayer.Character:FindFirstChild("Rumble Fruit") or game.Players.LocalPlayer.Character:FindFirstChild("Paw Fruit") or game.Players.LocalPlayer.Character:FindFirstChild("Gravity Fruit") or game.Players.LocalPlayer.Character:FindFirstChild("Dough Fruit") or game.Players.LocalPlayer.Character:FindFirstChild("Shadow Fruit") or game.Players.LocalPlayer.Character:FindFirstChild("Venom Fruit") or game.Players.LocalPlayer.Character:FindFirstChild("Control Fruit") or game.Players.LocalPlayer.Character:FindFirstChild("Dragon Fruit") then
                                        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("TalkTrevor","1")
                                        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("TalkTrevor","2")
                                        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("TalkTrevor","3")
                                    end
                                end
                            else
                                Tween(CFrame.new(-379.70889282227, 73.0458984375, 304.84692382813))
                                game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("SetSpawnPoint")
                            end
                        else
                            if game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BartiloQuestProgress","Bartilo") == 0 then
                                if string.find(game.Players.LocalPlayer.PlayerGui.Main.Quest.Container.QuestTitle.Title.Text, "Swan Pirates") and string.find(game.Players.LocalPlayer.PlayerGui.Main.Quest.Container.QuestTitle.Title.Text, "50") and game.Players.LocalPlayer.PlayerGui.Main.Quest.Visible == true then
                                    if game.Workspace.Enemies:FindFirstChild("Swan Pirate [Lv. 775]") then
                                        for i,v in pairs(game.Workspace.Enemies:GetChildren()) do
                                            if v.Name == "Swan Pirate [Lv. 775]" then
                                                PosMonBarto =  v.HumanoidRootPart.CFrame
                                                pcall(function()
                                                    repeat task.wait()
                                                        for k,x in pairs(game.Workspace.Enemies:GetChildren()) do
                                                            if x.Name ==  "Swan Pirate [Lv. 775]"  then
                                                                x.Humanoid:ChangeState(11)
                                                                sethiddenproperty(game.Players.LocalPlayer, "SimulationRadius", math.huge)
                                                                x.HumanoidRootPart.CanCollide = false
                                                                sethiddenproperty(game.Players.LocalPlayer, "SimulationRadius", math.huge)
                                                                x.HumanoidRootPart.Size = Vector3.new(30, 30, 30)
                                                                sethiddenproperty(game.Players.LocalPlayer, "SimulationRadius", math.huge)
                                                                x.HumanoidRootPart.CFrame = PosMonBarto
                                                                sethiddenproperty(game.Players.LocalPlayer, "SimulationRadius", math.huge)
                                                            end
                                                        end
                                                        v.HumanoidRootPart.CanCollide = false
                                                        v.HumanoidRootPart.Size = Vector3.new(35, 35, 35)
                                                        Tween( v.HumanoidRootPart.CFrame * CFrame.new(0,15,0))
                                                        game:GetService'VirtualUser':CaptureController()
                                                        game:GetService'VirtualUser':Button1Down(Vector2.new(1280, 672))                           
                                                    until not v.Parent or v.Humanoid.Health <= 0 or game.Players.LocalPlayer.PlayerGui.Main.Quest.Visible == false
                                                end)
                                            end
                                        end
                                    else
                                        Tween(CFrame.new(1057.92761, 137.614319, 1242.08069))
                                    end
                                else
                                    Tween(CFrame.new(-456.28952, 73.0200958, 299.895966))
                                    wait(1.1)
                                    game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("StartQuest","BartiloQuest",1)
                                end
                            elseif game.Players.LocalPlayer.Data.Level.Value >= 800 and game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BartiloQuestProgress","Bartilo") == 1 then
                                if game.Workspace.Enemies:FindFirstChild("Jeremy [Lv. 850] [Boss]") then
                                    MON = "Jeremy [Lv. 850] [Boss]"
                                    for i,v in pairs(game.Workspace.Enemies:GetChildren()) do
                                        if v.Name == MON then
                                            repeat wait()
                                                v.HumanoidRootPart.CanCollide = false
                                                v.HumanoidRootPart.Size = Vector3.new(35, 35, 35)
                                                Tween(v.HumanoidRootPart.CFrame * CFrame.new(0,15,0))
                                                game:GetService'VirtualUser':CaptureController()
                                                game:GetService'VirtualUser':Button1Down(Vector2.new(1280, 672))
                                            until not v.Parent or v.Humanoid.Health <= 0
                                        end
                                    end
                                elseif game.ReplicatedStorage:FindFirstChild("Jeremy [Lv. 850] [Boss]") then
                                    Tween(CFrame.new(-456.28952, 73.0200958, 299.895966))
                                    wait(1.1)
                                    game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BartiloQuestProgress","Bartilo")
                                    wait(1)
                                    Tween(CFrame.new(2099.88159, 448.931, 648.997375))
                                    wait(2)
                                else
                                    Tween(CFrame.new(2099.88159, 448.931, 648.997375))
                                end
                                wait(15)
                                if not game.ReplicatedStorage:FindFirstChild("Jeremy [Lv. 850] [Boss]") then
                                    Hop()
                                end
                            elseif game.Players.LocalPlayer.Data.Level.Value >= 800 and game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BartiloQuestProgress","Bartilo") == 2 then
								if (CFrame.new(-1850.49329, 13.1789551, 1750.89685).Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).magnitude <= 5 then
									game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-1858.87305, 19.3777466, 1712.01807)
									wait(1.5)
									game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-1803.94324, 16.5789185, 1750.89685)
									wait(1.5)
									game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-1858.55835, 16.8604317, 1724.79541)
									wait(1.5)
									game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-1869.54224, 15.987854, 1681.00659)
									wait(1.5)                                                                  
									game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-1800.0979, 16.4978027, 1684.52368) 
									wait(1.5)
									game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-1819.26343, 15.795166, 1717.90625)
									wait(1.5)
									game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-1813.51843, 15.8604736, 1724.79541)
									wait(1.5)
								else
									Tween(CFrame.new(-1850.49329, 13.1789551, 1750.89685))
								end
                            end
                        end
                    else
                        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("TravelZou")
                    end
                end
            end
        end
    end)
end)
spawn(function()
    pcall(function()
        while wait() do wait(5)
            if _G.AutoThird and NewWorld and game:GetService("Players").LocalPlayer.Data.Level.Value >= 1500 then
                if game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BartiloQuestProgress","Bartilo") == 3 then
                    if game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("TalkTrevor","1") ~= 0 then
                        if not game.Players.LocalPlayer.Backpack:FindFirstChild("Quake Fruit") and not game.Players.LocalPlayer.Backpack:FindFirstChild("Human: Buddha Fruit") and not game.Players.LocalPlayer.Backpack:FindFirstChild("String Fruit") and not game.Players.LocalPlayer.Backpack:FindFirstChild("Bird: Phoenix Fruit") and not game.Players.LocalPlayer.Backpack:FindFirstChild("Rumble Fruit") and not game.Players.LocalPlayer.Backpack:FindFirstChild("Paw Fruit") and not game.Players.LocalPlayer.Backpack:FindFirstChild("Gravity Fruit") and not game.Players.LocalPlayer.Backpack:FindFirstChild("Dough Fruit") and not game.Players.LocalPlayer.Backpack:FindFirstChild("Shadow Fruit") and not game.Players.LocalPlayer.Backpack:FindFirstChild("Venom Fruit") and not game.Players.LocalPlayer.Backpack:FindFirstChild("Control Fruit") and not game.Players.LocalPlayer.Backpack:FindFirstChild("Dragon Fruit") and not game.Players.LocalPlayer.Character:FindFirstChild("Quake Fruit") and not game.Players.LocalPlayer.Character:FindFirstChild("Human: Buddha Fruit") and not game.Players.LocalPlayer.Character:FindFirstChild("String Fruit") and not game.Players.LocalPlayer.Character:FindFirstChild("Bird: Phoenix Fruit") and not game.Players.LocalPlayer.Character:FindFirstChild("Rumble Fruit") and not game.Players.LocalPlayer.Character:FindFirstChild("Paw Fruit") and not game.Players.LocalPlayer.Character:FindFirstChild("Gravity Fruit") and not game.Players.LocalPlayer.Character:FindFirstChild("Dough Fruit") and not game.Players.LocalPlayer.Character:FindFirstChild("Shadow Fruit") and not game.Players.LocalPlayer.Character:FindFirstChild("Venom Fruit") and not game.Players.LocalPlayer.Character:FindFirstChild("Control Fruit") and not game.Players.LocalPlayer.Character:FindFirstChild("Dragon Fruit") then
                            Hop()
                        end
                    end
                end
            end
        end
    end)
end)
--while task.wait(.000000000000000000000000000000000000000000000000000001) do
--	game:GetService("RunService").Heartbeat:Connect(function()
spawn(function()
    while true do game:GetService("RunService").RenderStepped:Wait()
        for _,v in pairs(game:GetService("Workspace").Enemies:GetChildren()) do
			CheckQuest()
            if _G.AutoFarm and v.Name ~= "Ice Admiral [Lv. 700] [Boss]" and v.Name ~= "Don Swan [Lv. 3000] [Boss]" and v.Name ~= "Saber Expert [Lv. 200] [Boss]" and v.Name ~= "Longma [Lv. 2000] [Boss]" and StartMagnet and v:FindFirstChild("HumanoidRootPart") and v:FindFirstChild("Humanoid") and v.Humanoid.Health > 0 and (v.HumanoidRootPart.Position - game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.Position).magnitude <= 350 then
                if syn then
					if isnetworkowner(v.HumanoidRootPart) then
						v.HumanoidRootPart.CFrame = PosMon
						v.Humanoid.JumpPower = 0
						v.Humanoid.WalkSpeed = 0
						v.HumanoidRootPart.CanCollide = false
						v.HumanoidRootPart.Size = Vector3.new(50,50,50)
						if v.Humanoid:FindFirstChild("Animator") then
							v.Humanoid.Animator:Destroy()
						end
						sethiddenproperty(game.Players.LocalPlayer, "SimulationRadius",  math.huge)
						v.Humanoid:ChangeState(11)
					end
				else
					v.HumanoidRootPart.CFrame = PosMon
					v.Humanoid.JumpPower = 0
					v.Humanoid.WalkSpeed = 0
					v.HumanoidRootPart.CanCollide = false
					v.HumanoidRootPart.Size = Vector3.new(50,50,50)
					if v.Humanoid:FindFirstChild("Animator") then
						v.Humanoid.Animator:Destroy()
					end
					sethiddenproperty(game.Players.LocalPlayer, "SimulationRadius",  math.huge)
					v.Humanoid:ChangeState(11)
				end	
            end
        end
    end
end)

-- spawn(function()
-- 	while task.wait(.000000000000000000000000000000000000000000000000000001) do
-- 		if _G.AutoFarm then
-- 			pcall(function()
-- 				CheckQuest()
-- 				for _,v in pairs(game:GetService("Workspace").Enemies:GetChildren()) do
-- 					if _G.AutoFarm and StartMagnet and v.Name == Ms and v:FindFirstChild("Humanoid") and v:FindFirstChild("HumanoidRootPart") and (Ms == "Factory Staff [Lv. 800]" or Ms == "Monkey [Lv. 14]" or Ms == "Dragon Crew Warrior [Lv. 1575]" or Ms == "Dragon Crew Archer [Lv. 1600]" or Ms == "Head Baker [Lv. 2275]" or Ms == "Baking Staff [Lv. 2250]" or Ms == "Cake Guard [Lv. 2225]") and v.Humanoid.Health > 0 and (v.HumanoidRootPart.Position - game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.Position).Magnitude <= 150 then
-- 						v.Head.CanCollide = false
--                         v.HumanoidRootPart.CanCollide = false
--                         v.Humanoid.Sit = false
--                         v.HumanoidRootPart.Size = Vector3.new(60, 60, 60)
--                         v.HumanoidRootPart.CFrame = PosMon
--                         sethiddenproperty(game.Players.LocalPlayer, "SimulationRadius", math.huge)
-- 					elseif _G.AutoFarm and StartMagnet and v.Name == Ms and v:FindFirstChild("Humanoid") and v:FindFirstChild("HumanoidRootPart") and string.find(Ms, "Fishman") and v.Humanoid.Health > 0 and (v.HumanoidRootPart.Position - game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.Position).Magnitude <= 250 then
-- 						v.Head.CanCollide = false
--                         v.HumanoidRootPart.CanCollide = false
--                         v.Humanoid.Sit = false
--                         v.HumanoidRootPart.Size = Vector3.new(60, 60, 60)
--                         v.HumanoidRootPart.CFrame = PosMon
--                         sethiddenproperty(game.Players.LocalPlayer, "SimulationRadius", math.huge)
-- 					elseif _G.AutoFarm and StartMagnet and v.Name == Ms and v.Humanoid.Health > 0 and v:FindFirstChild("Humanoid") and v:FindFirstChild("HumanoidRootPart") and (v.HumanoidRootPart.Position - game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.Position).Magnitude <= 270 then
-- 						v.Head.CanCollide = false
--                         v.HumanoidRootPart.CanCollide = false
--                         v.Humanoid.Sit = false
--                         v.HumanoidRootPart.Size = Vector3.new(60, 60, 60)
--                         v.HumanoidRootPart.CFrame = PosMon
--                         sethiddenproperty(game.Players.LocalPlayer, "SimulationRadius", math.huge)
-- 					end
-- 				end
-- 			end
--             )
-- 		end
-- 	end
-- end
-- )
_G.AutoCavender = true
_G.AutoBuddy = true
spawn(function()
	while wait() do
		pcall(function()
			if game:GetService("Players").LocalPlayer.Data.Level.Value == 2300 then
				if _G.AutoCavender then
					local args = {
						[1] = "BuySuperhuman",
						[2] = true
					}
					
					Superhuman = game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer(unpack(args))
					local args = {
						[1] = "BuyBlackLeg",
						[2] = true
					}
					BlackLeg = game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer(unpack(args))
					local args = {
						[1] = "BuyElectro",
						[2] = true
					}
					
					Electro = game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer(unpack(args))
					local args = {
						[1] = "BuyFishmanKarate",
						[2] = true
					}
					
					FishmanKarate = game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer(unpack(args))
					local args = {
						[1] = "BlackbeardReward",
						[2] = "DragonClaw",
						[3] = "1",
						[4] = true
					}
					
					DragonClaw3 = game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer(unpack(args))
					if Superhuman == 1 or FishmanKarate == 1 or Electro == 1 or DragonClaw3 == 1 or BlackLeg == 1 then
						if not game:GetService("Players").LocalPlayer.PlayerGui.Main.Inventory.Container.Stored.ScrollingFrame.Frame:FindFirstChild('Canvander') then
							if game:GetService("Workspace").Enemies:FindFirstChild("Beautiful Pirate [Lv. 1950] [Boss]") then
								for i,v in pairs(game:GetService("Workspace").Enemies:GetChildren()) do
									if v.Name == "Beautiful Pirate [Lv. 1950] [Boss]" then
										if v:WaitForChild("Humanoid").Health > 0 then
											repeat task.wait()
												_G.AutoFarm = false
												_G.AutoBuddy = false
												Tween(v.HumanoidRootPart.CFrame * CFrame.new(0,30,0))
												v.HumanoidRootPart.CanCollide = false
												v.HumanoidRootPart.Size = Vector3.new(100, 100, 100)
												game:GetService("VirtualUser"):CaptureController()
												game:GetService("VirtualUser"):Button1Down(Vector2.new(1280, 670),workspace.CurrentCamera.CFrame)
											until not _G.Canvender or not v.Parent or v.Humanoid.Health <= 0
										end
									end
								end
							else
								_G.AutoFarm = false
								_G.Buddy = false
								game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("requestEntrance",Vector3.new(5314.58203125, 25.419387817383, -125.94227600098))
								for _,v in pairs(game:GetService("ReplicatedStorage"):GetChildren()) do
									if not game:GetService("ReplicatedStorage"):FindFirstChild("Beautiful Pirate [Lv. 1950] [Boss]") then
										Hop()
									end
								end
							end
						else
							spawn(function()
								pcall(function()
									while true do wait()
										if _G.AutoBuddy then
											if game:GetService("Players").LocalPlayer.Data.Level.Value == 2300 then
												local args = {
													[1] = "BuySuperhuman",
													[2] = true
												}
												
												Superhuman = game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer(unpack(args))
												local args = {
													[1] = "BuyBlackLeg",
													[2] = true
												}
												BlackLeg = game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer(unpack(args))
												local args = {
													[1] = "BuyElectro",
													[2] = true
												}
												
												Electro = game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer(unpack(args))
												local args = {
													[1] = "BuyFishmanKarate",
													[2] = true
												}
												
												FishmanKarate = game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer(unpack(args))
												local args = {
													[1] = "BlackbeardReward",
													[2] = "DragonClaw",
													[3] = "1",
													[4] = true
												}
												
												DragonClaw3 = game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer(unpack(args))
												if game:GetService("Players").LocalPlayer.PlayerGui.Main.Inventory.Container.Stored.ScrollingFrame.Frame:FindFirstChild('Canvander') then
													if Superhuman == 1 or FishmanKarate == 1 or Electro == 1 or DragonClaw3 == 1 or BlackLeg == 1 then
														if not game:GetService("Players").LocalPlayer.PlayerGui.Main.Inventory.Container.Stored.ScrollingFrame.Frame:FindFirstChild('Buddy Sword') then
															_G.AutoFarm = false
															for i,v in pairs(game:GetService("ReplicatedStorage"):GetChildren()) do
																if v:IsA('Model') then
																	if string.find(v.Name, "Cake Queen [Lv. 2175] [Boss]") then
																		if (game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame.Position - v.HumanoidRootPart.CFrame.Position).Magnitude >= 3000 then
																			game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-676.018127, 381.592041, -11180.0615, 0.968381941, 2.78306675e-08, -0.24947232, -3.5300463e-08, 1, -2.54684132e-08, 0.24947232, 3.34696395e-08, 0.968381941)
																			game.Players.LocalPlayer.Character.Humanoid.Health = 0
																			wait(0.5)
																			local args = {
																				[1] = "SetSpawnPoint"
																			}
																			game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer(unpack(args))
																		end
																	end
																end
															end
															if game:GetService("Workspace").Enemies:FindFirstChild("Cake Queen [Lv. 2175] [Boss]") then
																for i,v in pairs(game:GetService("Workspace").Enemies:GetChildren()) do
																	if v.Name == "Cake Queen [Lv. 2175] [Boss]" then
																		if v:WaitForChild("Humanoid").Health > 0 then
																			repeat task.wait()
																				_G.AutoFarm = false
																				_G.AutoCavender = false
																				Tween(v.HumanoidRootPart.CFrame * CFrame.new(0,30,0))
																				v.HumanoidRootPart.CanCollide = false
																				v.HumanoidRootPart.Size = Vector3.new(100, 100, 100)
																				game:GetService("VirtualUser"):CaptureController()
																				game:GetService("VirtualUser"):Button1Down(Vector2.new(1280, 670),workspace.CurrentCamera.CFrame)
																			until not _G.Buddy or not v.Parent or v.Humanoid.Health <= 0
																		end
																	end
																end
															else
																for i,v in pairs(game:GetService("ReplicatedStorage"):GetChildren()) do
																	if not game:GetService("ReplicatedStorage"):FindFirstChild("Cake Queen [Lv. 2175] [Boss]") then
																		Hop()
																	end
																end
															end
														end
													end
												end
											end
										end
									end
								end)
							end)
						end
					end
				end
			end
		end)
	end
end)
spawn(function()
	game:GetService("RunService").Heartbeat:Connect(function()
		pcall(function()
			for i,v in pairs(game:GetService("ReplicatedStorage"):GetChildren()) do
				if Auto_Bone and StartMagnetBoneMon and Magnet then
					if (v.Name == "Reborn Skeleton [Lv. 1975]" or v.Name == "Living Zombie [Lv. 2000]" or v.Name == "Demonic Soul [Lv. 2025]" or v.Name == "Posessed Mummy [Lv. 2050]") and (v.HumanoidRootPart.Position - MainMonBone.Position).Magnitude <= 300 then
						v.Head.CanCollide = false
						v.HumanoidRootPart.CanCollide = false
						v.HumanoidRootPart.Size = Vector3.new(60, 60, 60)
						v.HumanoidRootPart.CFrame = MainMonBone
						sethiddenproperty(game.Players.LocalPlayer, "SimulationRadius", math.huge)
					end
				end
			end
		end)
	end)
end)
warn("Anti AFK : Work")
local vu = game:GetService("VirtualUser")
game:GetService("Players").LocalPlayer.Idled:connect(function()
	vu:Button2Down(Vector2.new(0,0),workspace.CurrentCamera.CFrame)
	wait(1)
	vu:Button2Up(Vector2.new(0,0),workspace.CurrentCamera.CFrame)
end)
