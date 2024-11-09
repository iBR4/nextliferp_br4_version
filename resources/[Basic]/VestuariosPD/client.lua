--1275
local _skins = {
	[285] = true,
	[286] = true,
	[287] = true,
	[71] = true,
	[205] = true,
	[280] = true,
	[284] = true,
	[281] = true,
	[282] = true
}
local pickup = createPickup( 1578.8591308594, -1687.5872802734, 16.1953125, 3, 1275, 1)
local pickupa = createPickup( 1586.5009765625, -1690.193359375, 16.1953125, 3, 1264, 1)
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
guiCreateLabel( 0.20, 0.06, 0.70, 0.04, 'Este es el menu del cambiador de LSPD', true, window )
guiCreateLabel( 0.10, 0.10, 1.00, 0.04, 'En el puedes guardar tu ropa actual y colocarte la', true, window )
guiCreateLabel( 0.30, 0.15, 1.00, 0.04, '     Ropa de servicio.', true, window )
GuardarAspecto = guiCreateButton(0.55, 0.21, 0.47, 0.08, "Guardar tu ropa.", true, window)
TomarAspectoGuardado = guiCreateButton(0.55, 0.31, 0.47, 0.08, "Recoger tu ropa.", true, window)
Listaparaskins = guiCreateGridList(0.03, 0.20, 0.50, 0.90, true, window)
guiGridListAddColumn(Listaparaskins, "Skins", 0.84)
TomarSkin = guiCreateButton(0.55, 0.69, 0.47, 0.08, "Cambiar a...", true, window)
agaga = guiCreateButton(0.55, 0.79, 0.47, 0.08, "Recoger Placa", true, window)
function borrarArmasPD()
    if getLocalPlayer(  ) then
        local x1, y1, z1 = getElementPosition(getLocalPlayer())
        local x2, y2, z2 = 1586.5009765625, -1690.193359375, 16.1953125
        local distanceBetweenPoints = getDistanceBetweenPoints3D(x1, y1, z1, x2, y2, z2)
        if(distanceBetweenPoints < 2) then
            triggerServerEvent( "borrarBasuraPD", localPlayer, localPlayer )
        end
    end
