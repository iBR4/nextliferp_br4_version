loadstring(exports.MySQL:getMyCode())()
import('*'):init('MySQL')
local MarkersCarpintero = {}
addEventHandler("onResourceStart", resourceRoot, function()
	for i, v in ipairs(getJobsCarpintero()) do
		--
		Blip( 2407.1376953125, -1311.2373046875, 25.197914123535, 56, 2, 255, 0, 0, 255, 0, 200, getRootElement() )
		--
		Pickup(v[1], v[2], v[3], 3, 1210, 0)
		MarkersCarpintero[i] = Marker(v[1], v[2], v[3]-1, "cylinder", 1.5, 100, 100, 100, 0)
		MarkersCarpintero[i]:setInterior(v.int)
		MarkersCarpintero[i]:setDimension(v.dim)
		MarkersCarpintero[i]:setData("MarkerJob", "Carpintero")
	end
end)
local Pickup = Pickup( 2405.0534667969, -1315.2135009766, 25.267454147339, 3, 1463, 0)
setElementInterior(Pickup, 0)
setElementDimension(Pickup, 0)
local Marcador = Marker( 2405.0534667969, -1315.2135009766, 25.267454147339, "cylinder", 1.7, 100, 100, 100, 0)
setElementInterior(Marcador, 0)
setElementDimension(Marcador, 0)
local Construmark1 = Marker( 2401.7827148438, -1306.9012451172, 25.412853240967, "cylinder", 1.7, 100, 100, 100, 0)
setElementInterior(Construmark1, 0)
setElementDimension(Construmark1, 0)
local Construmark2= Marker(2397.3557128906, -1306.7366943359, 25.567361831665, "cylinder", 1.7, 100, 100, 100, 0)
setElementInterior(Construmark2, 0)
setElementDimension(Construmark2, 0)
local Construmark3= Marker(2393.4448242188, -1306.7368164062, 25.567028045654, "cylinder", 1.7, 100, 100, 100, 0)
setElementInterior(Construmark3,0)
setElementDimension(Construmark3,0)
local Construmark4= Marker(2388.0354003906, -1305.9731445312, 24.992118835449, "cylinder", 1.7, 100, 100, 100, 0)
setElementInterior(Construmark4,0)
setElementDimension(Construmark4,0)
local Construmark5= Marker(2384.8193359375, -1305.7896728516, 24.582855224609, "cylinder", 1.7, 100, 100, 100, 0)
setElementInterior(Construmark5,0)
setElementDimension(Construmark5,0)
local Construmark6= Marker(2388.0366210938, -1314.787109375, 24.966638565063, "cylinder", 1.7, 100, 100, 100, 0)
setElementInterior(Construmark6,0)
setElementDimension(Construmark6,0)
local Construmark7= Marker(2384.71484375, -1314.9370117188, 24.591194152832, "cylinder", 1.7, 100, 100, 100, 0)
setElementInterior(Construmark7,0)
setElementDimension(Construmark7,0)
local Construmark8= Marker(2382.1760253906, -1314.7780761719, 24.200387954712, "cylinder", 1.7, 100, 100, 100, 0)
setElementInterior(Construmark8,0)
setElementDimension(Construmark8,0)
local vender = Marker(2396.2631835938, -1315.2139892578, 25.491882324219, "cylinder", 1.7, 100, 100, 100, 0)
setElementInterior(vender, 0)
setElementDimension(vender, 0)
local stateWindow = false
local boat
local gruz
local stateJob = false
local markerGruz
local markerSkad
local text = "Comezar"
local zp = 0
local gruzHand = false
local objeto = {}
--recojer
addEventHandler("onResourceStart", resourceRoot, function()
	for i, v in ipairs(Element.getAllByType("player")) do
		bindKey(v, "mouse1", "down", function(player)
		if not player:isInVehicle() then
			if player:isWithinMarker(Marcador) then
				print(1)
				if (getElementData(player, "Roleplay:trabajoVIP") == "Carpintero") or (getElementData(player, "Roleplay:trabajo") == "Carpintero") then
					print(2)
					local ob = getElementData(player,"objeto") or 0
					if (ob >= 1) then
					print(3)
					player:outputChat("Ya tienes madera",255,0,0,true)
					else
					print(4)
					--setPedAnimation( player, "CARRY", "liftup", 4.1, true, true, true )
					setPedAnimation( player, "CARRY", "crry_prtial", 4.1, true, true, true )
					 setTimer( function()
					print(5)
					setPedAnimation( player, nil )
					setPedAnimation( player, "CARRY", "crry_prtial", 4.1, true, true, true )
					local x,y,z = getElementPosition(player)
					gruz = createObject ( 1463, x, y, z )
					local a = getPlayerName(player)
					player:outputChat("> recoje unos troncos de madera con sus manos",178, 140, 214,true)
					setTimer(function(p)
					if isElement(p) then
					print(6)
					p:setData("TextInfo", {"",178, 140, 214})
					end
					end, 4000, 1, player)
					attachElements ( gruz, player, 0,0.4,0.5)
					if ( gruz ) then -- if it was created
					print(7)
					setObjectScale ( gruz, 0.5)
       					setElementCollisionsEnabled (gruz, false)
					end
					  setPedAnimation(player, nil )
					--toggleControl( "jump", true )
					--toggleControl(player, "fire", true )
					--toggleControl( "sprint", true )
					end,700,1)
					setElementData(player,"objeto",1)
					end
					 else
					print(8)
					player:outputChat("¡Tu no trabajas aquí!", 150, 50, 50, true)
					
					end
				end
			end
		end)
	end
end
)
local sillas = {
{1720},
{1805},
{1811},
{2096},
{2079},
{2120},
{2124},
{1739},
}
--construir
addEventHandler("onResourceStart", resourceRoot, function()
	for i, v in ipairs(Element.getAllByType("player")) do
		bindKey(v, "mouse1", "down", function(player)
		if not player:isInVehicle() then
			if player:isWithinMarker(Construmark1) then
				if (getElementData(player, "Roleplay:trabajoVIP") == "Carpintero") or (getElementData(player, "Roleplay:trabajo") == "Carpintero") then
					local ob = getElementData(player,"objeto") or 0
					if (ob >= 1) then  
						destroyElement(gruz)
						setElementFrozen( player, true)
						player:outputChat("> agarra el martillo y comienza a fabricar un mueble",178, 140, 214,true)	 
						setTimer( function(player)
            					setPedAnimation(player, "BASEBALL", "Bat_M",-1, true, false, false, false)
						end, 100, 1,player )
						setTimer( function(player)
		     			 	setElementFrozen( player, false )
						setPedAnimation (player)
						local x,y,z = getElementPosition(player)
						gruz1 = createObject (1720, x, y, z )
						local a = getPlayerName(player)
					setTimer(function(p)
					if isElement(p) then
					p:setData("TextInfo", {"",178, 140, 214})
					end
					end, 4000, 1, player)
						attachElements ( gruz1, player, 0,0.4,0.05)
						setPedAnimation( player, "CARRY", "crry_prtial", 4.1, true, true, true )
						if ( gruz1 ) then -- if it was created
						setObjectScale ( gruz1, 1)
       						setElementCollisionsEnabled (gruz1, false)
						end
						end, 40000, 1,player )
						setElementData(player,"silla",1)
						 removeElementData(player,"objeto")
					else
					player:outputChat("No tienes madera para fabricar", 150, 50, 50, true)
					end
					 else
					player:outputChat("¡Tu no trabajas aquí!", 150, 50, 50, true)
					end
				end
			end
		end)
	end
end
)
--con2
addEventHandler("onResourceStart", resourceRoot, function()
	for i, v in ipairs(Element.getAllByType("player")) do
		bindKey(v, "mouse1", "down", function(player)
		if not player:isInVehicle() then
			if player:isWithinMarker(Construmark2) then
				if (getElementData(player, "Roleplay:trabajoVIP") == "Carpintero") or (getElementData(player, "Roleplay:trabajo") == "Carpintero") then
					local ob = getElementData(player,"objeto") or 0
					if (ob >= 1) then  
						destroyElement(gruz)
						setElementFrozen( player, true)
						player:outputChat("> agarra el martillo y comienza a fabricar un mueble",178, 140, 214,true)	 
						setTimer( function(player)
            					setPedAnimation(player, "BASEBALL", "Bat_M",-1, true, false, false, false)
						end, 100, 1,player )
						setTimer( function(player)
		     			 	setElementFrozen( player, false )
						setPedAnimation (player)
						local x,y,z = getElementPosition(player)
						gruz1 = createObject (1805, x, y, z )
							local a = getPlayerName(player)
					setTimer(function(p)
					if isElement(p) then
					p:setData("TextInfo", {"",255, 0, 216})
					end
					end, 4000, 1, player)
						attachElements ( gruz1, player, 0,0.4,0.2)
						setPedAnimation( player, "CARRY", "crry_prtial", 4.1, true, true, true )
						if ( gruz1 ) then -- if it was created
						setObjectScale ( gruz1, 1)
       						setElementCollisionsEnabled (gruz1, false)
						end
						end, 40000, 1,player )
						setElementData(player,"silla",1)
						 removeElementData(player,"objeto")
					else
					player:outputChat("No tienes madera para fabricar", 150, 50, 50, true)
					end
					 else
					player:outputChat("¡Tu no trabajas aquí!", 150, 50, 50, true)
					end
				end
			end
		end)
	end
end
)
--cons3
addEventHandler("onResourceStart", resourceRoot, function()
	for i, v in ipairs(Element.getAllByType("player")) do
		bindKey(v, "mouse1", "down", function(player)
		if not player:isInVehicle() then
			if player:isWithinMarker(Construmark3) then
				if (getElementData(player, "Roleplay:trabajoVIP") == "Carpintero") or (getElementData(player, "Roleplay:trabajo") == "Carpintero") then
					local ob = getElementData(player,"objeto") or 0
					if (ob >= 1) then  
						destroyElement(gruz)
						setElementFrozen( player, true)
						player:outputChat("> agarra el martillo y comienza a fabricar un mueble",178, 140, 214,true)	 
						setTimer( function(player)
            					setPedAnimation(player, "BASEBALL", "Bat_M",-1, true, false, false, false)
						end, 100, 1,player )
						setTimer( function(player)
		     			 	setElementFrozen( player, false )
						setPedAnimation (player)
						local x,y,z = getElementPosition(player)
						gruz1 = createObject (1811, x, y, z )
							local a = getPlayerName(player)
					setTimer(function(p)
					if isElement(p) then
					p:setData("TextInfo", {"",255, 0, 216})
					end
					end, 4000, 1, player)
						attachElements ( gruz1, player, 0,0.4,0.05)
						setPedAnimation( player, "CARRY", "crry_prtial", 4.1, true, true, true )
						if ( gruz1 ) then -- if it was created
						setObjectScale ( gruz1, 1)
       						setElementCollisionsEnabled (gruz1, false)
						end
						end, 0000, 1,player )
						setElementData(player,"silla",1)
						 removeElementData(player,"objeto")
					else
					player:outputChat("No tienes madera para fabricar", 150, 50, 50, true)
					end
					 else
					player:outputChat("¡Tu no trabajas aquí!", 150, 50, 50, true)
					end
				end
			end
		end)
	end
end
)
--cons4
addEventHandler("onResourceStart", resourceRoot, function()
	for i, v in ipairs(Element.getAllByType("player")) do
		bindKey(v, "mouse1", "down", function(player)
		if not player:isInVehicle() then
			if player:isWithinMarker(Construmark4) then
				if (getElementData(player, "Roleplay:trabajoVIP") == "Carpintero") or (getElementData(player, "Roleplay:trabajo") == "Carpintero") then
					local ob = getElementData(player,"objeto") or 0
					if (ob >= 1) then  
						destroyElement(gruz)
						setElementFrozen( player, true)
						player:outputChat("> agarra el martillo y comienza a fabricar un mueble",178, 140, 214,true)	 
						setTimer( function(player)
            					setPedAnimation(player, "BASEBALL", "Bat_M",-1, true, false, false, false)
						end, 100, 1,player )
						setTimer( function(player)
		     			 	setElementFrozen( player, false )
						setPedAnimation (player)
						local x,y,z = getElementPosition(player)
						gruz1 = createObject ( 1720, x, y, z )
							local a = getPlayerName(player)
					setTimer(function(p)
					if isElement(p) then
					p:setData("TextInfo", {"",255, 0, 216})
					end
					end, 4000, 1, player)
						attachElements ( gruz1, player, 0,0.4,0.05)
						setPedAnimation( player, "CARRY", "crry_prtial", 4.1, true, true, true )
						if ( gruz1 ) then -- if it was created
						setObjectScale ( gruz1, 1)
       						setElementCollisionsEnabled (gruz1, false)
						end
						end, 40000, 1,player )
						setElementData(player,"silla",1)
						 removeElementData(player,"objeto")
					else
					player:outputChat("No tienes madera para fabricar", 150, 50, 50, true)
					end
					 else
					player:outputChat("¡Tu no trabajas aquí!", 150, 50, 50, true)
					end
				end
			end
		end)
	end
end
)
--cons5
addEventHandler("onResourceStart", resourceRoot, function()
	for i, v in ipairs(Element.getAllByType("player")) do
		bindKey(v, "mouse1", "down", function(player)
		if not player:isInVehicle() then
			if player:isWithinMarker(Construmark5) then
				if (getElementData(player, "Roleplay:trabajoVIP") == "Carpintero") or (getElementData(player, "Roleplay:trabajo") == "Carpintero") then
					local ob = getElementData(player,"objeto") or 0
					if (ob >= 1) then  
						destroyElement(gruz)
						setElementFrozen( player, true)
						player:outputChat("> agarra el martillo y comienza a fabricar un mueble",178, 140, 214,true)	 
						setTimer( function(player)
            					setPedAnimation(player, "BASEBALL", "Bat_M",-1, true, false, false, false)
						end, 100, 1,player )
						setTimer( function(player)
		     			 	setElementFrozen( player, false )
						setPedAnimation (player)
						local x,y,z = getElementPosition(player)
						 gruz1 = createObject ( 2096, x, y, z )
							local a = getPlayerName(player)
					setTimer(function(p)
					if isElement(p) then
					p:setData("TextInfo", {"",255, 0, 216})
					end
					end, 4000, 1, player)
						attachElements ( gruz1, player, 0,0.4,0.05)
						setPedAnimation( player, "CARRY", "crry_prtial", 4.1, true, true, true )
						if ( gruz1 ) then -- if it was created
						setObjectScale ( gruz1, 1)
       						setElementCollisionsEnabled (gruz1, false)
						end
						end, 40000, 1,player )
						setElementData(player,"silla",1)
						 removeElementData(player,"objeto")
					else
					player:outputChat("No tienes madera para fabricar", 150, 50, 50, true)
					end
					 else
					player:outputChat("¡Tu no trabajas aquí!", 150, 50, 50, true)
					end
				end
			end
		end)
	end
end
)
--cons6
addEventHandler("onResourceStart", resourceRoot, function()
	for i, v in ipairs(Element.getAllByType("player")) do
		bindKey(v, "mouse1", "down", function(player)
		if not player:isInVehicle() then
			if player:isWithinMarker(Construmark6) then
				if (getElementData(player, "Roleplay:trabajoVIP") == "Carpintero") or (getElementData(player, "Roleplay:trabajo") == "Carpintero") then
					local ob = getElementData(player,"objeto") or 0
					if (ob >= 1) then  
						destroyElement(gruz)
						setElementFrozen( player, true)
						player:outputChat("> agarra el martillo y comienza a fabricar un mueble",178, 140, 214,true)	 
						setTimer( function(player)
            					setPedAnimation(player, "BASEBALL", "Bat_M",-1, true, false, false, false)
						end, 100, 1,player )
						setTimer( function(player)
		     			 	setElementFrozen( player, false )
						setPedAnimation (player)
						local x,y,z = getElementPosition(player)
						gruz1 = createObject ( 2079, x, y, z )
							local a = getPlayerName(player)
					setTimer(function(p)
					if isElement(p) then
					p:setData("TextInfo", {"",255, 0, 216})
					end
					end, 4000, 1, player)
						attachElements ( gruz1, player, 0,0.4,0.05)
						setPedAnimation( player, "CARRY", "crry_prtial", 4.1, true, true, true )
						if ( gruz1 ) then -- if it was created
						setObjectScale ( gruz1, 1)
       						setElementCollisionsEnabled (gruz1, false)
						end
						end, 40000, 1,player )
						setElementData(player,"silla",1)
						 removeElementData(player,"objeto")
					else
					player:outputChat("No tienes madera para fabricar", 150, 50, 50, true)
					end
					 else
					player:outputChat("¡Tu no trabajas aquí!", 150, 50, 50, true)
					end
				end
			end
		end)
	end
end
)
--cons7
addEventHandler("onResourceStart", resourceRoot, function()
	for i, v in ipairs(Element.getAllByType("player")) do
		bindKey(v, "mouse1", "down", function(player)
		if not player:isInVehicle() then
			if player:isWithinMarker(Construmark7) then
				if (getElementData(player, "Roleplay:trabajoVIP") == "Carpintero") or (getElementData(player, "Roleplay:trabajo") == "Carpintero") then
					local ob = getElementData(player,"objeto") or 0
					if (ob >= 1) then  
						destroyElement(gruz)
						setElementFrozen( player, true)
						player:outputChat("> agarra el martillo y comienza a fabricar un mueble",178, 140, 214,true)	 
						setTimer( function(player)
            					setPedAnimation(player, "BASEBALL", "Bat_M",-1, true, false, false, false)
						end, 100, 1,player )
						setTimer( function(player)
		     			 	setElementFrozen( player, false )
						setPedAnimation (player)
						local x,y,z = getElementPosition(player)
						gruz1 = createObject ( 2120, x, y, z )
							local a = getPlayerName(player)
					setTimer(function(p)
					if isElement(p) then
					p:setData("TextInfo", {"",255, 0, 216})
					end
					end, 4000, 1, player)
						attachElements ( gruz1, player, 0,0.4,0.05)
						setPedAnimation( player, "CARRY", "crry_prtial", 4.1, true, true, true )
						if ( gruz1 ) then -- if it was created
						setObjectScale ( gruz1, 1)
       						setElementCollisionsEnabled (gruz1, false)
						end
						end, 40000, 1,player )
						setElementData(player,"silla",1)
						 removeElementData(player,"objeto")
					else
					player:outputChat("No tienes madera para fabricar", 150, 50, 50, true)
					end
					 else
					player:outputChat("¡Tu no trabajas aquí!", 150, 50, 50, true)
					end
				end
			end
		end)
	end
end
)
--cons8
addEventHandler("onResourceStart", resourceRoot, function()
	for i, v in ipairs(Element.getAllByType("player")) do
		bindKey(v, "mouse1", "down", function(player)
		if not player:isInVehicle() then
			if player:isWithinMarker(Construmark8) then
				if (getElementData(player, "Roleplay:trabajoVIP") == "Carpintero") or (getElementData(player, "Roleplay:trabajo") == "Carpintero") then
					local ob = getElementData(player,"objeto") or 0
					if (ob >= 1) then  
						destroyElement(gruz)
						setElementFrozen( player, true)
						player:outputChat("> agarra el martillo y comienza a fabricar un mueble",178, 140, 214,true)	 
						setTimer( function(player)
            					setPedAnimation(player, "BASEBALL", "Bat_M",-1, true, false, false, false)
						end, 100, 1,player )
						setTimer( function(player)
		     			 	setElementFrozen( player, false )
						setPedAnimation (player)
						local x,y,z = getElementPosition(player)
						gruz1 = createObject ( 1739, x, y, z )
							local a = getPlayerName(player)
					setTimer(function(p)
					if isElement(p) then
					p:setData("TextInfo", {"",255, 0, 216})
					end
					end, 4000, 1, player)
						attachElements ( gruz1, player, 0,0.4,0.05)
						setPedAnimation( player, "CARRY", "crry_prtial", 4.1, true, true, true )
						if ( gruz1 ) then -- if it was created
						setObjectScale ( gruz1, 1)
       						setElementCollisionsEnabled (gruz1, false)
						end
						end, 40000, 1,player )
						setElementData(player,"silla",1)
						 removeElementData(player,"objeto")
					else
					player:outputChat("No tienes madera para fabricar", 150, 50, 50, true)
					end
					 else
					player:outputChat("¡Tu no trabajas aquí!", 150, 50, 50, true)
					end
				end
			end
		end)
	end
end
)
--vender
addEventHandler("onResourceStart", resourceRoot, function()
	for i, v in ipairs(Element.getAllByType("player")) do
		bindKey(v, "mouse1", "down", function(player)
		if not player:isInVehicle() then
			if player:isWithinMarker(vender) then
				if (getElementData(player, "Roleplay:trabajoVIP") == "Carpintero") or (getElementData(player, "Roleplay:trabajo") == "Carpintero") then
					local actualExp = exports.nlogin:getCharacterData(player,"CarpinteroExp") or 1-- player:getData("Roleplay:ExpJobCarpintero") or 1	
					local ob = getElementData(player,"silla") or 0
					if (ob >= 1) then  
					local a = getPlayerName(player)
					player:outputChat("> deja un mueble en el cobertizo",178, 140, 214,true)
					setTimer(function(p)
					if isElement(p) then
					p:setData("TextInfo", {"",255, 0, 216})
					end
					end, 4000, 1, player)
					local money = math.random(10,50)
					setPlayerMoney(player,getPlayerMoney(player)+money*actualExp/2)
					player:outputChat("Paga por el #FFF43Cmueble: #1F9100"..money.." dolares.",255,255,255,true)
					destroyElement(gruz, nil)
					destroyElement(gruz1, nil)
					removeElementData(player,"objeto")
					removeElementData(player,"silla")
					local suerte = math.random(1,7)
					local exp2 = 1 + actualExp
					if (exp2 <= 10) then
					if suerte == 2 then
					text = "Acabas de obtener #E511E81 #ffffffexperiencia por trabajar."
					--player:setData("Roleplay:ExpJobCarpintero",exp2)
					exports.nlogin:setCharacterData(player,"CarpinteroExp",exp2)
					else
					text = ""
					end
					player:outputChat(text, 255, 255, 255, true)
					else
					player:outputChat("Has llegado a #E511E8 10 #ffffffde experiencia que es el maximo", 255, 255, 255, true)
					end
					else
					player:outputChat("No tienes sillas para vender", 150, 50, 50, true)
					end
					 else
					player:outputChat("¡Tu no trabajas aquí!", 150, 50, 50, true)
					end
				end
			end
		end)
	end
end
)
addCommandHandler("trabajar", function(player, cmd)
		if not player:isInVehicle() then
			if (player:getData("Roleplay:trabajo") == "") or (player:getData("Roleplay:trabajoVIP") == "") then
				for i, marker in ipairs(MarkersCarpintero) do
					if player:isWithinMarker(marker) then
						local job = marker:getData("MarkerJob")
						if job == "Carpintero" then
							if (player:getData("Roleplay:trabajo") == "Carpintero") or (player:getData("Roleplay:trabajoVIP") == "Carpintero") then
								removeElementData(player,"objeto")
								removeElementData(player,"silla")
								player:outputChat("¡Ya estas trabajando aquí!", 150, 50, 50, true)
							else	
								removeElementData(player,"objeto")
								removeElementData(player,"silla")
								player:setData("Roleplay:trabajo", "Carpintero")
								player:outputChat("¡Bienvenido al trabajo de #ffff00Carpintero#ffffff!", 255, 255, 255, true)				
						end
					end
				end
			end
		end
	end
end)
addCommandHandler("trabajar2", function(player, cmd)
		if not player:isInVehicle() then
			local account = getPlayerAccount(player)
			if ( isObjectInACLGroup("user."..getAccountName(account), aclGetGroup("VIP")) ) or ( isObjectInACLGroup("user."..getAccountName(account), aclGetGroup("VIP+")) ) then
			if (player:getData("Roleplay:trabajo") == "") or (player:getData("Roleplay:trabajoVIP") == "") then
				for i, marker in ipairs(MarkersCarpintero) do
					if player:isWithinMarker(marker) then
						local job = marker:getData("MarkerJob")
						if job == "Carpintero" then
							if (player:getData("Roleplay:trabajo") == "Carpintero") or (player:getData("Roleplay:trabajoVIP") == "Carpintero") then
								removeElementData(player,"objeto")
								removeElementData(player,"silla")
								player:outputChat("¡Ya estas trabajando aquí!", 150, 50, 50, true)
							else	
								removeElementData(player,"objeto")
								removeElementData(player,"silla")
								player:setData("Roleplay:trabajoVIP", "Carpintero")
								player:outputChat("¡Bienvenido al trabajo de #ffff00Carpintero#ffffff!", 255, 255, 255, true)	
							end			
						end
					end
				end
			end
		end
	end
end)
addCommandHandler("renunciar", function(player, cmd)
		if not player:isInVehicle() then
			if (getElementData(player, "Roleplay:trabajo") == "Carpintero") then
				for i, v in ipairs(MarkersCarpintero) do
					if player:isWithinMarker(v) then
						local job = v:getData("MarkerJob")
						if job == "Carpintero" then
							if (getElementData(player, "Roleplay:trabajo") == "Carpintero") then
								removeElementData(player,"objeto")
								removeElementData(player,"silla")
								player:outputChat("¡Acabas de renunciar!", 50, 150, 50, true)
								player:setData("Roleplay:trabajo", "")
							else
								removeElementData(player,"objeto")
								removeElementData(player,"silla")
								player:outputChat("¡No has trabajado en este lugar, no puedes renunciar aquí!", 150, 50, 50, true)
								player:outputChat("Tu trabajo actual es de: #ffff00"..player:getData("Roleplay:trabajo"), 255, 255, 255, true)					
						end
					end
				end
			end
		end
	end
end)
addCommandHandler("renunciar", function(player, cmd)
		if not player:isInVehicle() then
			if (getElementData(player, "Roleplay:trabajoVIP") == "Carpintero") then
				for i, v in ipairs(MarkersCarpintero) do
					if player:isWithinMarker(v) then
						local job = v:getData("MarkerJob")
						if job == "Carpintero" then
							if (getElementData(player, "Roleplay:trabajoVIP") == "Carpintero") then
								removeElementData(player,"objeto")
								removeElementData(player,"silla")
								player:outputChat("¡Acabas de renunciar!", 50, 150, 50, true)
								player:setData("Roleplay:trabajoVIP", "")
							else
								removeElementData(player,"objeto")
								removeElementData(player,"silla")
								player:outputChat("¡No has trabajado en este lugar, no puedes renunciar aquí!", 150, 50, 50, true)
								player:outputChat("Tu trabajo actual es de: #ffff00"..player:getData("Roleplay:trabajo"), 255, 255, 255, true)					
						end
					end
				end
			end
		end
	end
end)
