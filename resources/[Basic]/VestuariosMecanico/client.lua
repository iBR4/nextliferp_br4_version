--1275
local _skins = {
	[50] = true,
	[305] = true,
	[268] = true,
}
local pickup = createPickup( 2527.0793457031, -1536.5633544922, 24.54062461853, 3, 1275, 1)
local pickupa = createPickup( 2527.0793457031, -1536.5633544922, 24.54062461853, 3, 1275, 1)
setElementInterior( pickup, 0)
setElementInterior( pickupa, 0)
window = guiCreateWindow(0.37, 0.25, 0.23, 0.49, "Cambiador", true)
guiWindowSetSizable(window, false)
guiSetVisible(window,false)
guiSetProperty(window, "CaptionColour", "FE0B1CF7")
cerrar = guiCreateButton(0.55, 0.90, 0.47, 0.08, "Salir", true, window)
guiSetFont(cerrar, "sa-header")
guiSetProperty(cerrar, "ClippedByParent", "False")
guiSetProperty(cerrar, "AlwaysOnTop", "True")
guiSetProperty(cerrar, "RiseOnClick", "False")
guiCreateLabel( 0.20, 0.06, 0.70, 0.04, 'Este es el menu del cambiador de Mecanicos', true, window )
guiCreateLabel( 0.10, 0.10, 1.00, 0.04, 'En el puedes guardar tu ropa actual y colocarte la', true, window )
guiCreateLabel( 0.30, 0.15, 1.00, 0.04, '     Ropa de servicio.', true, window )
GuardarAspecto = guiCreateButton(0.55, 0.21, 0.47, 0.08, "Guardar tu ropa.", true, window)
TomarAspectoGuardado = guiCreateButton(0.55, 0.31, 0.47, 0.08, "Recoger tu ropa.", true, window)
Listaparaskins = guiCreateGridList(0.03, 0.20, 0.50, 0.90, true, window)
guiGridListAddColumn(Listaparaskins, "Skins", 0.84)
TomarSkin = guiCreateButton(0.55, 0.69, 0.47, 0.08, "Cambiar a...", true, window)
addCommandHandler("mecanico",
	function ()
		if localPlayer:getData("Roleplay:faccion") == "Mecanico" then
			if isPedWithinRange(2527.0793457031, -1536.5633544922, 24.54062461853,0.1,localPlayer) then
				guiSetVisible(window,true)
				showCursor(true)
				guiGridListClear( Listaparaskins )
				guiGridListSetItemData( Listaparaskins, guiGridListAddRow( Listaparaskins, 'Mecanico' ), 1, '50' )
				guiGridListSetItemData( Listaparaskins, guiGridListAddRow( Listaparaskins, 'Mecanico-2' ), 1, '305' )
				guiGridListSetItemData( Listaparaskins, guiGridListAddRow( Listaparaskins, 'Mecanico-3' ), 1, '268' )
		
			end
		end
	end
)
addEventHandler( "onClientRender", getRootElement(), 
	function()
		local x,y = getScreenFromWorldPosition(2527.0793457031, -1536.5633544922, 24.54062461853, 0, true )
		local dist = getDistanceBetweenPoints3D( 2527.0793457031, -1536.5633544922, 24.54062461853, getElementPosition(localPlayer) )
		local dista = getDistanceBetweenPoints3D( 2527.0793457031, -1536.5633544922, 24.54062461853, getElementPosition(localPlayer) )
		if x and dist <= 10 then
			x = x - (dxGetTextWidth( '/vestuarios', 2-(dist/30)*2, "default-bold" )/2)
			
			dxDrawText('/mecanico', x-1, y-1, x+1, y+1, tocolor(0,0,0,255), 1.2-(dist/10), "default-bold","left","top",false,false,false,false,false)
			dxDrawText('/mecanico', x+1, y+1, x-1, y-1, tocolor(0,0,0,255), 1.2-(dist/10), "default-bold","left","top",false,false,false,false,false)
			dxDrawText('/mecanico', x, y, x, y, tocolor(2,172,240,255), 1.2-(dist/10), "default-bold","left","top",false,false,false,false,false)
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
				triggerServerEvent('VestuarioPoli',localPlayer, 'Colocar', id)
			end
		elseif source == GuardarAspecto then
			if _skins[localPlayer:getModel()] then
			else
				mySkin = localPlayer:getModel()
				triggerServerEvent('VestuarioPoli',localPlayer, 'Guardar', localPlayer:getModel())
			end
		elseif source == TomarAspectoGuardado then
			if mySkin then
				triggerServerEvent('VestuarioPoli',localPlayer, 'Tomar', mySkin)
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
