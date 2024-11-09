local Items = {}
addEventHandler( "onClientResourceStart", resourceRoot,
	function()
	local screenW, screenH = guiGetScreenSize()
	wndInv = guiCreateWindow((screenW - 300) / 2, (screenH - 300) / 2, 296, 276, "Inventario", false)
	guiWindowSetSizable(wndInv, false)
	guiSetVisible( wndInv, false )
	--(screenW - 467) / 2, (screenH - 258) / 2, 439, 288
	gridObj = guiCreateGridList(10, 25, 276, 218, false, wndInv)
	guiGridListAddColumn(gridObj, "Objeto", 0.5)
	guiGridListAddColumn(gridObj, "Cantidad / Municion", 0.5)
	botUsar = guiCreateButton(10, 250, 89, 16, "Usar", false, wndInv)
	botTirar = guiCreateButton(197, 251, 89, 15, "Tirar", false, wndInv)
	guiSetProperty(botUsar, "NormalTextColour", "FFAAAAAA")
	end
)
function colocarArmas(player)
	if isElement(player) then
		tablaArmas = {}
		local weaponSlots = {2,3,4,5,6,7,8,9}
		for i, slot in ipairs(weaponSlots) do
			local ammo = getPedTotalAmmo ( player, slot ) 
			if ( getPedWeapon ( player, slot ) ~= 0 ) then
				local weapon = getPedWeapon ( player, slot )
				local ammo = getPedTotalAmmo ( player, slot )
				if ammo ~= 0 then
					table.insert(tablaArmas, {weapon, ammo})
				end
			end
		end 
		for k, v in pairs(tablaArmas) do
			if v[1] > 0 then
				local row = guiGridListAddRow(gridObj)
				guiGridListSetItemText(gridObj, row, 1, getWeaponNameFromID(v[1]), false, false)
				guiGridListSetItemText(gridObj, row, 2, v[2], false, false)
			end
		end
	end
end
addEvent( 'Open:Inventory', true)
addEventHandler( 'Open:Inventory', getLocalPlayer(  ), 
	function(t,rr)
		if not localPlayer:getData("EnEdicion") then
			if rr == 'refresh' then
				Items.refresh(t)
				return 
			end
			if not guiGetVisible( wndInv ) then
				guiSetVisible( wndInv, true )
				showCursor( true )
				Items.refresh(t)
			else
				guiSetVisible( wndInv, not true )
				showCursor( not true )
			end
		end
	end
)
--localPlayer:setData('Items',false)
function Items.refresh(t)
	guiGridListClear( gridObj )
	if t then
		colocarArmas(localPlayer)
		for k,v in pairs(t) do
			local row = guiGridListAddRow( gridObj )
			guiGridListSetItemText( gridObj, row, 1, v.Item,false,false )
			guiGridListSetItemText( gridObj, row, 2,''..v.Value, false,false)
		end
	end
end
function Items.buttons(b)
	if (b ~= 'left') then return end
	if (source == botUsar) then
		local object,quantity = guiGridListGetItemText( gridObj, guiGridListGetSelectedItem( gridObj ), 1 ),guiGridListGetItemText( gridObj, guiGridListGetSelectedItem( gridObj ), 2 ) 
		if object ~= "" and quantity ~= "" then
			triggerServerEvent('Refresh:Inventory', localPlayer, object,quantity)
			setEnabled(botUsar, 2000)
			if object == 'Bidon de Gasolina' then
				guiSetVisible( wndInv, not true )
				showCursor( not true )
			end
		end
	elseif (source == botTirar) then
		local object,quantity = guiGridListGetItemText( gridObj, guiGridListGetSelectedItem( gridObj ), 1 ),guiGridListGetItemText( gridObj, guiGridListGetSelectedItem( gridObj ), 2 ) 
		if object ~= "" and quantity ~= "" then
			setEnabled(botTirar, 2000)
			triggerServerEvent('TiraItem:Inventory', localPlayer, object,quantity)
		end
	end
end
addEventHandler('onClientGUIClick',resourceRoot,Items.buttons)
addEventHandler("onClientRender", getRootElement(), function()
	for k, v in ipairs(getElementsByType("pickup")) do
		local pick = v:getData("pickup.infoshops") 
		if pick then
			tx, ty, tz = getElementPosition( v )
			local px, py, pz = getElementPosition(localPlayer)
			dist = math.sqrt( ( px - tx ) ^ 2 + ( py - ty ) ^ 2 + ( pz - tz ) ^ 2 )
			if dist < 8 then
				if isLineOfSightClear( px, py, pz, tx, ty, tz, true, false, false, true, false, false, false,localPlayer ) then
					local sx, sy, sz = getElementPosition( v )
					local x, y = getScreenFromWorldPosition( sx, sy, sz)
					if x and y then
						dxDrawBorderedText ("#FFFB89Usa la #ffffff'F' #FFFB89para interactuar", x-150, y+20, 200 + x-80, 40 + y-60, tocolor ( 255, 255, 255, 255 ),1, "default-bold","center", "center" )
						
						
					end
				end
			end
		end
	end
end)
--#FEF887Usa la tecla '#FFFFFFF#FFFFFF'#FEF887 para interactuar
function dxDrawBorderedText( text, x, y, w, h, color, scale, font, alignX, alignY, clip, wordBreak, postGUI )
	dxDrawText(text:gsub('#%x%x%x%x%x%x', ''), (x) - 1, (y) + 1, (w) - 1, (h) + 1, tocolor ( 0, 0, 0, 255 ), scale, font, alignX, alignY, clip, wordBreak, postGUI, true)
	dxDrawText(text:gsub('#%x%x%x%x%x%x', ''), (x) + 1, (y) + 1, (w) + 1, (h) + 1, tocolor ( 0, 0, 0, 255 ), scale, font, alignX, alignY, clip, wordBreak, postGUI, true)
	dxDrawText(text, x, y, w, h, color, scale, font, alignX, alignY, clip, wordBreak, postGUI, true)
end
--
local SonidoPlayer = {}
--
addEvent("SoundsPhone", true)
addEventHandler("SoundsPhone", root, function(tip, jugador)
	if tip == "LlamarSound" then
		s = Sound("sounds/LlamarSound.mp3", true)
		s:setVolume(0.50)
	elseif tip == "LlamadaSound" then
		local x, y, z = getElementPosition( jugador )
		SonidoPlayer[jugador] = Sound3D("sounds/LlamadaSound.mp3", x, y, z, true)
		attachElements( jugador, SonidoPlayer[jugador])
		SonidoPlayer[jugador]:setVolume(0.50)
		setSoundMaxDistance(SonidoPlayer[jugador], 10)
	elseif tip == "stopLlamada" then
		stopSound(s)
	elseif tip == "stopLlamado" then
		if SonidoPlayer[jugador] then
			stopSound(SonidoPlayer[jugador])
			SonidoPlayer[jugador] = nil
		end
	end
end)