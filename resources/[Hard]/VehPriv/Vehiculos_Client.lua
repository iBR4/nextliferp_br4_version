local screenW, screenH = guiGetScreenSize()
maFen = nil
local colorButton = {}
local cColor = {}
local colorButtonA = {}
local colorEx = {}
local player = getLocalPlayer()
function guiStart (atList)
	if maFen == nil then
		local x, y = guiGetScreenSize()
		maFen = guiCreateWindow( x / 2 - 200, y / 2 - 175, 400, 350, "Concesionaria de los santos", false )
		guiSetText ( maFen, "Concesionaria de los santos")
		maTab = guiCreateTabPanel( 180, 30, 230, 100, false, maFen )
		carPic = guiCreateStaticImage( 5, 5, 200, 85, "Png\\rien.png", false, maTab )
		local cBNum = 0
		local cBx = 0.46
		while cBNum ~= 4 do
			cBNum = cBNum + 1
			colorButtonA[cBNum] = guiCreateButton ( cBx, 0.39, 0.10, 0.06, "color"..cBNum.."", true , maFen )
			cBx = cBx + 0.13
		end
		guiWindowSetSizable (maFen, false )
		guiWindowSetMovable (maFen, true )
		showList(atList)
		buyButton = guiCreateButton( 0.03, 0.89, 0.33, 0.10, "Comprar", true, maFen )
		closeButton = guiCreateButton( 0.66, 0.89, 0.33, 0.10, "Cerrar", true, maFen )
		addEventHandler( "onClientGUIClick", maFen, aClickGui )
		showCursor ( true )
		guiSetVisible ( maFen, true )
		--guiCreateStaticImage( 5, 5, 200, 85, "colors\\2.png", false, maTab )
		
		colorFen = guiCreateWindow( x / 2 - 260, y / 2 - 40, 520, 210, "Colores", false )
		local colorNum = 0
		local colorNum1 = 0
		local colorX = 10
		local colorY = 25
		while colorNum ~= 127 do
			colorButton = guiCreateStaticImage( colorX, colorY, 23, 23, "colors\\"..colorNum..".png", false, colorFen )
			setElementData ( colorButton , "colorNum1", ""..colorNum.."" )
			addEventHandler( "onClientGUIClick", colorButton, aClickGuiColor )
			colorNum = colorNum + 1
			colorX = colorX + 25
			if colorNum1 == 19 then
				colorY = colorY + 25
				colorNum1 = 0
				colorX = 10
			else
				colorNum1 = colorNum1 + 1
			end		
		end
		colorCloseButton = guiCreateButton( 0.76, 0.85, 0.23, 0.1, "Cerrar", true, colorFen )
		addEventHandler( "onClientGUIClick", colorFen, aClickGui )
		guiWindowSetSizable ( colorFen, false )
		guiSetVisible ( colorFen, false )
		
	else
		guiSetVisible ( maFen, true )
		showCursor ( true )
		guiBringToFront ( maFen )
		showList(atList)
	end
end
addEvent( "guiStart", true  )
addEventHandler( "guiStart", getRootElement(), guiStart )
function destroyvehicles ( vehicle )
	destroyElement ( vehicle )
end
addEvent( "destroyvehicles", true  )
addEventHandler( "destroyvehicles", getRootElement(), destroyvehicles )
function showList(atList)
	local table = {}
--	outputChatBox ( ""..atList.."" )
	vehicleList   = guiCreateGridList ( 0.01 , 0.07, 0.4, 0.8, true, maFen )
	vehicleList1  = guiGridListAddColumn( vehicleList, "Vehiculos", 0.5 )
	priceList = guiGridListAddColumn( vehicleList, "Precios (Cash/Coins)", 0.7 )
	Slots = guiGridListAddColumn( vehicleList,"Slots" ,0.2)
