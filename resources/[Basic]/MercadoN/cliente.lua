
guns = {
{22,2000},
{24,5000},
{28,4500},
{25,3000},
{30,15000},	
}


guiWdw = guiCreateWindow ( 379, 208, 602, 370, "Mercado Negro", false )
gunList = guiCreateGridList ( 0.05, 0.05, 0.3, 0.9, true, guiWdw )
colGun = guiGridListAddColumn( gunList, "Arma", 0.4 )
colCost = guiGridListAddColumn( gunList, "Costo x Carg.", 0.5 )
btnDiscard = guiCreateButton(0.4, 0.8, 0.15, 0.15, "Descartar", true, guiWdw)
btnClose = guiCreateButton(0.6, 0.8, 0.15, 0.15, "Cerrar", true, guiWdw)
btnBuy = guiCreateButton(0.8, 0.8, 0.15, 0.15, "Comprar", true, guiWdw)
btnAdd = guiCreateButton(0.8, 0.1, 0.15, 0.1, "Meter al carrito", true, guiWdw)
editAmount = guiCreateEdit (0.4, 0.1, 0.35, 0.1, "Pon aqui la cantidad de cargadores", true, guiWdw)
guiWindowSetSizable( guiWdw, false)
guiSetVisible(guiWdw, false)


cart = guiCreateGridList ( 0.4, 0.25, 0.55, 0.5, true, guiWdw )
colOrdGun = guiGridListAddColumn( cart, "Arma", 0.25 )
colOrdAmmo = guiGridListAddColumn( cart, "Cargadores", 0.33 )
colOrdCost = guiGridListAddColumn( cart, "Costo total", 0.33 )

addEvent("vermercadon",true)
addEventHandler("vermercadon",root,function()
	guiSetVisible(guiWdw, true)
	showCursor(true)
	guiGridListClear( gunList )
	for p,v in ipairs(guns) do
		local row = guiGridListAddRow ( gunList )
		guiGridListSetItemText ( gunList, row, colGun,  getWeaponNameFromID(v[1]), false, false )
		guiGridListSetItemText ( gunList, row, colCost, "$"..v[2], false, false )
		--
		guiGridListSetItemData ( gunList, row, 2, v[2] )
	end
end)

addEventHandler("onClientGUIClick",resourceRoot,function()
	local gunName = guiGridListGetItemText ( gunList, guiGridListGetSelectedItem( gunList ), 1 )
	local cost = guiGridListGetItemData( gunList, guiGridListGetSelectedItem ( gunList ), 2 )
	if source == btnClose then
		guiSetText ( editAmount, "Pon aqui la cantidad de cargadores" )
		guiSetVisible(guiWdw, false)
		showCursor(false)
	elseif source == btnAdd then
		local ammo = guiGetText(editAmount)
		if ammo ~= "" or ammo ~= "Pon aqui la cantidad de balas" then
			if tonumber(ammo) then
				if tonumber(ammo) >= 1 then
					if gunName ~= "" then
						local costo = tonumber(ammo) * tonumber(cost)
						guiSetText ( editAmount, "" )
						local row = guiGridListAddRow ( cart )
						guiGridListSetItemText ( cart, row, colOrdGun, gunName, false, false )
						guiGridListSetItemText ( cart, row, colOrdAmmo,"   "..ammo, false, false )
						guiGridListSetItemText ( cart, row, colOrdCost,"  $"..costo, false, false )

						guiGridListSetItemData ( cart, row, 2, ammo )
						guiGridListSetItemData ( cart, row, 3, costo )
					else
						outputChatBox("[ERROR] Selecciona un arma primero",255,50,50,true)
					end
				else
					outputChatBox("[ERROR] Pon una cantidad de balas",255,50,50,true)
				end
			else
				outputChatBox("[ERROR] Pon una cantidad de balas",255,50,50,true)
			end
		else
			outputChatBox("[ERROR] Pon una cantidad de balas",255,50,50,true)
		end
	elseif source == btnBuy then
		local rowCount = guiGridListGetRowCount ( cart )
		local ordCost = 0
		for i=0,rowCount-1 do
			ordCost = ordCost + guiGridListGetItemData( cart, i, 3 )
		end
		local playerMoney = getPlayerMoney()
		if playerMoney < ordCost then
			outputChatBox( "[NPC] !No puedes pagar eso! Necesitas $"..ordCost,255,50,50,true)
		else
			if cart ~= "" then
				guiSetText( editAmount, "" )
				local ID = math.random(10000,99999)
				outputChatBox("Tu pedido #ee0000#"..ID.." #FFFFFFa sido ordenado pon #ee0000/pedidos #FFFFFFpara verlo",255,255,255,true)
				for i=0,rowCount-1 do
					local ordGunName = guiGridListGetItemText ( cart, 0, 1 )
					local ordGunAmmo = guiGridListGetItemData ( cart, 0, 2 )
					local ordGunCost = guiGridListGetItemData ( cart, 0, 3 )
					triggerServerEvent( "onClientGiveWeapon", getLocalPlayer(), ordGunName, ordGunAmmo, ordGunCost, ID)
					guiGridListRemoveRow(cart,0)
				end
			else
				outputChatBox("[ERROR] No hay nada en el carrito",255,50,50,true)
			end
		end
	elseif source == btnDiscard then
		local dat = guiGridListGetItemText ( cart, guiGridListGetSelectedItem( cart ), 1 )
		if dat ~= "" then 
			local ar,ac = guiGridListGetSelectedItem(cart)
			guiGridListRemoveRow ( cart, ar )
		else
			outputChatBox("[ERROR] Selecciona un arma primero",255,50,50,true)
		end
	end
end)


addEventHandler("onClientRender", getRootElement(), function()
	local playerX, playerY, playerZ = 2351.4404296875, -653.3505859375, 128.0546875
	local sx, sy = getScreenFromWorldPosition(playerX, playerY, playerZ + 0.5)
	if sx and sy then
		local playerX2, playerY2, playerZ2 = getElementPosition ( localPlayer )
		local cx, cy, cz = getCameraMatrix()
		local distance = getDistanceBetweenPoints3D(playerX2, playerY2, playerZ2, playerX, playerY, playerZ + 0.5)
		if distance < 20 then
			dxDrawBorderedText3 ( "Aquí puedes obtener el pedido tuyo \nUsa #00FF00/pedido [N.Pedido]", sx, sy, sx, sy , tocolor ( 255, 255, 255, 255 ),1, "default-bold","center", "center" ) 
		end
	end
end)

function dxDrawBorderedText3( text, x, y, w, h, color, scale, font, alignX, alignY, clip, wordBreak, postGUI )
	dxDrawText(text:gsub('#%x%x%x%x%x%x', ''), (x) + 1, (y) + 1, (w) + 1, (h) + 1, tocolor ( 0, 0, 0, 255 ), scale, font, alignX, alignY, clip, wordBreak, postGUI, true)
	dxDrawText(text, x, y, w, h, color, scale, font, alignX, alignY, clip, wordBreak, postGUI, true)
end

