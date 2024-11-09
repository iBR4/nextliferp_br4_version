local Rentas = {
	Info = {
		 {462, 1661.5915527344, -1902.7338867188, 13.3, 0, 0, 2.2, 70}
		,{462,1659.1832275391, -1902.6949462891, 13.3, 0, 0, 2.2, 70}
		,{462,1664.4688720703, -1903.2485351563, 13.3, 0, 0, 2.2, 70}
		,{462,1667.2891845703, -1902.7875976563, 13.3, 0, 0, 2.2, 70}
		,{604,1668.0953369141, -1885.6697998047, 13.3, 0, 0, 89, 80}
		,{466,1668.3645019531, -1891.263671875, 13.3, 0, 0, 89, 85}
		,{542,1668.4317626953, -1897.3745117188, 13.3, 0, 0, 89, 90}
		,{478,1646.0145263672, -1903.9688720703, 13.3, 0, 0, 2.2, 10}
		,{516,1639.0792236328, -1904.1765136719, 13.3, 0, 0, 2.2, 110}
	},
	creados = {},
	tiempos = {}
}
addEventHandler( "onResourceStart", getResourceRootElement(),
	function()
		for i,v in ipairs(Rentas.Info) do
			
			local id,x,y,z,rx,ry,rz,precio = unpack(v)
			Rentas.creados[i] = Vehicle(id,x,y,z,rx,ry,rz, 'Rentable')
			Rentas.creados[i]:setData('Vehiculo:Rentable:Precio', precio)
			Rentas.creados[i]:setData('Vehiculo:Rentable:Duracion', 600)
			Rentas.creados[i]:setData('InRenta', false)
			Rentas.creados[i]:setData('Fuel',100)
			Rentas.creados[i]:setDamageProof( true )
			Rentas.creados[i].frozen = true
			if id == 481 or id == 462 then
				Rentas.creados[i]:setData("LockedVeh", true)
			else
				Rentas.creados[i]:setLocked( true ) 
			end
		end
		Timer(triggerClientEvent,1000,1,'onClienVehicleRentaText',resourceRoot, Rentas.creados)
	end
)
function RentarVehiculo(player)
	
	local veh = getVehicleCercano(player)
	if veh then
		if not player:getData('InRenta') then
			
			if not veh:getData('InRenta') then
				local precio = veh:getData('Vehiculo:Rentable:Precio')
				
				if precio then
					if player:getMoney() >= precio then
						player:takeMoney(precio)
						veh:setData('InRenta',player)
						player:setData('InRenta',true)
						veh:setLocked(false)
						veh:setDamageProof(false)
						veh.frozen = false
						if veh.model == 481 or veh.model == 462 then
							veh:setData("LockedVeh", false)
						end
						exports['Notificaciones']:setTextNoti(player, 'Haz rentado un/a '..getVehicleNameFromModel( veh.model ), 0,255,0)
						Rentas.tiempos[veh] = Timer(
							function(veh)
								local duration = veh:getData('Vehiculo:Rentable:Duracion')
								if duration > 0 then
									veh:setData('Vehiculo:Rentable:Duracion', duration-1)
								else
									local owner = veh:getData('InRenta')
									if isElement( owner ) then
										if owner.vehicle and owner.vehicle == veh then
											removePedFromVehicle( owner )
										end
										
										owner:setData('InRenta',false)
									end
									veh:respawn()
									veh:setData('Vehiculo:Rentable:Duracion', 600)
									veh:setData('InRenta',false)
									veh:setData('Fuel',100)
									veh:setDamageProof( true )
									veh:setEngineState(false)
									veh.frozen = true
									if veh.model == 481 or id == 462 then
										veh:setData("LockedVeh", true)
									else
										veh:setLocked( true ) 
									end
									Rentas.tiempos[veh]:destroy()
								end
							end
						, 1000, 0, veh)
					end
				end
			end
		else
			exports['Notificaciones']:setTextNoti(player, '¡Ya haz rentado un vehiculo!', 255,0,0)
		end
	end
end
addCommandHandler("sasas", RentarVehiculo)
function getVehicleCercano(player)
	for k,v in pairs(Element.getAllByType('vehicle')) do
		
		if getDistanceBetweenPoints3D( player.position, v.position ) <= 3 then
			return v
		end
	end
	return false
end
addEventHandler( "onPlayerJoin", getRootElement(), 
	function()
		if #Rentas.creados > 0 then
			Timer(triggerClientEvent,1000,1,'onClienVehicleRentaText',source, Rentas.creados)
		end
	end
)
addEventHandler( "onResourceStop", getResourceRootElement(),
	function()
		for i,v in ipairs(Element.getAllByType('player')) do
			
			if v:getData('InRenta') then
				v:setData('InRenta', false)
			end
		end
	end
)