local blip = {}
addEvent("Police:create_blip", true)
function create_blip(p)
	local pos = Vector3(p:getPosition())
	local x, y, z = pos.x, pos.y, pos.z
	blip[p] = Blip.createAttachedTo(p, 0, 3, 20, 80, 100, 500)
end
addEventHandler("Police:create_blip", root, create_blip)
addEvent("Police:destroy_blip", true)
function destroy_blip(p)
	if isElement(blip[p]) then
		destroyElement(blip[p])
	end
end
addEventHandler("Police:destroy_blip", root, destroy_blip)
addEventHandler("onClientResourceStart", resourceRoot, function()
	EngineTXD("files/taser.txd"):import(347)
	EngineDFF("files/taser.dff"):replace(347)
end)
--
function fireTaserSound(weapon, ammo, ammoInClip, hitX, hitY, hitZ, hitElement, startX, startY, startZ)
	if (weapon == 23) then
		Sound3D("files/Fire.mp3", startX, startY, startZ)
		local s = Sound3D("files/Fire.mp3", hitX, hitY, hitZ)
		s:setMaxDistance(50)
		for i=1, 5, 1 do
			Effect.addPunchImpact(hitX, hitY, hitZ, 0, 0, 0)
			Effect.addSparks(hitX, hitY, hitZ, 0, 0, 0, 8, 1, 0, 0, 0, true, 3, 1)
		end
		Effect.addPunchImpact(startX, startY, startZ, 0, 0, -3)
		if (source == localPlayer) then
			toggleControl("fire", false)
			setTimer(function()
				toggleControl("fire", true)
			end, 350, 1)
		end
	end
end
addEventHandler("onClientPlayerWeaponFire", getRootElement(), fireTaserSound)
--
function AnimacionTaser(attacker, weapon, bodypart, loss)
	if (weapon == 23) then
		triggerServerEvent("setAnimAndCable", attacker, source)
		cancelEvent()
	end
end
addEventHandler("onClientPlayerDamage", getRootElement(), AnimacionTaser)
addEventHandler ("onClientPlayerDamage", root,
function (attacker, weapon)
	if source == localPlayer then
		if localPlayer:getData("NoDamageKill") == true then
			cancelEvent()
		end
	end
end
)
pickups_infos = {
	{ info = "¿Necesitas ayuda? Usa #2EFF00/comoempezar", 1748.8609619141, -1863.1843261719, 14, int = 0, dim = 0, r = 255, g = 255, b = 255, font = "default-bold"  },--CMED SALIDA
	
	{ info = "Toca #FF0000Click Izquierdo #FFFFFFpara entrar", 2013.2103271484, -1414.6441650391, 16, int = 0, dim = 0, r = 255, g = 255, b = 255, font = "default-bold"  },--CMED ENTRADA
	
	{ info = "Toca #FF0000Click Izquierdo #FFFFFFpara salir", 1414.2526855469, -11.995247840881, 1000.9251708984, int = 1, dim = 0, r = 255, g = 255, b = 255, font = "default-bold"  },--CMED ENTRADA
	{ info = "Toca #FF8300Click Izquierdo #FFFFFFpara entrar", 1826.162109375, -1538.5263671875, 13.546875, int = 0, dim = 0, r = 255, g = 255, b = 255, font = "default-bold"  },--CPD PRISION Entrada
	{ info = "Toca #FF8300Click Izquierdo #FFFFFFpara salir", 1817.4936523438, -1536.9014892578, 13, int = 0, dim = 0, r = 255, g = 255, b = 255, font = "default-bold"  },--CPD PRISION Entrada
	--PD
	{ info = "#FFFFFF/emergencias\n#004500$100 dolares",2041.3333740234, -1430.818359375, 17.1640625, int = 0, dim = 0, r = 150, g = 50, b = 50, font = "default-bold"},
	{ info = "#FFFFFF/emergencias\n#004500$100 dolares",1172.0767822266, -1321.44140625, 15.39880657196, int = 0, dim = 0, r = 150, g = 50, b = 50, font = "default-bold"},
}
addEventHandler("onClientRender", getRootElement(), function()
	local playerX2, playerY2, playerZ2 = getElementPosition ( localPlayer )
	for k, v in pairs(pickups_infos) do
		local playerX, playerY, playerZ = v[1], v[2], v[3]
		local sx, sy = getScreenFromWorldPosition(playerX, playerY, playerZ + 0.5)
		if sx and sy then
			local cx, cy, cz = getCameraMatrix()
			local distance = getDistanceBetweenPoints3D(playerX2, playerY2, playerZ2, playerX, playerY, playerZ + 0.5)
			if distance < 10 then
				dxDrawBorderedText3 ( v.info, sx, sy, sx, sy , tocolor ( v.r, v.g, v.b, 255 ),1, v.font,"center", "center" ) 
			end
		end
	end
end)
function dxDrawBorderedText3( text, x, y, w, h, color, scale, font, alignX, alignY, clip, wordBreak, postGUI )
	dxDrawText(text:gsub('#%x%x%x%x%x%x', ''), (x) + 1, (y) + 1, (w) + 1, (h) + 1, tocolor ( 0, 0, 0, 255 ), scale, font, alignX, alignY, clip, wordBreak, postGUI, true)
	dxDrawText(text, x, y, w, h, color, scale, font, alignX, alignY, clip, wordBreak, postGUI, true)
