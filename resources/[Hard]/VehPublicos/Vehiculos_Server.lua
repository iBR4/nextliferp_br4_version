loadstring(exports.MySQL:getMyCode())()
import('*'):init('MySQL')
--local baliza = {}
permisos = {
["Desarrollador"]=true,
["Administrador.General"]=true,
["Admin"]=true,
["Sup.Staff"]=true,
["SuperModerador"]=true,
["Moderador"]=true,
["Moderador A Pruebas"]=true,
}
local CinturonSeguridad = {}
--[[addCommandHandler("balizas",function(source)
	local veh = getPedOccupiedVehicle(source)
	if veh then
		if baliza[veh] == true then
			baliza[veh] = false
		else
			baliza[veh] = true
		end
	end
end)]]
addEventHandler("onVehicleEnter", getRootElement(), function( thePlayer, seat, jacked )
	if thePlayer:getType() == "player" then
		if seat == 0 then
			if thePlayer:getData('Roleplay:faccion') == source:getData("VehiculoPublico") or thePlayer:getData("Roleplay:trabajo") == source:getData("VehiculoPublico") or thePlayer:getData("Roleplay:trabajoVIP") == source:getData("VehiculoPublico") or thePlayer:getData("Roleplay:Mision") == source:getData("VehiculoPublico") or permisos[getACLFromPlayer(source)] == true then
			else
				thePlayer:removeFromVehicle(thePlayer:getOccupiedVehicle())
				source:setEngineState (false)
				source:setLightState(0, 1)
				source:setLightState(1, 1)
				source:setFrozen(false)
				outputChatBox("#FFFFFFEste vehiculo solo puede manejarlo un #FBFFA4trabajador publico",thePlayer, 150, 50, 50, true)
				--
			end
		end
	end
end)
addEventHandler("onVehicleStartExit", getRootElement(), function(thePlayer, seat)
	local veh = thePlayer:getOccupiedVehicle()
	if veh:getData('Locked') == 'Cerrado' then
		thePlayer:outputChat("¡El vehiculo está BLOQUEADO! NO puedes bajarte.",255,50,50,true)
		cancelEvent()
	else
	 	if CinturonSeguridad[thePlayer] then
			if CinturonSeguridad[thePlayer] == true then
				MensajeRol(thePlayer, " se desabrocha el cinturon de seguridad.")
				CinturonSeguridad[thePlayer] = nil
				setElementData(thePlayer,"cinturon",false)
			end
		end
	end
end)
addEventHandler("onVehicleDamage", getRootElement(), function(loss)
	local thePlayer = source:getOccupant()
	if (thePlayer) then
		local dmg = math.floor(loss)
		if dmg >= 100 then
			if CinturonSeguridad[thePlayer] then
				if CinturonSeguridad[thePlayer] == true then
					thePlayer:outputChat("#FF3E3EEl vehículo sufrió un gran daño debido al último golpe.", 150, 50, 50,true)
					thePlayer:outputChat("#1FFF00No te sucede nada gracias al#FFFFFF cinturón de seguridad.", 50, 150, 50,true)
					thePlayer:setHealth(source:getHealth())
				end
			else
				thePlayer:outputChat("#FF3E3EEl vehículo sufrió un gran daño debido al último golpe.", 150, 50, 50,true)
				thePlayer:outputChat("#FF3E3ETambien te dañaste en el proceso por no llevar #FFFFFFel cinturón de seguridad.", 150, 50, 50,true)
				if thePlayer:getHealth() >= 20 then
					thePlayer:setHealth(thePlayer:getHealth() - math.random(3,8) )
				end
			end
			source:setFrozen(false)
			source:setLightState(0, 1)
			source:setLightState(1, 1)
		end
	end
end)
setTimer(
function ( )
	for _, vehicle in ipairs ( getElementsByType ( "vehicle" ) ) do
	 if getElementHealth(vehicle) < 401 then
	 setVehicleDamageProof( vehicle, true)
	 setVehicleEngineState( vehicle, false)
 else
     if getElementHealth(vehicle) > 402 then
	 setVehicleDamageProof( vehicle, false)
   end
  end
 end
end,
100, 0
)
local nocintu = {
[509]=true,
[481]=true,
[510]=true,
[581]=true,
[462]=true,
[521]=true,
[463]=true,
[522]=true,
[461]=true,
[448]=true,
[468]=true,
[586]=true,
[523]=true,
}
addCommandHandler("cinturon", function(thePlayer)
	local veh = thePlayer:getOccupiedVehicle()
	local seat = thePlayer:getOccupiedVehicleSeat()
	if veh then 
		if CinturonSeguridad[thePlayer] then
			MensajeRol(thePlayer, " se desabrocha el cinturon de seguridad.")
			CinturonSeguridad[thePlayer] = nil		
			setElementData(thePlayer,"cinturon",false)
		else
			if not nocintu[veh:getModel()] then
			MensajeRol(thePlayer, " se abrocha el cinturon de seguridad.")
			CinturonSeguridad[thePlayer] = true
			setElementData(thePlayer,"cinturon",true)
			end
		end
	end
end)
bicicletas = {
[510]=true,
[481]=true,
[509]=true,
}
addEventHandler("onVehicleEnter", getRootElement(), function( player, seat, jacked, door )
	if source:getHealth() <= 280 then
		source:setEngineState (false)
		source:setFrozen(false)
		source:setData('Motor', 'apagado')
	end
	if seat == 0 then
		if not bicicletas[source:getModel()] then
			if source:getHealth() >= 300 then
				if source:getData('Motor') == 'apagado' then
					local gas = getElementData(source, "Fuel") or 0
					if gas >= 1 then 
						source:setEngineState (false)
						player:outputChat("Escribe #00FF00/motor #FFFFFFpara encender el motor del vehiculo.", 255, 255, 255, true)
						player:outputChat("", 255, 255, 255, true)
						player:outputChat("", 255, 255, 255, true)
					end
					source:setFrozen(false)
				end	
			else
				source:setEngineState (false)
				source:setFrozen(false)
				source:setData('Motor', 'apagado')
				player:outputChat("¡El vehiculo esta destruido, Llama a un mecanico o compra un Kit!", 150, 50, 50, true)
			end
				if source:getData('Motor') == 'encendido' then
				player:outputChat("#2AB900Alguien poco ecologista se dejo el motor encendido.", 255, 255, 255, true)
			end
			if source:getData('Fuel') and source:getData('Fuel') <= 10 then
				player:outputChat("#2AB900Parece que te estas quedando sin comubisble, el tanque esta en reserva.", 255, 255, 255, true)
			end
		end
	end
end) 
addCommandHandler("llenarnaftaveh",function(player,cmd,fuel)
	if permisos[getACLFromPlayer(player)] == true then
		if not fuel or not tonumber(fuel) then
			player:outputChat("#2AB900/llenarnaftaveh [cantidad/gas].", 255, 255, 255, true)
			return
		end
		local veh = player:getOccupiedVehicle()
		setElementData(veh,"Fuel",tonumber(fuel))
		exports["Logs-Vehs"]:sendDiscordLogMessage(""..(player:getData("Nombre:staff") or getPlayerName(player)).." Lleno la gasolina de un vehiculo")  
	end
end)
local nomotor = {
[509]=true,
[481]=true,
[510]=true,
}
addCommandHandler("motor", function(player)
	if not notIsGuest(player) then
		local cuenta = player.account.name
		local veh = player:getOccupiedVehicle()
		local seat = player:getOccupiedVehicleSeat()
		if veh and seat == 0 then
			if getElementData(veh, 'Owner') == cuenta or player:getData("Roleplay:faccion") == veh:getData("VehiculoPublico") or player:getData("Roleplay:trabajo") == veh:getData("VehiculoPublico") or player:getData("Roleplay:trabajoVIP") == veh:getData("VehiculoPublico") or permisos[getACLFromPlayer(player)] == true then
				--if getElementData(veh, 'Owner') == cuenta or permisos[getACLFromPlayer(player)] == true or player:getData("Roleplay:faccion") == veh:getData("VehiculoPublico") 
					--or player:getData("Roleplay:trabajo") == veh:getData("VehiculoPublico") or player:getData("Roleplay:Mision") == veh:getData("VehiculoPublico") then
			local nick = _getPlayerNameR( player )
			local ID = getElementData(player,"ID")
			local gas = getElementData(veh, "Fuel") or 0
			if gas >= 1 then 
				if not player:getData("EnGasolinera") then
					if veh:getHealth() >= 300 then
						if not nomotor[veh:getModel()] then
						if veh:getData('Motor') == 'apagado' then
							MensajeRol(player, " esta encendiendo el motor del vehículo.")
							setTimer(function(player, veh)
								veh:setEngineState(true)
								veh:setData('Motor','encendido',false)
								veh:setFrozen(false)
								MensajeRol2(player, "El motor del vehículo de "..nick.." fue encendido.")
							end, 2000, 1, player, veh)
							for i,v in ipairs(getPlayersOverArea(player,13)) do
								v:triggerEvent('SonidoEncenderVeh',v,'auto')
							end
						else
							MensajeRol(player, " apago el motor del vehículo.")
							setTimer(function(player, veh)
								veh:setEngineState(false)
							--	veh:setFrozen(true)
								veh:setData('Motor','apagado')
								end, 200, 1, player, veh)
								end
							else
							player:outputChat("Este vehiculo no cuenta con un motor", 240, 0, 0, true)
							end
						end
					end
				end
			else
				player:outputChat("#FF3E3ENo tienes las llaves de este vehiculo", 255, 255, 255, true)
			end
		end
	end
end)
function refreshIDVehicleDBFromPlayer( player )
	if isElement(player) then
		local account = player.account.name
		local datos = databaseQuery("SELECT * From Info_Vehicles WHERE Cuenta='"..account.."'")
		if #datos > 0 then
			for k,v in pairs(datos) do
				local id = tonumber(v.ID)
				local id = id > 1 and tostring(id-1) or tostring(1)
				databaseUpdate("UPDATE Info_Vehicles SET ID='"..id.."', Placa='"..player.name:sub(1, player.name:find('_')-1)..' '..id.."' WHERE Cuenta='"..account.."'")
			end
			guardarVehiculosJugador(player)
			crearVehiculosJugador(player)
		end
	end
