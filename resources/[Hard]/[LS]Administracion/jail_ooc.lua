permisos = {
["Desarrollador"]=true,
["Administrador.General"]=true,
["Admin"]=true,
["Sup.Staff"]=true,
["SuperModerador"]=true,
["Moderador"]=true,
["Moderador A Pruebas"]=true,
}
local sql = dbConnect("sqlite", "datosjail.db");
dbExec(sql, "CREATE TABLE IF NOT EXISTS JailOOC(accountName,TiempoRestante)")
dbExec(sql, "CREATE TABLE IF NOT EXISTS JailIC(accountName,TiempoRestante)")
local statsSQL = dbConnect("sqlite", ":stats/sanciones.db");
dbExec(statsSQL, "CREATE TABLE IF NOT EXISTS datosOOC(accountName,tipo,motivo,tiempo,staff)")
local valoresJailOOC = {}
local tiempoTimers = {}
addCommandHandler("jail", function(source, cmd, jugador, tiempo, ...)
		if permisos[getACLFromPlayer(source)] == true then
			if tonumber(jugador) then
				local player = getPlayerFromName(jugador)
				if (player) and not isPlayerExists(player) then
					if player ~= source then
						if tonumber(tiempo) then
							local razon = table.concat({...}, " ")
							if razon ~="" and razon~= " " then
								-- si se encuentra en un vehiculo lo saca del auto
								if player:isInVehicle() then
									player:removeFromVehicle(player:getOccupiedVehicle())
								end
								for i, v in ipairs(Element.getAllByType("player")) do
									v:outputChat("#FF9B00"..source:getData("Nombre:staff").." #FFFFFF metio en Jail OOC a #FFF827"..player:getName().." #FFFFFFpor "..tiempo.." #FFFFFFminutos.", 255, 255, 255, true)
									v:outputChat("#FF0000Razon:#FFFFFF "..razon.."#FFFFFF", 255, 255, 255, true)
									--dbExec(statsSQL,"INSERT INTO datosOOC(accountName,tipo,motivo,tiempo,staff) VALUES(?,?,?,?,?)", player, "Jail", razon , tiempo, getAccountName(getPlayerAccount(player)))
								end
								--
								player:setTeam(Team.getFromName("Jail OOC"))
								player:setDimension(math.random(0,300))
								player:setInterior(5)
								player:setPosition(322.72, 306.43, 999.15)
								player:setData("JailOOC", 0)
								player:outputChat("Fuiste enviado a #FF5959Jail OOC #ffffffpor "..tiempo.." minutos", 255, 255, 255, true)
								player:outputChat("Puedes ver mas informacion sobre tu jail en #FF5959/stats#ffffff", 255, 255, 255, true)
								player:outputChat("¿Te jailean mucho?, Procura leer nuestras reglas en #FFFA59nuestra pagina web#ffffff", 255, 255, 255, true)
								--
								table.insert(valoresJailOOC, {AccountName(player), tonumber(tiempo*60)})
								tiempoTimers[player] = setTimer(bajarTiempoJails, 1000, 0, player)
							end
						end
					end
				end
			else
				local player = getPlayerFromName(jugador)
				if (player) and not isPlayerExists(player) then
					if player ~= source then
						if tonumber(tiempo) then
							local razon = table.concat({...}, " ")
							if razon ~="" and razon~= " " then
								-- si se encuentra en un vehiculo lo saca del auto
								if player:isInVehicle() then
									player:removeFromVehicle(player:getOccupiedVehicle())
								end
								for i, v in ipairs(Element.getAllByType("player")) do
									v:outputChat("#FF9B00"..source:getData("Nombre:staff").." #FFFFFF metio en Jail OOC a #FFF827"..player:getName().." #FFFFFFpor "..tiempo.." #FFFFFFminutos.", 255, 255, 255, true)
									v:outputChat("#FF0000Razon:#FFFFFF "..razon.."#FFFFFF", 255, 255, 255, true)
									exports["Logs-BANEOS"]:sendDiscordLogMessage(" metio en Jail OOC a "..player:getName().." por "..tiempo.." minutos, razon: "..razon..".", player)
									
									
								end
								--
								player:setTeam(Team.getFromName("Jail OOC"))
								player:setDimension(math.random(0,300))
								player:setInterior(5)
								player:setPosition(322.72, 306.43, 999.15)
								player:setData("JailOOC", 0)
								player:setData("Jaileado", true)
								dbExec(statsSQL,"INSERT INTO datosOOC(accountName,tipo,motivo,tiempo,staff) VALUES(?,?,?,?,?)", player:getName(), "Jail", razon, tiempo, source:getData("Nombre:staff"))
		
								player:outputChat("Fuiste enviado a #FF5959Jail OOC #ffffffpor "..tiempo.." minutos", 255, 255, 255, true)
								player:outputChat("Puedes ver mas informacion sobre tu jail en #FF5959/stats#ffffff", 255, 255, 255, true)
								player:outputChat("¿Te jailean mucho?, Procura leer nuestras reglas en #FFFA59nuestra pagina web#ffffff", 255, 255, 255, true)
								table.insert(valoresJailOOC, {AccountName(player), tonumber(tiempo*60)})
								tiempoTimers[player] = setTimer(bajarTiempoJails, 1000, 0, player)
						end
					end
				end
			else
                outputChatBox("#44A5CASyntax: #FFFFFF/jail [Nombre_Apellido] [Tiempo] [Motivo]", source, 0,0,0, true)
			end
		end
	end
end)
addCommandHandler("sacarjail", function(source, cmd, jugador, ...)
		if permisos[getACLFromPlayer(source)] == true then
			if tonumber(jugador) then
		    local player = getPlayerFromName(jugador)
				if (player) then
					if player ~= source then
						if isPlayerExists(player) then
							local razon = table.concat({...}, " ")
							if razon ~="" and razon ~=" " then
								for i, v in ipairs(Element.getAllByType("player")) do
									v:outputChat("#FF9B00"..source:getData("Nombre:staff").." #FFFFFFliberó del Jail OOC a #FFF827"..player:getName().."", 255, 255, 255, true)
									v:outputChat("#FF0000Razon:#FFFFFF "..razon.."", 255, 255, 255, true)
								end
								player:outputChat("#ffffff Cumpliste tu condena #FF5959OOC#ffffff, ¡Te recomendamos leer las reglas para evitar ser sancionado!", 50, 150, 50, true)
								player:setPosition(2098, -1807.3177490234, 13.554069519043)
								player:setInterior(0)
								player:setDimension(0)
								player:setTeam(nil)
								player:setData("JailOOC", 0)
								player:setData("Jaileado", false)
								if isTimer(tiempoTimers[player]) then
									killTimer(tiempoTimers[player])
								end
								for i, v in ipairs(valoresJailOOC) do
									if AccountName(player) == v[1] then
										table.remove(valoresJailOOC, i, v[1])
									end
								end
							end
						end
					end
				end
			else
				local player = getPlayerFromName(jugador)
				if (player) then
					if player ~= source then
						if isPlayerExists(player) then
							local razon = table.concat({...}, " ")
							if razon ~="" and razon ~=" " then
								for i, v in ipairs(Element.getAllByType("player")) do
									v:outputChat("#FF9B00"..source:getData("Nombre:staff").." #FFFFFFliberó del Jail OOC a #FFF827"..player:getName().."", 255, 255, 255, true)
									v:outputChat("#FF0000Razon:#FFFFFF "..razon.."", 255, 255, 255, true)
								end
								player:outputChat("#ffffff Cumpliste tu condena #FF5959OOC#ffffff, ¡Te recomendamos leer las reglas para evitar ser sancionado!", 50, 150, 50, true)
								player:setPosition(2098, -1807.3177490234, 13.554069519043)
								player:setInterior(0)
								player:setDimension(0)
								player:setTeam(nil)
								player:setData("JailOOC", 0)
								player:setData("Jaileado", false)
								
								if isTimer(tiempoTimers[player]) then
									killTimer(tiempoTimers[player])
								end
								for i, v in ipairs(valoresJailOOC) do
									if AccountName(player) == v[1] then
										table.remove(valoresJailOOC, i, v[1])
								end
							end
						end
					end
				end
			else
                outputChatBox("#44A5CASyntax: #FFFFFF/sacarjail [Nombre_Apellido] [Motivo]", source, 0,0,0, true)
			end
		end
	end
end)
addCommandHandler("advertir", function(player, cmd, otro, ...)
	if permisos[getACLFromPlayer(player)] == true then
            if otro then
                local other, name = exports["Gamemode"]:getFromName(player,otro)
                local name = name:gsub(" ", "_")
                if other then
                    if ( ... ) then
                        local pPalabras = { ... }
                        local motivo = table.concat( pPalabras, " " )
                        if motivo then
                            outputChatBox(player:getData("Nombre:staff").."#ffffff te ha advertido. Motivo: #F06C6C"..motivo, other, 255, 255, 0, true)
                            outputChatBox("#FFFFFFAdvertiste a #FFFF00"..name.."#FFFFFF. Motivo: #F06C6C"..motivo, player, 255, 255, 0, true)
                            dbExec(statsSQL,"INSERT INTO datosOOC(accountName,tipo,motivo,tiempo,staff) VALUES(?,?,?,?,?)", name, "Advertencia", motivo, "ADV", player:getData("Nombre:staff"))
                            
                        end
                    else
                        outputChatBox("#44A5CASyntax: #FFFFFF/advertir [ID] [Motivo]", player, 0,0,0, true)
                    end
                end
            else
                outputChatBox("#44A5CASyntax: #FFFFFF/advertir [ID] [Motivo]", player, 0,0,0, true)
            end
        end
end)
addEventHandler("onPlayerQuit", getRootElement(), function()
	if isTimer(tiempoTimers[source]) then
		killTimer(tiempoTimers[source])
	end
end)
addCommandHandler("sancionados", function(source)
	if not notIsGuest( source ) then
		if permisos[getACLFromPlayer(source)] == true then
			source:outputChat("* Jugadores encarcelados: ", 50, 150, 50, true)
			for i, v in ipairs(valoresJailOOC) do
				if i == 0 then
					source:outputChat("- Ninguno", 150, 50, 50, true)
				else
					source:outputChat(v[1].. " | Tiempo: "..v[2], 150, 50, 50, true)
				end
			end
		end
	end
end)
function setPlayerJail(player)
	if isElement(player) then
		if player:getType() == "player" then
			tiempoTimers[player] = setTimer(bajarTiempoJails, 1000, 0, player)
			player:setTeam(Team.getFromName("Jail OOC"))
			for i, v in ipairs(valoresJailOOC) do
				if AccountName(player) == v[1] then
					player:outputChat("* Tienes #FF0033"..v[2].."#FFFFFF segundos para salir de jail", 255, 255, 255, true)
				end
			end
		end
	end
