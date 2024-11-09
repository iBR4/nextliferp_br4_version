 local sx_, sy_ = guiGetScreenSize()
local sx, sy = sx_/1360, sy_/768
local ValoresTrabajo = {}
local PosicionMoto = {}
local MarcadoresRuta = {}
local BlipsRuta = {}
local ColRuta = {}
local comienzo = false
local MarkerMissionPizzero = {
{1987.0830078125, -1605.4833984375, 13.529932975769},
{2002.7421875, -1594.1865234375, 13.577275276184},
{2017.08984375, -1630.033203125, 13.546875},
{2015.7099609375, -1641.8369140625, 13.78240776062},
{1975.5439453125, -1634.0439453125, 16.211059570312},
{1972.2255859375, -1633.927734375, 18.568988800049},
{1981.2861328125, -1682.9169921875, 17.053829193115},
{2166.5078125, -1671.8876953125, 15.074395179749},
{2244.271484375, -1638.408203125, 15.90740776062},
{2495.349609375, -1690.65234375, 14.765625},
{2522.66796875, -1679.294921875, 15.496999740601},
{2459.4716796875, -1691.009765625, 13.545081138611},
{2486.4716796875, -1645.537109375, 14.077178955078},
{2498.4716796875, -1643.2998046875, 13.782609939575},
{2413.83203125, -1647.162109375, 14.011916160583},
{2393.29296875, -1647.3251953125, 13.536407470703},
{2068.794921875, -1588.8154296875, 13.491129875183},
{2065.3037109375, -1584.1640625, 13.482041358948},
{1863.90234375, -1597.8681640625, 14.306245803833},
{1909.9365234375, -1597.732421875, 14.306245803833},
{1854.05078125, -1914.896484375, 15.256797790527},
{1872.271484375, -1912.404296875, 15.256797790527},
{1895.4931640625, -2068.626953125, 15.668893814087},
{1762.5166015625, -2102.6708984375, 13.856951713562},
{1734.826171875, -2129.6923828125, 14.021014213562},
{1804.35546875, -2124.2177734375, 13.942373275757},
{1898.470703125, -2029.0185546875, 13.546875},
{2242.572265625, -1882.892578125, 14.234375},
{2241.3408203125, -1882.763671875, 14.234375},
{2261.4521484375, -1906.4833984375, 14.9375},
{2238.1259765625, -1906.517578125, 14.9375},
{2333.388671875, -1943.7333984375, 14.96875},
{2483.4580078125, -1996.267578125, 13.834323883057},
{2523.9677734375, -1998.849609375, 13.78261089325},
{2522.525390625, -2018.8583984375, 14.074416160583},
{2465.369140625, -2020.3994140625, 14.124163627625},
{2146.796875, -1470.3095703125, 26.042566299438},
{1939.125, -1114.486328125, 27.452295303345},
{2232.419921875, -1159.74609375, 25.890625},
{2387.24609375, -1328.3291015625, 25.124164581299},
{2487.2109375, -1417.728515625, 28.837533950806},
{2492.181640625, -1417.7275390625, 28.837532043457},
}
function startMisionPizzero(ruta)
	if localPlayer:getData("Roleplay:trabajo") == "Pizzero" or localPlayer:getData("Roleplay:trabajoVIP") == "Pizzero" then
		if ruta == 1 then
			if ValoresTrabajo[localPlayer][4] >= 1 then
				local i = MarkerMissionPizzero[math.random(1, #MarkerMissionPizzero)]
				local x, y, z = i[1], i[2], i[3]
				MarcadoresRuta[localPlayer] = Marker(x, y, z-1, "cylinder", 1.3, 200, 200, 0, 80)
				ColRuta[localPlayer] = createColCircle( x, y, 7 )
				BlipsRuta[localPlayer] = createBlipAttachedTo(MarcadoresRuta[localPlayer], 0, 2, 200, 200, 0, 255)
				addEventHandler("onClientColShapeHit", ColRuta[localPlayer], onHitPizzeroCol)
				--
				addEventHandler("onClientMarkerHit", MarcadoresRuta[localPlayer], onHitPizzeroMarker)
			else
				--triggerEvent("callCinematic", localPlayer, "¡Ya no tienes suficiente pedidos, ve por mas!", 5000, "No")
				outputChatBox("#ffffff[#FF524DPedidos Ya#ffffff] ¡Ya no tienes suficiente pedidos, ve por mas!",255,100,100,true)
				localPlayer:setData("PizzeroPedidos", false)
				triggerServerEvent("givePizzeroExp", localPlayer)
			end
		end
	end
end
function onHitPizzeroMarker(hitElement)
	if isElement(hitElement) and hitElement:getType() == "player" and hitElement == localPlayer then
		if hitElement:getData("Roleplay:trabajo") == "Pizzero" or hitElement:getData("Roleplay:trabajoVIP") == "Pizzero" and ValoresTrabajo[hitElement][3] == true then
			if hitElement:isInVehicle() then
				--triggerEvent("callCinematic", hitElement, "Baja de la moto y entrega la pizza.", 5000, "No")
				outputChatBox("#ffffff[#FF524DPedidos Ya#ffffff] Baja de la moto y entrega la pizza.",255,100,100,true)
			else
				destroyMarkersPizzero()
				if ValoresTrabajo[localPlayer][4] >= 1 then
					setTimer(startMisionPizzero, 50, 1, 1)
					ValoresTrabajo[localPlayer][4] = ValoresTrabajo[localPlayer][4] - 1
					localPlayer:setFrozen(true)
					fadeCamera(false)
					--
					setTimer(function()
						if isElement(localPlayer) then
							localPlayer:setFrozen(false)
							fadeCamera(true)
							--
							triggerServerEvent( "giveMoneyPizzero", localPlayer )
						end
						--
					end, math.random(1,3)*1000, 1, localPlayer)
				else
					outputChatBox("#ffffff[#FF524DPedidos Ya#ffffff] ¡Ya no tienes suficiente pedidos, ve por mas!",255,100,100,true)
					localPlayer:setData("PizzeroPedidos", false)
				end
			end
		end
	end
end
function onHitPizzeroCol(hitElement)
	if isElement(hitElement) and hitElement:getType() == "player" and hitElement == localPlayer then
		if hitElement:isInVehicle() then
			if hitElement:getData("Roleplay:trabajo") == "Pizzero" or hitElement:getData("Roleplay:trabajoVIP") == "Pizzero" and ValoresTrabajo[hitElement][3] == true then
				outputChatBox("#ffffff[#FF524DPedidos Ya#ffffff] Baja de la moto y entrega la pizza.",255,100,100,true)
			end
		end
	end
end
--
local mark = Marker(2125.8747558594, -1807.7248535156, 13.554527282715-1, "cylinder", 1.3, 100, 100, 100, 0)
Pickup(2125.8747558594, -1807.7248535156, 13.554527282715, 3, 1582, 0)
--
addCommandHandler("obtenerpedidos", function()
	if localPlayer:isInVehicle() then
		local veh = localPlayer:getOccupiedVehicle( )
		if localPlayer:isWithinMarker(mark) then
			if localPlayer:getData("Roleplay:trabajo") == "Pizzero" or localPlayer:getData("Roleplay:trabajoVIP") == "Pizzero" and veh:getData("VehiculoPublico") == "Pizzero" then
				if localPlayer:getData("PizzeroPedidos") == true then
					outputChatBox("#ffffff[#FF524DPedidos Ya#ffffff] ¡Ya tienes los pedidos, ve a entregarlos!",255,100,100,true)
				else
					outputChatBox("#ffffff[#FF524DPedidos Ya#ffffff] Tomaste los pedidos, ve a entregarlos.",255,100,100,true)
					--
					ValoresTrabajo[localPlayer][4] = 5
					--
					localPlayer:setData("PizzeroPedidos", true)
					--
					startMisionPizzero(1)
				end
			end
		end
	end
end)
--
addEvent( "IniciarPizzero", true )
function IniciarPizzero()
	destroyMarkersPizzero()
end
addEventHandler("IniciarPizzero", root, IniciarPizzero)
local timerCount = {}
local TableSegundos = {}
local PosicionAuto = {}
addEventHandler("onClientVehicleEnter", getRootElement(),
    function(thePlayer, seat)
        if thePlayer == getLocalPlayer() then
        	if seat == 0 then
        		if source:getModel() == 448 then
        			if thePlayer:getData("Roleplay:trabajo") == "Pizzero" or thePlayer:getData("Roleplay:trabajoVIP") == "Pizzero" then
        				if ValoresTrabajo[localPlayer] then else
	        				local x, y, z = getElementPosition(thePlayer)
	        				local x2, y2, z2 = getElementRotation(thePlayer)
							ValoresTrabajo[localPlayer] = {nil, 1, true, 0}
							table.insert(PosicionAuto, {x, y, z, x2, y2, z2})
        				end
        				if timerCount[localPlayer] then
        					if isTimer(timerCount[localPlayer]) then
        						killTimer( timerCount[localPlayer] )
        						TableSegundos[localPlayer] = nil
								timerCount[localPlayer] = nil
        					end
        				end
        			end
        		end
        	end
        end
    end
)
addEventHandler("onClientVehicleExit", getRootElement(),
	function(thePlayer, seat)
        if thePlayer == getLocalPlayer() then
        	if seat == 0 then
        		if source:getModel() == 448 then
        			if thePlayer:getData("Roleplay:trabajo") == "Pizzero" or thePlayer:getData("Roleplay:trabajoVIP") == "Pizzero" then
        				if ValoresTrabajo[thePlayer] then
        					if ValoresTrabajo[thePlayer][3] == true then
		        				if not timerCount[localPlayer] then
		        					TableSegundos[localPlayer] = 60
		        					timerCount[localPlayer] = setTimer(function(veh)
		        						if isElement(localPlayer) then
		        							if isElement(veh) then
				        						if TableSegundos[localPlayer] >= 1 then
				        							TableSegundos[localPlayer] = TableSegundos[localPlayer] - 1
				        						else
				        							--
				        							destroyMarkersPizzero()
													if veh and veh ~= nil then
														triggerServerEvent('destroypizz',localPlayer)
													end
				        							ValoresTrabajo[localPlayer] = nil
				        							table.remove(PosicionAuto, 1)
				        							triggerServerEvent("FailedMissionPizzero", localPlayer)
				        							--
							        				if timerCount[localPlayer] then
							        					if isTimer(timerCount[localPlayer]) then
							        						killTimer( timerCount[localPlayer] )
							        						timerCount[localPlayer] = nil
		        											TableSegundos[localPlayer] = nil
							        					end
							        				end
				        						end
				        					end
				        				end
		        					end, 1000, 0, source)
		        				end
		        			end
		        		end
        			end
        		end
        	end
        end
	end
)
function failedMission()
	destroyMarkersPizzero()
	table.remove(PosicionAuto, 1)
	ValoresTrabajo[localPlayer] = nil
	if timerCount[localPlayer] then
		if isTimer(timerCount[localPlayer]) then
			killTimer( timerCount[localPlayer] )
			timerCount[localPlayer] = nil
			TableSegundos[localPlayer] = nil
		end
	end
end
addEvent("failedMission", true)
addEventHandler("failedMission", root, failedMission)
function destroyMarkersPizzero()
	if isElement(MarcadoresRuta[localPlayer]) then
		destroyElement(MarcadoresRuta[localPlayer])
		MarcadoresRuta[localPlayer] = nil
	end
	if isElement(ColRuta[localPlayer]) then
		destroyElement(ColRuta[localPlayer])
		ColRuta[localPlayer] = nil
	end
	if isElement(BlipsRuta[localPlayer]) then
		destroyElement(BlipsRuta[localPlayer])
		BlipsRuta[localPlayer] = nil
	end
end
				
--e
addEventHandler("onClientRender", getRootElement(), function()
	--
	if localPlayer:getData("Roleplay:trabajo") == "Pizzero" or localPlayer:getData("Roleplay:trabajoVIP") == "Pizzero" then
		if TableSegundos[localPlayer] then
			local segundos = TableSegundos[localPlayer] or 0
			local sW = sx_/1280
			dxDrawBorderedText3("#FF0033"..segundos.."#FFFFFF segundos\npara volver a subir a tu moto.", 96*sW, 450*sy, 251*sW, 532*sy, tocolor(255, 255, 255, 255), 1, "default-bold", "center", "center")
		end
	end
	--
	local playerX2, playerY2, playerZ2 = getElementPosition ( localPlayer )
	for k, v in pairs(getJobsPizzero()) do
		local playerX, playerY, playerZ = v[1], v[2], v[3]
		local sx, sy = getScreenFromWorldPosition(playerX, playerY, playerZ + 0.5)
		if sx and sy then
			local cx, cy, cz = getCameraMatrix()
			local distance = getDistanceBetweenPoints3D(playerX2, playerY2, playerZ2, playerX, playerY, playerZ + 0.5)
			if distance < 10 then
				dxDrawBorderedText3 ( v[4], sx, sy, sx, sy , tocolor (0, 139, 255, 255 ),1, "default-bold","center", "center" ) 
				
			end
		end
	end
	local playerX, playerY, playerZ = 2125.8747558594, -1807.7248535156, 13.554527282715
	local sx, sy = getScreenFromWorldPosition(playerX, playerY, playerZ + 0.5)
	if sx and sy then
		local cx, cy, cz = getCameraMatrix()
		local distance = getDistanceBetweenPoints3D(playerX2, playerY2, playerZ2, playerX, playerY, playerZ + 0.5)
		if distance < 10 then
			dxDrawBorderedText3 ( "/obtenerpedidos", sx, sy, sx, sy , tocolor (0, 255, 0, 255 ),1, "default-bold","center", "center" ) 
		end
	end
	local playerX1, playerY1, playerZ1 = 0, 0, 0
	local sx1, sy1 = getScreenFromWorldPosition(playerX1, playerY1, playerZ1 + 0.5)
	if sx1 and sy1 then
		local cx, cy, cz = getCameraMatrix()
		local distance = getDistanceBetweenPoints3D(playerX2, playerY2, playerZ2, playerX1, playerY1, playerZ1 + 0.5)
		if distance < 10 then
			dxDrawBorderedText3 ( "", sx1, sy1, sx1, sy1 , tocolor (255, 255, 255, 255 ),1, "default-bold","center", "center" ) 
		end
	end
	local playerX12, playerY12, playerZ12 = 2864.126953125, -1434.8022460938, 10.971571922302
	local sx2, sy2 = getScreenFromWorldPosition(playerX12, playerY12, playerZ12 + 0.5)
	if sx2 and sy2 then
		local cx, cy, cz = getCameraMatrix()
		local distance = getDistanceBetweenPoints3D(playerX2, playerY2, playerZ2, playerX12, playerY12, playerZ12 + 0.5)
		if distance < 10 then
			dxDrawBorderedText3 ( "#02FF00/trabajar | /trabajar2 | /renunciar \n#FFFFFF Mesero", sx2, sy2, sx2, sy2 , tocolor (255, 255, 255, 255 ),1, "default-bold","center", "center" ) 
		end
	end
end)
function dxDrawBorderedText3( text, x, y, w, h, color, scale, font, alignX, alignY, clip, wordBreak, postGUI )
	dxDrawText(text:gsub('#%x%x%x%x%x%x', ''), (x) + 1, (y) + 1, (w) + 1, (h) + 1, tocolor ( 0, 0, 0, 255 ), scale, font, alignX, alignY, clip, wordBreak, postGUI, true)
	--dxDrawText(text:gsub('#%x%x%x%x%x%x', ''), (x) - 1, (y)- 1, (w)- 1, (h) -1, tocolor ( 0, 0, 0, 255 ), scale, font, alignX, alignY, clip, wordBreak, postGUI, true)
	dxDrawText(text, x, y, w, h, color, scale, font, alignX, alignY, clip, wordBreak, postGUI, true)
end