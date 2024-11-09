changeTable = {}
changeTable[597] = "Vehiculo CHARLIE"
function nameToggle()
    local theVeh   = getPedOccupiedVehicle(localPlayer)
    local theVehID = getElementModel(theVeh)
    theVehName = changeTable[theVehID]
    if not theVehName then theVehName = getVehicleName(theVeh) end
    theAlpha = 255
end
local conos = {}
addCommandHandler("cono", function(p, cmd)
	if not notIsGuest( p ) then
		if getPlayerFaction( p, "Policia" ) or getPlayerFaction( p, "S.W.A.T." ) or getPlayerFaction( p, "Medico" ) then
			maxConos = #conos
			local pos = Vector3(p:getPosition())
			local x, y, z = pos.x, pos.y, pos.z
			local dim = p:getDimension()
			local int = p:getInterior()
			conos[maxConos + 1] = Object(1238, x, y, z-0.7, 0, 0, 0, false)
			--
			conos[maxConos + 1]:setData("Object:Cono", true)
			--
			conos[maxConos + 1]:setCollisionsEnabled(false)
			conos[maxConos + 1]:setDimension(dim)
			conos[maxConos + 1]:setInterior(int)
		end
	end
end)
addCommandHandler("qcono", function(p, cmd)
	if not notIsGuest( p ) then
		if getPlayerFaction( p, "Policia" ) or getPlayerFaction( p, "S.W.A.T." ) or getPlayerFaction( p, "Medico" ) then
			local pos = Vector3(p:getPosition())
			local x, y, z = pos.x, pos.y, pos.z
			for i, v in ipairs(Element.getWithinRange(x, y, z, 1, "object")) do
				if v:getData("Object:Cono") == true then
					if isElement(v) then
						destroyElement(v)
					end
				end
			end
		end
	end
end)
local comandosdisponibles = createMarker ( 1539.8149414062, -1628.0119628906, 13, "cylinder", 10, 255,255,0,0 )
function mensajeelevador(source)
	if getPlayerFaction( source, "Policia" ) or getPlayerFaction( p, "DOEM" ) or getPlayerFaction( p, "DDI" ) then
	if isElementWithinMarker(source, comandosdisponibles) then
		outputChatBox("#4169E1[LSPD] #ffffffPuedes abrir el porton utilizando #49FF00/abrirp",source,255,255,255,true)
		end
	end
end
addEventHandler("onMarkerHit", comandosdisponibles, mensajeelevador)
------------------------------------------------------------------------
local marcador = createMarker ( 1581.9749755859, -1681.2114257812, 15.4, "cylinder", 1.5, 255,255,0,0 )
function mensajeelevador(source)
	if isElementWithinMarker(source, marcador) then
		outputChatBox("#FF8F11[ASCENSOR] #ffffffUsa #F3FF00/ascensor #ffffffo #F3FF00/elevador #ffffffpara usarlo.",source,255,255,255,true)
	end
end
addEventHandler("onMarkerHit", marcador, mensajeelevador)
function plantabaja( player )
	if getPlayerFaction( player, "Policia" ) then
  if isElementWithinMarker( player, marcador ) then
    triggerClientEvent (player, "OpenWinS" , getRootElement())
	end
else
	--outputChatBox("No cuentas con una tarjeta de acceso.",player,255,255,255,true)
  end
end
addCommandHandler("elevador", plantabaja)
addCommandHandler("ascensor", plantabaja)
-------------------------------------------------------------------
local marcadorSub = createMarker ( 1524.4831542969, -1677.8767089844, 6.21875, "cylinder", 1.5, 255,255,0,0 )
function mensajeelevador(source)
	if isElementWithinMarker(source, marcadorSub) then
		outputChatBox("#FF8F11[ASCENSOR] #ffffffUsa #F3FF00/ascensor #ffffffo #F3FF00/elevador #ffffffpara usarlo.",source,255,255,255,true)
	end
end
addEventHandler("onMarkerHit", marcadorSub, mensajeelevador)
function subsuelo( player )
	if getPlayerFaction( player, "Policia" ) then
  if isElementWithinMarker( player, marcadorSub ) then
    triggerClientEvent (player, "OpenWinS" , getRootElement())
end
 else
	outputChatBox("No cuentas con una tarjeta de acceso.",player,255,255,255,true)
  end
