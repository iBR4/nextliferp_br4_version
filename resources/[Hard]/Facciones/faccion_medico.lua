mysql = exports.MySQL

permisosTotal = {
	["Desarrollador"] = true,
	["Administrador.General"] = true,
	["Admin"] = true,
	["Sup.Staff"] = true,
	["SuperModerador"] = true,
	["Moderador"] = true,
	["Moderador A Pruebas"] = true,
}

--- Spawn

local JugadorMuerto = {}
local ValoresTablaAsesinato = {}
local antiSpamMensajes = {}

cuerpos = {
	[3]="Torso", 
	[4]="Culo", 
	[5]="Brazo izquierdo", 
	[6]="Brazo derecho", 
	[7]="Pierna izquierda", 
	[8]="Pierna derecha", 
	[9]="Cabeza", 
}

local adentro = {}

function PlayerDamageText( attacker, weapon, bodypart, loss )
	if source:getHealth() < 10 then
		source:setData("Herido", {"", 150, 50, 0})
		if ( attacker and attacker:getType() == "player" and bodypart ) then
			if ( source and source:getType() == "player" ) then
				if not source:isDead() then
					local tick = getTickCount()
					if (antiSpamMensajes[source] and antiSpamMensajes[source][1] and tick - antiSpamMensajes[source][1] < 10000) then
						return
					end
					--source:outputChat(exports["Mysql"]:_getPlayerNameR(attacker).." #FA0E0Ete acaba de atacar.", 255, 255, 255, true)
					source:outputChat("#ffffff".._getPlayerNameR(attacker).."#FA0E0Ete acaba de atacar.", 255, 255, 255, true)
					if (not antiSpamMensajes[source]) then
						antiSpamMensajes[source] = {}
					end
					antiSpamMensajes[source][1] = getTickCount()
				end
			end
		else
			if not isPedInVehicle(source) then
				if source:getData("Agua") ~= 0 or source:getData("Comida") ~= 0  then
					if adentro[source] == nil then
						source:setHealth(source:getHealth() - 2.5*loss)
					end
				end
			end
		end
	end
end
addEventHandler("onPlayerDamage", getRootElement(), PlayerDamageText)

local pick = Pickup(1395.2529296875, 6.2666015625, 1000.9158935547,3,1239)
setElementInterior(pick,1)
setElementDimension(pick,4)

local pick2 = Marker(1402.6123046875, 4.25, 1000.9077758789-1,"cylinder",4,255,255,255,50)
setElementInterior(pick2,1)
setElementDimension(pick2,4)

local num = 0
local car = {}

function crearveh(source)
	if isElementWithinPickup(source,pick) then
		if source:getData("Roleplay:faccion") == "Medico" then
			local x,y,z = 1394.4287109375, -15.4970703125, 1000.9178466797
			num = num + 1
			car[num] = createVehicle(416,x,y,z,0,0,270.69354248047)
			car[num]:setInterior(1)
			car[num]:setDimension(4)
			car[num]:setPlateText("LSRD")
			car[num]:setData('Locked', 'Cerrado')
			car[num]:setData('Motor','apagado')
			car[num]:setData("vrd",num)
			car[num]:setData("VehiculoPublico", "Medico")
			car[num]:setData('Fuel',100)
			car[num]:setLocked(true)
			car[num]:setEngineState (false)
			car[num]:setFrozen(true)
		else
			source:outputChat("[ERROR] NO eres de esta faccion",255, 100, 100, true)
		end
	end
end
addCommandHandler("veh",crearveh)

function destroy(source)
	if isElementWithinMarker(source,pick2) then
		if source:isInVehicle() then
			local veh = getPedOccupiedVehicle(source)
			local nume = veh:getData("vrd")
			if isElement(car[nume]) then
				car[nume]:destroy()
				car[nume] = nil
			end
		else
			source:outputChat("[ERROR] Tienes que estar encima de tu vehiculo",255, 100, 100, true)
		end
	end