-- 	node = xmlLoadFile("data\\vehicles.xml")
-- 	if ( node ) then
-- 		local vNum = 0
-- 		while ( xmlFindSubNode ( node, "group", vNum ) ~= false ) do
-- 			local group = xmlFindSubNode ( node, "group", vNum )
-- 			if xmlNodeGetAttribute ( group, "type" ) == atList then
-- 				local gName = xmlNodeGetAttribute ( group, "id" )
-- --				guiGridListSetItemText( vehicleList, guiGridListAddRow ( vehicleList ), 1, ""..gName.."", false, false )
-- 				local vNum1 = 0
-- 				while ( xmlFindSubNode ( group, "vehicle", vNum1 ) ~= false ) do
-- 					local aVehicle = xmlFindSubNode ( group, "vehicle", vNum1 )
-- 					local vId = xmlNodeGetAttribute ( aVehicle, "id" )
-- 					local vName = getVehicleNameFromID ( vId )
-- 					local vPrice = xmlNodeGetAttribute ( aVehicle, "price" )
-- 					local vMaletero = xmlNodeGetAttribute ( aVehicle, "malee" )
-- 					local row = guiGridListAddRow ( vehicleList )
-- 					guiGridListSetItemText( vehicleList, row, 1, ""..vName.."", false, false )
-- 					guiGridListSetItemText( vehicleList, row, 2, ""..vPrice.."", false, false )
-- 					guiGridListSetItemText( vehicleList, row, 3, ""..vMaletero.."", false, false )
-- 					vNum1 = vNum1 + 1
-- 				end
-- 			end
-- 			vNum = vNum + 1
-- 		end
-- 		
-- 		bindKey ( "arrow_u", "down", navList )
-- 		bindKey ( "arrow_d", "down", navList )
-- 		xmlUnloadFile ( node )
-- 	end
		addEventHandler( "onClientGUIClick", vehicleList, aClickGuiCar )
 		addEventHandler( "onClientGUIDoubleClick", vehicleList, aClickDoubleGui )
	for i, v in ipairs(ShopConceInfo[atList]) do
		local row = guiGridListAddRow ( vehicleList, getVehicleNameFromModel(v.model), ""..v.price.." ("..(v.coins).." Coins)", v.slots )
		guiGridListSetItemData ( vehicleList, row, 1, v.model )
		guiGridListSetItemData ( vehicleList, row, 2, tonumber(v.coins) )
		guiGridListSetItemData ( vehicleList, row, 3, tonumber(v.price) )
	end
	return table
end
function navList ( key, keyState)
	local rowSel = guiGridListGetSelectedItem ( vehicleList )
	if key == "arrow_u" then
		guiGridListSetSelectedItem ( vehicleList, tonumber(rowSel)-1, 1 )
	elseif key == "arrow_d" then
		guiGridListSetSelectedItem ( vehicleList, tonumber(rowSel)+1, 1 )
	end
	local aCurrentVehicle = guiGridListGetItemText ( vehicleList, guiGridListGetSelectedItem ( vehicleList ), 1 )
	if fileExists( "Png\\"..aCurrentVehicle..".png" ) then
		guiStaticImageLoadImage ( carPic, "Png\\"..aCurrentVehicle..".png" )
	end
end
	
function aClickGui (button)
	if ( button == "left") then
		if ( source == closeButton ) then
			guiSetVisible ( maFen, false )
			guiSetVisible ( colorFen, false )
			showCursor ( false )
			destroyElement ( vehicleList )
			unbindKey ( "arrow_u", "down", navList )
			unbindKey ( "arrow_d", "down", navList )
			local num = 0
			while num ~= 4 do
				num = num + 1
				if ( colorEx[num] ) then
					guiStaticImageLoadImage ( colorEx[num], "colors\\rien.png" )
				end
			end
			guiStaticImageLoadImage ( carPic, "Png\\rien.png" )
		elseif ( source == buyButton ) then
			if ( aCurrentVehicle ) ~= "" then
				local cNum = 0
				while cNum ~=4 do
					cNum = cNum + 1
					cColor[cNum] = getElementData ( colorButtonA[cNum], "apColor" )
					if cColor[cNum] == false then
						cColor[cNum] = "1"
					end
				end
				applyVehicle ( cColor[1], cColor[2], cColor[3], cColor[4] )
				guiSetVisible ( maFen, false )
				guiSetVisible ( colorFen, false )
				showCursor ( false )
				unbindKey ( "arrow_u", "down", navList )
				unbindKey ( "arrow_d", "down", navList )
				destroyElement ( vehicleList )
				guiStaticImageLoadImage ( carPic, "Png\\rien.png" )
			else
				outputChatBox ( "No seleccionaste un vehiculo." )
			end
		
		elseif ( source == colorCloseButton ) then
			guiSetVisible ( colorFen, false )
		
		elseif ( source == colorButtonA[4] ) then
			guiSetVisible ( colorFen, true )
			guiBringToFront ( colorFen )
			setElementData ( colorFen, "typColor", "4" )
		
		elseif ( source == colorButtonA[3] ) then
			guiSetVisible ( colorFen, true )
			guiBringToFront ( colorFen )
			setElementData ( colorFen, "typColor", "3" )
		
		elseif ( source == colorButtonA[2] ) then
			guiSetVisible ( colorFen, true )
			guiBringToFront ( colorFen )
			setElementData ( colorFen, "typColor", "2" )
			
		elseif ( source == colorButtonA[1] ) then
			guiSetVisible ( colorFen, true )
			guiBringToFront ( colorFen )
			setElementData ( colorFen, "typColor", "1" )
		end
	end
