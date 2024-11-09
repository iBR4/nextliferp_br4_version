loadstring(exports.MySQL:getMyCode())()
mysql = exports.MySQL
import('*'):init('MySQL')
import('*'):init('Tiendas')

permisos = {
	["Desarrollador"]=true,
	["Administrador.General"]=true,
	["Admin"]=true,
	["Sup.Staff"]=true,
	["SuperModerador"]=true,
	["Moderador"]=true,
	["Moderador A Pruebas"]=true,
}

loadstring(exports.MySQL:getMyCode())()
import('*'):init('MySQL')

-- local blips = {
-- {2132.9758300781, -1140.1700439453, 38.934371948242}, --Conce Jefferson
-- {2479.2683105469, -1747.7116699219, 35.134429931641}, --Conce Moto
-- {547.654296875, -1285.9326171875, 17.248237609863}, --Conce Cara
-- {1097.763671875, -1370.8673095703, 13.5}, --Conce Camioentas
-- {1897.4875488281, -2345.3630371094, 13}, --Conce Aviones
-- {1399.150390625, 456.26892089844, 20.172252655029}, --Conce Raro Montgomery
-- }
-- addEventHandler("onResourceStart", resourceRoot, function()
-- 	for i, v in ipairs(blips) do
-- 		Blip( v[1], v[2], v[3], 55, 2, 255, 0, 0, 255, 0, 200, getRootElement() )
-- 	end
-- end)
-- local Blips2 = {
-- {723.11, -1494.55, 1.5}, --Conce Barcos
-- }
-- addEventHandler("onResourceStart", resourceRoot, function()
-- 	for i, v in ipairs(Blips2) do
-- 		Blip( v[1], v[2], v[3], 9, 2, 255, 0, 0, 255, 0, 200, getRootElement() )
-- 	end
-- end)

