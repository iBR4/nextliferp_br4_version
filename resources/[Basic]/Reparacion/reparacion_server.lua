loadstring(exports.MySQL:getMyCode())()

import('*'):init('MySQL')

local PagarReparacion = {}
local MarkersRepairs = {}
local ReparandoVehiculo = {}
-- code money #00DD00

addEventHandler("onResourceStart", resourceRoot, function()

	for i, v in ipairs(getMarkerRepairs()) do

		Blip( 1025.0031738281, -1024.5626220703, 32.1015625, 27, 0, 0, 0, 0, 0, 0, 200, getRootElement() )

		MarkersRepairs[i] = Marker(v.Posiciones[1], v.Posiciones[2], v.Posiciones[3]-1, "cylinder", 4.5, 255, 0, 0, 50)

		--

		addEventHandler("onMarkerLeave", MarkersRepairs[i], function(player)

			if player and player:getType() =="player" then

				if player:isInVehicle() then

					local veh = player:getOccupiedVehicle()

					local seat = player:getOccupiedVehicleSeat()

					if veh and seat == 0 then

						if PagarReparacion[player] == true then

							PagarReparacion[player] = false
						--	setDato(player, "PagarReparacion", "No", true)

							--

							exports["Notificaciones"]:setTextNoti(player, "¡Acabas de cancelar la reparación de tu auto!", 150, 50, 50)

						end

					end

				end

			end

		end)

	end

end)

local comandosdisponibles = createMarker ( 2501.6142578125, -1547.3289794922, 24.54062461853, "cylinder", 2, 255,255,0,0 )

function mensajeelevador(source)
	if isElementWithinMarker(source, comandosdisponibles) then
		outputChatBox("Escribe #FBFF00/repararveh#ffffff para empezar a reparar tu vehículo.",source,255,255,255,true)
	end
end
addEventHandler("onMarkerHit", comandosdisponibles, mensajeelevador)

local comandosdisponibles2 = createMarker ( 2164.3779296875, -1908.5120849609, 13.587950706482, "cylinder", 2, 255,255,0,0 )
function mensajeelevador2(source)
	if isElementWithinMarker(source, comandosdisponibles2) then
		outputChatBox("Escribe #FBFF00/repararveh#ffffff para empezar a reparar tu vehículo.",source,255,255,255,true)
	end
end
addEventHandler("onMarkerHit", comandosdisponibles2, mensajeelevador2)

local comandosdisponibles3 = createMarker ( 1024.9727783203, -1024.8627929688, 32.153297424316, "cylinder", 2, 255,255,0,0 )
function mensajeelevador3(source)
	if isElementWithinMarker(source, comandosdisponibles3) then
		outputChatBox("Escribe #FBFF00/repararveh#ffffff para empezar a reparar tu vehículo.",source,255,255,255,true)
	end
end
addEventHandler("onMarkerHit", comandosdisponibles3, mensajeelevador3)



addCommandHandler("repararveh", function(player, cmd)
	if not notIsGuest(player) then
		local veh = player:getOccupiedVehicle()
		local seat = player:getOccupiedVehicleSeat()
		if player:isInVehicle() then
			if veh and seat == 0 then
				for i, marker in ipairs(MarkersRepairs) do
					if player:isWithinMarker(marker) then
						local costoTotal = math.ceil(0.2*veh:getHealth())
						if veh:getHealth() <= 1000 then
							if player:getMoney() >= costoTotal then
								
								--
								player:outputChat("#FFFFFFEstas a punto de reparar tu vehículo por favor usa  #FBFF00/rpagar", 255, 255, 255, true)

								--
								PagarReparacion[player] = true
							--	setDato(player, "PagarReparacion", "Si", true)

							else

								exports["Notificaciones"]:setTextNoti(player, "Debes tener: $"..convertNumber(costoTotal).." dólares para reparar tu vehiculo.", 150, 50, 50)

							end

						else

							exports["Notificaciones"]:setTextNoti(player, "El vehículo debe tener menos de 90% de daño.", 150, 50, 50)

						end

					end

				end

			else

				exports["Notificaciones"]:setTextNoti(player, "Solamente el conductor puede usar este comando.", 150, 50, 50)

			end

		end

	end

end)



local timerReparacion = {}



addCommandHandler("rpagar", function(player)
	if not notIsGuest(player) then
		local veh = player:getOccupiedVehicle()
		local seat = player:getOccupiedVehicleSeat()
		if player:isInVehicle() then
			if veh and seat == 0 then
				if PagarReparacion[player] == true then
					for i, marker in ipairs(MarkersRepairs) do
						if player:isWithinMarker(marker) then
							local costoTotal = math.ceil(0.5*veh:getHealth())
							if veh:getHealth() <= 1000 then
								if player:getMoney() >= costoTotal then
									veh:setEngineState(false)
									veh:setLightState(0, 1)
									veh:setLightState(1, 1)
									veh:setData('Motor','apagado')
									veh:setFrozen(true)
									--
									player:outputChat("¡Si te bajas del vehículo se cancelara la reparación!", 150, 50, 50)
									--
									player:triggerEvent("callCinematic", player, "Reparando", 5000, "No")
									timerReparacion[player] = setTimer(function(p, veh, cost)
											if isElement(p) and isElement(veh) then
												veh:setFrozen(false)
												veh:setEngineState(true)
												veh:setData('Motor','encendido')
												--
												p:outputChat("Vehiculo reparado. Costo: #2F7D00"..convertNumber(costoTotal).." dólares.", 255, 255, 255, true)
												--
												playSoundFrontEnd(p, 46)
												--
												veh:fix()
												p:takeMoney(tonumber(cost))
												--
										--		setDato(p, "ReparandoVehiculo", "No", true)
												ReparandoVehiculo[player] = true
												--
											end
										end, 5000, 1, player, veh, costoTotal)
									--
							--		setDato(player, "ReparandoVehiculo", "Si", true)
									ReparandoVehiculo[player] = true
									PagarReparacion[player] = false
								--	setDato(player, "PagarReparacion", "No", true)
								else
									exports["Notificaciones"]:setTextNoti(player, "Debes tener: $"..convertNumber(costoTotal).." dólares para reparar tu vehiculo.", 150, 50, 50)
								end
							else
								exports["Notificaciones"]:setTextNoti(player, "El vehículo debe tener menos de 90% de daño.", 150, 50, 50)
							end
						end
					end
				end
			end
		end
	end
end)



addEventHandler("onVehicleExit", getRootElement(), function(player, seat, jacked)

	if ReparandoVehiculo[player] == true or PagarReparacion[player] == true then

		if isTimer(timerReparacion[player]) then

			killTimer(timerReparacion[player])

		end

		--

		exports["Notificaciones"]:setTextNoti(player, "¡Acabas de cancelar la reparación de tu auto!", 150, 50, 50)

		--

		ReparandoVehiculo[player] = false
		PagarReparacion[player] = false
	--	setDato(player, "ReparandoVehiculo", "No", true)

	--	setDato(player, "PagarReparacion", "No", true)

	end

end)





