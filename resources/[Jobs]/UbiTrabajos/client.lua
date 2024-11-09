gps_panel = { button = {}, window = {}, memo = {}, label = {}, gridlist = {}, column = {}, image_back = {} }
section_type = nil

function centerWindow ( center_window )
	local sx, sy = guiGetScreenSize ( )
	local windowW, windowH = guiGetSize ( center_window, false )
	local x, y = ( sx - windowW ) / 2, ( sy - windowH ) / 2
	guiSetPosition ( center_window, x, y, false )
end

-------------------------------------------- 1 окно
gps_panel.window[1] = guiCreateWindow(0.33, 0.27, 0.34, 0.38, "Centro de trabajos", true)
centerWindow(gps_panel.window[1])
guiSetVisible(gps_panel.window[1],false)
guiWindowSetSizable(gps_panel.window[1], true)

        Frase1 = guiCreateLabel(195, 28, 89, 24, "¡Bienvenido!", false, gps_panel.window[1])
        Frase2 = guiCreateLabel(154, 52, 172, 20, "Este es el centro de trabajos", false, gps_panel.window[1])
        Frase3 = guiCreateLabel(80, 67, 368, 15, "¡Aqui podras encontrar todas las ubicaciones de los trabajos!", false, gps_panel.window[1])

--gps = guiCreateStaticImage(40, 140, 330, 220, "gps.png", false, gps_panel.window[1])

        gps_panel.button[1] = guiCreateButton(70, 134, 342, 39, "TRABAJOS", false, gps_panel.window[1])
        guiSetFont(gps_panel.button[1], "default-bold-small")
        guiSetProperty(gps_panel.button[1], "NormalTextColour", "FF06EB01")

        Frase4 = guiCreateLabel(17, 107, 547, 17, "¡Haz click en el boton debajo, alli encontraras todas las ubicaciones en la ciudad!", false, gps_panel.window[1])

        gps_panel.button[8] = guiCreateButton(14, 252, 441, 30, "CERRAR", false, gps_panel.window[1])
        guiSetProperty(gps_panel.button[8], "NormalTextColour", "FFED0000")  

-------------------------------------------- 2 окно

gps_panel.window[2] = guiCreateWindow(0, 0, 400, 385, "Informacion sobre lugares", false)
centerWindow(gps_panel.window[2])
guiSetVisible(gps_panel.window[2],false)

gps_panel.gridlist[1] = guiCreateGridList(0.03, 0.15, 0.94, 0.45, true, gps_panel.window[2])
gps_panel.column[1] = guiGridListAddColumn(gps_panel.gridlist[1], "Elige tu destino", 0.9)
gps_panel.label[1] = guiCreateLabel(0.03, 0.07, 0.9, 0.12, "Puedes hacer doble click al destino para marcarlo.", true, gps_panel.window[2])
guiSetFont(gps_panel.label[1], "default-bold-small")
guiLabelSetHorizontalAlign(gps_panel.label[1], "center", false)
gps_panel.label[2] = guiCreateLabel(0.25, 0.61, 0.5, 0.12, "Descripcion sobre el lugar:", true, gps_panel.window[2])
guiSetFont(gps_panel.label[2], "default-bold-small")
guiLabelSetHorizontalAlign(gps_panel.label[2], "center", false)
gps_panel.memo[1] = guiCreateMemo(0.03, 0.67, 0.94, 0.21, "", true, gps_panel.window[2])
gps_panel.button[7] = guiCreateButton(0.03, 0.9, 0.45, 0.1, "Marcar destino", true, gps_panel.window[2])
guiSetProperty(gps_panel.button[7], "NormalTextColour", "FF06EB01")
gps_panel.button[15] = guiCreateButton(0.50, 0.9, 0.94, 0.1, "CERRAR", true, gps_panel.window[2])
guiSetProperty(gps_panel.button[15], "NormalTextColour", "FFED0000")
    
	--Название,x,y,z,информация