end
addCommandHandler("elevador", subsuelo)
addCommandHandler("ascensor", subsuelo)
-------------------------------------------------------------------
local marcadorTechoo = createMarker ( 1572.0100097656, -1675.6479492188, 28.3984375, "cylinder", 1.5, 255,255,0,0 )
function mensajeelevador(source)
	if isElementWithinMarker(source, marcadorTechoo) then
		outputChatBox("#FF8F11[ASCENSOR] #ffffffUsa #F3FF00/ascensor #ffffffo #F3FF00/elevador #ffffffpara usarlo.",source,255,255,255,true)
	end
end
addEventHandler("onMarkerHit", marcadorTechoo, mensajeelevador)
function techo( player )
	if getPlayerFaction( player, "Policia" ) then
  if isElementWithinMarker( player, marcadorTechoo ) then
    triggerClientEvent (player, "OpenWinS" , getRootElement())
  end
  else
	outputChatBox("No cuentas con una tarjeta de acceso.",player,255,255,255,true)
end
end
addCommandHandler("elevador", techo)
addCommandHandler("ascensor", techo)
-------------------------------------------------------------------
local barras = {}
addCommandHandler("barra", function(p, cmd)
	if not notIsGuest( p ) then
		if getPlayerFaction( p, "Policia" ) or getPlayerFaction( p, "S.W.A.T." ) or getPlayerFaction( p, "Medico" ) then
			maxBarras = #barras
			local pos = Vector3(p:getPosition())
			local x, y, z = pos.x, pos.y, pos.z
			local rot = Vector3(p:getRotation())
			local rx, ry, rz = rot.x, rot.y, rot.z
			local dim = p:getDimension()
			local int = p:getInterior()
			barras[maxBarras + 1] = Object(1459, x, y, z-0.6, 0, 0, rz, false)
			--
			barras[maxBarras + 1]:setData("Object:Barra", true)
			--
			barras[maxBarras + 1]:setCollisionsEnabled(true)
			barras[maxBarras + 1]:setDimension(dim)
			barras[maxBarras + 1]:setInterior(int)
		end
	end
end)
addCommandHandler("qbarra", function(p, cmd)
	if not notIsGuest( p ) then
		if getPlayerFaction( p, "Policia" ) or getPlayerFaction( p, "S.W.A.T." ) or getPlayerFaction( p, "Medico" ) then
			local pos = Vector3(p:getPosition())
			local x, y, z = pos.x, pos.y, pos.z
			for i, v in ipairs(Element.getWithinRange(x, y, z, 1, "object")) do
				if v:getData("Object:Barra") == true then
					if isElement(v) then
						destroyElement(v)
					end
				end
			end
		end
	end
end)
local antiSpamRadio = {}
function radio(p, cmd, ...)
	if not notIsGuest( p ) then
		if getPlayerFaction( p, "Policia" ) then
			local seconds = getRealTime().second
			time = getRealTime ()
			day = time.monthday
			mes = time.month 	
			ano = time.year + 1900
			hour = time.hour
			mins = time.minute
			if day <= 9 then
				dia = "0"..day..""
			else
				dia = day
			end
			if hour <= 9 then
				hora = "0"..hour..""
			else
				hora = hour
			end
			if mins <= 9 then
				minutos = "0"..mins..""
			else
				minutos = mins
			end
			local nick = _getPlayerNameR(p)
			--
			if p:getData("Roleplay:faccion_division") ~="" then
				div = "| "..p:getData("Roleplay:faccion_division").." "
			else
				div = ""
			end
			local msg = table.concat({...}, " ")
			if msg ~="" and msg ~=" " then
				local faccion = p:getData("Roleplay:faccion")
				local division = p:getData("Roleplay:faccion_division")
				--outputDebugString("**[CH: 911, S: 1] "..nick..": "..msg.."", 0, 118, 98, 134)
				--
				for i, v in ipairs(Element.getAllByType("player")) do
					if v:getData("Roleplay:faccion") == faccion and v:getData("Roleplay:faccion_division") == division then
						--
						playSoundFrontEnd (v, 49)
						--
						setTimer(function(v, rank)
							if isElement(v) then
							--v:outputChat("**[CH: 911, S: 1] "..nick..": "..msg.."", 118, 98, 134, true)
							v:outputChat("#0070FF[RADIO] "..(p:getData("Roleplay:faccion_rango") or "").." | ("..(p:getData("ID") or 0)..") "..nick..": #ffffff"..msg.."", 118, 98, 134, true)
                            exports["logs-policia"]:sendDiscordLogMessage("``[RADIO] "..(p:getData("Roleplay:faccion_rango") or "").." | ("..(p:getData("ID") or 0)..") "..nick..": "..msg.."``",255 ,255 , 255, true)
						end
						end, 0, 1, v, rank)
						-- antispam
						if (not antiSpamRadio[v]) then
							antiSpamRadio[v] = {}
						end
						antiSpamRadio[v][1] = getTickCount()
					end
				end
				p:setData("TextInfo", {"> habla por la radio", 178, 140, 214})
				setTimer(function(p)
					if isElement(p) then
					p:setData("TextInfo", {"", 178, 140, 214})
				end
				end, 2000, 1, p)
			end
		end
	end