end
function isPlayerExists(player)
	for _, v in ipairs (valoresJailOOC) do
		if v[1] == AccountName(player) then
			return true
		end
	end
	return false
end
function getPlayerIndex(tab, index, player)
	for _, v in ipairs (valoresJailOOC) do
		if v[index] == AccountName(player) then
			return _
		end
	end
	return 0
end
function bajarTiempoJails(player)
	for i, v in ipairs(valoresJailOOC) do
		if AccountName(player) == v[1] then
			if v[2] >= 1 then
				v[2] = v[2] - 1
				player:setData("JailOOC", v[2])
			end
			if v[1] and v[2] == 0 then
				table.remove(valoresJailOOC, i, v[1])
				local thePlayer = getPlayerFromName(v[1])
				if (thePlayer) then
					if isTimer(tiempoTimers[thePlayer]) then
						killTimer(tiempoTimers[thePlayer])
					end
					thePlayer:setTeam(nil)
					thePlayer:setData("Jaileado", false)
					thePlayer:outputChat("#ffffff Cumpliste tu condena #FF5959OOC#ffffff, ¡Te recomendamos leer las reglas para evitar ser sancionado!", 50, 150, 50, true)
					thePlayer:setPosition(2098, -1807.3177490234, 13.554069519043)
					thePlayer:setInterior(0)
					thePlayer:setDimension(0)
				end
			end
		end
	end
end