end
function getVehicleFromID(player, id)
	if isElement(player) then
		local cuenta = player.account.name
		if _AutosCreados[cuenta] then
			if _AutosCreados[cuenta][tonumber(id)] then
				return _AutosCreados[cuenta][tonumber(id)]
			end
		end
	end
	return false;
end
local veh_sirens = {}
local sirensOffs = {
	[596] = {{0.5, -0.5, 1},{-0.5, -0.5, 1},{0, -0.5, 1},{255,0,0},{0,0,255}},
	[597] = {{0.5, -0.5, 1},{-0.5, -0.5, 1},{0, -0.5, 1},{255,0,0},{0,0,255}},
	[598] = {{0.5, -0.5, 1},{-0.5, -0.5, 1},{0, -0.5, 1},{255,0,0},{0,0,255}},
	[599] = {{0.5, 0.5, 1.2},{-0.5, 0.5, 1.2},{0, 0.5, 1.2},{255,0,0},{0,0,255}},
	[490] = {{0.5, 0.5, 1.2},{-0.5, 0.5, 1.2},{0, 0.5, 1.2},{255,0,0},{0,0,255}},
	[528] = {{0.5, 0.5, 1.1},{-0.5, 0.5, 1.1},{0, 0.5, 1.1},{255,0,0},{0,0,255}},
	[427] = {{0.3, 0.8, 1.2},{-0.3, 0.8, 1.2},{0, 0.8, 1.2},{255,0,0},{0,0,255}},
	[523] = {{0.3, -1, 0.5},{-0.3, -1, 0.5},{0, -1, 0.5},{255,0,0},{0,0,255}},
	[416] = {{0.3, 1.2, 1.2},{-0.3, 1.2, 1.2},{0, 1.2, 1.2},{255,0,0},{0,0,255}},
	[407] = {{0.7, 3.2, 1.3},{-0.7, 3.2, 1.3},{0, 3.2, 1.3},{255,255,0},{255,255,0}},
	[544] = {{0.6, 3.2, 1.3},{-0.6, 3.2, 1.3},{0, 3.2, 1.3},{255,255,0},{255,255,0}},
	[433] = {{0.4, 1, 1.8},{-0.4, 1, 1.8},{0, 1, 1.8},{73,41,3},{73,41,3}},
}
function toggleHordVehicle(player)
	local veh = player.vehicle;
	local seat = player:getOccupiedVehicleSeat()
	if veh and seat == 0 or seat == 1 then
		local id = veh.model;
		if id == 596 or id == 597 or id == 598 or id == 599 or id == 490 or id == 528 or id == 427 or id == 523 or id == 416 or id == 407 or id == 544 or id == 433 then
			
			if not veh_sirens[veh] then
				veh_sirens[veh] = true
				setVehicleSirensOn( veh, true )
				triggerClientEvent('SirenaConfig',root, veh)
				addVehicleSirens(veh,3,2,false,false,true)
				local fr,fg,fb = unpack(sirensOffs[id][1]) 
				local r,g,b = unpack(sirensOffs[id][4])
				setVehicleSirens(veh, 1, fr,fg,fb, (r or 255), (g or 0), (b or 0), 255, 255 )
				local fr,fg,fb = unpack(sirensOffs[id][2])
				local r,g,b = unpack(sirensOffs[id][5])
				setVehicleSirens(veh, 2, fr,fg,fb, (r or 0), (g or 0), (b or 255), 255, 255 )
				local fr,fg,fb = unpack(sirensOffs[id][3])
				setVehicleSirens(veh, 3, fr,fg,fb, 255, 255, 255, 255, 255 )
			
			else
				removeVehicleSirens(veh)
				triggerClientEvent('SirenaConfig',root, veh)
			
				veh_sirens[veh] = nil
				setVehicleSirensOn( veh, false)
			end
		end
	end
