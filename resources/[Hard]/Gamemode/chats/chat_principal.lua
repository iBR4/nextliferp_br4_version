local antiSpam  = {} 
mysql = exports.MySQL
Animaciones = {"prtial_gngtlkA", "prtial_gngtlkB", "prtial_gngtlkC", "prtial_gngtlkD", "prtial_gngtlkE", "prtial_gngtlkF", "prtial_gngtlkG", "prtial_gngtlkG"}
addEventHandler("onPlayerChat", root, function( message, _type )
	cancelEvent()
	--if not source:getAccount():isGuest () then
			if (source:isMuted()) then
			source:outputChat("No puedes escribir, estás muteado.. ", 150, 0, 0)
		return
		end
		local tick = getTickCount()
		if (antiSpam[source] and antiSpam[source][1] and tick - antiSpam[source][1] < 500) then
			return
		end
		if _type == 0 then
			if message ~= "" and message ~= " " and message:len() >= 1 then
				local pos = Vector3(source:getPosition())
				local x, y, z = pos.x, pos.y, pos.z
				local nick = _getPlayerNameR( source )
				chatCol = ColShape.Sphere(x, y, z, 20)
				nearPlayers = chatCol:getElementsWithin("player") 
				--outputConsole("[Ingles] "..nick.." dice: "..message.."")
				--outputDebugString(""..nick.." dice en "..(source:getData("Roleplay:Idioma") or "Ingles")..":"..message.."", 0, 221, 250, 255)
				local preFind = message:find("-")
				message3 = message
				if preFind then
					local posFind = message:find('-', preFind+1)
					if posFind ~= nil then 
						local color = string.format("#%.2X%.2X%.2X", 221, 250, 255)
						message3 = tostring(message:sub(1,preFind).."#FF00D8"..message:sub(preFind+1,posFind-1)..color..message:sub(posFind,message:len()))
					end
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
				--source:setData("TextInfo", {"dice: "..message3, 221, 250, 255})
				setTimer(function(p)
					if isElement(p) then
						p:setData("TextInfo", {"",221, 250, 255})
					end
				end, 5000, 1, source)
				for _,v in ipairs(nearPlayers) do
					if not getElementData(source, "Muerto") then
					if source:getData("Familias:Enmascarado") then
						--v:outputChat("#FFFCD1[ING] "..source:getData("Familias:Enmascarado").." dice"..(source:getData("Roleplay:Idioma") or "")..":#FFFFFF "..message3..".", 221, 250, 255, true)
						--v:outputChat("#FFFFFF["..hora..":"..minutos..":"..seconds.."] ["..(source:getData("Roleplay:Idioma") or "Ingles").."] "..source:getData("Familias:Enmascarado").." dice :#FFFFFF "..message3.."", 221, 250, 255, true)
						v:outputChat("#FFF8C2[ING] "..source:getData("Familias:Enmascarado").." dice:#FFFFFF "..message3..".", 221, 250, 255, true)
					else
						--v:outputChat("#FFFFFF["..hora..":"..minutos..":"..seconds.."] ["..(source:getData("Roleplay:Idioma") or "Ingles").."] "..nick.." dice :#FFFFFF "..message3.."", 221, 250, 255, true)
						v:outputChat("#FFF8C2[ING] "..nick.." dice:#FFFFFF "..(message3)..".", 221, 250, 255, true)
						end
					end
				end
				if not source:isInVehicle() then 
					if not source:getData("NoDamageKill") == true then
						if exports["Facciones"]:getTaserCables(source) == false then
							if not getElementData(source, "Muerto") then
							if source:getData("animPlayer") == false then
								--source:setAnimation ( "GANGS", Animaciones[math.random(1, #Animaciones)], 1, false,false)
								end
							end
						end
					end
				end
				if (not antiSpam[source]) then
					antiSpam[source] = {}
				end
				antiSpam[source][1] = getTickCount()
				if isElement( chatCol ) then
					destroyElement( chatCol )
				end
			else
				source:outputChat("Debes escribir más de 1 carácteres.", 150, 0, 0)
			end
		end
		if _type == 1 then
			if message ~= "" and message ~= " " and message:len() >= 1 then
				local pos = Vector3(source:getPosition())
				local x, y, z = pos.x, pos.y, pos.z
				local nick = _getPlayerNameR( source )
				chatCol = ColShape.Sphere(x, y, z, 20)
				nearPlayers = chatCol:getElementsWithin("player") 
				outputDebugString("* "..message.." (("..nick.."))", 0, 215, 122, 8)
			    for _,v in ipairs(nearPlayers) do
					if source:getData("Familias:Enmascarado") then
						v:outputChat("#F000F0*"..source:getData("Familias:Enmascarado").." "..message.."", 184, 108, 255, true)
					else
						v:outputChat("#F000F0*"..nick.." "..message.."", 184, 108, 255, true)
					end
				end
				if (not antiSpam[source]) then
					antiSpam[source] = {}
				end
				antiSpam[source][1] = getTickCount()
				if isElement( chatCol ) then
					destroyElement( chatCol )
				end
			else
				source:outputChat("Debes escribir más de 1 carácteres.", 150, 0, 0)
			end
		end
	--end
end)
local antiSpamSusurro = {}
function chatSUSURRO( source, cmd, ... )
	if not source:getAccount():isGuest () then
		if (source:isMuted()) then
		return
		end
		local tick = getTickCount()
		if (antiSpamSusurro[source] and antiSpamSusurro[source][1] and tick - antiSpamSusurro[source][1] < 500) then
			--source:outputChat(" [ Argentina Roleplay ]: Espera 2 segundos para enviar un mensaje.. ", 150, 0, 0)
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
		if message ~= "" and message ~= " " and message:len() >= 3 then
			local pos = Vector3(source:getPosition())
			local x, y, z = pos.x, pos.y, pos.z
			local nick = _getPlayerNameR( source )
			local cuenta = source:getAccount():getName()
			chatCol = ColShape.Sphere(x, y, z, 2)
			nearPlayers = chatCol:getElementsWithin("player") 
			outputDebugString(""..nick.." susurra: "..message.."", 0, 165, 242, 255)
			for _,v in ipairs(nearPlayers) do
				if not getElementData(source, "Muerto") then
				if source:getData("Familias:Enmascarado") then
				v:outputChat("#FFF8C2[ING] "..source:getData("Familias:Enmascarado").." susurra:#929292 "..message..".", 221, 250, 255, true)
				else
				v:outputChat("#FFF8C2[ING] "..nick.." susurra:#929292 "..message..".", 221, 250, 255, true)
					end
				end
			end
			if (not antiSpamSusurro[source]) then
				antiSpamSusurro[source] = {}
			end
			antiSpamSusurro[source][1] = getTickCount()
			if isElement( chatCol ) then
				destroyElement( chatCol )
			end
		else
			source:outputChat("Debes escribir más de 1 carácteres.", 150, 0, 0)
		end
	end
end
addCommandHandler({"s", "susurro"}, chatSUSURRO)
local antiSpamAme = {}
function chatAme(source, cmd, ...)
	if not source:getAccount():isGuest () then
		if (source:isMuted()) then
		return
		end
		local tick = getTickCount()
		if (antiSpamAme[source] and antiSpamAme[source][1] and tick - antiSpamAme[source][1] < 500) then
			return
		end
		local message = table.concat({...}, " ")
		if message ~= "" and message ~= " " and message:len() >= 1 then
			local pos = Vector3(source:getPosition())
			local x, y, z = pos.x, pos.y, pos.z
			local nick = _getPlayerNameR( source )
			local cuenta = source:getAccount():getName()
			chatCol = ColShape.Sphere(x, y, z, 2)
			nearPlayers = chatCol:getElementsWithin("player") 
			source:outputChat("#F000F0> "..message.."", 240, 0, 240, true)
			source:setData("TextInfo", {"> "..message, 240, 0, 240})
			setTimer(function(source)
				if isElement(source) then
				source:setData("TextInfo", {"", 240, 0, 240})
			end
			end, 5000, 1, source)
			if (not antiSpamAme[source]) then
				antiSpamAme[source] = {}
			end
			antiSpamAme[source][1] = getTickCount()
			if isElement( chatCol ) then
				destroyElement( chatCol )
			end
		else
			source:outputChat("Debes escribir más de 1 carácteres.", 150, 0, 0)
		end
	end
end
addCommandHandler({"ame"}, chatAme)
function chatGlobal( source, cmd, ... )
	if not source:getAccount():isGuest () then
		local cuenta = source:getAccount():getName()
		if isObjectInACLGroup ("user."..cuenta, aclGetGroup ( "Admin" ) ) or isObjectInACLGroup ("user."..cuenta, aclGetGroup ( "SuperModerador" ) ) or isObjectInACLGroup ("user."..cuenta, aclGetGroup ( "Moderador" ) ) then
			local tick = getTickCount()
			if (antiSpam[source] and antiSpam[source][1] and tick - antiSpam[source][1] < 500) then
				--source:outputChat(" [ SecondLife Roleplay ]: Espera 2 segundos para enviar un mensaje.. ", 150, 0, 0)
				return
			end
			local message = table.concat({...}, " ")
			if message ~= "" and message ~= " " and message:len() >= 3 then
				local pos = Vector3(source:getPosition())
				local x, y, z = pos.x, pos.y, pos.z
				local nick = _getPlayerNameR( source )
				local cuenta = source:getAccount():getName()
				outputDebugString(""..nick..": "..message.."", 0, 165, 242, 255)
				if isObjectInACLGroup ("user."..cuenta, aclGetGroup ( "Admin" ) ) then
					tipo = " [#ee0000Admin#A5F2FF]"
				elseif isObjectInACLGroup ("user."..cuenta, aclGetGroup ( "SuperModerador" ) ) then
					tipo = " [#ee0000SuperMod#A5F2FF]"
				elseif isObjectInACLGroup ("user."..cuenta, aclGetGroup ( "Moderador" ) ) then
					tipo = " [#ee0000Mod#A5F2FF]"
				else
					tipo = ""
				end
				for _,v in ipairs(Element.getAllByType("player")) do
					v:outputChat("((GLOBAL)) "..nick..": #A5F2FF"..message.."", 165, 242, 255, true)
				end
				if (not antiSpam[source]) then
					antiSpam[source] = {}
				end
				antiSpam[source][1] = getTickCount()
			else
				source:outputChat("Debes escribir más de 1 carácteres.", 150, 0, 0)
			end
		end
	end
end
addCommandHandler({"o", "global"}, chatGlobal)
function trunklateText(thePlayer, text, factor)
    local msg = (tostring(text):gsub("%u", string.lower))
	return (tostring(msg):gsub("^%l", string.upper))
end