end
addCommandHandler("borrarveh",destroy)

local herido = {}
function PlayerKilled( ammo, attacker, weapon, bodypart )
if herido[source] == true or cuerpos[bodypart] == "Cabeza" then
	if ( attacker and attacker:getType() == "player" and bodypart ) then
		if ( source and source:getType() == "player" ) then
			--source:outputChat("#FF0033[ADVERTENCIA] #FFFF00Si reconnectas en pleno asesinato de tu personaje, serás sancionado.", 150, 50, 50, true)
			source:outputChat("#F06C6CCaiste muerto en el suelo gracias a #FFFF00".._getPlayerNameR(attacker).."", 255, 255, 255, true)
		--	JugadorMuerto[source] = false
		----
			source:setData("Muerto",true)
			setTimer( function(player)
				if isElement(player) then
				if player:getData("Muerto") == true then
						setElementData(player, "AceptarMuertoo", true)
						outputChatBox("#FFFFFFYa puedes utilizar #9CFF97/aceptarmuerte #FFFFFFprocura que no estes cortando un rol.", player, 0,0,0, true)
					end
				end
			end, 60000, 1, source)
			----
			setTimer(function(source, weapon, bodypart, attacker)
				if isElement(source) or isElement(attacker) then
				local pos = Vector3(source:getPosition())
				local x, y, z = pos.x, pos.y, pos.z
				local pos2 = Vector3(source:getRotation())
				local rx, ry, rz = pos2.x, pos2.y, pos2.z
				local int = source:getInterior()
				local dim = source:getDimension()
				source:spawn(x, y, z, rz, source:getModel(), int, dim, nil)
				source:setFrozen(true)
				source:setData("NoDamageKill", true)
				setPedAnimation(source, "crack", "crckdeth1", -1, false, false, false, true)
				source:setHealth(100)
		--		JugadorMuerto[source] = true
				source:setData("Muerto",true)
				herido[source] = nil
				source:setCameraTarget(source)
				source:removeFromVehicle(source:getOccupiedVehicle())
				--source:outputChat("#FFFFFFPuedes avisar de tu muerte con el comando #00FF00/avisarmuerte", 255, 255, 255, true)
				source:outputChat("#FFFFFFHas caido totalmente #FFFF00muerto #FFFFFFen el suelo. \nDebes esperar 60 segundos para poder usar #F06C6C/aceptarmuerte", 255, 255, 255, true)
				source:setData("Herido", {"Esta persona está Muerta", 150, 50, 0})
				ValoresTablaAsesinato[source] = attacker
			end
			end, 1000, 1, source, weapon, bodypart, attacker)
		end
	else
		--source:outputChat("#FF0033[ADVERTENCIA] #FFFF00Si reconnectas en pleno asesinato de tu personaje, serás sancionado.", 150, 50, 50, true)
		source:outputChat("#F06C6CCaiste muerto en el suelo gracias a #FFFF00Nadie", 255, 255, 255, true)
		--	JugadorMuerto[source] = false
			source:setData("Muerto",true)
			setTimer( function(player)
			if player then
			if player:getData("Muerto") == true then
				setElementData(player, "AceptarMuertoo", true)
				outputChatBox("#FFFFFFYa puedes utilizar #9CFF97/aceptarmuerte #FFFFFFprocura que no estes cortando un rol.", player, 0,0,0, true)
					end
				end
			end, 60000, 1, source)
		setTimer(function(source, weapon, bodypart)
			if isElement(source) then
			local pos = Vector3(source:getPosition())
			local x, y, z = pos.x, pos.y, pos.z
			local pos2 = Vector3(source:getRotation())
			local rx, ry, rz = pos2.x, pos2.y, pos2.z
			local int = source:getInterior()
			local dim = source:getDimension()
			source:spawn(x, y, z, rz, source:getModel(), int, dim, nil)
			source:setFrozen(true)
			setPedAnimation(source, "crack", "crckdeth1", -1, false, false, false, true)
			source:setHealth(100)
			source:setCameraTarget(source)
			source:setData("NoDamageKill", true)
		--	JugadorMuerto[source] = true
			source:setData("Muerto",true)
			herido[source] = nil
			source:removeFromVehicle(source:getOccupiedVehicle())
			--source:outputChat("#FFFFFFPuedes avisar de tu muerte con el comando #00FF00/avisarmuerte", 255, 255, 255, true)
			--source:outputChat("#FFFFFFO puedes aceptar tu destino utilizando el comando #963200/aceptarmuerte", 255, 255, 255, true)
			source:outputChat("#FFFFFFHas caido totalmente #FFFF00muerto #FFFFFFen el suelo. \nDebes esperar 60 segundos para poder usar #F06C6C/aceptarmuerte", 255, 255, 255, true)
			source:setData("Herido", {"Esta persona está Muerta", 150, 50, 0})
			ValoresTablaAsesinato[source] = source
		end
		end, 1000, 1, source, weapon, bodypart)
	end
