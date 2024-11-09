local pick = Pickup(2209.8232421875, -2272.12109375, 13.554685592651,3,1239)
local pick2 = Marker(2208.205078125, -2277.529296875, 13.554685592651-1,"cylinder",4,255,255,255,50)
local car = {}
local num = 0
function crearveh(source)
	if isElementWithinPickup(source,pick) then
		if source:getData("Roleplay:faccion") == "Mecanico" then
			local x,y,z =  2215.826171875, -2270.498046875, 13.554685592651
			num = num + 1
			car[num] = createVehicle(525,x,y,z,0, 0, 45.942779541016)
			car[num]:setPlateText("Mecanico")
			car[num]:setData('Locked', 'Cerrado')
			car[num]:setData('Motor','apagado')
			car[num]:setData("vrd",num)
			car[num]:setData("VehiculoPublico", "Mecanico")
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
--[[addCommandHandler("rveh", function(player, cmd)
	if isElement(player) then
		if not notIsGuest(player) then
			local cuenta = player:getAccount():getName()
			if getPlayerFaction(player, "Mecanico") then
				local veh = player:getOccupiedVehicle()
				local seat = player:getOccupiedVehicleSeat()
				if player:isInVehicle() then
					if veh and seat == 0 then
						local owner = veh:getData("Owner")
						if owner then
							local thePlayer = getPlayerFromName(owner)
							if (thePlayer) then
								local costoTotal = math.ceil(0.5*veh:getHealth())
								veh:fix()
								--
								player:outputChat("Acabas de reparar el vehículo de ".._getPlayerNameR(thePlayer).."", 50, 150, 50, true)
								thePlayer:outputChat("El mecanico: ".._getPlayerNameR(player).." acaba de reparar tu vehículo por el costo de: #004500$"..convertNumber(costoTotal).." dólares", 50, 150, 50, true)
								--
								thePlayer:takeMoney(tonumber(costoTotal))
							end
						else
							if isObjectInACLGroup ("user."..cuenta, aclGetGroup ( "Admin" ) ) then
								veh:fix()
							end
						end
					end
				end
			end
		end
	end
end)]]
function radio(p, cmd, ...)
	if not notIsGuest( p ) then
		if getPlayerFaction( p, "Mecanico" ) then
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
				outputDebugString("**[CH: 311, S: Mecanicos] "..nick..": "..msg.."", 0, 118, 98, 134)
				--
				for i, v in ipairs(Element.getAllByType("player")) do
					if v:getData("Roleplay:faccion") == faccion and v:getData("Roleplay:faccion_division") == division then
						--
						playSoundFrontEnd (v, 49)
						--
						setTimer(function(v, rank)
							if isElement(v) then
							v:outputChat("**[CH: 311, S: Mecanicos] "..nick..": "..msg.."", 0, 189, 255, true)
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
function changeCarLightsColor ( thePlayer, cmd, red, green, blue )
	local cuenta = thePlayer:getAccount():getName()
	if thePlayer:getData("Roleplay:faccion") == "Mecanico" or isObjectInACLGroup ("user."..cuenta, aclGetGroup ( "Admin" ) ) then
		local theVehicle = getPedOccupiedVehicle ( thePlayer )
		if ( theVehicle ) then
			red = tonumber ( red )
			green = tonumber ( green )
			blue = tonumber ( blue )
			if red and green and blue then
				local color = setVehicleHeadLightColor ( theVehicle, red, green, blue )
				if(color) then
					outputChatBox ( "Has cambiado las luces del vehiculo",thePlayer,50,255,50,true )
				else
					outputChatBox( "No se ha podido cambiar las luces",thePlayer,255,50,50,true )
				end
			else
				outputChatBox( "No se ha podido cambiar las luces",thePlayer,255,50,50,true )
			end
		else
			outputChatBox( "No estas en ningun vehiculo!",thePlayer,255,50,50)
		end
	end
end
addCommandHandler ( "luz", changeCarLightsColor )
--puerta
addEventHandler("onResourceStart",getResourceRootElement(),function()
    --myGate1 = createObject ( 971, 2501.6999,-1514.4,26.60 , 0, 0, 360 )
    myGate1 = createObject ( 971, 2510.4,-1514.4,26.60 , 0, 0, 360 )
end)
addCommandHandler("abrirp",function(source)
	if source:getData("Roleplay:faccion") == "Mecanico" then
		moveObject ( myGate1, 2500, 2510.4,-1514.4,26.60 )
	end
end)
addCommandHandler("cerrarp",function(source)
	if source:getData("Roleplay:faccion") == "Mecanico" then
 		moveObject ( myGate1, 2500, 2501.6999,-1514.4,26.60 )
	end
end)
local comandosdisponibles = createMarker ( 2502.0300292969, -1514.8179931641, 24.096807479858, "cylinder", 10, 255,255,0,0 )
function mensajeelevador(source)
	if getPlayerFaction( source, "Mecanico" ) then
	if isElementWithinMarker(source, comandosdisponibles) then
		outputChatBox("#4169E1[Mecanicos] #ffffffComandos disponibles: #49FF00/abrirp - /cerrarp",source,255,255,255,true)
		end
	end
end
addEventHandler("onMarkerHit", comandosdisponibles, mensajeelevador)
local function createBlip2(x, y, z, icon)
	createBlip( x, y, z, icon, 2, 255, 255, 255, 255, 0, 50 )
end
