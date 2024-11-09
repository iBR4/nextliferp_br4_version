local sx_, sy_ = guiGetScreenSize()
local sx, sy = sx_/1360, sy_/768
local ValoresTrabajo = {}
local PosicionAuto = {}
local MarcadoresRuta = {}
local BlipsRuta = {}
local PedsRuta = {}
local TimerK = {}
local tableN = {}
function getSkinsRandom()
	local allSkins = getValidPedModels ( )
	local result = false
	local random = math.random(1, #allSkins)
	for key, skin in ipairs(allSkins) do
		if skin == tonumber(random) then
			result = skin
			break
		end
	end
	if (result) then
		return result
	else
		return 0
	end
end
function startRutaJardinero(tip, ruta)
		if (getElementData(localPlayer, "Roleplay:trabajo") == "Jardinero") or (getElementData(localPlayer, "Roleplay:trabajoVIP") == "Jardinero") then
		if tip == "LS" then
			if ruta == 1 then
				ValoresTrabajo[localPlayer][1] = tonumber(#MarkerMissionJardinero)
				ValoresTrabajo[localPlayer][4] = tonumber(ruta)
				for i=1, #MarkerMissionJardinero do
					if i >= ValoresTrabajo[localPlayer][2] and i <= ValoresTrabajo[localPlayer][2] then
						local x, y, z = MarkerMissionJardinero[i][1], MarkerMissionJardinero[i][2], MarkerMissionJardinero[i][3]
						local x2, y2, z2 = MarkerMissionJardinero[i][4], MarkerMissionJardinero[i][5], MarkerMissionJardinero[i][6]
						MarcadoresRuta[i] = Marker(x, y, z - 1, "cylinder", 3, 255, 255, 0, 100)
						BlipsRuta[i] = createBlipAttachedTo(MarcadoresRuta[i], 0, 2, 50, 150, 50, 255)
						--
						if i >= 2 and i <= 13 then
							for _, peds in ipairs(MarkerMissionJardinero[i].Peds) do
								--
								--
								if isElement(PedsRuta[i]) then
									addEventHandler("onClientPedDamage", PedsRuta[i], function()
										cancelEvent()
									end)
								end
							end
						end
						--
						if i <= 13 then
							setMarkerTarget(MarcadoresRuta[i], x2, y2, z2)
							setMarkerIcon ( MarcadoresRuta[i], "arrow" )
						else
							setMarkerIcon ( MarcadoresRuta[i], "finish" )
						end
						--
						addEventHandler("onClientMarkerHit", MarcadoresRuta[i], onJardineroHitMarker)
					end
				end
			end
			if ruta == 2 then
				ValoresTrabajo[localPlayer][1] = tonumber(#MarkerMissionJardinero2)
				ValoresTrabajo[localPlayer][4] = 2
				for i=1, #MarkerMissionJardinero2 do
					if i >= ValoresTrabajo[localPlayer][2] and i <= ValoresTrabajo[localPlayer][2] then
						local x, y, z = MarkerMissionJardinero2[i][1], MarkerMissionJardinero2[i][2], MarkerMissionJardinero2[i][3]
						local x2, y2, z2 = MarkerMissionJardinero2[i][4], MarkerMissionJardinero2[i][5], MarkerMissionJardinero2[i][6]
						MarcadoresRuta[i] = Marker(x, y, z - 1, "cylinder", 3, 255, 255, 0, 100)
						BlipsRuta[i] = createBlipAttachedTo(MarcadoresRuta[i], 0, 2, 50, 150, 50, 255)
						--
						if i >= 2 and i <= 16 then
							for _, peds in ipairs(MarkerMissionJardinero2[i].Peds) do
								--
								if isElement(PedsRuta[i]) then
									addEventHandler("onClientPedDamage", PedsRuta[i], function()
										cancelEvent()
									end)
								end
							end
						end
						--
						if i <= 16 then
							setMarkerTarget(MarcadoresRuta[i], x2, y2, z2)
							setMarkerIcon ( MarcadoresRuta[i], "arrow" )
						else
							setMarkerIcon ( MarcadoresRuta[i], "finish" )
						end
						--
						addEventHandler("onClientMarkerHit", MarcadoresRuta[i], onJardineroHitMarker)
					end
				end
			end
		end
	end
end
function onJardineroHitMarker( hitElement )
	if isElement(hitElement) and hitElement:getType() == "player" and hitElement == localPlayer then
		if hitElement:isInVehicle() then
				if (getElementData(hitElement, "Roleplay:trabajo") == "Jardinero") or (getElementData(hitElement, "Roleplay:trabajoVIP") == "Jardinero") and ValoresTrabajo[hitElement][3] == true then
				local veh = hitElement:getOccupiedVehicle()
				local seat = hitElement:getOccupiedVehicleSeat()
				if veh:getModel() == 532 and seat == 0 and veh:getData("VehiculoPublico") == "Jardinero" then
					if ValoresTrabajo[hitElement][1] ==ValoresTrabajo[hitElement][2] then
						destroyMarkersJardinero()
						--
						local x, y, z, x2, y2, z2 = unpack(PosicionAuto[1])
						veh:setPosition(x, y, z)
						veh:setRotation(x2, y2, z2)
						veh:setLocked(true)
						veh:setFrozen(true)
						veh:setData("Motor", "apagado")
						veh:setEngineState(false)
						table.remove(PosicionAuto, 1)
						outputChatBox("Si deseas trabajar, vuelve a subir al tractor.", 50, 150, 50, true)
						triggerServerEvent( "giveJardineroExp", hitElement )
						--triggerServerEvent( "drogas", hitElement )
						triggerServerEvent( "giveMoneyJardinero", hitElement )
						--
						ValoresTrabajo[hitElement] = nil;
						TimerK[hitElement] = nil;
						tableN[hitElement] = nil;
						hitElement:setControlState("enter_exit", true)
						setTimer(function(hitElement)
							if isElement(hitElement) then
								hitElement:setControlState("enter_exit", false)
							end
						end, 1000, 1, hitElement)
					else
						if ValoresTrabajo[hitElement][1] >= 1 then
							veh:setFrozen(false)
							fadeCamera(true)
							local time = math.random(1,3)
							triggerEvent("callCinematic", hitElement, "Cosechando..", time*1000, "No")
							setTimer(function(veh, hitElement)
								if isElement(veh) then
									veh:setFrozen(false)
									fadeCamera(true)
									--
									
								end
								--
							end, time*1000, 1, veh, hitElement)
						end
						ValoresTrabajo[hitElement][2] = ValoresTrabajo[hitElement][2] + 1
						setTimer(startRutaJardinero, 50, 1, "LS", ValoresTrabajo[hitElement][4])
						destroyMarkerRut(hitElement, ValoresTrabajo[hitElement][4])
					end
				end 
			end
		end
	end
end
function destroyMarkerRut(player, rut)
	if rut == 1 then
		for i=1, #MarkerMissionJardinero do
			if i <= ValoresTrabajo[player][2] then
				if isElement(MarcadoresRuta[i]) then
					destroyElement(MarcadoresRuta[i])
					MarcadoresRuta[i] = nil
				end
				if isElement(BlipsRuta[i]) then
					destroyElement(BlipsRuta[i])
					BlipsRuta[i] = nil
				end
				if isElement(PedsRuta[i]) then
					destroyElement(PedsRuta[i])
					PedsRuta[i] = nil
				end
			end
		end
	end
	if rut == 2 then
		for i=1, #MarkerMissionJardinero2 do
			if i <= ValoresTrabajo[player][2] then
				if isElement(MarcadoresRuta[i]) then
					destroyElement(MarcadoresRuta[i])
					MarcadoresRuta[i] = nil
				end
				if isElement(BlipsRuta[i]) then
					destroyElement(BlipsRuta[i])
					BlipsRuta[i] = nil
				end
				if isElement(PedsRuta[i]) then
					destroyElement(PedsRuta[i])
					PedsRuta[i] = nil
				end
			end
		end
	end
end
addEventHandler("onClientVehicleExit", root,
	function(thePlayer, seat)
        if thePlayer == getLocalPlayer() then
        	if seat == 0 then
        		if source:getModel() == 532 and source:getData("VehiculoPublico") == "Jardinero" then
        				if (getElementData(thePlayer, "Roleplay:trabajo") == "Jardinero") or (getElementData(thePlayer, "Roleplay:trabajoVIP") == "Jardinero") then
        				if ValoresTrabajo[thePlayer] then
        					if ValoresTrabajo[thePlayer][3] == true then
        						outputChatBox("Tienes 30 segundos para subir al vehículo o se cancelara la misión.", 150, 50, 50, true)
        						failedMissionJardinero("LS", thePlayer, source, 30)
        					end
        				end
        			end
        		end
        	end
        end
	end
)
addEventHandler("onClientVehicleEnter", root,
	function(thePlayer, seat)
		if thePlayer == getLocalPlayer() then
			if seat == 0 then
				if source:getModel() == 532 and source:getData("VehiculoPublico") == "Jardinero" then
					if (getElementData(thePlayer, "Roleplay:trabajo") == "Jardinero") or (getElementData(thePlayer, "Roleplay:trabajoVIP") == "Jardinero") then
						if tableN[thePlayer] == true then
        					if isTimer(TimerK[thePlayer]) then
        						killTimer(TimerK[thePlayer])
								TimerK[thePlayer] = nil;
								tableN[thePlayer] = nil;
        						outputChatBox("¡Perfecto sigue con la misión!", 50, 150, 50, true)
        					end
						end
						if ValoresTrabajo[thePlayer] then else
							local random = math.random(1, 2)
							ValoresTrabajo[thePlayer] = {nil, 1, true, random}
							startRutaJardinero("LS", random)
	        				local x, y, z = getElementPosition(source)
	        				local x2, y2, z2 = getElementRotation(source)
	        				table.insert(PosicionAuto, {x, y, z, x2, y2, z2})
	        				triggerEvent("callCinematic", thePlayer, "Conduce por los #FFFF00marcadores #ffffffintenta no ir tan rápido", 20000, "No")
						end
					end
				end
			end
		end
	end
)
addEvent("iniciarRutaJardinero", true)
function iniciarRutaJardinero()
	destroyMarkersJardinero()
end
addEventHandler("iniciarRutaJardinero", root, iniciarRutaJardinero)
addEvent("failedMissionJar", true)
function failedMissionJar()
	destroyMarkersJardinero()
	--
	TimerK[localPlayer] = nil;
	tableN[localPlayer] = nil;
	--
	table.remove(PosicionAuto, 1)
end
addEventHandler("failedMissionBas", root, failedMissionJar)
function failedMissionJardinero(tip, thePlayer, vehiculo, timer)
	if tip == "LS" then
		tableN[thePlayer] = true
		TimerK[thePlayer] = setTimer(function(p, veh)
			if isElement(p) and isElement(veh) then
				p:setData("Roleplay:trabajo", "")
				p:setData("Roleplay:trabajoVIP", "")
				destroyMarkersJardinero()
				ValoresTrabajo[p] = {nil, 1, false, 1}
				if veh and veh ~= nil then
					local x, y, z, x2, y2, z2 = unpack(PosicionAuto[1])
					veh:setPosition(x, y, z)
					veh:setRotation(x2, y2, z2)
					veh:setLocked(true)
					veh:setFrozen(true)
					veh:setEngineState(false)
				end
				--
				TimerK[p] = nil;
				tableN[p] = nil;
				--
				table.remove(PosicionAuto, 1)
			end
		end, timer*1000, 1, thePlayer, vehiculo)
	end
end
function destroyMarkersJardinero()
	for i=1, #MarkerMissionJardinero do
		if isElement(MarcadoresRuta[i]) then
			destroyElement(MarcadoresRuta[i])
			MarcadoresRuta[i] = nil
		end
		if isElement(BlipsRuta[i]) then
			destroyElement(BlipsRuta[i])
			BlipsRuta[i] = nil
		end
		if isElement(PedsRuta[i]) then
			destroyElement(PedsRuta[i])
			PedsRuta[i] = nil
		end
	end
	for i=1, #MarkerMissionJardinero2 do
		if isElement(MarcadoresRuta[i]) then
			destroyElement(MarcadoresRuta[i])
			MarcadoresRuta[i] = nil
		end
		if isElement(BlipsRuta[i]) then
			destroyElement(BlipsRuta[i])
			BlipsRuta[i] = nil
		end
		if isElement(PedsRuta[i]) then
			destroyElement(PedsRuta[i])
			PedsRuta[i] = nil
		end
	end
end
--
addEventHandler("onClientRender", getRootElement(), function()
	--
	local playerX2, playerY2, playerZ2 = getElementPosition ( localPlayer )
	for k, v in pairs(getJobsJardinero()) do
		local playerX, playerY, playerZ = v[1], v[2], v[3]
		local sx, sy = getScreenFromWorldPosition(playerX, playerY, playerZ + 0.5)
		if sx and sy then
			local cx, cy, cz = getCameraMatrix()
			local distance = getDistanceBetweenPoints3D(playerX2, playerY2, playerZ2, playerX, playerY, playerZ + 0.5)
			if distance < 20 then
				dxDrawBorderedText3 ( v[4], sx, sy, sx, sy , tocolor (0, 139, 255, 255 ),1, "default-bold","center", "center" ) 
			end
		end
	end
end)
function dxDrawBorderedText3( text, x, y, w, h, color, scale, font, alignX, alignY, clip, wordBreak, postGUI )
	dxDrawText(text:gsub('#%x%x%x%x%x%x', ''), (x) + 1, (y) + 1, (w) + 1, (h) + 1, tocolor ( 0, 0, 0, 255 ), scale, font, alignX, alignY, clip, wordBreak, postGUI, true)
	dxDrawText(text, x, y, w, h, color, scale, font, alignX, alignY, clip, wordBreak, postGUI, true)
end