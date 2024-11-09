
GUIEditor = {
    gridlist = {},
    window = {},
    button = {}
}
addEventHandler("onClientResourceStart", resourceRoot,
    function()
        ventana = guiCreateWindow(0.71, 0.39, 0.28, 0.55, "Mercado Negro", true)
        guiWindowSetSizable(ventana, false)
        guiarmas = guiCreateGridList(0.02, 0.06, 0.95, 0.75, true, ventana)
        guiGridListAddColumn(guiarmas, "ID", 0.2)
        guiGridListAddColumn(guiarmas, "ARMA", 0.2)
        guiGridListAddColumn(guiarmas, "MUNICION", 0.2)
        guiGridListAddColumn(guiarmas, "COSTO", 0.2)
        comprar = guiCreateButton(0.33, 0.87, 0.34, 0.07, "Comprar", true, ventana)
        guiSetFont(comprar, "default-bold-small")
        guiSetProperty(comprar, "NormalTextColour", "FFFFFEFE")
        cerrar = guiCreateButton(0.88, 0.90, 0.09, 0.07, "X", true, ventana)
        guiSetFont(cerrar, "default-bold-small")
        guiSetProperty(cerrar, "NormalTextColour", "FFFFFEFE")  
         guiSetVisible(ventana,false)  
    end
)
addEventHandler("onClientGUIClick",resourceRoot,function()
	local id = guiGridListGetItemData( guiarmas, guiGridListGetSelectedItem ( guiarmas ), 1 )
	local municion = guiGridListGetItemData( guiarmas, guiGridListGetSelectedItem ( guiarmas ), 3 )
	local costo = guiGridListGetItemData( guiarmas, guiGridListGetSelectedItem ( guiarmas ), 4 )
	if source == cerrar then
		showCursor(false)
		 guiSetVisible(ventana,false)
	elseif source == comprar then
        if guiarmas == "" then
        else
        triggerServerEvent("buyarma2",localPlayer,id,municion,costo)
        end
	end
end)
local armas = {
{4,"Cuchillo",1,1000},
{5,"Bate",1,1700},
{22,"Colt 45",17,9200},
{24,"Desert Eagle",7,12500},
--{28,"Uzi",130,50000},
--{29,"Mp5",150,110000},
{30,"Ak-47",30,40000},
--{0,"Chaleco",1000,500},
}
addEvent("vertienda",true)
addEventHandler("vertienda",getRootElement(),function()
	 guiSetVisible(ventana,true)
	 showCursor(true)
	 guiGridListClear( guiarmas )
	 for i, v in ipairs(armas) do
		local row = guiGridListAddRow(guiarmas)
       		guiGridListSetItemText(guiarmas, row, 1, v[1], false, true)
        	guiGridListSetItemText(guiarmas, row, 2, v[2], false, true)
        	guiGridListSetItemText(guiarmas, row, 3, v[3], false, true)
        	guiGridListSetItemText(guiarmas, row, 4, "$"..v[4], false, true)
        --
        	guiGridListSetItemData(guiarmas, row, 1, v[1] )
       	 	guiGridListSetItemData(guiarmas, row, 2, v[2] )
       	 	guiGridListSetItemData(guiarmas, row, 3, v[3] )
       	 	guiGridListSetItemData(guiarmas, row, 4, v[4] )
	end
end)
