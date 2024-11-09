
addEventHandler("onClientResourceStart", resourceRoot,
    function()
        Anunciadorawin = guiCreateWindow(0.33, 0.34, 0.40, 0.25, "Anuncios", true)
        guiWindowSetSizable(Anunciadorawin, false)
        Listanun = guiCreateComboBox(0.04, 0.48, 0.25, 0.49, "", true, Anunciadorawin)
        guiComboBoxAddItem(Listanun, "Anuncio-LS")
        guiComboBoxAddItem(Listanun, "Trabajo-LS")
        guiComboBoxAddItem(Listanun, "Venta-LS")
        guiComboBoxAddItem(Listanun, "Compra-LS")
        anunciome = guiCreateEdit(0.32, 0.48, 0.70, 0.13, "Texto a mostrar", true, Anunciadorawin)
        enviaranun = guiCreateButton(0.60, 0.85, 0.34, 0.09, "¡Enviar Anuncio (250)!", true, Anunciadorawin)
        guiSetFont(enviaranun, "default-bold-small")
        guiSetProperty(enviaranun, "NormalTextColour", "FFFFFFFF")
        cerrar = guiCreateButton(0.23, 0.85, 0.34, 0.09, "Cerrar panel", true, Anunciadorawin)
        guiSetFont(cerrar, "default-bold-small")
        guiSetProperty(cerrar, "NormalTextColour", "FFFFFFFF")
        costome = guiCreateLabel(0.05, 0.15, 1.99, 0.22, "No realices anuncios que podrian ser considerados ilegales. esto incumpliria la regla MA\nNecesitas un telefono celular para colocar un anuncio. Si no cuentas con uno tu telefono\nno se mostrara. Tambien deberas colocar tu edad si buscas trabajo.", true, Anunciadorawin)
        -- guiSetFont(ayuda, "default-bold-small")
        -- guiSetProperty(ayuda, "NormalTextColour", "FFFFFFFF")
		guiSetVisible(Anunciadorawin, false)
    end
)
--
addEventHandler("onClientResourceStart", resourceRoot,
    function()
        reglaswin = guiCreateWindow(0.04, 0.33, 0.28, 0.26, "Reglas", true)
        guiWindowSetSizable(reglaswin, false)
        reglas = guiCreateMemo(0.02, 0.10, 0.95, 0.83, 
"1. No se puede publicar anuncios rebuscado con el fín de encubrir cualquier tipo de actividad ilegal, como compra/venta de articulos ilegales, sicariatio, tráfico de personas,etc\n\n2.No se puede publicar sobre manifestaciones o disturbios. Deben de buscar personas por fuera del sistema de anuncios.\n\n3.No se puede publicar la venta de vehículos especificando que tienen algún articulo ilegal como por ejemplo el oxido nitroso, si desean vender un vehículo con dicho componente no lo coloquen en el anuncio.\n\n4.No se puede publicar anuncios como si fuera una forma de hacer un noticiero informativo, todos los anuncios deben incentivar un rol aceptado si o si.\n\n5.No se puede publicar anuncios con el fín de hacer de exponer una información de una persona, a su vez tampoco si es ilegal,legal,corrupto o cualquier tipo de situación en la que se vea involucrado.\n\n6.No se puede publicar anuncios sobre eventos en mitad de vía publica, para esto deben tener un permiso de manera IC.\n\n7.No se puede publicar anuncios sobre eventos en propiedades u locales privados, para esto debes pedir permiso del dueño de manera IC.\n\n8.Los eventos o juntas de personas para cualquier fin no ilegal están completamente permitidos, sin embargo si es una junta de exposición de vehículos no, para esto deben tener un permiso de manera IC.", true, reglaswin)
guiSetVisible(reglaswin, false)   
   end
)
--
addEventHandler("onClientGUIClick", resourceRoot, function()
    if source == cerrar then
        guiSetVisible(Anunciadorawin, false)
		guiSetVisible(reglaswin, false)
		guiSetInputEnabled(not guiGetInputEnabled())
	showCursor(false)
    -- elseif source == ayuda then
	if guiGetVisible(reglaswin) == true then
		guiSetVisible(reglaswin, false)
		showCursor(false)
	else
		guiSetVisible(reglaswin, true)
		showCursor(true)
	end	
	elseif source == enviaranun then
	local msg = guiGetText(anunciome)
	local text = guiGetText(Listanun)
	local ano = guiRadioButtonGetSelected(modoano)
	if msg ~= "" then
	if text ~= "" then
	triggerServerEvent("anuncioen",localPlayer,ano,text,msg)
	else
	outputChatBox("Debes poner un tema de anuncio",255,0,0,true)
	end
	else
	outputChatBox("Debes poner un algo que anunciar",255,0,0,true)
	end
    end
end)
addEvent("openanun", true)
addEventHandler("openanun", root, function()
	if guiGetVisible(Anunciadorawin) == true then
		guiSetVisible(Anunciadorawin, false)
		guiSetInputEnabled(not guiGetInputEnabled())
		showCursor(false)
	else
		guiSetVisible(Anunciadorawin, true)
		guiSetInputEnabled(not guiGetInputEnabled())
		showCursor(true)
	end	
end)
addEventHandler( "onClientRender", getRootElement(), 
	function()
		local x,y = getScreenFromWorldPosition(-2032.7354736328, -117.40480041504, 1035.171875, 0, true )
		local dist = getDistanceBetweenPoints3D(-2032.7354736328, -117.40480041504, 1035.171875, getElementPosition(localPlayer))
		local dimension = getElementDimension(localPlayer, 1)
		
		if x and dist <= 10 then
			
			if (getElementDimension ( localPlayer ) == 1) then
			x = x - (dxGetTextWidth( '/anuncio', 2-(dist/30)*2, "default-bold" )/2)
			
			dxDrawText('/anuncio', x-1, y-1, x+1, y+1, tocolor(0,0,0,255), 1.1-(dist/10), "default-bold","left","top",false,false,false,false,false)
			dxDrawText('/anuncio', x+1, y+1, x-1, y-1, tocolor(0,0,0,255), 1.1-(dist/10), "default-bold","left","top",false,false,false,false,false)
			dxDrawText('/anuncio', x, y, x, y, tocolor(255,84,840,255), 1.1-(dist/10), "default-bold","left","top",false,false,false,false,false)
		end
		end
	end
)
