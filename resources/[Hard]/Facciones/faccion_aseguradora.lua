--local pick = Pickup(2209.8232421875, -2272.12109375, 13.554685592651,3,1239)
--local pick2 = Marker(2208.205078125, -2277.529296875, 13.554685592651-1,"cylinder",4,255,255,255,50)
function radio(p, cmd, ...)
	if not notIsGuest( p ) then
		if getPlayerFaction( p, "Aseguradora" ) then
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
				outputDebugString("**[CH: 723, S: Aseguradora] "..nick..": "..msg.."", 0, 118, 98, 134)
				--
				for i, v in ipairs(Element.getAllByType("player")) do
					if v:getData("Roleplay:faccion") == faccion and v:getData("Roleplay:faccion_division") == division then
						--
						playSoundFrontEnd (v, 49)
						--
						setTimer(function(v, rank)
							if isElement(v) then
							v:outputChat("**[CH: 723, S: Aseguradora] "..nick..": "..msg.."", 0, 189, 255, true)
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