local marker_table = {
    ["vehicle"] = {
        {"Trabajo de Colectivero",1766.9105224609, -1903.4868164062, 13.56674861908,"Este trabajo cuenta con sistema de niveles, cada parada que hagas aumentara tu experiencia asi aumentando tu nivel laboral y mejorando una mejor paga, trata de subirte en un colectivo y pasar por distintas paradas para subir pasajeros."},
		{"Trabajo de Minero",1692.8028564453, -1947.3489990234, 8.2486572265625,"Este trabajo cuenta con sistema de niveles, cada piedra que mines aumentara tu experiencia asi aumentando tu nivel laboral y mejorando una mejor paga, En este trabajo tendras que minar, asi conseguiras materiales que puedes vender a NPC´S o Usuarios, tambien con estos podras procesarlos y crear armas en una fabrica oculta."},
		{"Trabajo de Taxista",1219.8073730469, -1814.4948730469, 16.59375,"Este trabajo podras usarlo a partir de Nivel 5 Ya que tiene una buena paga, Podras trabajar con NPC´S Realizando viajes que aumentaran tu nivel y paga, tambien podras trabajar con usuarios usando /taxi para enviar un anuncio universal."},
		{"Trabajo de Pizzero",2096.7297363281, -1788.8310546875, 13.553622245789,"Este trabajo tendras que repartir pizzas en una moto, cada vez que repartas mayor sera tu nivel asi aumentando tu pago."},
        {"Trabajo de Basurero",2169.4191894531, -1973.3009033203, 13.554850578308,"Este trabajo trata de recojer la basura en un camion, en algunas paradas podras encontrar materiales de minero, los cuales podras usar para crear armas o venderlos a NPC´S o usuarios, tambien recibiras una paga por basura recogida y aumentaras tu nivel asi aumentando tu paga."},
		{"Trabajo de Carnicero",2501.9714355469, -1494.7888183594, 24,"Este trabajo trata de carnear animales muertos, estos los procesaras y los enviaras embalados a una empresa externa."},
        {"Trabajo de Carpintero",2407.4128417969, -1311.1063232422, 25.187074661255,"En este trabajo tendras que tomar maderas, tranformarlas en sillas, mesas y venderlas, por cada objeto que fabriques subiras tu nivel y tu paga."},
		{"Trabajo de Camionero",2216.13671875, -2661.4777832031, 13.547953605652,"Este trabajo trata de manejar camiones, tienen varios niveles, mientras mas viajes mas subiras de nivel y mayor sera su paga."},
		{"Trabajo de Jardinero",-382.20120239258, -1447.6785888672, 25.7265625,"Este trabajo trata de manejar Cosechadores, tienen varios niveles, mientras mas coseches mas subiras de nivel y mayor sera su paga."},
		{"Trabajo de Ladron",1553.8634033203, -1675.7416992188, 16.1953125,"Este trabajo esta oculto ya que es ilegal, tendras que encontrarlo investigando el mapa, con este trabajo podras robar tiendas, pero ojo con la Policia."},
	},
}

addEvent("setPanelTrabajos", true)
addEventHandler("setPanelTrabajos", root, function()
	    if guiGetVisible(gps_panel.window[2]) == true then
		    guiSetVisible(gps_panel.window[2],false)
			showCursor(false)
			return
		end
	    local state = not guiGetVisible(gps_panel.window[1])
	    guiSetVisible(gps_panel.window[1],state)
		showCursor(state)
		guiSetText(gps_panel.memo[1],"")
	end
)

addEventHandler("onClientGUIClick",getRootElement(),
    function ()
	    if source == gps_panel.button[1] then
		    upgateGridList ("vehicle")
		elseif source == gps_panel.button[2] then
		    upgateGridList ("place")
		elseif source == gps_panel.button[3] then
		    upgateGridList ("jobs")
		elseif source == gps_panel.button[4] then
		    upgateGridList ("Miscellaneous")
		elseif source == gps_panel.button[7] then
		    local item = guiGridListGetItemText(gps_panel.gridlist[1], guiGridListGetSelectedItem(gps_panel.gridlist[1]), 1)
			if not item or item == "" then outputChatBox("#1E90FF[GPS] #FFFFFFSelecciona tu destino.",255,255,255,true) return end
			for i, v in ipairs (marker_table[section_type]) do
			    if v[1] == item then
				    x,y,z = v[2],v[3],v[4]
				end
			end
			outputChatBox("#1E90FF[GPS] #FFFFFFMarcaste correctamente tu destino, llamado #00FF00"..item..".",255,255,255,true)
		    createMarkerBlipOnMap (x,y,z)
			guiSetVisible(gps_panel.window[2],false)
			guiSetVisible(gps_panel.window[1],false)
			showCursor(false)
			section_type = nil
		elseif source == gps_panel.button[15] then
		    local state = not guiGetVisible(gps_panel.window[2])
	        guiSetVisible(gps_panel.window[2],state)
		    showCursor(state)
		elseif source == gps_panel.button[8] then
		    local state = not guiGetVisible(gps_panel.window[1])
	        guiSetVisible(gps_panel.window[1],state)
		    showCursor(state)
		elseif source == gps_panel.button[9] then
		    if isElement (markGps) then
		        col = getElementData(markGps,"mark_gps")
		        if col then
		            destroyElement(markGps)
			        destroyElement(col)
		        end
                outputChatBox("#1E90FF[GPS] #FFFFFFDestino eliminado con exito.",255,255,255,true)
			else
                outputChatBox("#1E90FF[GPS] #FFFFFFDestino no configurado.",255,255,255,true)
            end	
		elseif source == gps_panel.gridlist[1] then
		    local item = guiGridListGetItemText(gps_panel.gridlist[1], guiGridListGetSelectedItem(gps_panel.gridlist[1]), 1)
			for i, v in ipairs (marker_table[section_type]) do
			    if v[1] == item then
				    guiSetText(gps_panel.memo[1],v[5])
				end
			end
		end
	end
)