end
function aClickGuiColor (button)
		color1Choose = getElementData ( source, "colorNum1" )
		if  color1Choose ~= false then
			typeColorButton = getElementData ( colorFen, "typColor" )
			if typeColorButton == "2"  then
				local exPosX = 0.60
				affColorExemple ( color1Choose, typeColorButton, exPosX )
				
			elseif typeColorButton ==  "1" then
				local exPosX = 0.47
				affColorExemple ( color1Choose, typeColorButton, exPosX )
				
			elseif typeColorButton == "3" then
				local exPosX = 0.73
				affColorExemple ( color1Choose, typeColorButton, exPosX )
			
			elseif typeColorButton == "4" then
				local exPosX = 0.86
				affColorExemple ( color1Choose, typeColorButton, exPosX )
			end
		end
end
function affColorExemple ( color1Choose, typeColorButton, exPosX )
--	outputChatBox ( ""..color1Choose.."" )
	guiSetVisible ( colorFen, false )
	setElementData ( colorButtonA[tonumber(typeColorButton)], "apColor", ""..color1Choose.."" )	
	if ( colorEx[tonumber(typeColorButton)] ) then
		guiStaticImageLoadImage ( colorEx[tonumber(typeColorButton)], "colors\\"..color1Choose..".png" )
	else
		colorEx[tonumber(typeColorButton)] = guiCreateStaticImage( exPosX, 0.46, 0.08, 0.06, "colors\\"..color1Choose..".png", true, maFen )		
	end
end	
function aClickDoubleGui (button)
	if (button == "left" ) then
		if ( source == vehicleList ) then
			local cNum = 0
			while cNum ~=4 do
				cNum = cNum + 1
				cColor[cNum] = getElementData ( colorButtonA[cNum], "apColor" )
				if cColor[cNum] == false then
					cColor[cNum] = "1"
				end
			end
			applyVehicle (cColor[1], cColor[2], cColor[3], cColor[4] )
			if aCurrentVehicle ~= "" then                                          --- SE IF FAUDRAI LE METTRE PLUS HAUT  y a un doublon ligne 303
				guiSetVisible ( maFen, false )
				showCursor ( false )
				unbindKey ( "arrow_u", "down", navList )
				unbindKey ( "arrow_d", "down", navList )
				destroyElement ( vehicleList )
				guiStaticImageLoadImage ( carPic, "Png\\rien.png" )
			end
		end
	end
end
function aClickGuiCar (button)
	if (button == "left" ) then
		if (source == vehicleList ) then
			aCurrentVehicle = guiGridListGetItemText ( vehicleList, guiGridListGetSelectedItem ( vehicleList ), 1 )
			if ( carPic ) then
				if fileExists("Png\\"..aCurrentVehicle..".png") then
					guiStaticImageLoadImage ( carPic, "Png\\"..aCurrentVehicle..".png" )
				else
					guiStaticImageLoadImage ( carPic, "Png\\rien.png" )
				end
			else
				carPic = guiCreateStaticImage( 5, 5, 200, 85, "Png\\"..aCurrentVehicle..".png", false, maTab )
			end
		end
	end
