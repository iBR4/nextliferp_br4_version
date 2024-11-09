
addEventHandler("onClientResourceStart", resourceRoot,
    function()
        PanelComidas = guiCreateWindow(0.34, 0.24, 0.34, 0.49, "Tienda", true)
        guiWindowSetSizable(PanelComidas, false)
        Texto = guiCreateLabel(0.07, 0.07, 0.89, 0.04, "Haz click sobre el objeto que quieres comprar y luego click en Comprar", true, PanelComidas)
        ListaComidas = guiCreateGridList(0.02, 0.13, 0.96, 0.77, true, PanelComidas)
        guiGridListAddColumn(ListaComidas, "Objeto", 0.3)
        guiGridListAddColumn(ListaComidas, "Precio", 0.1)
        guiGridListAddColumn(ListaComidas, "Descripción", 0.5)
        botonComprarComida = guiCreateButton(0.04, 0.93, 0.40, 0.05, "Comprar", true, PanelComidas)
        guiSetFont(botonComprarComida, "default-bold-small")
        guiSetProperty(botonComprarComida, "NormalTextColour", "FF34E01E")
        cerrar2 = guiCreateButton(0.56, 0.93, 0.40, 0.05, "Cerrar", true, PanelComidas)
        guiSetFont(cerrar2, "default-bold-small")
        guiSetProperty(cerrar2, "NormalTextColour", "FFFD0000")   
        guiSetVisible(PanelComidas,false)
        showCursor(false)
  
    end
)
addEventHandler("onClientGUIClick", resourceRoot, function()
	local itemName = guiGridListGetItemText ( ListaComidas, guiGridListGetSelectedItem ( ListaComidas ), 1 )
	local costo = guiGridListGetItemText ( ListaComidas, guiGridListGetSelectedItem ( ListaComidas ), 2 )
	local descripcion = guiGridListGetItemText ( ListaComidas, guiGridListGetSelectedItem ( ListaComidas ), 3 )
	if source == cerrar2 then
		setVisible(PanelComidas)
	elseif source == botonComprarComida then
		setEnabled(botonComprarComida, 2000)
		if itemName ~="" then
			triggerServerEvent("BuyItem", localPlayer, itemName, costo)
		end
	end
end)
local items = { 
{"Telefono", 100, "Recibirás un Telefono"},
{"Agenda", 20, "Recibirás una Agenda"},
{"Camara", 120, "Recibirás una Camara con 10 Cartuchos"},
{"Radio", 200, "Recibirás una Radio"},
{"Parlante", 500, "Recibirás un Parlante de mano"},
{"Cuchillo de Caza", 500, "Recibirás un Cuchillo (ARMA)"},
{"Bidon Vacio", 250, "Recibirás un bidon sin Gasolina"},
{"Lata de Spray", 50, "Recibirás Lata de Spary +75 HP"},
{"Kit Herramientas", 1000, "Recibirás un Kit para tu vehiculo"},
{"Localizador", 30000, "Recibirás un Localizador para tu vehiculo"},
{"gato", 500, "Recibirás un gato para desvolcar tu vehiculo"},
{"Pizzeta", 200, "Recibirás una Pizzeta +70 HP"},
{"Pizza Chica", 20, "Recibirás una Pizza Chica +20 HP"},
{"Pizza Grande", 30, "Recibirás una Pizza Grande +35 HP"},
--
{"Paella", 200, "Recibirás una Paella +100 HP"},
{"Pata de Pollo", 10, "Recibirás una Pata de pollo +15 HP"},
{"Hamb. de Pollo", 20, "Recibirás una Hamburguesa de Pollo +30 HP"},
{"Pollo Asado", 30, "Recibirás un Pollo +40 HP"},
--
{"Cerveza", 20, "Recibirás una Cerveza"},
{"Agua", 50, "Recibirás una botella de agua +60HP"},
{"Caja de Cigarros", 50 , "Recibirás una caja con 20 Cigarros"},
{"Encendedor", 25, "Recibirás un Encendedor"},
--
{"Hamburguesa", 10, "Recibirás una Hamburguesa +15 HP"},
{"Hamburguesa Chica", 20, "Recibirás una Hamburguesa Chica +20 HP"},
{"Hamburguesa Grande", 30, "Recibirás una Grande +40 HP"},
--
{"Caña de pescar", 100, "Recibirás una caña para pescar"},
{"Cebo", 10, "Recibirás un cebo para tu caña"},
}
addEvent("Comidas:setWindow", true)
addEventHandler("Comidas:setWindow", root, function( tab )
	setVisible(PanelComidas)
	guiGridListClear( ListaComidas )
	for i, v in ipairs( tab ) do
		local row = guiGridListAddRow(ListaComidas)
		guiGridListSetItemText( ListaComidas, row, 1, v, false, true )
		for index, valor in ipairs( items ) do
			if valor[1] == v then
				guiGridListSetItemText(ListaComidas, row, 2,valor[2], false, true)
				guiGridListSetItemText(ListaComidas, row, 3, valor[3], false, true)
			end
		end
	end
end)
function setEnabled( var, timer )
	guiSetEnabled( var, false )
	setTimer(guiSetEnabled, timer, 1, var, true)
end
function setVisible( var )
	if guiGetVisible( var ) == true then
		guiSetVisible(var, false)
		showCursor(false)
		guiSetInputEnabled(false)
	else
		guiSetVisible(var, true)
		showCursor(true)
		guiSetInputEnabled(true)
	end
end
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
						--dxDrawBorderedText ( "Usa la tecla '#FDCE61F#FFFFFF' para interactuar\n#FDCE61"..(pick or "").."", x-80, y-120, 200 + x-80, 40 + y-120, tocolor ( 255, 255, 255, 255 ),1, "default-bold","center", "center" )
					end
				end
			end
		end
	end
end)
function dxDrawBorderedText( text, x, y, w, h, color, scale, font, alignX, alignY, clip, wordBreak, postGUI )
	dxDrawText(text:gsub('#%x%x%x%x%x%x', ''), (x) - 1, (y) + 1, (w) - 1, (h) + 1, tocolor ( 0, 0, 0, 255 ), scale, font, alignX, alignY, clip, wordBreak, postGUI, true)
	dxDrawText(text:gsub('#%x%x%x%x%x%x', ''), (x) + 1, (y) + 1, (w) + 1, (h) + 1, tocolor ( 0, 0, 0, 255 ), scale, font, alignX, alignY, clip, wordBreak, postGUI, true)
	dxDrawText(text, x, y, w, h, color, scale, font, alignX, alignY, clip, wordBreak, postGUI, true)
end