else
	if ( attacker and attacker:getType() == "player" and bodypart ) then
		if ( source and source:getType() == "player" ) then
			--source:outputChat("#FF0033[ADVERTENCIA] #FFFF00Si reconnectas en pleno asesinato de tu personaje, serás sancionado.", 150, 50, 50, true)
			source:outputChat("#F06C6CCaiste inconsciente en el suelo gracias a #FFFF00".._getPlayerNameR(attacker).."", 255, 255, 255, true)
		--	JugadorMuerto[source] = false
			source:setData("Muerto",true)
			setTimer( function(player)
			if player then
			if player:getData("Muerto") == true then
				setElementData(player, "AceptarMuertoo", true)
				outputChatBox("#FFFFFFYa puedes utilizar #9CFF97/aceptarmuerte #FFFFFFprocura que no estes cortando un rol.", player, 0,0,0, true)
					end
				end
			end, 60000, 1, source)
			setTimer(function(source, weapon, bodypart, attacker)
				if isElement(source) or isElement(attacker) then
				local pos = Vector3(source:getPosition())
				local x, y, z = pos.x, pos.y, pos.z
				local pos2 = Vector3(source:getRotation())
				local rx, ry, rz = pos2.x, pos2.y, pos2.z
				local int = source:getInterior()
				local dim = source:getDimension()
				source:spawn(x, y, z, rz, source:getModel(), int, dim, nil)
				source:setFrozen(true)
				setPedAnimation(source, "crack", "crckdeth1", -1, false, false, false, true)
				source:setHealth(100)
				source:setCameraTarget(source)
				herido[source] = true
		---		JugadorMuerto[source] = true
				source:setData("Muerto",true)
				source:removeFromVehicle(source:getOccupiedVehicle())
				source:outputChat("#FF4949Te estás desangrando, luego de pasados 60 segundos podrás elegir morir", 255, 255, 255, true)
				source:outputChat("#FFFFFFUsa el comando #FF4949/aceptarmuerte #FFFFFFpara aparecer en el hospital mas cercano.", 255, 255, 255, true)
				source:outputChat("#FFFFFFTambien podes avisar de tu muerte con el comando #36FF00/avisarmuerte", 255, 255, 255, true)
				source:setData("Herido", {"Esta persona está Inconsciente", 150, 50, 0})
				ValoresTablaAsesinato[source] = attacker
			end
			end, 1000, 1, source, weapon, bodypart, attacker)
		end
	else
		--source:outputChat("#FF0033[ADVERTENCIA] #FFFF00Si reconnectas en pleno asesinato de tu personaje, serás sancionado.", 150, 50, 50, true)
		source:outputChat("#F06C6CCaiste inconsciente en el suelo gracias a #FFFF00Nadie", 255, 255, 255, true)
	--	JugadorMuerto[source] = false
			source:setData("Muerto",true)
			setTimer( function(player)
				if isElement(player) then
					if player:getData("Muerto") == true then
						setElementData(player, "AceptarMuertoo", true)
						outputChatBox("#FFFFFFYa puedes utilizar #9CFF97/aceptarmuerte #FFFFFFprocura que no estes cortando un rol.", player, 0,0,0, true)
					end
				end
			end, 60000, 1, source)
		setTimer(function(source, weapon, bodypart)
			if isElement(source) then
				local pos = Vector3(source:getPosition())
				local x, y, z = pos.x, pos.y, pos.z
				local pos2 = Vector3(source:getRotation())
				local rx, ry, rz = pos2.x, pos2.y, pos2.z
				local int = source:getInterior()
				local dim = source:getDimension()
				source:spawn(x, y, z, rz, source:getModel(), int, dim, nil)
				source:setFrozen(true)
				setPedAnimation(source, "crack", "crckdeth1", -1, false, false, false, true)
				source:setHealth(100)
				--JugadorMuerto[source] = true
				source:setData("Muerto",true)
				herido[source] = true
				source:setCameraTarget(source)
				source:removeFromVehicle(source:getOccupiedVehicle())
				source:outputChat("#FF4949Te estás desangrando, luego de pasados 60 segundos podrás elegir morir", 255, 255, 255, true)
				source:outputChat("#FFFFFFUsa el comando #FF4949/aceptarmuerte #FFFFFFpara aparecer en el hospital mas cercano.", 255, 255, 255, true)
				source:outputChat("#FFFFFFTambien podes avisar de tu muerte con el comando #36FF00/avisarmuerte", 255, 255, 255, true)
				source:setData("Herido", {"Esta persona está Inconsciente", 150, 50, 0})
				ValoresTablaAsesinato[source] = source
			end
		end, 1000, 1, source, weapon, bodypart)
	end
	end
