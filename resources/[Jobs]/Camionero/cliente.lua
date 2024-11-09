local sx_, sy_ = guiGetScreenSize()
local sx, sy = sx_/1360, sy_/768
local ValoresTrabajo = {}
local MarcadoresRuta = {}
local BlipsRuta = {}
local tableN = {}
local TimerK = {}
local rutasin = {}
local posrut = {}
local marcador = {}
local blip = {}
local dinero = {}
camionwin = guiCreateWindow(0.33, 0.37, 0.33, 0.25, "Camionero", true)
guiWindowSetSizable(camionwin, false)
rutas = guiCreateGridList(0.02, 0.08, 0.95, 0.75, true, camionwin)
guiGridListAddColumn(rutas, "Nivel", 0.1)
guiGridListAddColumn(rutas, "Trabajo", 0.5)
guiGridListAddColumn(rutas, "Ganancia", 0.2)
guiGridListAddColumn(rutas, "N°", 0.1)
trabajar = guiCreateButton(0.60, 0.86, 0.34, 0.11, "Aceptar trabajo", true, camionwin)
guiSetFont(trabajar, "default-bold-small")
guiSetProperty(trabajar, "NormalTextColour", "FFFEFEFE")
cerrar = guiCreateButton(0.05, 0.86, 0.34, 0.11, "Cerrar panel", true, camionwin)
guiSetFont(cerrar, "default-bold-small")
guiSetProperty(cerrar, "NormalTextColour", "FFFD0000")
guiSetVisible(camionwin,false)
addEventHandler("onClientGUIClick",resourceRoot,function()
	local money = guiGridListGetItemData( rutas, guiGridListGetSelectedItem ( rutas ), 3 )
	local name = guiGridListGetItemText( rutas, guiGridListGetSelectedItem ( rutas ), 2 )
    local nivel = guiGridListGetItemText ( rutas, guiGridListGetSelectedItem ( rutas ), 1 )
    local key = guiGridListGetItemText ( rutas, guiGridListGetSelectedItem ( rutas ), 4 )
	if source == cerrar then
		guiSetVisible(camionwin,false)
		showCursor(false)
	elseif source == trabajar then
		guiSetVisible(camionwin,false)
		showCursor(false)
		outputChatBox("[CAMIONEROS] #FFFFFFSubete al camion.",255,50,50,true)
		if name ~= "" then
			if (getElementData(localPlayer,"Camionero:Nivel") or 1) >= tonumber(nivel) then
				triggerServerEvent("respawnveh",localPlayer)
				rutasin[localPlayer] = key
				dinero[localPlayer] = money
			else
				outputChatBox("[CAMIONEROS] #FFFFFFNo tienes suficiente nivel",255,50,50,true)
			end
		else
			outputChatBox("[CAMIONEROS] #FFFFFFSelecciona una opción primero",255,50,50,true)
		end
	end
end)
local rutas2 = {
{1,"Ganton - Ropa",200,11},
{1,"Unity Station | Alimentos",120,12},
{1,"Liverpool RD | Alimentos",100,13},
{2,"Rodeo RD | Alimentos",420,21},
{2,"Interstate 27 | Bebidas",520,22},
{3,"Interstate 87 | Herramientas",700,31},
{3,"Fabrica | Electronicos",800,32},
{3,"Bay S.t | Alimentos",1000,33},
{4,"Interstate 7 | Gasolina",1200,41},
{4,"Interstate 7 | Petroleo",1000,42},
{4,"S.t San fierro | Alimentos",2300,43},
{5,"Shore S.t | Alimentos",2700,51},
{5,"Onion S.t | Herramientas",3000,52},
{5,"Norris S.t | Desconocido",3400,53},
}
addEvent("panelcamio",true)
addEventHandler("panelcamio",root,function()
	guiSetVisible(camionwin,true)
	showCursor(true)
	guiGridListClear( rutas )
	for i, v in ipairs(rutas2) do
		local row = guiGridListAddRow(rutas)
       	guiGridListSetItemText(rutas, row, 1, v[1], false, true)
        guiGridListSetItemText(rutas, row, 2, v[2], false, true)
        guiGridListSetItemText(rutas, row, 3, "   $"..v[3], false, true)
        guiGridListSetItemText(rutas, row, 4, "  "..v[4], false, true)
        --
        guiGridListSetItemData(rutas, row, 3, v[3] )
	end
end)
function startRutaCamionero(ruta)
	if localPlayer:getData("Roleplay:trabajo") == "Camionero" or localPlayer:getData("Roleplay:trabajoVIP") == "Camionero" then
		local rut = queruta(ruta)
		ValoresTrabajo[localPlayer][1] = tonumber(#rut)
		ValoresTrabajo[localPlayer][4] = tonumber(ruta)
		for i=1, #rut do
			if i >= ValoresTrabajo[localPlayer][2] and i <= ValoresTrabajo[localPlayer][2] then
				local x, y, z = rut[i][1], rut[i][2], rut[i][3]
				local x2, y2, z2 = rut[i][4], rut[i][5], rut[i][6]
				MarcadoresRuta[i] = Marker(x, y, z - 1, "checkpoint", 3, 255, 255, 0, 100)
				BlipsRuta[i] = createBlipAttachedTo(MarcadoresRuta[i], 0, 2, 50, 150, 50, 255)
				if i <= 1 then
					setMarkerTarget(MarcadoresRuta[i], x2, y2, z2)
					setMarkerIcon ( MarcadoresRuta[i], "checkpoint" )
				else
					setMarkerIcon ( MarcadoresRuta[i], "finish" )
				end
				addEventHandler("onClientMarkerHit", MarcadoresRuta[i], onCamioneroHitMarker)
			end
		end
	end
end
function queruta(ruta)
	if tonumber(ruta) == 11 then
		return MisionMarkerCamionero11
	elseif tonumber(ruta) == 12 then
		return MisionMarkerCamionero12
	elseif tonumber(ruta) == 13 then
		return MisionMarkerCamionero13
	elseif tonumber(ruta) == 21 then
		return MisionMarkerCamionero21
	elseif tonumber(ruta) == 22 then
		return MisionMarkerCamionero22
	elseif tonumber(ruta) == 31 then
		return MisionMarkerCamionero31
	elseif tonumber(ruta) == 32 then
		return MisionMarkerCamionero32
	elseif tonumber(ruta) == 33 then
		return MisionMarkerCamionero33
	elseif tonumber(ruta) == 41 then
		return MisionMarkerCamionero41
	elseif tonumber(ruta) == 42 then
		return MisionMarkerCamionero42
	elseif tonumber(ruta) == 43 then
		return MisionMarkerCamionero43
	elseif tonumber(ruta) == 51 then
		return MisionMarkerCamionero51
	elseif tonumber(ruta) == 52 then
		return MisionMarkerCamionero52
	elseif tonumber(ruta) == 53 then
		return MisionMarkerCamionero53		
	end
end
function onCamioneroHitMarker( hitElement )
	if isElement(hitElement) and hitElement:getType() == "player" and hitElement == localPlayer then
		if hitElement:isInVehicle() then
			if hitElement:getData("Roleplay:trabajo") == "Camionero" or hitElement:getData("Roleplay:trabajoVIP") == "Camionero" and ValoresTrabajo[hitElement][3] == true then
				local veh = hitElement:getOccupiedVehicle()
				if veh:getData("VehiculoPublico") == "Camionero" then
					if ValoresTrabajo[hitElement][1] == ValoresTrabajo[hitElement][2] then
						destroyMarkersCamionero(ValoresTrabajo[hitElement][4])
						outputChatBox("[CAMIONEROS] #FFFFFFSi deseas trabajar vuelve a cargar el camion.",255,50,50,true)
						triggerServerEvent( "giveMoneyCamionero", hitElement , dinero[localPlayer])
						triggerServerEvent( "giveCamioneroExp", hitElement )
						--
						ValoresTrabajo[hitElement][2] = ValoresTrabajo[hitElement][2] - 1
						TimerK[hitElement] = nil;
						tableN[hitElement] = nil;
					else
						ValoresTrabajo[hitElement][2] = ValoresTrabajo[hitElement][2] + 1
						setTimer(startRutaCamionero, 50, 1,ValoresTrabajo[hitElement][4])
						destroyMarkerRut(hitElement, ValoresTrabajo[hitElement][4])
					end
				end
			end
		end
	end
end
function destroyMarkerRut(player, ruta)
	local rut = queruta(ruta)
	for i=1, #rut do
		if i <= ValoresTrabajo[player][2] then
			if isElement(MarcadoresRuta[i]) then
				destroyElement(MarcadoresRuta[i])
				MarcadoresRuta[i] = nil
			end
			if isElement(BlipsRuta[i]) then
				destroyElement(BlipsRuta[i])
				BlipsRuta[i] = nil
			end
		end
	end
end
function startrecarga(localPlayer)
	if isElement(localPlayer) and localPlayer:getType() == "player" and localPlayer == getLocalPlayer() then
		if localPlayer == getLocalPlayer() then
			local veh = getPedOccupiedVehicle ( localPlayer )
			if localPlayer:getData("Roleplay:trabajo") == "Camionero" or localPlayer:getData("Roleplay:trabajoVIP") == "Camionero" then 
				if veh:getData("VehiculoPublico") == "Camionero" then
					setElementRotation(veh,0, 0, 0)
					setElementPosition(veh,2197.9138183594, -2657.0283203125, 13.2+0.1)
					for i,v in pairs(getElementsByType("vehicle"))do setElementCollidableWith(v,veh,false)end
					setElementFrozen(veh,true)
					setElementFrozen(getLocalPlayer(),true)
					outputChatBox("[CAMIONEROS] #FFFFFFEspera a que el camion se cargue de mercancia.",255,50,50,true)
					if isElement(blip[localPlayer]) then
						destroyElement(blip[localPlayer])
						blip[localPlayer] = nil
					end
					if isElement(marcador[localPlayer]) then
						destroyElement(marcador[localPlayer])
						marcador[localPlayer] = nil
					end
					setTimer(function()
						local rut = rutasin[localPlayer]
						startRutaCamionero(rut)
						triggerServerEvent("trans",localPlayer,100)
						setElementFrozen(veh,false)
						setElementFrozen(getLocalPlayer(),false)
						outputChatBox("[CAMIONEROS] #FFFFFFTu camion recuperara las colisiones en #FFF78F15 segundos#FFFFFF, procura salir.",255,50,50,true)
						fixVehicle(veh)
						setTimer(function()
							for i,v in pairs(getElementsByType("vehicle"))do setElementCollidableWith(v,veh,true)end	
							triggerServerEvent("trans",localPlayer,255)
						end,10000,1)
					end,10000,1)
				end
			end
		end
	end
end
local TableSegundos = {}
function destroyMarkersCamionero(ruta)
	local rut = queruta(ruta)
	for i=1, #rut do
		if i <= ValoresTrabajo[localPlayer][2] then
			if isElement(MarcadoresRuta[i]) then
				destroyElement(MarcadoresRuta[i])
				MarcadoresRuta[i] = nil
			end
			if isElement(BlipsRuta[i]) then
				destroyElement(BlipsRuta[i])
				BlipsRuta[i] = nil
			end
		end
	end
	if TableSegundos[localPlayer] == nil then
		marcador[localPlayer] = Marker(2197.9138183594, -2657.0283203125, 13.2, "cylinder", 8, 255, 0, 0, 100)
		blip[localPlayer] = createBlipAttachedTo(marcador[localPlayer], 0, 2, 50, 150, 50, 255)
		addEventHandler("onClientMarkerHit", marcador[localPlayer], startrecarga)
		outputChatBox("[CAMIONEROS] #FFFFFFDirigete al #FF0000marcador #FFFFFFpara cargar el camion.",255,50,50,true)
	end
end
local timerCount = {}
local PosicionAuto = {}
addEventHandler("onClientVehicleEnter",getRootElement(),function(thePlayer, seat)
	if thePlayer == getLocalPlayer() then
		if seat == 0 then
			if source:getData("VehiculoPublico") == "Camionero" then
				if thePlayer:getData("Roleplay:trabajo") == "Camionero" or thePlayer:getData("Roleplay:trabajoVIP") == "Camionero" then
    				if timerCount[localPlayer] then
    					if isTimer(timerCount[localPlayer]) then
    						killTimer( timerCount[localPlayer] )
    						TableSegundos[localPlayer] = nil
							timerCount[localPlayer] = nil
    					end
    				end
					if ValoresTrabajo[thePlayer] then else
						ValoresTrabajo[thePlayer] = {nil, 1, true, rut}
						marcador[thePlayer] = Marker(2197.9138183594, -2657.0283203125, 13.2, "cylinder", 8, 255, 0, 0, 100)
						blip[thePlayer] = createBlipAttachedTo(marcador[thePlayer], 0, 2, 50, 150, 50, 255)
						addEventHandler("onClientMarkerHit", marcador[thePlayer], startrecarga)
						outputChatBox("[CAMIONEROS] #FFFFFFDirigete al #FF0000marcador #FFFFFFpara cargar el camion.",255,50,50,true)
					end
				end
			end
		end
	end
end)
addEventHandler("onClientVehicleExit", getRootElement(),
	function(thePlayer, seat)
        if thePlayer == getLocalPlayer() then
        	if seat == 0 then
        		if source:getData("VehiculoPublico") == "Camionero" then
        			if thePlayer:getData("Roleplay:trabajo") == "Camionero" or thePlayer:getData("Roleplay:trabajoVIP") == "Camionero" then
        				if ValoresTrabajo[thePlayer] then
        					if ValoresTrabajo[thePlayer][3] == true then
		        				if not timerCount[localPlayer] then
		        					TableSegundos[localPlayer] = 30
		        					timerCount[localPlayer] = setTimer(function()
		        						if isElement(localPlayer) then
			        						if TableSegundos[localPlayer] >= 1 then
			        							TableSegundos[localPlayer] = TableSegundos[localPlayer] - 1
			        						else
			        							--
			        							destroyMarkerRut(thePlayer,ValoresTrabajo[thePlayer][4])
			        							destroyMarkersCamionero(ValoresTrabajo[thePlayer][4])
			        							ValoresTrabajo[localPlayer] = nil
												if isElement(blip[localPlayer]) then
													destroyElement(blip[localPlayer])
													blip[localPlayer] = nil
												end
												if isElement(marcador[localPlayer]) then
													destroyElement(marcador[localPlayer])
													marcador[localPlayer] = nil
												end
												triggerServerEvent("destroycamm",localPlayer)
			        							table.remove(PosicionAuto, 1)
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
addEvent("failedMissionCam",true)
addEventHandler("failedMissionCam",getRootElement(),function()
	if localPlayer == getLocalPlayer() then
		if isElement(blip[localPlayer]) then
			destroyElement(blip[localPlayer])
			blip[localPlayer] = nil
		end
		if isElement(marcador[localPlayer]) then
			destroyElement(marcador[localPlayer])
			marcador[localPlayer] = nil
		end
		triggerServerEvent("destroycamm",localPlayer)
		table.remove(PosicionAuto, 1)
		if ValoresTrabajo[thePlayer] then
			destroyMarkerRut(localPlayer,ValoresTrabajo[localPlayer][4])
			destroyMarkersCamionero(ValoresTrabajo[localPlayer][4])
			ValoresTrabajo[localPlayer] = nil
		end
	end
end)
addEventHandler("onClientRender", getRootElement(), function()
		local playerX2, playerY2, playerZ2 = getElementPosition ( localPlayer )
	if localPlayer:getData("Roleplay:trabajo") == "Camionero" or localPlayer:getData("Roleplay:trabajoVIP") == "Camionero" then
		if TableSegundos[localPlayer] then
			local segundos = TableSegundos[localPlayer] or 0
			local sW = sx_/1280
			dxDrawBorderedText3("#FF0033"..segundos.."#FFFFFF segundos\npara volver a subir a tu camion.", 96*sW, 450*sy, 251*sW, 532*sy, tocolor(255, 255, 255, 255), 1, "default-bold", "center", "center")
		end
	end
	local playerX3, playerY3, playerZ3 = 2216.2065429688, -2661.6057128906, 13.556979179382
	local sx, sy = getScreenFromWorldPosition(playerX3, playerY3, playerZ3 + 0.5)
	if sx and sy then
		local cx, cy, cz = getCameraMatrix()
		local distance = getDistanceBetweenPoints3D(playerX2, playerY2, playerZ2, playerX3, playerY3, playerZ3 + 0.5)
		if distance < 20 then
			dxDrawBorderedText3 ( "#02FF00/trabajar | /trabajar2 | /renunciar\n#FFFFFF* Camionero", sx, sy, sx, sy , tocolor (0, 139, 255, 255 ),1, "default-bold","center", "center" ) 
		end
	end
	local playerX, playerY, playerZ = 2220.5122070312, -2666.2299804688, 13.546875
	local sx, sy = getScreenFromWorldPosition(playerX, playerY, playerZ + 0.5)
	if sx and sy then
		if localPlayer:getData("Roleplay:trabajo") == "Camionero" or localPlayer:getData("Roleplay:trabajoVIP") == "Camionero" then
		local cx, cy, cz = getCameraMatrix()
		local distance = getDistanceBetweenPoints3D(playerX2, playerY2, playerZ2, playerX, playerY, playerZ + 0.5)
		if distance < 20 then
			dxDrawBorderedText3 ( "Presiona #FF8B00F #FFFFFFPara acceder al menu", sx, sy, sx, sy , tocolor (255, 255, 255, 255 ),1, "default-bold","center", "center" ) 
		end
	end
	end
end)
function dxDrawBorderedText3( text, x, y, w, h, color, scale, font, alignX, alignY, clip, wordBreak, postGUI )
	dxDrawText(text:gsub('#%x%x%x%x%x%x', ''), (x) + 1, (y) + 1, (w) + 1, (h) + 1, tocolor ( 0, 0, 0, 255 ), scale, font, alignX, alignY, clip, wordBreak, postGUI, true)
	dxDrawText(text, x, y, w, h, color, scale, font, alignX, alignY, clip, wordBreak, postGUI, true)
end