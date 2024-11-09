local tiemponuevo = {}

addEventHandler("onResourceStart", getRootElement(), function() 
	for k, v in ipairs(getElementsByType("player")) do
		removeElementData(v, "vehiculoAlquilado")
		removeElementData(v, "vehiculoAlquilados")
	end
end)

addEventHandler( "onCharacterLogout", getRootElement(), function()
	if getElementData(source, "vehiculoAlquilados") then
		destroyElement(getElementData(source, "vehiculoAlquilados"))
		removeElementData(source, "vehiculoAlquilados")
		local Continuar = getElementData(source, "vehiculoAlquilado")
		if Continuar then
			if isTimer(Continuar) then
				if killTimer(Continuar) then
					removeElementData(source, "vehiculoAlquilado")
				end
			end
		end
	end
end)

addEvent("alquilarVehiculo", true)
function createVeh(vehiculo, player, tiempo, monto)
	if vehiculo and player then
		if not getElementData(player, "vehiculoAlquilado") and not getElementData(player, "vehiculoAlquilados") then
			if takePlayerMoney(player, monto) then
				local vx, vy, vz = 1655.6107177734, -1892.2729492188, 13.552103996277
				local rx, ry, rz = 0, 0, 90
				local vehicle = createVehicle( getVehicleModelFromName(vehiculo), vx, vy, vz, rx, ry, rz)
				setElementInterior( vehicle, 0 )
				setElementDimension( vehicle, 0 )
				setVehicleLocked( vehicle, false )
				setVehicleEngineState( vehicle, true )
				setElementData(vehicle, "Fuel", 100 )
				setElementData(vehicle, "Vehiculos:JugadorA", player)
				setElementData(vehicle, "Vehiculos:Alquilado", true)
				tiemponuevo[player] = setTimer( function(playero, vehiculo)
					if getElementData(playero, "vehiculoAlquilado") then
						outputChatBox("#FFAE00El alquiler ha terminado, gracias por su compra.", playero, 0,0,0, true)
						destroyElement(vehiculo)
						removeElementData(playero, "vehiculoAlquilado")
						removeElementData(playero, "vehiculoAlquilados")
					end
				end, tiempo, 1, player, vehicle)
				setElementData(player, "vehiculoAlquilado", tiemponuevo[player])
				setElementData(player, "vehiculoAlquilados", vehicle)
				--exports["Logs-OC"]:sendDiscordLogMessage("ha alquilado un "..vehiculo.." por "..(tiempo*60).." segundos.", player)
				tiemponuevo[player] = nil
				outputChatBox("#3A7EFF[ALQUILER]#90C2FF Te hemos alquilado un/a: #589EF2"..vehiculo.."#90C2FF por el costo de #589EF2"..monto.."#90C2FF, estará estacionado esperando que lo uses. \nPara cancelar el alquiler puedes usar #F06C6C/cancelaralquiler", player, 0,0,0, true)
			else
				outputChatBox("#FF0000Necesitas tener como mínimo "..monto.." para alquilar el vehículo", player, 0,0,0, true)
			end
		else
			outputChatBox("#FF0000Ya has alquilado un vehículo, espera que concluya el tiempo.", player, 0,0,0, true)
		end
	end
end
addEventHandler("alquilarVehiculo", getRootElement(), createVeh)

addEvent("desalquilarVehiculo", true)
function destroyVeh(playeros)
	if playeros then
		local Continuar = getElementData(playeros, "vehiculoAlquilado")
		if Continuar then
			if isTimer(Continuar) then
				local vehiculoAlquilao = getElementData(playeros, "vehiculoAlquilados")
				if vehiculoAlquilao then
					if killTimer(Continuar) then
						if destroyElement(vehiculoAlquilao) then
							outputChatBox("#3A7EFF[ALQUILER]#F06C6C Has cancelado el alquiler de un vehículo", playeros, 0,0,0, true)
							removeElementData(playeros, "vehiculoAlquilado")
							removeElementData(playeros, "vehiculoAlquilados")
						else
							outputChatBox("#FF0000No se pudo destruir el vehículo.", playeros, 0,0,0, true)
						end
					else
						outputChatBox("#FF0000No se pudo cancelar el alquiler.", playeros, 0,0,0, true)
					end
				else
					outputChatBox("#FF0000No tienes ningún vehículo alquilado.", playeros, 0,0,0, true)
				end
			else
				outputChatBox("#FF0000No tienes ningún vehiculo alquilado", playeros, 0,0,0, true)
			end
		else
			outputChatBox("#FF0000No tienes ningún vehículo alquilado.", playeros, 0,0,0, true)
		end
	end
end
addCommandHandler("cancelaralquiler", destroyVeh)
addEventHandler("desalquilarVehiculo", getRootElement(), destroyVeh)