end
--win veh pub
        winpubveh = guiCreateWindow(0.34, 0.24, 0.34, 0.49, "Vehiculos - PDLC", true)
        guiWindowSetSizable(winpubveh, false)
        Texto = guiCreateLabel(0.07, 0.07, 0.89, 0.04, "Haz click sobre el vehiculo que quieres y luego coloca respawnear", true, winpubveh)
        vehlist = guiCreateGridList(0.02, 0.13, 0.96, 0.77, true, winpubveh)
		guiGridListAddColumn(vehlist, "ID", 0.2)
		guiGridListAddColumn(vehlist, "Vehiculo", 0.3)
		guiGridListAddColumn(vehlist, "Int", 0.2)
		guiGridListAddColumn(vehlist, "Key", 0.1)
        respawnear = guiCreateButton(0.04, 0.93, 0.40, 0.05, "Respawnear", true, winpubveh)
        guiSetFont(respawnear, "default-bold-small")
        guiSetProperty(respawnear, "NormalTextColour", "FF34E01E")
        cerrar = guiCreateButton(0.56, 0.93, 0.40, 0.05, "Cerrar", true, winpubveh)
        guiSetFont(cerrar, "default-bold-small")
        guiSetProperty(cerrar, "NormalTextColour", "FFFD0000")   
        guiSetVisible(winpubveh,false)
        showCursor(false)
addEventHandler("onClientGUIClick",getRootElement(),function()
		local id = guiGridListGetItemText( vehlist, guiGridListGetSelectedItem ( vehlist ), 1 )
    	local itenName = guiGridListGetItemText ( vehlist, guiGridListGetSelectedItem ( vehlist ), 2 )
    	local int = guiGridListGetItemText ( vehlist, guiGridListGetSelectedItem ( vehlist ), 3 )
    	local key = guiGridListGetItemText ( vehlist, guiGridListGetSelectedItem ( vehlist ), 4 )
	if source == cerrar then
		guiSetVisible(winpubveh,false)
		showCursor(false)
	elseif source == respawnear then
		if itenName ~= "" then
			outputChatBox(" ",50,255,50,true)
			outputChatBox("#3A63FF[FACCION] #ffffffSpawneaste el vehiculo #36FF00"..itenName.."#ffffff, Recuerda una vez termines de utilizarlo borrarlo para evitar lag.",50,255,50,true)
			--guiSetVisible(winpubveh,false)
			--showCursor(false)
			triggerServerEvent("spawnpd",localPlayer,id,key)
		else
			outputChatBox("#3A63FF[FACCION] #ffffffSelecciona un Vehiculo primero",255,50,50,true)
		end
	end
end)
function vehpub(id)
	if id == 598 or id == 599 or id == 523 or id == 468 or id == 490 or id == 528 or id == 490 then
		return "Policia"
	end