end
addEventHandler("onPlayerWasted", getRootElement(), PlayerKilled)

--ver asesino 

function VerAsesino(player, cmd, who)
	if not notIsGuest( player ) then
		if permisosTotal[getACLFromPlayer(player)] == true then
			local thePlayer = exports["Gamemode"]:getFromName( player, who )
			if (thePlayer) then
				if ValoresTablaAsesinato[thePlayer] then
					player:outputChat("* El asesino de ".._getPlayerNameR(thePlayer).." es: #FF0033".._getPlayerNameR(ValoresTablaAsesinato[thePlayer]), 255, 255, 255, true)
				end
			else
				player:outputChat("Syntax: /asesino [ID]", 255, 255, 255, true)
			end
		end
	end
end
addCommandHandler("asesino", VerAsesino)

function aceptarMuerte(player)
    if player:getData("Muerto") == true and player:getData("AceptarMuertoo") == true then
        JugadorMuerto[player] = nil
        setControlState(player, "fire", true)
        local skin = player:getModel()
        player:spawn(2037.5325927734, -1411.6639404297, 17.1640625, 130, skin, 0, 0, nil)
        player:setModel(skin)
        player:setData("Herido", {"", 150, 50, 0})
        player:setHealth(100)
        player:setFrozen(false)
        player:setData("NoDamageKill", nil)
        herido[player] = nil
        setPedAnimation(player)
        takeAllWeapons(player)
        outputChatBox("#F06C6C[HOSPITAL] #FFFFFFTodas tus armas han sido retiradas, más un monto de #9CFF97$750 dólares #FFFFFFen gastos médicos.", player, 0, 0, 0, true)
        takePlayerMoney(player, 750)
        player:setData("Muerto", false)
        player:setData("AceptarMuertoo", false)
        player:setData("LSPD:Disponible", false)
    end
end
addCommandHandler("aceptarmuerte", aceptarMuerte)

local aviso = {
	AntiSpamM = {},
	blips = {},
}

