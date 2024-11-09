local ArmasTable = {
{22, "Pistola 9mm", 3000, "Pistola + 17 balas", 17},
{24, "Desert Eagle.44", 8000, "Pistola + 10 balas", 10},
{29, "MP5", 3000, "Subfusil de Asalto + 17 balas", 17},
{25, "Escopeta Regmigton", 10000, "Escopeta + 5 balas", 5},
{31, "Fusil De Asalto", 10000, "Fusil de Asalto + 10 balas", 10},
{0, "Chaleco", 1000, "+100 de chaleco antibalas", 100},
}
addEventHandler("onClientResourceStart", resourceRoot,
    function()
        PanelArmas = guiCreateWindow(0.34, 0.24, 0.34, 0.49, "Tienda", true)
        guiWindowSetSizable(PanelArmas, false)
        guiSetVisible(PanelArmas, false)
        guiSetAlpha(PanelArmas, 0.80)
        Texto = guiCreateLabel(0.07, 0.07, 0.89, 0.04, "Haz click sobre el objeto que quieres comprar y luego click en Comprar", true, PanelArmas)
        ListaArmas = guiCreateGridList(0.02, 0.13, 0.96, 0.77, true, PanelArmas)
        guiGridListAddColumn(ListaArmas, "Objeto", 0.3)
        guiGridListAddColumn(ListaArmas, "Precio", 0.2)
        guiGridListAddColumn(ListaArmas, "Descripción", 0.5)
        botonComprarArma = guiCreateButton(0.04, 0.93, 0.40, 0.05, "Comprar", true, PanelArmas)
        guiSetFont(botonComprarArma, "default-bold-small")
        guiSetProperty(botonComprarArma, "NormalTextColour", "FF34E01E")
        botonCerrarArma = guiCreateButton(0.56, 0.93, 0.40, 0.05, "Cerrar", true, PanelArmas)
        guiSetFont(botonCerrarArma, "default-bold-small")
        guiSetProperty(botonCerrarArma, "NormalTextColour", "FFFD0000")     
    end
)
addEventHandler("onClientGUIClick", resourceRoot, function()
    local id = guiGridListGetItemData( ListaArmas, guiGridListGetSelectedItem ( ListaArmas ), 1 )
    local itenName = guiGridListGetItemText ( ListaArmas, guiGridListGetSelectedItem ( ListaArmas ), 1 )
    local costo = guiGridListGetItemData ( ListaArmas, guiGridListGetSelectedItem ( ListaArmas ), 2 )
    local descripcion = guiGridListGetItemText ( ListaArmas, guiGridListGetSelectedItem ( ListaArmas ), 3 )
    local valor = guiGridListGetItemData ( ListaArmas, guiGridListGetSelectedItem ( ListaArmas ), 3 )
    if source == botonCerrarArma then
        setVisible(PanelArmas)
    elseif source == botonComprarArma then
        setEnabled(botonComprarArma, 2000)
        if itenName ~="" then
           triggerServerEvent("buyWeapon", localPlayer, id, itenName, costo, descripcion, valor)
        end
    end
end)
addEvent("Armas:setWindow", true)
addEventHandler("Armas:setWindow", root, function( )
    setVisible(PanelArmas)
    --
    guiGridListClear( ListaArmas )
    --
    for i, v in ipairs(ArmasTable) do
        local row = guiGridListAddRow( ListaArmas )
        guiGridListSetItemText(ListaArmas, row, 1, v[2], false, true)
        guiGridListSetItemText(ListaArmas, row, 2, "$"..v[3], false, true)
        guiGridListSetItemText(ListaArmas, row, 3, v[4], false, true)
        --
        guiGridListSetItemData( ListaArmas, row, 1, v[1] )
        guiGridListSetItemData( ListaArmas, row, 2, v[3] )
        guiGridListSetItemData( ListaArmas, row, 3, v[5] )
    end
end)