end
addCommandHandler("rf", radio)
local antiSpamOOCRadio = {}
function ooc_radio(p, cmd, ...)
	if not notIsGuest( p ) then
		if p:getData("Roleplay:faccion") ~="" then
			local tick = getTickCount()
			if (antiSpamOOCRadio[p] and antiSpamOOCRadio[p][1] and tick - antiSpamOOCRadio[p][1] < 1000) then
				return
			end
			local nick = _getPlayerNameR( p )
			--
			if p:getData("Roleplay:faccion_division") ~="" then
				div = "| "..p:getData("Roleplay:faccion_division").." "
			else
				div = ""
			end
			local msg = table.concat({...}, " ")
			if msg ~="" and msg ~=" " then
				outputDebugString("[OOC] ["..(p:getData("Roleplay:faccion_rango") or "").." "..div.."]"..nick..": "..msg.."", 0, 255, 255, 255)
				for i, v in ipairs(Element.getAllByType("player")) do
					if v:getData("Roleplay:faccion") == p:getData("Roleplay:faccion") and v:getData("Roleplay:faccion_division") == p:getData("Roleplay:faccion_division") then
						v:outputChat("#FFFFFF[OOC] #243A6E["..(p:getData("Roleplay:faccion_rango") or "").." "..div.."]#FFFFFF "..nick..":#FFFFFF "..msg.."", 255, 255, 255, true)
						exports["logs-policia"]:sendDiscordLogMessage("``[OOC] ["..(p:getData("Roleplay:faccion_rango") or "").." "..div.."] "..nick..": "..msg.."``")
					end
				end
			end
			if (not antiSpamOOCRadio[p]) then
				antiSpamOOCRadio[p] = {}
			end
			antiSpamOOCRadio[p][1] = getTickCount()
		end
	end
end
addCommandHandler("f", ooc_radio)
local antiSpamDepartament = {}
function radio_derpatament(p, cmd, ...)
	if not notIsGuest( p ) then
		if getPlayerFaction( p, "Policia" ) or getPlayerFaction(p, "Medico") or getPlayerDivision( p, "DOEM" ) or getPlayerDivision( p, "DDI" ) or getPlayerFaction( p, "Medico" ) or getPlayerFaction( p, "Bombero" ) or getPlayerFaction( p, "Mecanico" ) or getPlayerFaction( p, "Gobierno" )  then
			local tick = getTickCount()
			if (antiSpamDepartament[p] and antiSpamDepartament[p][1] and tick - antiSpamDepartament[p][1] < 1000) then
				return
			end
			local nick = _getPlayerNameR( p )
			if getPlayerFaction(p, "Policia") then
				rank = "LSPD"
			elseif getPlayerFaction(p, "Medico") then
				rank = "LSFD"
			elseif getPlayerFaction(p, "Bombero") then
				rank = "LSRD"
			elseif getPlayerFaction(p, "Gobierno") then
				rank = "LSJD"
			elseif getPlayerFaction(p, "Mecanico") then
				rank = "LSMW"
			end
			local msg = table.concat({...}, " ")
			if msg ~="" and msg ~=" " then
				for i, v in ipairs(Element.getAllByType("player")) do
					if getPlayerFaction(v, "Policia") or getPlayerFaction(v, "Medico") or getPlayerDivision( v, "DOEM" ) or getPlayerDivision( v, "DDI" ) or getPlayerFaction( v, "Medico" ) or getPlayerFaction( v, "Bombero" ) or getPlayerFaction( v, "Mecanico" )  or getPlayerFaction( v, "Gobierno" ) then
						setTimer(function(v)
							if isElement(v) then
								v:outputChat("#E10000[RAD. DEPART - ("..rank.."#E10000) "..nick.."]: #FFFFFF"..msg.."", 0, 0, 0, true)
								exports["logs-policia"]:sendDiscordLogMessage("``[RAD. DEPART - ("..rank..") "..nick.."]: "..msg.."``")
								
							end
						end, 800, 1, v)
						if (not antiSpamRadio[v]) then
							antiSpamRadio[v] = {}
						end
					end
				end
			end
		end
	end