--avisar_muerte
local LlamadosMuerteCentral = {}
function acudirLlamado(player, cmd, num)
	if getElementData(player,"Roleplay:faccion") == "Medico" or getElementData(player,"Roleplay:faccion") == "Policia" then
	if num then
		local llamado = tonumber(num)
		if tonumber(num) then
			if LlamadosMuerteCentral[""..num..""] then
				if unpack(LlamadosMuerteCentral[""..num..""]) == "Nadie" then
					local muerto, name = exports["Gamemode"]:getFromName(player, num)
					if muerto then
						local x, y, z = getElementPosition(muerto)
						blip = createBlip( x, y, z, 0, 3, 200, 128, 13, 178, 0, 99999.0, player)
						outputChatBox("#F06C6C[CENTRAL] #FFFFFFTomaste el llamado #800DB2#"..llamado.."#ffffff, te estaremos colocando la ubicación en el GPS.", player, 0,0,0, true)
						setTimer(function(blip)
							if blip then
								destroyElement( blip )
							end
						end, 60000, 1, blip)
					end
				end
			end
		end
	else
		outputChatBox("#F06C6CSyntax: #FFFFFF/llamadomuerte # \n#F06C6CEjemplo: #FFFFFF/llamadomuerte 2", player, 0,0,0, true)	
		end
	end
end
addCommandHandler("llamadomuerte", acudirLlamado)

local antiSpamW = {}

addCommandHandler("avisarmuerte", function( player )
	if not notIsGuest(player) then
		if player:getData("Muerto") == true then
		local tick = getTickCount()
		if (antiSpamW[player] and antiSpamW[player][1] and tick - antiSpamW[player][1] < 80000) then
		player:outputChat("Debes esperar 80 segundos para alertar nuevamente",255,0,0,true)
		return
	end
		local IDMuerte =  player:getData("ID") or 0  
		outputChatBox("#9CFF97[ENTORNO]#FFFFFF Alguien pasaría cerca viendo tu cuerpo en el suelo, seguidamente llamaría al 911.", player, 0,0,0, true)
		LlamadosMuerteCentral[""..IDMuerte..""] = {"Nadie"}
		setTimer(function(k)
			if k then
				LlamadosMuerteCentral[""..k..""] = nil
			end
		end, 90000, 1, IDMuerte)
		for k, miembro in ipairs(getElementsByType("player")) do
			if getElementData(miembro,"Roleplay:faccion") == "Medico" or getElementData(miembro,"Roleplay:faccion") == "Policia" then
				outputChatBox("#FFFFFF[Central#FFFFFF] #FE3333Nos llego un llamado de una persona herida. #FFFFFF/llamadomuerte "..IDMuerte.."#FFFFFF.", miembro, 0,0,0, true)
				triggerClientEvent( miembro, "herido2", miembro )
				end
			end
	end
	if (not antiSpamW[player]) then
	antiSpamW[player] = {}
	end
	antiSpamW[player][1] = getTickCount()
end
end)

addEventHandler( "onPlayerCommand", getRootElement(), 
	function(c)
		if c == 'limpref' then
			if getPlayerFaction( source, "Medico" ) or getPlayerFaction( source, "Bomberos" ) then
				if aviso.blips[source] then
					for k,v in pairs(aviso.blips[source]) do
						v:destroy()
						aviso.blips[source][k] = nil
					end
				end
			end
		end
	end
)

-- curar jugadores

local antiSpamW = {}

