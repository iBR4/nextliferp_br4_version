local marcadorSalida = Marker(1414.2526855469, -11.995247840881, 1000.9251708984-1, "cylinder", 3, 100, 100, 100, 0)
marcadorSalida:setInterior(1)
marcadorSalida:setDimension(4)
local marcadorEntrada = Marker(1176.970703125, -1308.7109375, 13.911705970764, "cylinder", 3, 100, 100, 100, 0)
marcadorEntrada:setInterior(0)
marcadorEntrada:setDimension(0)
addEventHandler("onResourceStart", getRootElement(), function()
	for i, v in ipairs(Element.getAllByType("player")) do
		bindKey(v, "mouse1", "down", function(player)
			if not notIsGuest(player) then
				if player:isWithinMarker(marcadorSalida) then
					if getElementDimension( player ) == 4 and getElementInterior( player ) == 1 then
						local veh = player:getOccupiedVehicle()
						local seat = player:getOccupiedVehicleSeat()
						if player:isInVehicle() and veh and seat == 0 then
		 					veh:setPosition(1176.970703125, -1308.7109375, 13.911705970764)
							veh:setRotation(-0, 0, 65.729461669922)
							veh:setInterior(0)
							veh:setDimension(0)
							player:setDimension(0)
							player:setInterior(0)
						else
							player:setPosition(1180.5048828125, -1308.169921875, 13.701462745667)
							player:setDimension(0)
							player:setInterior(0)
						end
					end
				elseif player:isWithinMarker(marcadorEntrada) then
					if getPlayerFaction(player, "Medico") then
						local veh = player:getOccupiedVehicle()
						local seat = player:getOccupiedVehicleSeat()
						if player:isInVehicle() and veh and seat == 0 then
							veh:setPosition(1414.2526855469, -11.995247840881, 1000.9251708984)
							veh:setDimension(4)
							veh:setRotation(-0, 0, 173.85733032227)
							veh:setInterior(1)
							player:setDimension(4)
							player:setInterior(1)
						else
							player:setPosition(1414.2526855469, -11.995247840881, 1000.9251708984)
							player:setDimension(4)
							player:setInterior(1)
						end
					else
						exports['Notificaciones']:setTextNoti(player, "Necesitas ser LSRD para poder entrar.", 150, 50, 50)
					end
				end
			end
		end,player)
	end
end)
addEventHandler("onPlayerLogin",getRootElement(),function()
	for i, v in ipairs(Element.getAllByType("player")) do
		bindKey(v, "mouse1", "down", function(player)
			if not notIsGuest(player) then
				if player:isWithinMarker(marcadorSalida) then
					if getElementDimension( player ) == 4 and getElementInterior( player ) == 1 then
						local veh = player:getOccupiedVehicle()
						local seat = player:getOccupiedVehicleSeat()
						if player:isInVehicle() and veh and seat == 0 then
		 					veh:setPosition(1176.970703125, -1308.7109375, 13.911705970764)
							veh:setRotation(-0, 0, 65.729461669922)
							veh:setInterior(0)
							veh:setDimension(0)
							player:setDimension(0)
							player:setInterior(0)
						else
							player:setPosition(1180.5048828125, -1308.169921875, 13.701462745667)
							player:setDimension(0)
							player:setInterior(0)
						end
					end
				elseif player:isWithinMarker(marcadorEntrada) then
					if getPlayerFaction(player, "Medico") then
						local veh = player:getOccupiedVehicle()
						local seat = player:getOccupiedVehicleSeat()
						if player:isInVehicle() and veh and seat == 0 then
							veh:setPosition(1414.2526855469, -11.995247840881, 1000.9251708984)
							veh:setDimension(4)
							veh:setRotation(-0, 0, 173.85733032227)
							veh:setInterior(1)
							player:setDimension(4)
							player:setInterior(1)
						else
							player:setPosition(1414.2526855469, -11.995247840881, 1000.9251708984)
							player:setDimension(4)
							player:setInterior(1)
						end
					else
						exports['Notificaciones']:setTextNoti(player, "Necesitas ser LSRD para poder entrar.", 150, 50, 50)
					end
				end
			end
		end)
	end
end)
--[[local marcadorSalida = Marker(485.7958984375, 467.0107421875, 1025.8203125-1, "cylinder", 3, 100, 100, 100, 0)
marcadorSalida:setInterior(6)
local marcadorEntrada = Marker(-172.6244354248, 201.69821166992, 17.49169921875-1, "cylinder", 3, 100, 100, 100, 0)
marcadorEntrada:setInterior(0)
--PD
local salida = Marker(478.8291015625, 103.01953887939, 1021.7077636719-1, "cylinder", 3, 100, 100, 100, 0)
salida:setInterior(4)
local entrada = Marker(5.7446880340576, -1086.0267333984, 27.966259002686-1, "cylinder", 3, 100, 100, 100, 0)
entrada:setInterior(0)
addEventHandler("onResourceStart", resourceRoot, function()
	for i, v in ipairs(Element.getAllByType("player")) do
		bindKey(v, "mouse1", "down", function(player)
			if not notIsGuest(player) then
				if player:isWithinMarker(marcadorSalida) then
					local veh = player:getOccupiedVehicle()
					local seat = player:getOccupiedVehicleSeat()
					if player:isInVehicle() and veh and seat == 0 then
							player:setInterior(0)
							veh:setPosition(5.7446880340576, -1086.0267333984, 27.966259002686)
							veh:setInterior(0)
							veh:setRotation(-0, 0, 107)
						for ind,val in ipairs(getVehicleOccupants(veh)) do
							val:setInterior(0)
						end
					else
						player:setPosition(5.7446880340576, -1086.0267333984, 27.966259002686)
						player:setDimension(0)
						player:setInterior(0)
					end
				elseif player:isWithinMarker(marcadorEntrada) then
					--if getPlayerFaction(player, "Policia") then
						local veh = player:getOccupiedVehicle()
						local seat = player:getOccupiedVehicleSeat()
						if player:isInVehicle() and veh and seat == 0 then
								player:setInterior(6)
								veh:setPosition(478.8291015625, 103.01953887939, 1021.7077636719)
								veh:setRotation(0, 0, 178.26416015625)
								veh:setInterior(4)
							for ind,val in ipairs(getVehicleOccupants(veh)) do
								val:setInterior(4)
							end	
						else
							player:setPosition(478.8291015625, 103.01953887939, 1021.7077636719)
							player:setInterior(4)
						end
					--else
					--	exports['[LS]Notificaciones']:setTextNoti(player, "Necesitas ser LSRD para poder entrar.", 150, 50, 50)
					--end
				elseif player:isWithinMarker(salida) then
					local veh = player:getOccupiedVehicle()
					local seat = player:getOccupiedVehicleSeat()
					if player:isInVehicle() and veh and seat == 0 then
							player:setInterior(0)
							veh:setPosition(5.7446880340576, -1086.0267333984, 27.966259002686)
							veh:setInterior(0)
							veh:setRotation(-0, 0, 353)
						for ind,val in ipairs(getVehicleOccupants(veh)) do
							val:setInterior(0)
						end
					else
						player:setPosition(5.7446880340576, -1086.0267333984, 27.966259002686)
						player:setDimension(0)
						player:setInterior(0)
					end
				elseif player:isWithinMarker(entrada) then
						--if getPlayerFaction(player, "Policia") then
						local veh = player:getOccupiedVehicle()
						local seat = player:getOccupiedVehicleSeat()
						if player:isInVehicle() and veh and seat == 0 then
								player:setInterior(4)
								veh:setPosition(478.8291015625, 103.01953887939, 1021.7077636719)
								veh:setRotation(0, 0, 178.26416015625)
								veh:setInterior(4)
							for ind,val in ipairs(getVehicleOccupants(veh)) do
								val:setInterior(4)
							end	
						else
							player:setPosition(478.8291015625, 103.01953887939, 1021.7077636719)
							player:setInterior(4)
						end
					--else
					--	exports['[LS]Notificaciones']:setTextNoti(player, "Necesitas ser LSRD para poder entrar.", 150, 50, 50)
					--end
				end
			end
		end)
	end
end)
]]