end
addCommandHandler("d", radio_derpatament)
addCommandHandler("departamental", radio_derpatament)
local antiSpam = {}
function megafono_policia ( source, cmd, ... )
	if not notIsGuest( source ) then
		local tick = getTickCount()
		if (antiSpam[source] and antiSpam[source][1] and tick - antiSpam[source][1] < 500) then
			return
		end
		if getPlayerFaction( source, "Policia" ) or getPlayerDivision( source, "DOEM" ) or getPlayerDivision( source, "DDI" ) or getPlayerFaction( source, "Medico" ) then
		--	if inPlayerVehiclePolice(source) then
				local msg = table.concat({...}, " ")
				if msg ~="" and msg ~=" " then
					local vehicle = source:getOccupiedVehicle()
					local seat = source:getOccupiedVehicleSeat()
					if seat == 0 or seat == 1 then
						local pos = Vector3(vehicle:getPosition())
						local nick = _getPlayerNameR( source )
						local x, y, z = pos.x, pos.y, pos.z
						chatCol = ColShape.Sphere(x, y, z, 30)
						nearPlayers = chatCol:getElementsWithin("player") 
						outputDebugString("[MEGÁFONO] "..nick.." o<:  #FFFFFF¡"..msg.."!", 0, 215, 255, 0)
						exports["logs-policia"]:sendDiscordLogMessage("``[MEGÁFONO] "..nick.." o<: ¡"..msg.."!``")
						for _,v in ipairs(nearPlayers) do
							v:outputChat("[MEGÁFONO] "..nick.." o< : #FFFFFF¡ "..msg.." !", 255, 255, 0, true)
							
						end
						if isElement( chatCol ) then
							destroyElement( chatCol )
						end
					end
				end
		--	end
		end
		if (not antiSpam[source]) then
			antiSpam[source] = {}
		end
		antiSpam[source][1] = getTickCount()
	end
end
addCommandHandler("meg", megafono_policia)
addCommandHandler("m", megafono_policia)
addCommandHandler("megafono", megafono_policia)
function esposar_policia ( source, cmd, jugador )
	if not notIsGuest( source ) then
		if getPlayerFaction( source, "Policia" ) then
			local player = exports["Gamemode"]:getFromName( source, jugador )
			if ( player ) then
				if (player:getName() ~= source:getName()) then
					local posicion = Vector3(source:getPosition()) -- source
					local x2, y2, z2 = posicion.x, posicion.y, posicion.z
					local pos = Vector3(player:getPosition())
					local x, y, z = pos.x, pos.y, pos.z
					if getDistanceBetweenPoints3D(x2, y2, z2, x, y, z) < 1.5 then -- 5
						if player:getData("Roleplay:arrestado") ~="arrestado" then
							if player:getOccupiedVehicle() then
								player:removeFromVehicle(player:getOccupiedVehicle())
							end
							setPedAnimation( player, "GRAVEYARD", "mrnM_loop", -1, false, true, true, false)
							toggleControl( player, "aim_weapon", false )
							toggleControl( player, "next_weapon", false )
							toggleControl( player, "previous_weapon", false )
							toggleControl( player, "jump", false )
							toggleControl( player, "fire", false )
							player:setData("TextInfo", {"[Esposado]", 150, 50, 0})
							player:setWeaponSlot(0)
							source:outputChat("* Acabas de Esposar al jugador: #FFFFFF"..player:getName().."", 0, 150, 0, true)
							exports["logs-policia"]:sendDiscordLogMessage("``El jugador "..source:getName().." le coloco las esposas a "..player:getName().."``")
						end
					else
						source:outputChat("* Tienes que estar cerca al jugador.", 150, 0, 0)
					end
				else
					source:outputChat("* No te puedes Esposar tu mismo", 150, 0, 0)
				end
			end
		end
	end
