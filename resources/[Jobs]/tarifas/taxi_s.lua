local tarifas = { }
addCommandHandler( "tarifas",
	function( player )
		local veh = getPedOccupiedVehicle( player )
		if veh and getVehicleNameFromModel( getElementModel( veh ) ) == "Taxi" and getElementData(player,"Roleplay:trabajo") == "Taxista" or getElementData(player,"Roleplay:trabajoVIP") == "Taxista" then
			if not tarifas[veh] then tarifas[veh] = { } outputChatBox( "No hay tarifas asignadas", player, 255, 0, 0 )
			else
				outputChatBox( "Tarifas del Taxi matricula: "..getVehiclePlateText( veh ), player, 255,255,255 )
				for i=1, #tarifas[veh] do 
					local d = tarifas[veh][i]
					outputChatBox( "	Tarifa "..i..": Coste/m - "..d, player, 0, 255, 0 )
				end
				outputChatBox( "Utiliza /limpiartarifas para asignar nuevas", player, 255,255,255 )
			end
		end
	end
)
addEventHandler( "onVehicleExit", getRootElement( ),
	function( p, seat )
		if seat ~= 0 and getVehicleNameFromModel( getElementModel( source ) ) == "Taxi" then
			local a_pagar = getElementData( source, "cantidad_a_pagar" ) or 0
			if a_pagar then
				local money = getPlayerMoney( p )
				if money >= a_pagar then
					local conductor = getVehicleOccupant( source, 0 )
					takePlayerMoney( p, a_pagar )
					outputChatBox( "Se te ha cobrado "..math.floor(a_pagar)..",00$ por el viaje", p, 0, 255, 0 )
					if conductor then
						outputChatBox( "Recibiste "..math.floor(a_pagar)..",00$ por el viaje", conductor, 0, 255, 0 )
						givePlayerMoney( conductor, tonumber( math.floor(a_pagar) )/2 )
					end
				end
			end
		end
	end
)
addEventHandler( "onVehicleEnter", getRootElement( ),
	function( p, seat )
		if getVehicleNameFromModel( getElementModel( source ) ) == "Taxi" then
			triggerClientEvent( p, "asignarTarifasCoche", p, source, tarifas[source] )
		end
	end
)
addCommandHandler( "borrartarifa",
	function( p, cmd, id )
		local veh = getPedOccupiedVehicle( p ) 
		if veh and getVehicleNameFromModel( getElementModel( veh ) ) == "Taxi" and getElementData(player,"Roleplay:trabajo") == "Taxista" or getElementData(player,"Roleplay:trabajoVIP") == "Taxista" then
			if not tarifas[veh] then tarifas[veh] = { } outputChatBox( "No hay tarifas asignadas", p, 255, 0, 0 )
			else
				if id then 
					if tarifas[veh][tonumber(id)] then 
						outputChatBox( "Borrada la tarifa "..id..".", p, 0, 255, 0 )
						table.remove( tarifas[veh], id )
						triggerClientEvent( root, "actualizarTarifasVeh", root, veh, tarifas[veh] )
					else
						outputChatBox( "La tarifa "..id.." no existe.", p, 255, 0, 0 )
					end
				else
					outputChatBox( "CMD: /"..cmd.." [nº tarifa. puedes ver en /tarifas]", p, 255, 0, 0 )
				end
			end
		end		
	end
)
addCommandHandler( "creartarifa",
	function( player, cmd, coste )
		local veh = getPedOccupiedVehicle( player )
		if veh and getVehicleNameFromModel( getElementModel( veh ) ) == "Taxi" and getElementData(player,"Roleplay:trabajo") == "Taxista" or getElementData(player,"Roleplay:trabajoVIP") == "Taxista" then
			if not tarifas[veh] then tarifas[veh] = { } else
				if #tarifas[veh] < 4 then
					local coste = tonumber(coste)
					if coste then
						if coste < 10 then
							table.insert( tarifas[veh], coste )
							outputChatBox( "Nueva tarifa "..#tarifas[veh].." creada.", player, 0, 255, 0 )
							outputChatBox( "Coste por metro: "..coste.."$.", player, 0, 255, 0 )
							triggerClientEvent( root, "actualizarTarifasVeh", root, veh, tarifas[veh] )
							outputChatBox( "Tarifas actualizadas", player, 0, 255, 0 )
						else
							outputChatBox( "El coste es demasiado alto, no te pases.", player, 255, 0, 0 )
						end
					else
						outputChatBox( "Debes asignar un coste por metro a la tarifa.", player, 255, 0, 0 )
						outputChatBox( "Uso: /"..cmd.." [coste por metro(numero)]", player, 255, 0, 0 )
					end
				else
					outputChatBox( "Solo puedes crear 3 tarifas maximo", player, 255, 0, 0 )
				end
			end
		else
			outputChatBox( "Debes ser un taxista y estar en un vehiculo 'Taxi' para crear tarifas", player, 255, 0, 0 )
		end
	end
)