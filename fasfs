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