end
addCommandHandler("esposar", esposar_policia)
function liberar_policia ( source, cmd, jugador )
	if not notIsGuest( source ) then
		if getPlayerFaction( source, "Policia" ) then
			local player = exports["Gamemode"]:getFromName( source, jugador )
			if ( player ) then
				local posicion = Vector3(source:getPosition()) -- source
				local x2, y2, z2 = posicion.x, posicion.y, posicion.z
				local pos = Vector3(player:getPosition())
				local x, y, z = pos.x, pos.y, pos.z
				if getDistanceBetweenPoints3D(x2, y2, z2, x, y, z) < 1.5 then -- 5
					player:outputChat("#000000[#0055EE LSPD#000000]#FFFFFF Te quito las esposas", true, true, true)
					exports["logs-policia"]:sendDiscordLogMessage("``El jugador "..source:getName().." le quito las esposas a "..player:getName().."``")
					source:outputChat("* Acabas de liberar al jugador: #FFFFFF"..player:getName().."", 0, 150, 0, true)
					player:setData("TextInfo", {"", 255, 255, 255})
					toggleControl( player, "aim_weapon", true )
					toggleControl( player, "next_weapon", true )
					toggleControl( player, "previous_weapon", true )
					toggleControl( player, "jump", true )
					toggleControl( player, "fire", true )
					setPedAnimation( player )
				else
					source:outputChat("* Tienes que estar cerca al jugador.", 150, 0, 0)
				end
			end
		end
	end
end
addCommandHandler("liberar", liberar_policia)
local valoresArresto = {}
local tiempoArrestos = {}
local posicionesJail = {
[1]={2796.2436523438, -2468.8762207031, 13.63159942627},
[2]={2796.2436523438, -2468.8762207031, 13.63159942627},
[3]={2796.2436523438, -2468.8762207031, 13.63159942627},
[4]={2796.2436523438, -2468.8762207031, 13.63159942627},
}
addCommandHandler("arrestar", function(player, cmd, who, time, id, ...)
    if not notIsGuest(player) then
        if getPlayerFaction(player, "Policia") or getPlayerDivision(player, "DOEM") or getPlayerDivision(player, "DDI") then
            if tonumber(time) then
                local thePlayer = exports["Gamemode"]:getFromName(player, who)
                local arrestReason = table.concat({ ... }, " ")
                if thePlayer and not isPlayerExistsArresto(thePlayer) then
                    if tonumber(id) >= 1 and tonumber(id) <= 4 then
                        thePlayer:outputChat("Has sido arrestado por " .. _getPlayerNameR(player) .. " por " .. tonumber(time) .. " minutos. Motivo: " .. arrestReason, 150, 50, 50, true)
                        exports["Logs-arrestos"]:sendDiscordLogMessage("" .. _getPlayerNameR(thePlayer) .. " sido arrestado por " .. tonumber(time) .. " minutos. Motivo: " .. arrestReason .. ".", player)
                        player:outputChat("Metiste a " .. _getPlayerNameR(thePlayer) .. " a la cárcel por " .. tonumber(time) .. " minutos. Motivo: " .. arrestReason, 50, 150, 50, true)
                        if thePlayer:isInVehicle() then
                            thePlayer:removeFromVehicle(thePlayer:getOccupiedVehicle())
                        end
                        local x, y, z = posicionesJail[tonumber(id)][1], posicionesJail[tonumber(id)][2], posicionesJail[tonumber(id)][3]
                        thePlayer:setPosition(x, y, z)
                        thePlayer:setDimension(0)
                        thePlayer:setInterior(0)
                        table.insert(valoresArresto, { AccountName(thePlayer), tonumber(time * 60) })
                        tiempoArrestos[thePlayer] = setTimer(bajarTimeArresto, 1000, 0, thePlayer)
                        -- Establecer motivo de arresto para el jugador arrestado en el cliente
                        thePlayer:setData("ArrestingOfficer", _getPlayerNameR(player)) -- Nombre de quien arrestó
                        thePlayer:setData("ArrestReason", arrestReason) -- Motivo de arresto
                    else
                        player:outputChat("* Debes colocar el número de celda que estará el preso: 1-4", 150, 50, 50, true)
                    end
                else
                    outputChatBox("#44A5CASyntax: #FFFFFF/arrestar [ID] [Tiempo] [Celda] [Motivo]", player, 0, 0, 0, true)
                end
            else
                outputChatBox("#44A5CASyntax: #FFFFFF/arrestar [ID] [Tiempo] [Celda] [Motivo]", player, 0, 0, 0, true)
            end
        end
    end
end)
addCommandHandler("sacarcarcel", function(player, cmd, who)
	if not notIsGuest( player ) then
		if getPlayerFaction( player, "Policia" ) or getPlayerDivision( player, "DOEM" ) or getPlayerDivision( player, "DDI" ) then
			local thePlayer = exports["Gamemode"]:getFromName( player, who )
			if (thePlayer) then
				if isPlayerExistsArresto(thePlayer) then
					thePlayer:setTeam(nil)
					thePlayer:outputChat("#000000[#0055EE Penal #000000]#FFFFFF Acabas ser liberado", 255, 255, 255, true, true, true)
					local playerName = getPlayerName(player)
                    local arrestedPlayerName = getPlayerName(thePlayer)
					exports["logs-policia"]:sendDiscordLogMessage("``El jugador "..getPlayerName(player).." a liberado a "..getPlayerName(thePlayer).." de la carcel.``")
					thePlayer:setPosition(2675.8022460938, -2454.24609375, 13.638482093811)
					thePlayer:setInterior(0)
					thePlayer:setDimension(0)
					setElementData(thePlayer, "JailOOC", 0)
					if isTimer(tiempoArrestos[thePlayer]) then
						killTimer(tiempoArrestos[thePlayer])
					end
					for i, v in ipairs(valoresArresto) do
						if AccountName(thePlayer) == v[1] then
							table.remove(valoresArresto, i, v[1])
						end
					end
				end
			else
				outputChatBox("#44A5CASyntax: #FFFFFF/sacardecarcel [ID]", player, 0,0,0, true)
			end
		end
	end
end)
addEventHandler("onPlayerQuit", getRootElement(), function()
	if isTimer(tiempoArrestos[source]) then
		killTimer(tiempoArrestos[source])
	end
end)
function setPlayerJailPolice(player)
	if isElement(player) then
		if player:getType() == "player" then
			tiempoArrestos[player] = setTimer(bajarTimeArresto, 1000, 0, player)
			for i, v in ipairs(valoresArresto) do
				if AccountName(player) == v[1] then
					player:outputChat("* Tienes #FF0033"..v[2].."#FFFFFF segundos para salir de la carcel", 255, 255, 255, true)
				end
			end
		end
	end