addEventHandler("onClientGUIDoubleClick",getRootElement(),
    function ()
	    local item = guiGridListGetItemText(gps_panel.gridlist[1], guiGridListGetSelectedItem(gps_panel.gridlist[1]), 1)
        if not item or item == "" then return end
		for i, v in ipairs (marker_table[section_type]) do
			if v[1] == item then
			    x,y,z = v[2],v[3],v[4]
			end
		end
		outputChatBox("#1E90FF[GPS] #FFFFFFMarcaste correctamente tu destino, llamado #00FF00"..item..".",255,255,255,true)
		createMarkerBlipOnMap (x,y,z)
	    guiSetVisible(gps_panel.window[2],false)
		guiSetVisible(gps_panel.window[1],false)
		showCursor(false)
		section_type = nil
	end
)

function upgateGridList (section)
    section_type = section
    guiGridListClear(gps_panel.gridlist[1])
    for i, v in ipairs (marker_table[section]) do
	    local row = guiGridListAddRow(gps_panel.gridlist[1])
		guiGridListSetItemText ( gps_panel.gridlist[1], row, gps_panel.column[1], v[1], false, false )
	end
	guiSetVisible(gps_panel.window[2],true)
	guiSetVisible(gps_panel.window[1],false)
end

function createMarkerBlipOnMap (posX,posY,posZ)
    if isElement (markGps) then
		col = getElementData(markGps,"mark_gps")
		if col then
		    destroyElement(markGps)
			destroyElement(col)
		end
    end
    local markGps = createMarker(posX, posY, posZ, "checkpoint", 4, 0, 255, 0, 255)
	local blip = createBlip(posX,posY,posZ,41,4)
	setElementData(markGps,"mark_gps",blip)
	addEventHandler("onClientMarkerHit",getRootElement(),
	    function ()
		    if source == markGps then
			    local col = getElementData(source,"mark_gps")
				if isElementWithinMarker(getLocalPlayer(),source) then
				    outputChatBox("#1E90FF[GPS] #FFFFFFLlegaste a tu destino, eliminaremos el blip.",255,255,255,true)
					destroyElement(source)
					destroyElement(col)
				end
			end
		end
	)
end

addEventHandler( "onClientRender", getRootElement(), 

	function()

		local x,y = getScreenFromWorldPosition(-2032.8400878906, -117, 1035.171875, 0, true )

		local dist = getDistanceBetweenPoints3D(-2032.8400878906, -117, 1035.171875, getElementPosition(localPlayer))

		local dimension = getElementDimension(localPlayer, 1)


		
		if x and dist <= 10 then
			
			if (getElementDimension ( localPlayer ) == 90) then
			x = x - (dxGetTextWidth( '/trabajos', 2-(dist/30)*2, "default-bold" )/2)

			

			dxDrawText('/trabajos', x-1, y-1, x+1, y+1, tocolor(0,0,0,255), 1.1-(dist/10), "default-bold","left","top",false,false,false,false,false)

			dxDrawText('/trabajos', x+1, y+1, x-1, y-1, tocolor(0,0,0,255), 1.1-(dist/10), "default-bold","left","top",false,false,false,false,false)

			dxDrawText('/trabajos', x, y, x, y, tocolor(46,255,0,255), 1.1-(dist/10), "default-bold","left","top",false,false,false,false,false)
		end

		end

	end

)