end
function applyVehicle ( cColor1, cColor2, cColor3, cColor4 )
	local player = getLocalPlayer ()
	shopName = getElementData (player, "shopName" )
	colshapeComps = getElementsByType ( "colshape" )
	for theKey,colshapeComp in ipairs(colshapeComps) do
		if getElementData ( colshapeComp, "SpawnPointName" ) == shopName then
			spawnState = getElementData ( colshapeComp, "etatPlace" )
			if spawnState == "libre" or spawnState == false then
				aCurrentVehicle = guiGridListGetItemText ( vehicleList, guiGridListGetSelectedItem ( vehicleList ), 1 )
				local cost = tonumber(guiGridListGetItemData ( vehicleList, guiGridListGetSelectedItem ( vehicleList ), 3 ))
				local male = guiGridListGetItemText ( vehicleList, guiGridListGetSelectedItem ( vehicleList ), 3 )
				local vId = tonumber(guiGridListGetItemData ( vehicleList, guiGridListGetSelectedItem ( vehicleList ), 1 ))
				local vCoins = tonumber(guiGridListGetItemData ( vehicleList, guiGridListGetSelectedItem ( vehicleList ), 2 ))
				local x,y,z = getElementPosition( colshapeComp )
				local sRz = getElementData ( colshapeComp, "sRz" )
				local nPlayer = getPlayerName ( getLocalPlayer ())
				if aCurrentVehicle ~= "" then
					local num = 0
					while num ~= 4 do
						num = num + 1
						if ( colorEx[num] ) then
							guiStaticImageLoadImage ( colorEx[num], "colors\\rien.png" )
						end
					end
					setTimer ( removeColD, 20000, 1, colshapeComp )
--					if getPlayerMoney ( player ) >= math.abs(cost) then
--						setElementData ( colshapeComp , "etatPlace", "OQP" )  ------------ <<<< VERSION 1 uniquement
--					end
					
					--print(cColor1, cColor2, cColor3, cColor4, vCoins)
					triggerServerEvent ( "but_applyVehicle", player, player, tonumber(cost), vId, x, y, z, nPlayer,tonumber(male), sRz, cColor1, cColor2, cColor3, cColor4, vCoins)
					aCurrentVehicle = nil
				end
			else
				outputChatBox ( "Espera un momento..." )
			end		
		end
	end
end
function removeColD ( colshapeComp )
	setElementData ( colshapeComp , "etatPlace", "libre" )
end
function setEnabled( var, timer )
	guiSetEnabled( var, false )
	setTimer(guiSetEnabled, timer, 1, var, true)
end
--windowcar
function getPlayerNearbyVehicle(localPlayer)
	if isElement(localPlayer) then
		for i,veh in ipairs(Element.getAllByType('vehicle')) do
			local vx,vy,vz = getElementPosition( veh )
			local px,py,pz = getElementPosition( localPlayer )
			if getDistanceBetweenPoints3D(vx,vy,vz, px,py,pz) < 3.5 then
				return veh
			end
		end
	end
	return false
end
addEventHandler("onClientRender", getRootElement(), function()
	local playerX2, playerY2, playerZ2 = getElementPosition ( localPlayer )
	for name, v in pairs(ShopConceInfo) do
		local playerX, playerY, playerZ = v.shopPos[1], v.shopPos[2], v.shopPos[3]
		local sx, sy = getScreenFromWorldPosition(playerX, playerY, playerZ + 0.5)
		if sx and sy then
			local cx, cy, cz = getCameraMatrix()
			local distance = getDistanceBetweenPoints3D(playerX2, playerY2, playerZ2, playerX, playerY, playerZ + 0.5)
			if distance < 20 then
				dxDrawBorderedText3 ( v.textoMarker, sx, sy, sx, sy , tocolor (0, 255, 0, 255 ),1, "default-bold","center", "center" ) 
			end
		end
	end
end)
function dxDrawBorderedText3( text, x, y, w, h, color, scale, font, alignX, alignY, clip, wordBreak, postGUI )
	dxDrawText(text:gsub('#%x%x%x%x%x%x', ''), (x) + 1, (y) + 1, (w) + 1, (h) + 1, tocolor ( 0, 0, 0, 255 ), scale, font, alignX, alignY, clip, wordBreak, postGUI, true)
	dxDrawText(text, x, y, w, h, color, scale, font, alignX, alignY, clip, wordBreak, postGUI, true)