end
function startJoin()
	if eventName == 'onPlayerJoin' then
		bindKey(source,"horn","down", toggleHordVehicle )
	else
		for i,v in ipairs(Element.getAllByType('player')) do
			bindKey(v,"horn","down", toggleHordVehicle )
		end
	end
end
addEventHandler( "onPlayerJoin", getRootElement(), startJoin )
addEventHandler( "onResourceStart", getResourceRootElement(  ), startJoin )
function isVehicleEmpty( vehicle )
	if isElement( vehicle ) or getElementType( vehicle ) == "vehicle" then
		for ind,val in ipairs(getVehicleOccupants(vehicle)) do
			return false
		end
	return true
	end
end
function getPlayerNearbyVehicle(player)
	if isElement(player) then
		for i,veh in ipairs(Element.getAllByType('vehicle')) do
			local vx,vy,vz = getElementPosition( veh )
			local px,py,pz = getElementPosition( player )
			if getDistanceBetweenPoints3D(vx,vy,vz, px,py,pz) < 3.3 then
				return veh
			end
		end
	end
	return false
end
function getPlayersOverArea(player,range)
	local new = {}
	local x, y, z = getElementPosition( player )
	local chatCol = ColShape.Sphere(x, y, z, range)
	new = chatCol:getElementsWithin("player") or {}
	chatCol:destroy()
	return new
end
local root = getRootElement () 
local thisResourceRoot = getResourceRootElement(getThisResource()) 
  
function toggleVehicleLock ( player, key, state ) 
    if ( getPedOccupiedVehicleSeat ( player ) == 0 ) then         
        local veh = getPedOccupiedVehicle ( player ) 
        if ( isVehicleLocked ( veh ) ) then 
            setVehicleLocked ( veh, false ) 
        else 
            setVehicleLocked ( veh, true ) 
        end 
    end 
end 
_getVehicleNameFromModel = getVehicleNameFromModel
function getVehicleNameFromModel(model)
	local model = tonumber(model)
    local check = exports.newmodels:isCustomModel(model)
    
	if check then
		return check.name
	else
		return _getVehicleNameFromModel(model)
	end
end
_getVehicleName = getVehicleName
function getVehicleName(veh)
	if isElement(veh) then
	    local check = exports.newmodels:isCustomModel(veh)
		if check then
			return check.name
		else
			return _getVehicleName(veh)
		end
	end
	return false
end