function curar_medico( source, cmd, jugador )
	if not notIsGuest( source ) then
		if getPlayerFaction( source, "Medico" )  or getPlayerFaction( source, "Bomberos" ) or permisosTotal[getACLFromPlayer(source)] == true then
			local tick = getTickCount()
			if (antiSpamW[source] and antiSpamW[source][1] and tick - antiSpamW[source][1] < 3000) then
				source:outputChat("Debes esperar 3 segundos",255,0,0,true)
				return
			end
			local player = exports["Gamemode"]:getFromName( source, jugador )
			if ( player ) then
				if ( not player:getData("Muerto") == true ) then
					local posicion = Vector3(source:getPosition()) -- source
					local x2, y2, z2 = posicion.x, posicion.y, posicion.z -- jugador
					local pos = Vector3(player:getPosition())
					local x, y, z = pos.x, pos.y, pos.z
					local pos2 = Vector3(player:getRotation())
					local rx, ry, rz = pos2.x, pos2.y, pos2.z
					local int = player:getInterior()
					local dim = player:getDimension()
				if getDistanceBetweenPoints3D(x2, y2, z2, x, y, z) < 1.5 then -- 5
					setPedAnimation(source)
					player:setHealth(player:getHealth()+20)
					player:setFrozen(false)
					MensajeRoleplay(source, "le ha dado una inyección ha ".._getPlayerNameR(player))
				end
				else
					source:outputChat("* El jugador: ".._getPlayerNameR(player).." esta muerto, usa el comando /reanimar [Nombre_Apellido o ID].", 150, 0, 0)
				end
			else
				source:outputChat("Syntax: /curar [ID]", 255, 255, 255, true)
			end
 		else
			source:outputChat("* No puedes usar este comando", 150, 50, 50)
		end
			if (not antiSpamW[source]) then
			antiSpamW[source] = {}
		end
		antiSpamW[source][1] = getTickCount()
	end
end
addCommandHandler("curar", curar_medico)

-- revivir para administradores

function revivirJugador(player, cmd, who)
	if not notIsGuest( player ) then
		if permisosTotal[getACLFromPlayer(player)] == true then
			local thePlayer = exports["Gamemode"]:getFromName( player, who )
			if (thePlayer) then
				if thePlayer:getData("Muerto") == true then
					local pos = Vector3(thePlayer:getPosition())
					local x, y, z = pos.x, pos.y, pos.z
					local pos2 = Vector3(thePlayer:getRotation())
					local rx, ry, rz = pos2.x, pos2.y, pos2.z
					local int = thePlayer:getInterior()
					local dim = thePlayer:getDimension()
					thePlayer:setData("Muerto",false)
					thePlayer:setData("LSPD:Disponible", false)
					setElementData(thePlayer, "AceptarMuertoo", false)
					thePlayer:spawn(x, y, z, rz, thePlayer:getModel(), int, dim, nil)
					thePlayer:setFrozen(false)
					thePlayer:setData("NoDamageKill", nil)
					setPedAnimation(thePlayer)
					thePlayer:setHealth(100)
					thePlayer:removeFromVehicle(thePlayer:getOccupiedVehicle())
					thePlayer:setData("Herido", {"", 150, 50, 0})
					outputDebugString("* ".._getPlayerNameR(player).." revivio al jugador: ".._getPlayerNameR(thePlayer).."", 0, 0, 150, 0)
					player:outputChat("* Acabas de revivir al jugador: ".._getPlayerNameR(thePlayer)..".", 50, 150, 0)
					thePlayer:outputChat("* ".._getPlayerNameR(player).." te acaba de revivir.", 50, 150, 0)
					exports["logs-medico"]:sendDiscordLogMessage("``".._getPlayerNameR(player).." Revivio a ".._getPlayerNameR(thePlayer)..".``", player)
					herido[player] = nil
				else
					player:outputChat("* El jugador: ".._getPlayerNameR(thePlayer).." no esta muerto.", 150, 0, 0)
				end
			else
				player:outputChat("Syntax: /revivir [ID]", 255, 255, 255, true)
			end
		end
	end
end
addCommandHandler("revivir", revivirJugador)

