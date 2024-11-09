local marcadorSalida = Marker(1826.171875, -1538.4677734375, 13.54687, "cylinder", 3, 100, 100, 100, 0)
marcadorSalida:setInterior(0)
marcadorSalida:setDimension(0)
local marcadorEntrada = Marker(1820.3701171875, -1536.779296875, 13.429853439331, "cylinder", 3, 100, 100, 100, 0)
marcadorEntrada:setInterior(0)
marcadorEntrada:setDimension(0)
addEventHandler("onResourceStart", resourceRoot, function()
	for i, v in ipairs(Element.getAllByType("player")) do
		bindKey(v, "mouse1", "down", function(player)
			if not notIsGuest(player) then
				if player:isWithinMarker(marcadorSalida) then
					if getElementDimension( player ) == 0 and getElementInterior( player ) == 0 then
						local veh = player:getOccupiedVehicle()
						local seat = player:getOccupiedVehicleSeat()
						if player:isInVehicle() and veh and seat == 0 then
							veh:setPosition(1820.3701171875, -1536.779296875, 13.429853439331)
							veh:setRotation(0, 0, 80.483520507812)
							veh:setInterior(0)
							veh:setDimension(0)
							player:setDimension(0)
							player:setInterior(0)
						else
							player:setPosition(1820.3701171875, -1536.779296875, 13.429853439331)
							player:setDimension(0)
							player:setInterior(0)
						end
					end
				elseif player:isWithinMarker(marcadorEntrada) then
					if getPlayerFaction(player, "Policia") then
						local veh = player:getOccupiedVehicle()
						local seat = player:getOccupiedVehicleSeat()
						if player:isInVehicle() and veh and seat == 0 then
							veh:setPosition(1826.171875, -1538.4677734375, 13.54687)
							veh:setDimension(0)
							veh:setRotation(0, 0, 257.27471923828)
							veh:setInterior(0)
							player:setDimension(0)
							player:setInterior(0)
						else
							player:setPosition(1826.171875, -1538.4677734375, 13.54687)
							player:setDimension(0)
							player:setInterior(0)
						end
					else
						player:outputChat("Necesitas ser #F43C33LSFD #FFFFFFpara ingresar al garage",255,255,255,true)
					end
				end
			end
		end)
	end
end)
addEventHandler("onPlayerLogin", getRootElement(), function()
	bindKey(source, "mouse1", "down", function(player)
		if not notIsGuest(player) then
			if player:isWithinMarker(marcadorSalida) then
				if getElementDimension( player ) == 0 and getElementInterior( player ) == 0 then
					local veh = player:getOccupiedVehicle()
					local seat = player:getOccupiedVehicleSeat()
					if player:isInVehicle() and veh and seat == 0 then
						veh:setPosition(1820.3701171875, -1536.779296875, 13.429853439331)
						veh:setRotation(0, 0, 80.483520507812)
						veh:setInterior(0)
						veh:setDimension(0)
						player:setDimension(0)
						player:setInterior(0)
					else
						player:setPosition(1820.3701171875, -1536.779296875, 13.429853439331)
						player:setDimension(0)
						player:setInterior(0)
					end
				end
			elseif player:isWithinMarker(marcadorEntrada) then
				if getPlayerFaction(player, "Policia") then
					local veh = player:getOccupiedVehicle()
					local seat = player:getOccupiedVehicleSeat()
					if player:isInVehicle() and veh and seat == 0 then
						veh:setPosition(1826.171875, -1538.4677734375, 13.54687)
						veh:setDimension(0)
						veh:setRotation(0, 0, 257.27471923828)
						veh:setInterior(0)
						player:setDimension(0)
						player:setInterior(0)
					else
						player:setPosition(1826.171875, -1538.4677734375, 13.54687)
						player:setDimension(0)
						player:setInterior(0)
					end
				else
					player:outputChat("Necesitas ser #F43C33LSFD #FFFFFFpara ingresar al garage",255,255,255,true)
				end
			end
		end
	end)
end)