end
function dxDrawBorderedText( text, x, y, w, h, color, scale, font, alignX, alignY, clip, wordBreak, postGUI )
	dxDrawText(text:gsub('#%x%x%x%x%x%x', ''), (x) - 1, (y) + 1, (w) - 1, (h) + 1, tocolor ( 0, 0, 0, 255 ), scale, font, alignX, alignY, clip, wordBreak, postGUI, true)
	dxDrawText(text:gsub('#%x%x%x%x%x%x', ''), (x) + 1, (y) + 1, (w) + 1, (h) + 1, tocolor ( 0, 0, 0, 255 ), scale, font, alignX, alignY, clip, wordBreak, postGUI, true)
	dxDrawText(text, x, y, w, h, color, scale, font, alignX, alignY, clip, wordBreak, postGUI, true)
end
function convert ( number )  
	local formatted = number  
	while true do      
		formatted, k = string.gsub(formatted, "^(-?%d+)(%d%d%d)", '%1,%2')    
		if ( k==0 ) then      
			break   
		end  
	end  
	return formatted
end
-- GANSUAR
--windowcar
local blipsveh = {}
local marcadores = {
{1371.9547119141, -1892.4736328125, 13},
{2572.6618652344, -1126.2003173828, 65},
}
addCommandHandler("dondevendervehestado",function()
	outputChatBox("#FFFFFFSe marcaron todos los blips para vender tu #C8C8C8vehiculo al estado", 227, 114, 1,true)	
	outputChatBox("#C8C8C8Para eliminar los mismos escribe #3EFF00/limpiarblips", 255, 255, 255,true)
	for i, v in ipairs(marcadores) do				
		blipsveh[i] = Blip(v[1], v[2], v[3], 0, 2, 255 ,255, 0, 255, 0, 99999,localPlayer)
	end
end)
addCommandHandler("limpiarblips",function()
	for i, v in ipairs(blipsveh) do	
		if isElement( v ) then
			v:destroy()
			v = nil
		end
	end
	outputChatBox("",255,255,255,true)
end)
function getPlayerNearbyVehicle(localPlayer)
	if isElement(localPlayer) then
		for i,veh in ipairs(Element.getAllByType('vehicle')) do
			local vx,vy,vz = getElementPosition( veh )
			local px,py,pz = getElementPosition( localPlayer )
			if getDistanceBetweenPoints3D(vx,vy,vz, px,py,pz) < 3.5 then
				return veh
			end
		end
	end
	return false
end
local pos = false
local sx,sy = guiGetScreenSize(  )
local veryo = true
addEventHandler( "onClientRender", root,
	function( )
		if veryo == true then
			local vehs = getElementsByType( 'vehicle' )
			for i=1, #vehs do 
				local v= vehs[i]
				local x, y, z = getElementPosition( v )
				if getDistanceBetweenPoints3D( x, y, z, unpack( {getCameraMatrix(getLocalPlayer())} ) ) < 40 then
					if getVehicleType(v) == "Automobile" then
						local cx, cy, cz = getVehicleComponentPosition( v, 'wheel_rb_dummy', "world" )
						if cx and cy and cz then
							local sx, sy = getScreenFromWorldPosition( cx, cy, cz )
							local text = getElementData( v, "yo" ) or ""
							if sx and sy then
								dxDrawText( text, sx-3, sy, sx, sy, tocolor(0,0,0), 1, "default-bold", "center", "center" )
								dxDrawText( text, sx, sy, sx, sy, tocolor(255,255,255), 1, "default-bold", "center", "center" )
							end
						end
					end
				end
			end
		end
	end
)
local seatWindows = {
	[0] = 4,
	[1] = 2,
	[2] = 5,
	[3] = 3
}
addEvent( "abrirVentanilla", true )
addEventHandler( "abrirVentanilla", getRootElement( ),
	function( veh, p )
		if veh then
			local seat = getPedOccupiedVehicleSeat( p )
			if seatWindows[seat] and setVehicleWindowOpen( veh, seatWindows[seat], not isVehicleWindowOpen( veh, seatWindows[seat] ) ) then
			end
		end	
	end
)
-- addEventHandler( "onClientRender", getRootElement(),
-- 	function()
-- 		for i, v in ipairs(getElementsByType('pickup', resourceRoot)) do
-- 			if getElementData(v, "SpawnShopName") then
-- 			--	dxDrawTextOnElement(v,"",0,20,255,255,255,255,2,"default")
-- 			end
-- 		end
-- 	end
-- )
--------------------------------------------------------------------------------
-- local ConceJeff = Pickup(2131.7060546875, -1150.5327148438, 24, 3, 1239)
function dxDrawTextOnElement(TheElement,text,height,distance,R,G,B,alpha,size,font,...)
    local x, y, z = getElementPosition(conceJeff)
    local x2, y2, z2 = getCameraMatrix()
    local distance = distance or 20
    local height = height or 1
    if (isLineOfSightClear(x, y, z, x2, y2, z2, ...)) then
        local sx, sy = getScreenFromWorldPosition(x, y, z+height)
        if(sx) and (sy) then
            local distanceBetweenPoints = getDistanceBetweenPoints3D(x, y, z, x2, y2, z2)
            if(distanceBetweenPoints < distance) then
                dxDrawText(text, sx+2, sy+2, sx, sy, tocolor(R or 255, G or 255, B or 255, alpha or 255), (size or 1)-(distanceBetweenPoints / distance), font or "arial", "center", "center")
            end
        end
    end