end
local listaveh = {
	{598,"Toyota Corolla PDLC",4,5105},
	{597,"Chevrolet Onix PDLC",4,8462},
	{596,"Ford Focus PDLC",4,8462},
	{523,"Moto Policia",4,6486},
	{528,"Camion S.W.A.T",4,9766},
	{427,"Enforcer",4,8432},
	{601,"S.W.A.T",4,9432},
	{525,"Towtruck",4,1510},
	{426,"Premier",4,6842},
	{560,"Sultan",4,6842}
}
--local pickup = Pickup(1528.8287353516, -1671.1840820312, 6.21875,3,1239)
--[[function verwin()
	if getElementData(localPlayer,"Roleplay:faccion") == "Policia" then
		if isElementWithinPickup(localPlayer,pickup) then
			guiSetVisible(winpubveh,true)
			showCursor(true)
			guiGridListClear( vehlist )
			for i,v in pairs(listaveh) do
				local row = guiGridListAddRow(vehlist)
		   		guiGridListSetItemText(vehlist, row, 1, v[1], false, true)
		    	guiGridListSetItemText(vehlist, row, 2, v[2], false, true)
		    	guiGridListSetItemText(vehlist, row, 3, v[3], false, true)
		    	guiGridListSetItemText(vehlist, row, 4, v[4], false, true)
		 	end
		end
	end
end
addCommandHandler("sacarvehiculo",verwin)
function isElementWithinPickup(theElement, thePickup)
	if (isElement(theElement) and getElementType(thePickup) == "pickup") then
		local x, y, z = getElementPosition(theElement)
		local x2, y2, z2 = getElementPosition(thePickup)
		if (getDistanceBetweenPoints3D(x2, y2, z2, x, y, z) <= 1) then
			return true
		end
	end
	return false
end
addEventHandler( "onClientRender", getRootElement(), 
	function()
		local x,y = getScreenFromWorldPosition(1528.8287353516, -1671.1840820312, 6.21875, 0, true )
		local dist = getDistanceBetweenPoints3D(1528.8287353516, -1671.1840820312, 6.21875, getElementPosition(localPlayer) )
		if x and dist <= 10 then
			x = x - (dxGetTextWidth( '/sacarvehiculo', 2-(dist/40)*2, "default-bold" )/2)
			
			dxDrawText('/sacarvehiculo', x-1, y-1, x+1, y+5, tocolor(0,0,0,255), 1.3-(dist/10), "default-bold","left","top",false,false,false,false,false)
			dxDrawText('/sacarvehiculo', x+1, y+1, x-1, y-5, tocolor(0,0,0,255), 1.3-(dist/10), "default-bold","left","top",false,false,false,false,false)
			dxDrawText('/sacarvehiculo', x, y, x, y+3, tocolor(255,255,255,255), 1.3-(dist/10), "default-bold","left","top",false,false,false,false,false)
		end
		local x2,y2 = getScreenFromWorldPosition(1529.0119628906, -1685.9713134766, 5.890625, 0, true )
		local dist2 = getDistanceBetweenPoints3D(1529.0119628906, -1685.9713134766, 5.890625, getElementPosition(localPlayer) )
		if x2 and dist2 <= 10 then
			x2 = x2 - (dxGetTextWidth( '/borrarvehiculo', 2-(dist/30)*2, "default-bold" )/2)
			
			dxDrawText('/borrarvehiculo', x2-1, y2-1, x2+1, y2+5, tocolor(0,0,0,255), 2-(dist2/10), "default-bold","left","top",false,false,false,false,false)
			dxDrawText('/borrarvehiculo', x2+1, y2+1, x2-1, y2-5, tocolor(0,0,0,255), 2-(dist2/10), "default-bold","left","top",false,false,false,false,false)
			dxDrawText('/borrarvehiculo', x2, y2, x2, y2+3, tocolor(255,255,255,255), 2-(dist2/10), "default-bold","left","top",false,false,false,false,false)
		end
	end
)]]
local font2 = "default-bold-small"
naif = {
	{"Estacionamiento",1524.4830322266, -1677.8200683594, 6.21875},
	{"Planta Baja",1582.1635742188, -1681.126953125, 16.1953125},
	{"Techo",1572.0100097656, -1675.6479492188, 28.3984375},
}	
function centerWindoww(centerWindoww)
    local screenW,screenH=guiGetScreenSize()
    local windowW,windowH=guiGetSize(centerWindoww,false)
    local x,y = (screenW-windowW)/2,(screenH-windowH)/2
    guiSetPosition(centerWindoww,x,y,false)
end
           
GUIEditor = {
    button = {},
    window = {}
}
GUIEditor.window[1] = guiCreateWindow(518, 264, 311, 321, "Elevador", false)
guiWindowSetSizable(GUIEditor.window[1], false)
guiSetVisible(GUIEditor.window[1],false)
g_nova = guiCreateGridList(0.03, 0.08, 0.94, 0.81, true, GUIEditor.window[1])
guiGridListAddColumn(g_nova, "Pisos / Plantas ", 0.5)
guiGridListAddColumn(g_nova, "", 0.5)
GUIEditor.button[1] = guiCreateButton(0.06, 0.91, 0.30, 0.06, "Ir", true, GUIEditor.window[1])
guiSetProperty(GUIEditor.button[1], "NormalTextColour", "FFFFFFFF")
GUIEditor.button[2] = guiCreateButton(0.64, 0.91, 0.30, 0.06, "Cerrar", true, GUIEditor.window[1])
guiSetProperty(GUIEditor.button[2], "NormalTextColour", "FFFFFFFF") 
for i,ha in ipairs(naif) do
	local row = guiGridListAddRow(g_nova)
	guiGridListSetItemText(g_nova,row,1,ha[1],false,false)
	guiGridListSetItemData(g_nova,row,1,{ha[2],ha[3],ha[4]})
	guiSetFont(g_nova,font2)
end
function OpenWinS()
    if guiGetVisible ( GUIEditor.window[1] ) then
       guiSetVisible ( GUIEditor.window[1], false )
       showCursor(false)
       guiSetInputEnabled(false)
    else
    guiSetVisible ( GUIEditor.window[1], true )
   	showCursor(true)
   	guiSetInputEnabled(true) 
    end
end
addEvent( "OpenWinS", true  )
addEventHandler( "OpenWinS", getRootElement(), OpenWinS )
addEventHandler("onClientGUIClick",root,
	function ()
		local sel = guiGridListGetSelectedItem(g_nova)
		if source == GUIEditor.button[1] then
			if sel ~= -1 then
				local x,y,z = unpack(guiGridListGetItemData(g_nova,sel,1))
				setElementPosition(localPlayer,x,y,z)
			else
				outputChatBox("#FF8F11[ASCENSOR] #ffffffYa te encuentras aqui.",localPlayer,0,255,255)
			end
		end
	end
)
addEventHandler( 'onClientGUIClick', root,
function()
if source == GUIEditor.button[2] then
guiSetVisible(GUIEditor.window[1], false)
showCursor(false)
guiSetInputEnabled(false)
	end
end
)