addCommandHandler("misvehiculos", function(player, _)
	if not notIsGuest(player) then
		if isElement(player) then
			local cuenta = AccountName(player)
			local s = databaseQuery("SELECT * FROM Info_Vehicles where Cuenta = ?", cuenta)
			if not ( type( s ) == "table" and #s == 0 ) or not s then
				for i, v in ipairs(s) do
					player:outputChat("#A44B00Vehiculo: #FFFFFF"..getVehicleNameFromModel(v.Modelo).." #A44B00ID: #FFFFFF"..v.ID.." #A44B00Placa: #FFFFFF"..v.Placa, 255, 255, 255, true)
				end
			end
		end
	end
end)

function onCarJacked ( player, seat, jacked )
    if jacked and seat == 0 then
        outputChatBox("#FFFFFFTu vehículo ha sido robado por: #F06C6C"..getPlayerName(jacked), player, 0,0,0, true)
        setElementData(player, "vehicles:CarJacked", getPlayerName(jacked))
    end
end
addEventHandler ( "onVehicleExit", getRootElement(), onCarJacked )

function showCJ(player, cmd, other)
	if other then
		local other, name = exports["Gamemode"]:getFromName(player, other)
		if other then
			if getElementData(other, "vehicles:CarJacked") then
				outputChatBox("#fFFF00El vehículo de "..name.." fue robado por: #9CFF97"..getElementData(other, "vehicles:CarJacked"), player, 0,0,0, true)
			else
				outputChatBox("#fFFF00El vehículo de "..name.." no ha sido robado.", player, 0,0,0, true)
			end
		end
	else
		outputChatBox("#44A5CASyntax: #FFFFFF/cj [ID]", player, 0,0,0, true)
	end
end
addCommandHandler("cj", showCJ)

local miblip = {}
addCommandHandler('localizarveh',function(player,cmd,id)
	if isElement(player) then
		if tonumber(id) then
			local v = getVehicleFromID(player, tonumber(id))
			local x,y,z = getElementPosition( v )
			local zona,ciudad = getZoneName( x,y,z),getZoneName( x,y,z, true)
			local vName = getVehicleName( v )
			player:outputChat("Su #FF9908"..vName..' #FFFFFFse encuentra en #FF9908'..ciudad..' #FFFFFF|| #FF9908'..zona, 255, 255, 255,true)
	 		player:outputChat("utiliza #ee0000/limpiarblips #FFFFFFpara desmarcarlo",255,255,255,true)
	 			if isElement( miblip[player] ) then
					miblip[player]:destroy()
					miblip[player] = nil
				end
 				miblip[player] = Blip(x,y,z,0,2, 255,255,0,255,0,65535,player)
		else
			outputChatBox("#44A5CASyntax: #FFFFFF/localizarvehiculo [ID]", player, 0,0,0, true)
			end
		else
			outputChatBox("#44A5CASyntax: #FFFFFF/localizarvehiculo [ID]", player, 0,0,0, true)
		end
	end
)

addCommandHandler("cblip",function(player)
	if isElement( miblip[player] ) then
		miblip[player]:destroy()
		miblip[player] = nil
		player:outputChat("#ee0000Blip Eliminado",255,255,255,true)
	end
end)

addCommandHandler("limpiarblips",function(player)
	if isElement( miblip[player] ) then
		miblip[player]:destroy()
		miblip[player] = nil
		player:outputChat("#ee0000Blip Eliminado",255,255,255,true)
	end
end)

addCommandHandler('traerveh',
	function(player, _, ID, vehID)
		if isElement(player) then
			if permisos[getACLFromPlayer(player)] == true then
				local who = exports["Gamemode"]:getFromName( player, ID )
				if who then
					local veh = getVehicleFromID(who, vehID)
					if veh then
						local position = player.matrix.position + player.matrix.right * 3
						setElementPosition(veh,position.x,position.y,position.z)
						setElementDimension(veh, getElementDimension(player) )  
						setElementRotation(veh, getElementRotation(player))
						exports["Logs-Vehs"]:sendDiscordLogMessage(""..player:getData("Nombre:staff").." trajo un vehiculo a su posicion") 
					else
						player:outputChat("Syntax: /traerveh [ID] [IDveh]",255,50,50,true)
					end
				else
					player:outputChat("Syntax: /traerveh [ID] [IDveh]",255,50,50,true)
				end
			end
		end
	end
)

addCommandHandler( "desvolcar",
	function( p, _, ID, vehID )
		if permisos[getACLFromPlayer(p)] == true then
			local veh = getPedOccupiedVehicle( p )
			if veh then
				local rx, ry, rz = getElementRotation( veh )
				setElementRotation( veh, rx, ry-180, rz )
			else
				local who = exports["Gamemode"]:getFromName( p, ID )
				if who then
					local veh = getVehicleFromID(who, vehID)
					if veh then
						local rx, ry, rz = getElementRotation( veh )
						setElementRotation( veh, rx, ry-180, rz )	
						outputChatBox( "Has volteado el vehiculo con id "..vehID..".", p, 0, 255, 150 )
					else
						outputChatBox( "No existe el vehiculo", p, 255, 0, 0 )
					end
				else
					p:outputChat("Syntax: /desvolcar [ID] [IDveh]",255,50,50,true)
				end
			end
		end
	end
)

addCommandHandler( "vehreparar",
	function( p, _, ID, vehID )
		if permisos[getACLFromPlayer(p)] == true then
			local veh = getPedOccupiedVehicle( p )
			if veh then
				local rx, ry, rz = getElementRotation( veh )
				setElementRotation( veh, rx, ry-180, rz )
			else
				local who = exports["Gamemode"]:getFromName( p, ID )
				if who then
					local veh = getVehicleFromID(who, vehID)
					if veh then
						local rx, ry, rz = getElementRotation( veh )
						fixVehicle ( veh ) 
						outputChatBox( "Reparaste con exito el vehiculo "..vehID..".", p, 0, 255, 150 )
					else
						outputChatBox( "No existe el vehiculo", p, 255, 0, 0 )
					end
				else
					p:outputChat("Syntax: /vehreparar [ID] [IDveh]",255,50,50,true)
				end
			end
		end
	end
)

addCommandHandler( "doomveh",
    function( player, commandName )
            local dimension = getElementDimension( player )
            local minDistance = 4
            local x, y, z = getElementPosition( player )
            local conteo = 0
            if permisos[getACLFromPlayer(player)] == true then
            for key, value in ipairs( getElementsByType("vehicle") ) do
                if dimension == getElementDimension( value ) then
                    local distance = getDistanceBetweenPoints3D( x, y, z, getElementPosition( value ) )
                    if distance <= minDistance then
                        conteo = conteo + 1
                        setElementDimension( value, 666 )
                    player:outputChat("#FFFFFFUn total de #FF8300"..conteo.." vehículos#FFFFFF fueron enviados al inframundo.",255,50,50,true) 
                    exports["Logs-Vehs"]:sendDiscordLogMessage(""..player:getData("Nombre:staff").." Envio "..conteo.." vehiculos al inframundo")  
                end 
            end
        end
    end
end
)

-- candado
addCommandHandler("candado",
	function(player)
		if isElement(player) then
			if motor == true then
				local cuenta = player.account.name
				local veh = getPlayerNearbyVehicle(player)
				if veh then
					if bicicletas[veh:getModel()] then
						if veh:getData("Owner") == cuenta then
							if veh:getData("CandadoBicicleta") == false then
								veh:setData("CandadoBicicleta", true)
								veh:setFrozen(false)
								player:outputChat("Desbloqueaste la bicicleta con la llave del candado.", 255, 255, 255, true)
								MensajeRol(player, "le saca el candado a su bicicleta.")
							else
								player:outputChat("Bloqueaste la bicicleta con el candado.", 255, 255, 255, true)
								veh:setData("CandadoBicicleta", false)
								veh:setFrozen(true)
								MensajeRol(player, "le coloca el candado a su bicicleta.")
							end
						end
					end
				end
			else
				player:outputChat("Debes estar adentro de un vehiculo y ser el conductor.", 150, 50, 50, true)
			end
		end
	end
)

addCommandHandler('estadoveh',
	function(player)
		if isElement(player) then
			local cuenta = player.account.name
			local veh = player:getOccupiedVehicle()
			if veh and player:isInVehicle() then
				exports['Notificaciones']:setTextNoti(player, "Estado del Vehiculo: #ee0000"..math.ceil(veh:getHealth()/10)..'% #FFFF00de Vida', 255, 255, 1)
			else
				player:outputChat("[ERROR] Debes estar en un vehiculo",255,50,50,true)
			end
		end
	end
)

permisos = {
["Desarrollador"]=true,
["Administrador.General"]=true,
["Admin"]=true,
["Sup.Staff"]=true,
["SuperModerador"]=true,
["Moderador"]=true,
["Moderador A Pruebas"]=true,
}

TEMPORARY_VEHICLE = {}; 
  
function cmd_veh(plr, cmd, ...) 
    local vehicleName = table.concat({...}, " ") 
    local vehicleID = getVehicleModelFromName(vehicleName) 
    local x, y, z = getElementPosition(plr) 
    if permisos[getACLFromPlayer(plr)] == true then
    if isPedInVehicle(plr) then 
        outputChatBox ("¡Baja de tu vehiculo para poder crear uno nuevo!", plr, 255, 255, 255, true) 
        return  
    end 
     
    if vehicleID then 
        if TEMPORARY_VEHICLE[plr] ~= false then 
            --destroyElement(TEMPORARY_VEHICLE[plr]); 
        end 
         
        TEMPORARY_VEHICLE[plr] = createVehicle (vehicleID, x, y, z, 0, 0, 0) 
        warpPedIntoVehicle(plr, TEMPORARY_VEHICLE[plr]) 
        TEMPORARY_VEHICLE[plr]:setData("Fuel", 100)
         
        outputChatBox ("Acabas de crear un vehiculo temporal llamado: " .. vehicleName .. "", plr, 255, 255, 255, true) 
        exports["Logs-Vehs"]:sendDiscordLogMessage(""..plr:getData("Nombre:staff").." creo un vehiculo temporal llamado ".. vehicleName .."")  
    	end
    end 
end 
addCommandHandler("sv", cmd_veh) 
  
function deleteTempVeh(plr, seat, jacked) 
    if not TEMPORARY_VEHICLE[plr] then  
        return  
    end 
    
    destroyElement(TEMPORARY_VEHICLE[plr]) 
    outputChatBox ("Eliminaste con exito el vehiculo temporal", plr, 255, 255, 255, true) 
end 
addCommandHandler("borrarveh", deleteTempVeh) 
  
function PlayerQuit() 
    if not TEMPORARY_VEHICLE[source] then  
        return  
    end 
     
    destroyElement(TEMPORARY_VEHICLE[source]) 
end 
  
addEventHandler("onPlayerQuit", getRootElement(), PlayerQuit)

bicicletas = {
	[510]=true,
	[481]=true,
	[509]=true,
}

addCommandHandler("candado",
	function(player)
		if isElement(player) then
			if player:isInVehicle() then
				local cuenta = player.account.name
				local veh = getPlayerNearbyVehicle(player)
				if veh then
					if bicicletas[veh:getModel()] then
						if veh:getData("Owner") == cuenta then
							if veh:getData("CandadoBicicleta") == false then
								veh:setData("CandadoBicicleta", true)
								veh:setFrozen(false)
								player:outputChat("Desbloqueaste la bicicleta con la llave del candado.", 255, 255, 255, true)
								MensajeRol(player, "le saca el candado a su bicicleta.")
							else
								player:outputChat("Bloqueaste la bicicleta con el candado.", 255, 255, 255, true)
								veh:setData("CandadoBicicleta", false)
								veh:setFrozen(true)
								MensajeRol(player, "le coloca el candado a su bicicleta.")
							end
						end
					end
				end
			else
				player:outputChat("Debes estar adentro de un vehiculo y ser el conductor.", 150, 50, 50, true)
			end
		end
	end
)

function ejectPl(pl)
	local veh = getPedOccupiedVehicle(pl)
	if veh then
		local driver = getVehicleOccupant(veh,0)
		if driver and driver == pl then
			for i=1,4 do
				local pass = getVehicleOccupant(veh,i)
				if pass then
					removePedFromVehicle(pass)
					outputChatBox("Te tiraron del vehiculo.", pass,245,0,0,true)
				end
			end
		end
	end
end
addCommandHandler("expulsarveh", ejectPl)

addCommandHandler('venderveh',
	function(vendedor, _, vehID, comprador, precio)
		if isElement(vendedor) then
			if tonumber(vehID) then
				local veh = getVehicleFromID(vendedor, tonumber(vehID))
				local comprador = type(tonumber(comprador)) == 'number' and exports["Login"]:getFromName( vendedor, comprador ) or getPlayerFromName( comprador )
				if comprador and tonumber(precio) then
					if comprador ~= vendedor then
						if not getElementData(vendedor, 'Solicitador de Compra Veh') then
							local posicion = Vector3(vendedor:getPosition()) -- player
							local posicion2 = Vector3(comprador:getPosition()) -- jugador
							local x, y, z = posicion.x, posicion.y, posicion.z -- jugador
							local x2, y2, z2 = posicion2.x, posicion2.y, posicion2.z -- player
							if getDistanceBetweenPoints3D(x, y, z, x2, y2, z2) < 10 then -- 5
								if tonumber(precio) >= 1 and comprador:getMoney() >= tonumber(precio) then
									local idd = getLastID(comprador)
									if (not getPlayerVIP(comprador) and idd-1 < 2) or (getPlayerVIP(comprador) == "VIP" and idd-1 < 4) or (getPlayerVIP(comprador) == "VIP+" and idd-1 < 6 )then
										setDato(comprador, 'Solicitado de Compra Veh', vendedor, true)
										setDato(vendedor, 'Solicitador de Compra Veh', {veh=getVehicleFromID(vendedor, tonumber(vehID)),id=tonumber(vehID),precio=tonumber(precio)})
										comprador:outputChat('A recibido una solitud de venta',255,255,0)
										comprador:outputChat('Vehiculo: '..veh.name..' Precio: '..precio,255,255,0)
										comprador:outputChat('/comprarveh',255,255,0)
										outputDebugString( vendedor.name..' le esta vendiendo un vehiculo a '..comprador.name, 3, 255, 255, 0)
										Timer(
											function(v,c)
												setDato(c, 'Solicitado de Compra Veh', nil)
												setDato(v, 'Solicitador de Compra Veh', nil)
											end
										,5000,1, vendedor, comprador)
									end
								else
									exports['Notificaciones']:setTextNoti(vendedor, 'Esta persona no tiene dinero suficiente', 255, 0, 1)
								end
							else
								exports['Notificaciones']:setTextNoti(vendedor, 'El comprador debe estar a tu lado.', 255, 0, 1)
							end
						else
							exports['Notificaciones']:setTextNoti(vendedor, 'Ya has solitado una venta, espera un momento.', 255, 0, 1)
						end
					end
				end
				else
				outputChatBox("#44A5CASyntax: #FFFFFF/venderveh [SlotVehiculo] [Nombre_Comprador] [PrecioVehiculo]", vendedor, 0,0,0, true)
			end
		end
	end
)

addCommandHandler('comprarveh',
	function(comprador)
		if isElement(comprador) then
			local vendedor = getDato(comprador, 'Solicitado de Compra Veh')
			if isElement(vendedor) then
				local dato = getDato(vendedor, 'Solicitador de Compra Veh')
				if dato and table.getn(dato) == 3 then
					if comprador:getMoney() >= tonumber(dato.precio) then
						local cuentaV = vendedor.account.name
						local cuentaC = comprador.account.name
						local id = getLastID(comprador)
						local Plate = comprador.name:sub(1, comprador.name:find('_')-1)
						dato.veh:destroy()
						if table.getn(_AutosCreados[cuentaV]) > 0 then
							table.remove(_AutosCreados[cuentaV], dato.id)
						end
						comprador:takeMoney(dato.precio)
						vendedor:giveMoney(dato.precio)					
						databaseUpdate("UPDATE Info_Vehicles SET Cuenta='"..cuentaC.."', ID='"..id.."', Placa='"..Plate..' '..id.."' WHERE Cuenta='"..cuentaV.."' AND ID ='"..dato.id.."'")
						refreshIDVehicleDBFromPlayer(vendedor)
						exports['Notificaciones']:setTextNoti(getPlayersOverArea(comprador, 8), comprador.name..' le compro un vehiculo a '..vendedor.name, 50, 255, 50)
						comprador:outputChat('Le compraste un vehiculo a '..vendedor.name..' por '..dato.precio..'$')
						outputDebugString( comprador.name..' El compro el vehiculo a '..vendedor.name..' por '..dato.precio..'$', 3, 255, 255, 0)
						guardarVehiculosJugador(comprador)
						crearVehiculosJugador(comprador)
						setDato(comprador, 'Solicitado de Compra Veh', nil)
						setDato(vendedor, 'Solicitador de Compra Veh', nil)
					else
						exports['Notificaciones']:setTextNoti(vendedor, 'Esta persona no tiene dinero suficiente', 255, 0, 1)
					end
				end
			end
		end
	end
)

addCommandHandler( "ventanilla",
	function( p )
		local veh = getPedOccupiedVehicle(p)
		if veh then
			triggerClientEvent( root, "abrirVentanilla", root, veh, p )
		end
	end
)

addCommandHandler('maletero',function(player)
	if isElement(player) then
		local cuenta = player.account.name
		local veh = getPlayerNearbyVehicle(player)
		if veh then
			if veh:getData('Owner') == cuenta or veh:getData('VehiculoPublico') == player:getData("Roleplay:faccion") or permisos[getACLFromPlayer(player)] == true then
				player:setAnimation('BD_FIRE', 'wash_up', -1, false, false, false)
				Timer(function(player)
					if veh:getDoorOpenRatio(1) == 0 then
						veh:setDoorOpenRatio(1,1)
						player:setAnimation()
						for i,v in ipairs(getPlayersOverArea(player,13)) do
						v:triggerEvent('MaleteroCerrar',v,'auto')
						end
					else
						for i,v in ipairs(getPlayersOverArea(player,13)) do
						v:triggerEvent('MaleteroAbrir',v,'auto')
						end
						veh:setDoorOpenRatio(1,0)
						player:setAnimation()
					end
				end,0,1,player)
			end
		else
			player:outputChat ("#FFFFFF[MALETERO] #FF1414No estas cerca de ningun maletero o no estas conduciendo ningun vehiculo.",255, 120, 0,true)
		end
	end
end)

addCommandHandler('capo',function(player)
	if isElement(player) then
		local cuenta = player.account.name
		local veh = getPlayerNearbyVehicle(player)
		if veh then
			if veh:getData('Owner') == cuenta or veh:getData('VehiculoPublico') == player:getData("Roleplay:faccion") or permisos[getACLFromPlayer(player)] == true then
				--player:setAnimation('BD_FIRE', 'wash_up', -1, false, false, false)
				Timer(function(player)
    				if getVehicleDoorOpenRatio(veh, 0 ) == 0 then
        				setVehicleDoorOpenRatio(veh, 0, 1)
						player:setAnimation()
						for i,v in ipairs(getPlayersOverArea(player,13)) do
						v:triggerEvent('MaleteroCerrar',v,'auto')
						end
					else
						for i,v in ipairs(getPlayersOverArea(player,13)) do
						v:triggerEvent('MaleteroAbrir',v,'auto')
						end
						setVehicleDoorOpenRatio(veh, 0, 0)
						player:setAnimation()
					end
				end,0,1,player)
			end
		else
			--player:outputChat ("#FFFFFF[MALETERO] #FF1414No estas cerca de ningun maletero o no estas conduciendo ningun vehiculo.",255, 120, 0,true)
		end
	end
end)

local weaponsP = {
	[22]=true,
	[23]=true,
	[24]=true,
	[25]=true,
	[26]=true,
	[27]=true,
	[28]=true,
	[29]=true,
	[32]=true,
	[30]=true,
	[31]=true,
	[33]=true,
	[34]=true,
	[38]=true,
	[16]=true,
	[17]=true,
	[18]=true,
	[39]=true,
}

addCommandHandler('vermaletero',
	function(player)
		if isElement(player) then
			local cuenta = player.account.name
			local veh = getPlayerNearbyVehicle(player)
			if veh then
					if veh:getDoorOpenRatio(1) == 1 then
						local mensaje = ''
						local male = veh:getData('Maletero')
						--print(inspect(male))
						local check = true
						player:outputChat ('#FFFFFF===== #FFFFFFMALETERO de #FFFFFF'..getVehiclePlateText( veh )..'#FFFFFF =====',255, 120, 0,true)
						for i, array in pairs(male.Items) do
							--local array = male.Items[i]
							if array then
								local item2
								if not array then
									item2 = "#FF8F00Slot: #FFFFFF"..i..': #FF8F00| Objeto:#FFFFFF Vacio'	
								elseif array[1] == 'Chaleco' then
									item2 = "#FF8F00Slot: #FFFFFF"..i..": #FF8F00| Objeto:#FFFFFF Chaleco"
								else
									item2 = "#FF8F00Slot: #FFFFFF"..i..": #FF8F00| Objeto:#FFFFFF "..array[1].." #FFFFFFCon #FFFFFF"..array[2].." Balas"
								end
								player:outputChat(item2, 50, 150, 50, true)
								check = false
							end
						end
						if check then
							player:outputChat ("El maletero esta vacio.",255, 120, 0,true)
						end
					else
					player:outputChat ("#FF1414[MALETERO] #FFFFFFEl maletero esta cerrado. usa #42FF00/maletero #FFFFFFpara abrirlo.",255, 120, 0,true)
				end
			end
		end
	end
)

function armaslot(id)
	if id == 30 or id == 31 then
		return 5
	elseif id == 25 then
		return 3
	end
	return false
end

local antiSpamComando = {}

function getSpamGuardado()
	if isTimer(antiSpamComando[player]) then return true end
	return false
end

addCommandHandler('metermaletero',
	function(player, _, ...)
		if isElement(player) then
			if not antiSpamComando[player] then
				antiSpamComando[player] = true
			end
			local cuenta = player.account.name
			local veh = getPlayerNearbyVehicle(player)
			if veh then
				if veh:getDoorOpenRatio(1) == 1 then
					if isTimer(antiSpamComando[player]) then player:outputChat ("#FF1414[MALETERO] #FFFFFFAguarda 5 segundos para seguir Accionando!.",255, 120, 0,true) return end
					antiSpamComando[player] = setTimer(function() end, 5000, 1)
					local slot = getEmptySpace(veh)
					local male = veh:getData('Maletero')
					if weaponsP[getPedWeapon(player)] then
						if slot then
							local muni = ...
							if tonumber(muni) then
								muni = math.floor(math.abs(muni))
								if getPedTotalAmmo( player ) >= tonumber(muni) then
									if getPedTotalAmmo( player ) == tonumber(muni) then
										
										male.Items[slot] = {getNameWeapon(player),tonumber(muni)}
										if takeWeapon(player, getPedWeapon(player)) then
											-- guardarma(player)
											-- update(player)
											-- takeAllWeapons(player)
											-- backup(player)
											update(player)
											veh:setData('Maletero', male)
											
											MensajeRol(player, "Mete algo en el maletero")
											if armaslot(getPedWeapon(player)) then
												--triggerClientEvent(player,"destruirarma",player,player,armaslot(getPedWeapon(player)))
											end
											player:outputChat ("#FF1414[MALETERO] #FFFFFFObjeto guardado en el maletero.",255, 120, 0,true)
										end
									else
										male.Items[slot] = {getNameWeapon(player),tonumber(muni)}
										if takeWeapon(player, getPedWeapon(player), muni) then
											-- guardarma(player)
											-- update(player)
											-- takeAllWeapons(player)
											-- backup(player)
											update(player)
											veh:setData('Maletero', male)
											
											MensajeRol(player, "Mete algo en el maletero")
											if armaslot(getPedWeapon(player)) then
												--triggerClientEvent(player,"destruirarma",player,player,armaslot(getPedWeapon(player)))
											end
											player:outputChat ("#FF1414[MALETERO] #FFFFFFObjeto guardado en el maletero.",255, 120, 0,true)
										end
									end
								else 
									player:outputChat ("#FF1414[MALETERO] #FFFFFFNo tienes esa cantidad en tus manos.",255, 120, 0,true)
								end
							else
								player:outputChat ("#FFFFFFSyntax : #13FF00/metermaletero + cantidad de balas o chaleco.",255, 120, 0,true)
							end
						else
							player:outputChat ("#FF1414[MALETERO] #FFFFFFEl maletero esta lleno.",255, 120, 0,true)
						end
					elseif (...) == 'chaleco' then
						if slot then
							local armor = player:getArmor() or 0
							if armor > 0 then
								male.Items[slot] = {'Chaleco',armor}
								veh:setData('Maletero', male)
																
								player:setArmor(0)
								MensajeRol(player, "Mete algo en el maletero")
								player:outputChat('#FF1414[MALETERO] #FFFFFFObjeto guardado en el maletero.', 255, 255, 0,true)
							end
						else
							player:outputChat ("#FF1414[MALETERO] #FFFFFFEl maletero lleno.",255, 120, 0,true)
						end
					end
				else
					player:outputChat ("#FF1414[MALETERO] #FFFFFFEl maletero esta cerrado. usa #42FF00/maletero #FFFFFFpara abrirlo.",255, 120, 0,true)
				end
			end
		end
	end
)

addCommandHandler('sacarmaletero',
	function(player, _, item, muni)
		if isElement(player) then
			if not antiSpamComando[player] then
				antiSpamComando[player] = true
			end
			local cuenta = player.account.name
			local veh = getPlayerNearbyVehicle(player)
			if veh then
				local owner = getElementData(veh, 'Owner')
				local vehPublico = veh:getData('VehiculoPublico')
				if owner == cuenta or vehPublico == player:getData("Roleplay:faccion") or permisos[getACLFromPlayer(player)] == true then
					if veh:getDoorOpenRatio(1) == 1 then
						local male = veh:getData('Maletero')
						if male and male.Items then  -- Verifica si maletero y male.Items están definidos
							
							local itemSlot = tonumber(item)
							if not itemSlot then
								return outputChatBox('Especifica el slot del item que deseas sacar.', player, 150, 50, 50)
							end
							if not male.Items[itemSlot] then
								return outputChatBox('El slot indicado esta vacio.', player, 150, 50, 50)
							end
							if isTimer(antiSpamComando[player]) then player:outputChat ("#FF1414[MALETERO] #FFFFFFAguarda 5 segundos para seguir Accionando!.",255, 120, 0,true) return end
							antiSpamComando[player] = setTimer(function() end, 5000, 1)
							--if getRealWeaponFromSlot( player, getIDWeapon(male.Items[itemSlot][1]) ) == 1 then
							--	return player:outputChat ("#FF1414[MALETERO] #FFFFFFNo cuentas con este arma!.",255, 120, 0,true) 
							--end
							if male.Items[itemSlot][1] == 'Chaleco' then
								player:setArmor(male.Items[itemSlot][2])
								male.Items[itemSlot] = false
								--
								veh:setData('Maletero', male)
								player:outputChat('#FF1414[MALETERO] #FFFFFFObjeto sacado del maletero.', 255, 255, 0, true)
							else
								local muni = tonumber(muni)
								if not muni then
									return outputChatBox('Especifica la cantidad de balas que deseas retirar.', player, 150, 50, 50)
								end 
								if muni > male.Items[itemSlot][2] then
									return outputChatBox('No posees esa cantidad de balas', player, 150, 50, 50)
								end
								male.Items[itemSlot][2] = male.Items[itemSlot][2] - muni
								
								local armID = getIDWeapon(male.Items[itemSlot][1])
								local DataWeap,Slot_ = getWeaponFromSlot( player, armID )
								if DataWeap == 1 then -- Tiene misma categoria
									if giveWeapon(player, getIDWeapon(male.Items[itemSlot][1]), tonumber(muni), true) then	
										update(player)
										if male.Items[itemSlot][2] <= 0 then
											male.Items[itemSlot] = false
										end								
										veh:setData('Maletero', male)
										player:outputChat('#FF1414[MALETERO] #FFFFFFObjeto sacado del maletero.', 255, 255, 0, true)
										MensajeRol(player, "Saca algo en el maletero")
									end				
									
								end
								if DataWeap == 2 then
									if getPedWeapon(player,Slot_) == 0 then
										if giveWeapon(player, getIDWeapon(male.Items[itemSlot][1]), tonumber(muni), true) then	
											update(player)
											if male.Items[itemSlot][2] <= 0 then
												male.Items[itemSlot] = false
											end								
											veh:setData('Maletero', male)
											player:outputChat('#FF1414[MALETERO] #FFFFFFObjeto sacado del maletero.', 255, 255, 0, true)
											MensajeRol(player, "Saca algo en el maletero")
										end
									else
										return player:outputChat ("#FF1414[MALETERO] #FFFFFFEsta arma no coincide en tu equipo de armas!.",255, 120, 0,true)
									end
								end
							end
							-- if numItems > 0 then
							-- 	item = tonumber(item)
							-- 	if item and item <= numItems and male.Items[item][1] ~= 'Vacio' then
							-- 		local reid, remuni = unpack(male.Items[item])
							-- 		if table.findWeapon(reid) then
							-- 			if muni then
							-- 				muni = math.floor(math.abs(muni))
							-- 				if muni <= tonumber(remuni) then
							-- 					local resto = tonumber(remuni) - tonumber(muni)
												
							-- 				else
							-- 					exports['[LS]Notificaciones']:setTextNoti(player, 'No tienes esa cantidad de munición en el maletero', 150, 50, 50)
							-- 				end
							-- 			end
							-- 		elseif male.Items[item][1] == 'chaleco' then
										
							-- 		else
							-- 			local itemName, quantity = unpack(male.Items[item])
							-- 			setPlayerItem(player, itemName, quantity)
							-- 			male.Items[item] = {'Vacio'}
							-- 			veh:setData('Maletero', male)
							-- 			exports['Notificaciones']:setTextNoti(player, 'A sacado '..itemName:lower()..' de su maletero', 255, 255, 0)
							-- 		end
							-- 	end
							-- else
							-- 	exports['Notificaciones']:setTextNoti(player, 'El maletero está vacío', 255, 255, 0)
							-- end
						else
							outputChatBox('El maletero está vacío', player, 255, 255, 0)
						end
					else
						outputChatBox("El maletero debe de estar abierto", player, 227, 114, 1)
					end
				end
			end
		end
	end
)

function getWeaponFromSlot(player,weapID)
	local slot = getSlotFromWeapon ( tonumber(weapID) )
	local weapons = getPedWeapon (player, slot)  
	if weapons == tonumber(weapID) then
		if getPedTotalAmmo(player, slot) > 0 then
			return 1
		end
	end
	return 2, getSlotFromWeapon ( tonumber(weapID) )
end

local nameWeapon = {
	[22]="Pistola 9mm",
	[24]="Desert Eagle .44",
	[25]="Escopeta Remington",
	[33]="Rifle de Caza",
	[28]="Uzi",
	[29]="Subfusil MP5",
	[31]="Fusil M4A1",
	[30]="AK-47",
}

local nameFromIDWeapon = {
	["Pistola 9mm"]=22,
	["Desert Eagle .44"]=24,
	["Escopeta Remington"]=25,
	["Rifle de Caza"]=33,
	["Uzi"]=28,
	["Subfusil MP5"]=29,
	["Fusil M4A1"]=31,
	["AK-47"]=30,
}

function guardarma(ped)
	for i=0, 12 do 
		local v = getPedWeapon( ped, i )
		local muni = getPedTotalAmmo(ped,i)
		if v and v ~= 0 then
			if muni and muni ~= 0 then
				if getPedWeapon( ped, i ) then
					takeWeapon( ped, v )
					giveWeapon( ped, v , muni )
				end	
			end
		end
	end
end

function update(source)
	--guardarma(source)
	local weapons = ""
	for index=0,12 do
		local weapon = source:getWeapon(index)
		local ammo = source:getTotalAmmo(index)
		weapons = weapons..tostring(index).."="..tostring(weapon)..","..tostring(ammo)..";"
	end
	mysql:update("UPDATE save_system SET Weapons = ?  WHERE Cuenta = ?", weapons, AccountName(source))
end

function backup(source)
	if not(mysql:notIsGuest(source)) then 
		local cuenta = mysql:AccountName(source)
		local save = mysql:query("SELECT * From save_system WHERE Cuenta = '"..mysql:AccountName(source).."'")
		if not ( type ( save ) == "table" and #save == 0 ) or not save then
			local weapons = save[1]["Weapons"]
			if weapons and type(weapons) == "string" and string.len(weapons) > 0 then
				for index=0,12 do
					local coded_string = string.match(weapons, tostring(index).."=%d+,%d+")
					if coded_string then
						local weapon_start , weapon_end = string.find(coded_string, tostring(index).."=")
						local ammo_start, ammo_end = string.find(coded_string, tostring(index).."=%d+,")
						local decoded_weapon = string.match(coded_string, "%d+", weapon_end)
						local decoded_ammo = string.match(coded_string, "%d+", ammo_end)
						local wep = tonumber(decoded_weapon)
						local ammu = tonumber(decoded_ammo)
						if wep ~= 0 then
							if ammu > 1 then
								giveWeapon(source, wep, ammu)
							end
						end
					else
						print("ERROR: Imposible recobrar arma en Slot: ".. tostring(index).."")
					end
				end
			end
		end
	end
end

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

function table.getn(t)
	local size = 0
	for _ in pairs(t) do
		size = size + 1
	end
	return size
end

function table.sizeM(t)
	local size = 0
	for k,v in pairs(t) do
		if v[1] ~= 'Vacio' then
			size = size + 1
		end
	end
	return size
end

function table.find(t, value)
	for i,v in pairs(t) do
		if v == value then
			return i,v
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

function getEmptySpace(veh)
	local male = veh:getData('Maletero')
	if male then
		for i=1,male.Slots do
			if not male.Items[i] then
				return i
			end
		end
	end
	return false
end

function getNameWeapon(player)
	return nameWeapon[tonumber(getPedWeapon(player))]
end

function getIDWeapon(name)
	return nameFromIDWeapon[tostring(name)]
end

function isItemWeaponMaletero(veh, id)
	local male = veh:getData('Maletero')
	for item,quantity in pairs(male.Items) do
		if tonumber(item) then
			if item == tostring(id) then
				return true
			else
				return false
			end
		end
	end
end

function setItemUpdate(veh, i, val)
	local male = veh:getData('Maletero')
	for item,quantity in pairs(male.Items) do
		if tonumber(item) then
			if item == tostring(i) then
				quantity = quantity + val
			end
		end
	end
	return false
end

function table.findWeapon(value)
	for _,v in pairs(nameWeapon) do
		if v == value then
			return true
		end
	end
	return false
end

local peticionSeguro = {}
local tipos_seguro = { ["Responsabilidad civil"] = 2500, ["Terceros completo"] = 4000, ["Todo riesgo"] = 5500 }
local comandoseguros = { {"Responsabilidad civil",2500}, {"Terceros completo",4000}, {"Todo riesgo", 5500},  }

addCommandHandler( "verseguro",
	function(p, _, ID, vehID)
		if getElementData(p,"Roleplay:faccion") == "Aseguradora" then 
				local cuenta = AccountName(p)
				local who = exports["Gamemode"]:getFromName( p, ID )
				if who then
					local veh = getVehicleFromID(who, vehID)
					if veh then
					local seguro = getElementData(veh,"seguro")
					local tseguro = getElementData(veh,"tiposeguro")
					outputChatBox( "     - Seguro: "..( tseguro or "Nada" ), p, 255, 255, 255 )
					outputChatBox( "     - Fecha: "..(os.date('%d-%m-%Y', seguro )), p, 255, 255, 255 )
					if (seguro - getRealTime().timestamp ) > 0 then
						outputChatBox( "     - Estado: #00ff00VIGENTE", p, 255, 255, 255, true )
					else
						outputChatBox( "     - Estado: #FE0000CADUCADO", p, 255, 255, 255, true )
					end
			
			
				else
					outputChatBox( "(( No se encuentra el vehiculo con esa ID. ))", p, 255, 0, 0 )
				end
			else
				outputChatBox( "Syntax: /verseguro [id del user] + [slot del auto]", p, 255, 255, 255 )
			end	
		end
	end
)

addCommandHandler( "seguros",
	function(p)
		if getElementData(p,"Roleplay:faccion") == "Aseguradora" then 
			outputChatBox( "Seguros disponibles:", p, 255, 255, 0 )
			for i=1, #comandoseguros do 
				local v = comandoseguros[i]
				outputChatBox( "		- ["..i.."] "..v[1]..": $"..v[2].."", p, 255, 255, 255 )
			end
		end
	end
)

addCommandHandler( "pseguro",
	function(p)
		if peticionSeguro[p] then
			local jugador, vehiculo, tipo = unpack( peticionSeguro[p] )
			local dinero = p:getMoney()
			if dinero >= tipos_seguro[tipo] then
				if isElement(vehiculo) then
					if p:takeMoney(tipos_seguro[tipo]) then
						if isElement(jugador) then
							jugador:giveMoney( tipos_seguro[tipo] * 0.2 )
							setElementData( vehiculo, "seguro", ( getRealTime().timestamp + (86400*31) ) )
							setElementData( vehiculo, "tiposeguro", tipo )
							outputChatBox( "Has ganado un 20% asegurando este vehiculo.", jugador, 0, 255, 0 )
							outputChatBox( "Le has asegurado el vehiculo a "..getPlayerName(p):gsub("_"," "), jugador, 0, 255, 0 )
							outputChatBox( "Tu vehiculo ha sido asegurado 1 mes por "..tipos_seguro[tipo].."$", p, 0, 255, 0 )
							outputChatBox( "Tipo de seguro elegido: #ffffff"..tipo, p, 0, 255, 0, true )
							--databaseUpdate("UPDATE Info_Vehicles SET ID='"..id.."', Placa='"..player.name:sub(1, player.name:find('_')-1)..' '..id.."' WHERE Cuenta='"..account.."'")
							--exports.fichas:addToFicha( exports.players:getCharacterID( jugador ), 8, tipos_seguro[tipo] )
						else
							--exports.factions:setFactionPresupuesto( 8, tipos_seguro[tipo] )
							outputChatBox( "(( El asegurador se ha desconectado. Se queda sin su comision. ))", p, 255, 0, 0 )
							outputChatBox( "Tu vehiculo ha sido asegurado 1 mes por "..tipos_seguro[tipo].."$", p, 0, 255, 0 )
							setElementData( vehiculo, "seguro", ( getRealTime().timestamp + (86400*31) ) )
							setElementData( vehiculo, "tiposeguro", tipo )
							outputChatBox( "Tipo de seguro elegido: #ffffff"..tipo, p, 0, 255, 0, true )						
						end
					else
						outputChatBox( "Error, no tienes suficiente dinero", p, 255, 0, 0 )
					end
				else
					outputChatBox( "El vehiculo que querias asegurar no se encuentra.", p, 255, 0, 0 )
				end
			else
				outputChatBox( "No tienes suficiente dinero para pagar el seguro.", p, 255, 0, 0 )
			end
		end
	end
)

addCommandHandler( "cseguro",
	function(p)
		if peticionSeguro[p] then
			local jugador, vehiculo, tipo = unpack( peticionSeguro[p] )
			if isElement(jugador) then
				outputChatBox( "El jugador "..getPlayerName(p):gsub("_"," ").." ha rechazado el seguro.", jugador, 255, 0, 0 )
				outputChatBox( "Has rechazado la oferta de seguro.", p, 255, 0, 0 )
			else
				outputChatBox( "Has rechazado la oferta de seguro.", p, 255, 0, 0 )
				peticionSeguro[p] = nil
			end
		end
	end
)

addCommandHandler( "asegurar",
	function( p, cmd, otro, ... )
		if getElementData(p,"Roleplay:faccion") == "Aseguradora" then 
			local other, name = exports["Gamemode"]:getFromName( p, otro )
			local tipo = table.concat( {...}, " " )
			if other then
				if tipos_seguro[tipo] then
					local veh = getPedOccupiedVehicle( other )
					if veh then
						peticionSeguro[other] = { p, veh, tipo }
						outputChatBox( "Peticion enviada a "..name..".", p, 0, 255, 0 )
						outputChatBox( "Has recibido una peticion para asegurar tu vehiculo. Utiliza /pseguro para aceptarla o /cseguro para rechazarla.", other, 255, 150, 0 )
					else
						outputChatBox( name.." no está subido a un vehículo.", p, 255, 0, 0 )
					end
				else
					outputChatBox( "Ese tipo de seguros no existe. Tipos:", p, 255, 255, 0 )
					for k, v in pairs( tipos_seguro ) do 
						outputChatBox( "		- Tipo: "..k.." | Precio: "..v.."$ por mes.", p, 255, 255, 255 )
					end
 				end
			else
				outputChatBox( "Syntax: /"..cmd.." [id jugador (debe estar subido a un vehiculo)]", p, 255, 255, 255 )
			end
		end
	end
)

-- RASTREAR
local blip = {}
local timer = {}
addCommandHandler( "rastrear",
	function(p, _, ID, vehID)
			if getElementData(p,"Roleplay:faccion") == "Aseguradora" then 
				local who = exports["Gamemode"]:getFromName( p, ID )
				if who then
					local veh = getVehicleFromID(who, vehID)
					if veh then
						if getElementDimension(veh) == 0 then
							local x, y, z = getElementPosition(veh)
							outputChatBox( "[PDA] Vehículo encontrado. Punto marcado en el mapa. Se eliminará en 2 minutos.", p, 0, 255, 0 )
							blip[p] = createBlip( x, y, z, 0, 2, 0, 255, 0 )
							setElementVisibleTo( blip[p], root, false )
							setElementVisibleTo( blip[p], p, true )
							timer[p] = setTimer( function( player )
								if player then
									if isElement( blip[player] ) then destroyElement( blip[player] ) blip[player] = nil end
									timer[player] = nil
								end	
							end, 2*60000, 1, p )
						else
							local intname = exports.interiors:getInteriorName( getElementDimension(veh) )
							if intname then
								outputChatBox( "[PDA] El vehiculo esta en "..intname, p, 0, 255, 0 )
							else
								outputChatBox( "[PDA] El vehiculo esta en una propiedad.", p, 0, 255, 0 )
							end
						end
					else
						outputChatBox( "[PDA] No se encuentra el vehículo.", p, 255, 0, 0 )
					end
				else
					outputChatBox( "Syntax: /rastrear [id del user] + [slot del auto]", p, 255, 255, 255 )
				end
			end
		end
)

addCommandHandler( "papeles", 
function (player, commandName, otherPlayer)
	local otherPlayer = otherPlayer
	local vehicle = getPedOccupiedVehicle( player )
	local otro, nombre = exports["Gamemode"]:getFromName ( player, otherPlayer )
	local x, y, z = getElementPosition( player )
	local Owner = vehicle:getData('Owner')
	local modelo = getVehicleName (vehicle)
	local matricula = getVehiclePlateText( vehicle )
    if getDistanceBetweenPoints3D( x, y, z, getElementPosition( otro ) ) < 5 then
		if vehicle then
			MensajeRol( player, "le muestra los papeles del coche a " .. nombre .. "." )
			outputChatBox ( "#ffffffPapeles del vehiculo #FF8700"..modelo..".", otro, 0, 255, 0 ,true)
			local name = getPlayerName( player )
			outputChatBox ( "#ffffffDueño: #FF8700".. Owner .. "", otro, 255, 255, 255 ,true)
			outputChatBox ( "#ffffffModelo: #FF8700" .. modelo .. " ", otro, 255, 255, 255 ,true)
			outputChatBox ( "#ffffffMatricula: #FF8700" .. matricula, otro, 255, 255, 255 ,true)
		end
	end
end)

addCommandHandler( "luces",
function( player, commandName )
		local vehicle = getPedOccupiedVehicle( player )
		if vehicle and getVehicleOccupant( vehicle ) == player then
					setVehicleOverrideLights( vehicle, getVehicleOverrideLights( vehicle ) == 2 and 1 or 2 )
		end
		for key, value in ipairs(getElementsByType("vehicle")) do
			if isElement(value) and getElementData(value, "Vehiculos:Alquilado") then
				if getElementData(value, "Vehiculos:JugadorA") == player then
					local vehicle = getPedOccupiedVehicle( player )
					if vehicle and getPedOccupiedVehicleSeat( player ) == 0 then
						--exports.chat:ame( player, ( getVehicleOverrideLights( vehicle ) == 2 and "apaga" or "enciende" ).." las luces del vehiculo." )
						setVehicleOverrideLights( vehicle, getVehicleOverrideLights( vehicle ) == 2 and 1 or 2 )
				
				end
			end
		end
	end
end)

function unhookTrailer(playerSource, commandName) 
   if (playerSource and isPedInVehicle(playerSource)) then 
      local theVehicle = getPedOccupiedVehicle(playerSource) 
      local vehiculos = { [515] = true} 
    if (getVehicleTowedByVehicle(theVehicle) and getElementModel(getVehicleTowedByVehicle(theVehicle)) == 435) then 
      local Remol = getVehicleTowedByVehicle(theVehicle) 
      local success = detachTrailerFromVehicle(theVehicle) 
     	end 
   	end 
end 
addCommandHandler("soltartrailer", unhookTrailer) 