end
-- addEventHandler("onClientRender", getRootElement(), 
-- function ()
--   
-- end)
-- -----------------------------------------------------------------------------------
-- local ConceMoto = Pickup(2475.7973632813, -1750.6513671875, 13.5, 3, 1239)
-- function dxDrawTextOnElement(TheElement,text,height,distance,R,G,B,alpha,size,font,...)
--     local x, y, z = getElementPosition(ConceMoto)
--     local x2, y2, z2 = getCameraMatrix()
--     local distance = distance or 20
--     local height = height or 1
--     if (isLineOfSightClear(x, y, z, x2, y2, z2, ...)) then
--         local sx, sy = getScreenFromWorldPosition(x, y, z+height)
--         if(sx) and (sy) then
--             local distanceBetweenPoints = getDistanceBetweenPoints3D(x, y, z, x2, y2, z2)
--             if(distanceBetweenPoints < distance) then
--                 dxDrawText(text, sx+2, sy+2, sx, sy, tocolor(R or 255, G or 255, B or 255, alpha or 255), (size or 1)-(distanceBetweenPoints / distance), font or "arial", "center", "center")
--             end
--         end
--     end
-- end
-- addEventHandler("onClientRender", getRootElement(), 
-- function ()
--   dxDrawTextOnElement(ConceMoto,"",0,20,255,255,255,255,2,"default")
-- end)
-- -----------------------------------------------------------------------------------
-- local ConceCaro = Pickup(542.10986328125, -1292.8754882812, 17.4, 3, 1239)
-- function dxDrawTextOnElement(TheElement,text,height,distance,R,G,B,alpha,size,font,...)
--     local x, y, z = getElementPosition(ConceCaro)
--     local x2, y2, z2 = getCameraMatrix()
--     local distance = distance or 20
--     local height = height or 1
--     if (isLineOfSightClear(x, y, z, x2, y2, z2, ...)) then
--         local sx, sy = getScreenFromWorldPosition(x, y, z+height)
--         if(sx) and (sy) then
--             local distanceBetweenPoints = getDistanceBetweenPoints3D(x, y, z, x2, y2, z2)
--             if(distanceBetweenPoints < distance) then
--                 dxDrawText(text, sx+2, sy+2, sx, sy, tocolor(R or 255, G or 255, B or 255, alpha or 255), (size or 1)-(distanceBetweenPoints / distance), font or "arial", "center", "center")
--             end
--         end
--     end
-- end
-- addEventHandler("onClientRender", getRootElement(), 
-- function ()
--   dxDrawTextOnElement(ConceCaro,"",0,20,255,255,255,255,2,"default")
-- end)
-- -----------------------------------------------------------------------------------
-- local ConceCamionetas = Pickup(1097.763671875, -1370.8673095703, 14, 3, 1239)
-- function dxDrawTextOnElement(TheElement,text,height,distance,R,G,B,alpha,size,font,...)
--     local x, y, z = getElementPosition(ConceCamionetas)
--     local x2, y2, z2 = getCameraMatrix()
--     local distance = distance or 20
--     local height = height or 1
--     if (isLineOfSightClear(x, y, z, x2, y2, z2, ...)) then
--         local sx, sy = getScreenFromWorldPosition(x, y, z+height)
--         if(sx) and (sy) then
--             local distanceBetweenPoints = getDistanceBetweenPoints3D(x, y, z, x2, y2, z2)
--             if(distanceBetweenPoints < distance) then
--                 dxDrawText(text, sx+2, sy+2, sx, sy, tocolor(R or 255, G or 255, B or 255, alpha or 255), (size or 1)-(distanceBetweenPoints / distance), font or "arial", "center", "center")
--             end
--         end
--     end
-- end
-- addEventHandler("onClientRender", getRootElement(), 
-- function ()
--   dxDrawTextOnElement(ConceCamionetas,"",0,20,255,255,255,255,2,"default")
-- end)
-- -----------------------------------------------------------------------------------
-- local ConceAvion = Pickup(1897.4875488281, -2345.3630371094, 13.546875, 3, 1239)
-- function dxDrawTextOnElement(TheElement,text,height,distance,R,G,B,alpha,size,font,...)
--     local x, y, z = getElementPosition(ConceAvion)
--     local x2, y2, z2 = getCameraMatrix()
--     local distance = distance or 20
--     local height = height or 1
--     if (isLineOfSightClear(x, y, z, x2, y2, z2, ...)) then
--         local sx, sy = getScreenFromWorldPosition(x, y, z+height)
--         if(sx) and (sy) then
--             local distanceBetweenPoints = getDistanceBetweenPoints3D(x, y, z, x2, y2, z2)
--             if(distanceBetweenPoints < distance) then
--                 dxDrawText(text, sx+2, sy+2, sx, sy, tocolor(R or 255, G or 255, B or 255, alpha or 255), (size or 1)-(distanceBetweenPoints / distance), font or "arial", "center", "center")
--             end
--         end
--     end
-- end
-- addEventHandler("onClientRender", getRootElement(), 
-- function ()
--   dxDrawTextOnElement(ConceAvion,"",0,20,255,255,255,255,2,"default")
-- end)
-- -----------------------------------------------------------------------------------
-- local ConceBarocs = Pickup(723.11, -1494.55, 1.93, 3, 1239)
-- function dxDrawTextOnElement(TheElement,text,height,distance,R,G,B,alpha,size,font,...)
--     local x, y, z = getElementPosition(ConceBarocs)
--     local x2, y2, z2 = getCameraMatrix()
--     local distance = distance or 20
--     local height = height or 1
--     if (isLineOfSightClear(x, y, z, x2, y2, z2, ...)) then
--         local sx, sy = getScreenFromWorldPosition(x, y, z+height)
--         if(sx) and (sy) then
--             local distanceBetweenPoints = getDistanceBetweenPoints3D(x, y, z, x2, y2, z2)
--             if(distanceBetweenPoints < distance) then
--                 dxDrawText(text, sx+2, sy+2, sx, sy, tocolor(R or 255, G or 255, B or 255, alpha or 255), (size or 1)-(distanceBetweenPoints / distance), font or "arial", "center", "center")
--             end
--         end
--     end
-- end
-- addEventHandler("onClientRender", getRootElement(), 
-- function ()
--   dxDrawTextOnElement(ConceBarocs,"",0,20,255,255,255,255,2,"default")
-- end)
-- -----------------------------------------------------------------------------------
-- local ConceMont = Pickup(1399.150390625, 456.26892089844, 20, 3, 1239)
-- function dxDrawTextOnElement(TheElement,text,height,distance,R,G,B,alpha,size,font,...)
--     local x, y, z = getElementPosition(ConceMont)
--     local x2, y2, z2 = getCameraMatrix()
--     local distance = distance or 20
--     local height = height or 1
--     if (isLineOfSightClear(x, y, z, x2, y2, z2, ...)) then
--         local sx, sy = getScreenFromWorldPosition(x, y, z+height)
--         if(sx) and (sy) then
--             local distanceBetweenPoints = getDistanceBetweenPoints3D(x, y, z, x2, y2, z2)
--             if(distanceBetweenPoints < distance) then
--                 dxDrawText(text, sx+2, sy+2, sx, sy, tocolor(R or 255, G or 255, B or 255, alpha or 255), (size or 1)-(distanceBetweenPoints / distance), font or "arial", "center", "center")
--             end
--         end
--     end
-- end
-- addEventHandler("onClientRender", getRootElement(), 
-- function ()
--   dxDrawTextOnElement(ConceMont,"",0,20,255,255,255,255,2,"default")
-- end)