function reanimar_medico ( source, cmd, jugador )
	if not notIsGuest( source ) then
		if getPlayerFaction( source, "Medico" ) or  getPlayerFaction( source, "Bomberos" ) then
			local player = exports["Gamemode"]:getFromName( source, jugador )
			if ( player ) then
				-- source
				local posicion = Vector3(source:getPosition()) -- source
				local x2, y2, z2 = posicion.x, posicion.y, posicion.z -- jugador
				-- jugador
				local pos = Vector3(player:getPosition())
				local x, y, z = pos.x, pos.y, pos.z
				local pos2 = Vector3(player:getRotation())
				local rx, ry, rz = pos2.x, pos2.y, pos2.z
				local int = player:getInterior()
				local dim = player:getDimension()
				if getDistanceBetweenPoints3D(x2, y2, z2, x, y, z) < 1.5 then -- 5
					if player:getData("Muerto") == true then
						if player ~= source then
						setPedAnimation(source, "MEDIC", "CPR", -1,true, false, false)
						outputDebugString("* ".._getPlayerNameR(source).." revivio al jugador: ".._getPlayerNameR(player).."", 0, 0, 150, 0)
						source:outputChat("* En 5 segundos será revivido el jugador: ".._getPlayerNameR(player).."", 50, 150, 50)
						--JugadorMuerto[player] = nil
						player:setData("Muerto",false)
						setElementData(player, "AceptarMuertoo", false)
						player:setData("LSPD:Disponible", false)
						setTimer(function(player, source, x, y, z, rz, int, dim) 
							if isElement(player) then
							player:spawn(x, y, z, rz, player:getModel(), int, dim, nil)
							setPedAnimation(source)
							player:setHealth(11)
							player:setData("Herido", {"", 150, 50, 0})
							player:outputChat("* ".._getPlayerNameR(source).." te acaba de revivir.", 50, 150, 50)
							source:outputChat("* Acabas de revivir al jugador: ".._getPlayerNameR(player)..".", 50, 150, 50)								
							herido[player] = nil
						end
						end, 5000, 1, player, source, x, y, z, rz, int, dim)
						end
						player:setData("NoDamageKill", false)
					else
						source:outputChat("* El jugador: ".._getPlayerNameR(player).." no esta muerto.", 150, 0, 0)
					end
				else
					source:outputChat("* Tienes que estar cerca al jugador.", 150, 0, 0)
				end
			else
				source:outputChat("Syntax: /reanimar [ID]", 255, 255, 255, true)
			end
		end
	end
end
addCommandHandler("reanimar", reanimar_medico)

function getPlayersWithinRange( vector, range )
	local players = {}	-- body
	for i,v in ipairs(Element.getAllByType('player')) do
		
		if getDistanceBetweenPoints3D( vector, v.positon ) <= range then
			table.insert(players, v)
		end
	end
	return players
end

function isElementWithinPickup(theElement, thePickup)
	if (isElement(theElement) and getElementType(thePickup) == "pickup") then
		local x, y, z = getElementPosition(theElement)
		local x2, y2, z2 = getElementPosition(thePickup)
		if (getDistanceBetweenPoints3D(x2, y2, z2, x, y, z) <= 1) then
			return true
		end
	end
	return false
end

-- SAVE LICENSES

addEventHandler("onPlayerLogin", getRootElement(), function(p, t, a)
	local conducir = t:getData("Muerto")
	if (conducir) then
		local va = t:getData("Muerto")
		source:setData("Muerto", va)
	else
		source:setData("Muerto", false)
	end
	if source:getData("Muerto") == true then 
		setTimer(function(source)
			source:setHealth(0)
		end,2000,1,source)
	end
end)

function quitMedico(q, r, e)
	local account = source:getAccount()
	if (account) then
		local va = source:getData("Muerto")
		account:setData("Muerto", va)
	end
end
addEvent("onStopResource", true)
addEventHandler("onPlayerQuit", getRootElement(), quitMedico)
addEventHandler("onStopResource", getRootElement(), quitMedico)

function stopPizzero( )
	for i, v in ipairs( Element.getAllByType("player") ) do
		if not notIsGuest then
			triggerEvent("onStopResource", v)
		end
	end
end
addEventHandler("onResourceStop", resourceRoot, stopPizzero)

---------------------------------------------------------------------
--[[
]]