end
addCommandHandler("basurapd", borrarArmasPD)
addCommandHandler("policia",
	function ()
		if localPlayer:getData("Roleplay:faccion") == "Policia" then
			if isPedWithinRange(1578.8591308594, -1687.5872802734, 16.1953125,0.4,localPlayer) then
				guiSetVisible(window,true)
				showCursor(true)
				guiGridListClear( Listaparaskins )
				if localPlayer:getData('Roleplay:faccion_division') == 'S.W.A.T' then
					guiGridListSetItemData( Listaparaskins, guiGridListAddRow( Listaparaskins, 'SWAT MUJER 1' ), 1, '40' )
					guiGridListSetItemData( Listaparaskins, guiGridListAddRow( Listaparaskins, 'SWAT MUJER 2' ), 1, '48' )
					guiGridListSetItemData( Listaparaskins, guiGridListAddRow( Listaparaskins, 'SWAT MUJER 3' ), 1, '13' )
					guiGridListSetItemData( Listaparaskins, guiGridListAddRow( Listaparaskins, 'SWAT HOMBRE 1' ), 1, '285' )
					guiGridListSetItemData( Listaparaskins, guiGridListAddRow( Listaparaskins, 'SWAT HOMBRE 2' ), 1, '286' )
					guiGridListSetItemData( Listaparaskins, guiGridListAddRow( Listaparaskins, 'SWAT HOMBRE 3' ), 1, '287' )
					guiGridListSetItemData( Listaparaskins, guiGridListAddRow( Listaparaskins, 'OFICIAL HOMBRE 1' ), 1, '280' )
					guiGridListSetItemData( Listaparaskins, guiGridListAddRow( Listaparaskins, 'OFICIAL HOMBRE 2' ), 1, '281' )
					guiGridListSetItemData( Listaparaskins, guiGridListAddRow( Listaparaskins, 'OFICIAL HOMBRE 3' ), 1, '282' )
					guiGridListSetItemData( Listaparaskins, guiGridListAddRow( Listaparaskins, 'OFICIAL MUJER 1' ), 1, '16' )
					guiGridListSetItemData( Listaparaskins, guiGridListAddRow( Listaparaskins, 'OFICIAL MUJER 2' ), 1, '15' )
					guiGridListSetItemData( Listaparaskins, guiGridListAddRow( Listaparaskins, 'OFICIAL MUJER 3' ), 1, '14' )
				elseif localPlayer:getData('Roleplay:faccion_division') == 'INTELIGENCIA' then
					guiGridListSetItemData( Listaparaskins, guiGridListAddRow( Listaparaskins, 'Oficial Hombre 1' ), 1, '280' )
					guiGridListSetItemData( Listaparaskins, guiGridListAddRow( Listaparaskins, 'Oficial Hombre 2' ), 1, '281' )
					guiGridListSetItemData( Listaparaskins, guiGridListAddRow( Listaparaskins, 'Oficial Hombre 3' ), 1, '282' )
					guiGridListSetItemData( Listaparaskins, guiGridListAddRow( Listaparaskins, 'Oficial Mujer 1' ), 1, '16' )
					guiGridListSetItemData( Listaparaskins, guiGridListAddRow( Listaparaskins, 'Oficial Mujer 2' ), 1, '15' )
					guiGridListSetItemData( Listaparaskins, guiGridListAddRow( Listaparaskins, 'Oficial Mujer 3' ), 1, '14' )
				else
					if localPlayer:getData('Roleplay:faccion_rango') == 'Cadete' then	
						guiGridListSetItemData( Listaparaskins, guiGridListAddRow( Listaparaskins, 'Cadete Hombre' ), 1, '71' )
						guiGridListSetItemData( Listaparaskins, guiGridListAddRow( Listaparaskins, 'Cadete Mujer' ), 1, '245' )
					elseif localPlayer:getData('Roleplay:faccion_rango') == 'Oficial I' then
					guiGridListSetItemData( Listaparaskins, guiGridListAddRow( Listaparaskins, 'Oficial Hombre 1' ), 1, '280' )
					guiGridListSetItemData( Listaparaskins, guiGridListAddRow( Listaparaskins, 'Oficial Hombre 2' ), 1, '281' )
					guiGridListSetItemData( Listaparaskins, guiGridListAddRow( Listaparaskins, 'Oficial Hombre 3' ), 1, '282' )
					guiGridListSetItemData( Listaparaskins, guiGridListAddRow( Listaparaskins, 'Oficial Mujer 1' ), 1, '211' )
					elseif localPlayer:getData('Roleplay:faccion_rango') == 'Oficial II' or localPlayer:getData('Roleplay:faccion_rango') == 'Oficial III' or localPlayer:getData('Roleplay:faccion_rango') == 'Oficial III+' or localPlayer:getData('Roleplay:faccion_rango') == 'Sargento I' or localPlayer:getData('Roleplay:faccion_rango') == 'Sargento II' or localPlayer:getData('Roleplay:faccion_rango') == 'Teniente' or localPlayer:getData('Roleplay:faccion_rango') == 'Capitan' or localPlayer:getData('Roleplay:faccion_rango') == 'Camandante' then
					
					guiGridListSetItemData( Listaparaskins, guiGridListAddRow( Listaparaskins, 'Oficial Hombre 1' ), 1, '280' )
					guiGridListSetItemData( Listaparaskins, guiGridListAddRow( Listaparaskins, 'Oficial Hombre 2' ), 1, '281' )
					guiGridListSetItemData( Listaparaskins, guiGridListAddRow( Listaparaskins, 'Oficial Hombre 3' ), 1, '282' )
					guiGridListSetItemData( Listaparaskins, guiGridListAddRow( Listaparaskins, 'Oficial Mujer 1' ), 1, '211' )
					guiGridListSetItemData( Listaparaskins, guiGridListAddRow( Listaparaskins, 'Oficial Mujer 2' ), 1, '298' )
					guiGridListSetItemData( Listaparaskins, guiGridListAddRow( Listaparaskins, 'Oficial Mujer 3' ), 1, '190' )
					elseif localPlayer:getData('Roleplay:faccion_rango') == 'Camandante' or localPlayer:getData('Roleplay:faccion_rango') == 'Jefe de Policia' then
					
					guiGridListSetItemData( Listaparaskins, guiGridListAddRow( Listaparaskins, 'Oficial Hombre 1' ), 1, '280' )
					guiGridListSetItemData( Listaparaskins, guiGridListAddRow( Listaparaskins, 'Oficial Hombre 2' ), 1, '281' )
					guiGridListSetItemData( Listaparaskins, guiGridListAddRow( Listaparaskins, 'Oficial Hombre 3' ), 1, '282' )
					guiGridListSetItemData( Listaparaskins, guiGridListAddRow( Listaparaskins, 'Oficial Hombre 4' ), 1, '20017' )
					
					guiGridListSetItemData( Listaparaskins, guiGridListAddRow( Listaparaskins, 'Oficial Mujer 1' ), 1, '211' )
					guiGridListSetItemData( Listaparaskins, guiGridListAddRow( Listaparaskins, 'Oficial Mujer 2' ), 1, '298' )
					guiGridListSetItemData( Listaparaskins, guiGridListAddRow( Listaparaskins, 'Oficial Mujer 3' ), 1, '190' )
					
					end
				end
			end
		end
	end
)
addEventHandler("onClientRender", getRootElement(),
    function()
        local x, y = getScreenFromWorldPosition(1578.8591308594, -1687.5872802734, 16.1953125, 0, true)
        local dist = getDistanceBetweenPoints3D(1578.8591308594, -1687.5872802734, 16.1953125, getElementPosition(localPlayer))
        
        -- Obtener las coordenadas de pantalla para la segunda ubicación
        local aa, ad = getScreenFromWorldPosition(1586.5009765625, -1690.193359375, 16.1953125, 0, true)
        local dista = getDistanceBetweenPoints3D(1586.5009765625, -1690.193359375, 16.1953125, getElementPosition(localPlayer))
        
        -- Verificar si aa y ad son valores válidos antes de usarlos
        if x and aa and dist <= 10 then
            x = x - (dxGetTextWidth('/vestuarios', 2 - (dist / 30) * 2, "default-bold") / 2)
            dxDrawText('/policia', x - 1, y - 1, x + 1, y + 1, tocolor(0, 0, 0, 255), 1.2 - (dist / 10), "default-bold", "left", "top", false, false, false, false, false)
            dxDrawText('/policia', x + 1, y + 1, x - 1, y - 1, tocolor(0, 0, 0, 255), 1.2 - (dist / 10), "default-bold", "left", "top", false, false, false, false, false)
            dxDrawText('/policia', x, y, x, y, tocolor(2, 172, 240, 255), 1.2 - (dist / 10), "default-bold", "left", "top", false, false, false, false, false)
            dxDrawText('/basurapd', aa - 1, ad - 1, aa + 1, ad + 1, tocolor(0, 0, 0, 255), 1.5 - (dista / 25), "default-bold", "left", "top", false, false, false, false, false)
            dxDrawText('/basurapd', aa + 1, ad + 1, aa - 1, ad - 1, tocolor(0, 0, 0, 255), 1.5 - (dista / 25), "default-bold", "left", "top", false, false, false, false, false)
            dxDrawText('/basurapd', aa, ad, aa, ad, tocolor(234, 0, 0, 255), 1.5 - (dista / 25), "default-bold", "left", "top", false, false, false, false, false)
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
