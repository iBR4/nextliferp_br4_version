local antiSpamGrito  = {} 
function chatGrito( source, cmd, ... )
	if not source:getAccount():isGuest () then
		if (source:isMuted()) then
			source:outputChat("No puedes escribir, estás muteado.. ", 150, 0, 0)
		return
		end
		local tick = getTickCount()
		if (antiSpamGrito[source] and antiSpamGrito[source][1] and tick - antiSpamGrito[source][1] < 500) then
			--source:outputChat("Espera 2 segundos para enviar un mensaje.. ", 150, 0, 0)
			return
		end
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
		local message = table.concat({...}, " ")
		if message ~= "" and message ~= " " and message:len() >= 1 then
			local pos = Vector3(source:getPosition())
			local x, y, z = pos.x, pos.y, pos.z
			local nick = _getPlayerNameR( source )
			chatCol = ColShape.Sphere(x, y, z, 20)
			nearPlayers = chatCol:getElementsWithin("player") 
			outputDebugString("#FFF8C2[ING] "..nick.." grita: ¡"..message:upper().."!", 0, 221, 250, 255)
			for _,v in ipairs(nearPlayers) do
				if not getElementData(source, "Muerto") then
				if source:getData("Familias:Enmascarado") then
				v:outputChat("#FFF8C2[ING] "..source:getData("Familias:Enmascarado").." grita:#FFFFFF ¡"..message.."!", 221, 250, 255, true)
				else
				--v:outputChat("#FFFCD1[ING] "..nick.." grita"..(source:getData("Roleplay:Idioma") or "")..": #FFFFFF¡"..message.."!", 221, 250, 255, true)
				v:outputChat("#FFF8C2[ING] "..nick.." grita:#FFFFFF ¡"..message.."!", 221, 250, 255, true)
					end
				end
			end
			if (not antiSpamGrito[source]) then
				antiSpamGrito[source] = {}
			end
			antiSpamGrito[source][1] = getTickCount()
			if isElement( chatCol ) then
				destroyElement( chatCol )
			end
		else
			source:outputChat("Debes escribir más de 1 carácteres.", 150, 0, 0)
		end
	end
end
addCommandHandler({"g"}, chatGrito)