end
function isPlayerExistsArresto(player)
	for _, v in ipairs (valoresArresto) do
		if v[1] == AccountName(player) then
			return true
		end
	end
	return false
end
function bajarTimeArresto(player)
	for i, v in ipairs(valoresArresto) do
		if AccountName(player) == v[1] then
			if v[2] >= 1 then
				v[2] = v[2] - 1
				setElementData(player, "JailOOC", v[2])
			end
			if v[1] and v[2] == 0 then
				table.remove(valoresArresto, i, v[1])
				setElementData(player, "JailOOC", 0)
				local thePlayer = getPlayerFromName(v[1])
				if (thePlayer) then
					if isTimer(tiempoArrestos[thePlayer]) then
						killTimer(tiempoArrestos[thePlayer])
					end
					thePlayer:setTeam(nil)
					thePlayer:outputChat("#000000[#0055EE Penal #000000]#FFFFFF Acabas ser liberado.", 255, 255, 255, true)
					thePlayer:setPosition(1546.2447509766, -1675.5861816406, 13.561938285828)
					thePlayer:setInterior(0)
					thePlayer:setDimension(0)
				end
			end
		end
	end
end
function fduty ( source )
	if getPlayerFaction( source, "Policia" ) or getPlayerDivision( source, "DOEM" ) or getPlayerDivision( source, "DDI" ) then
		if (source:getData("LSPD:Disponible") or false) == true then
			source:setData("LSPD:Disponible", false)
			source:outputChat("#44A5CA[LSPD] #F06C6CTe saliste de servicio", 255, 255, 255, true)
		else
			source:setData("LSPD:Disponible", true)
			source:outputChat("#44A5CA[LSPD] #9CFF97Te pusiste en servicio", 255, 255, 255, true)
		end
	else
		source:outputChat("#44A5CA[LSPD] #F06C6CNo perteneces a la faccion.", 150, 0, 0)
	end
end
addCommandHandler("fduty", fduty)