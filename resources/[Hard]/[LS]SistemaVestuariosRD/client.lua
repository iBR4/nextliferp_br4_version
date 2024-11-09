--1275
local _skins = {
	[279] = true,
	[277] = true,
	[70] = true,
	[275] = true,
	[280] = true,
	[284] = true,
	[281] = true,
	[282] = true
}
local pickup = createPickup(430.14202880859, 156.47608947754, 1016.815612793, 3, 1275, 1)
setElementInterior( pickup, 3)
window = guiCreateWindow(0.36, 0.19, 0.27, 0.65, "Vestuario - Medicina - Bomberos", true)
guiWindowSetSizable(window, false)
guiSetVisible(window,false)
cerrar = guiCreateLabel( 0.80, 0.005, 0.20, 0.04, 'Cerrar', true, window )
guiSetFont(cerrar, "default-bold-small")
guiSetProperty(cerrar, "ClippedByParent", "False")
guiSetProperty(cerrar, "AlwaysOnTop", "True")
guiSetProperty(cerrar, "RiseOnClick", "False")
GuardarAspecto = guiCreateButton(0.50, 0.12, 0.47, 0.08, "Guardar aspecto", true, window)
TomarAspectoGuardado = guiCreateButton(0.50, 0.21, 0.47, 0.08, "Tomar aspecto guardado", true, window)
Listaparaskins = guiCreateGridList(0.04, 0.31, 0.46, 0.65, true, window)
guiGridListAddColumn(Listaparaskins, "Skins", 0.84)
TomarSkin = guiCreateButton(0.55, 0.69, 0.38, 0.15, "Tomar Skin", true, window)
addCommandHandler("vestuarios",
	function ()
		if localPlayer:getData("Roleplay:faccion") == "Medico" then
			if isPedWithinRange(430.14202880859, 156.47608947754, 1016.815612793,0.5,localPlayer) then
				guiSetVisible(window,true)
				showCursor(true)
				guiGridListClear( Listaparaskins )
					guiGridListSetItemData( Listaparaskins, guiGridListAddRow( Listaparaskins, 'Paramedico I' ), 1, '275' )
					guiGridListSetItemData( Listaparaskins, guiGridListAddRow( Listaparaskins, 'Paramedico II' ), 1, '274' )
					guiGridListSetItemData( Listaparaskins, guiGridListAddRow( Listaparaskins, 'Paramedico III' ), 1, '276' )
					guiGridListSetItemData( Listaparaskins, guiGridListAddRow( Listaparaskins, 'Paramedica' ), 1, '53' )	
					guiGridListSetItemData( Listaparaskins, guiGridListAddRow( Listaparaskins, 'Medico' ), 1, '70' )	
					guiGridListSetItemData( Listaparaskins, guiGridListAddRow( Listaparaskins, 'Bombero I' ), 1, '277' )		
					guiGridListSetItemData( Listaparaskins, guiGridListAddRow( Listaparaskins, 'Bombero II' ), 1, '279' )						
					guiGridListSetItemData( Listaparaskins, guiGridListAddRow( Listaparaskins, 'Bombero III' ), 1, '278' )						
			end
		end
	end
)
-- Medico ID : 70
-- Paramedico X1: 275
-- Paramedico X2: 276
addEventHandler( "onClientRender", getRootElement(), 
	function()
		local x,y = getScreenFromWorldPosition(430.22637939453, 156.48066711426, 1016.815612793, 0, true )
		local dist = getDistanceBetweenPoints3D( 430.22637939453, 156.48066711426, 1016.815612793, getElementPosition(localPlayer) )
		if x and dist <= 10 then
			x = x - (dxGetTextWidth( '/vestuarios', 2-(dist/30)*2, "default-bold" )/2)
			
			dxDrawText('/vestuarios', x-1, y-1, x+1, y+1, tocolor(0,0,0,255), 1.5-(dist/10), "default-bold","left","top",false,false,false,false,false)
			dxDrawText('/vestuarios', x+1, y+1, x-1, y-1, tocolor(0,0,0,255), 1.5-(dist/10), "default-bold","left","top",false,false,false,false,false)
			dxDrawText('/vestuarios', x, y, x, y, tocolor(255,0,0,255), 1.5-(dist/10), "default-bold","left","top",false,false,false,false,false)
		end
	end
)
addEventHandler( "onClientGUIClick", getRootElement(), 
	function(b,s)
		if b ~= 'left' or s ~= 'up' then
			return
		end
		if source == cerrar then
			guiSetVisible(window,false)
			showCursor(false)
		elseif source == TomarSkin then
			if not mySkin then
				return
			end
			local id = tonumber(guiGridListGetItemData( Listaparaskins, guiGridListGetSelectedItem( Listaparaskins ), 1 )) or false
			if id then
				triggerServerEvent('VestuarioMedi',localPlayer, 'Colocar', id)
			end
		elseif source == GuardarAspecto then
			if _skins[localPlayer:getModel()] then
			else
				mySkin = localPlayer:getModel()
				triggerServerEvent('VestuarioMedi',localPlayer, 'Guardar', localPlayer:getModel())
			end
		elseif source == TomarAspectoGuardado then
			if mySkin then
				triggerServerEvent('VestuarioMedi',localPlayer, 'Tomar', mySkin)
			end
		end
	end
)
addEvent('refresh:MySkin', true)
addEventHandler('refresh:MySkin',localPlayer,
	function(id)
		mySkin = id
	end
)
function isPedWithinRange(x,y,z,range,ped)
	for _, type in ipairs({'player','ped'}) do
		for k,v in pairs(getElementsWithinRange(x,y,z,range, type)) do
			if v == ped then
				return true
			end
		end
	end
	return false;
end
