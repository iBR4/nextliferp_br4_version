
GUIEditor = {
    gridlist = {},
    window = {},
    button = {},
    label = {}
}
addEventHandler("onClientResourceStart", resourceRoot,
    function()
        windowp = guiCreateWindow(0.37, 0.25, 0.23, 0.49, "Armeria", true)
        guiWindowSetSizable(windowp, false)
        guiSetProperty(windowp, "CaptionColour", "FE0B1CF7")
        tomararma = guiCreateButton(0.55, 0.57, 0.50, 0.10, "Tomar Arma", true, windowp)
        guiSetFont(tomararma, "default-bold-small")
        caca = guiCreateButton(0.55, 0.70, 0.50, 0.10, "Guardar arma", true, windowp)
        guiSetFont(caca, "default-bold-small")
        guardar = guiCreateButton(0.55, 0.20, 0.50, 0.10, "Guardar tus armas", true, windowp)
        guiSetFont(guardar, "default-bold-small")
        guardatom = guiCreateButton(0.55, 0.32, 0.50, 0.10, "Recoger tus armas", true, windowp)
        guiSetFont(guardatom, "default-bold-small")
        armitas = guiCreateGridList(0.03, 0.20, 0.50, 0.90, true, windowp)
        guiGridListAddColumn(armitas, "ID", 0.5)
        guiGridListAddColumn(armitas, "Arma", 0.5)
        cerrar = guiCreateButton(0.55, 0.90, 0.40, 0.12, "Salir", true, windowp)
        guiSetFont(cerrar, "sa-header")
        GUIEditor.label[1] = guiCreateLabel(0.20, 0.06, 0.70, 0.04, "Este es el menu de la armeria SAPD", true, windowp)
        guiSetFont(GUIEditor.label[1], "default-bold-small")
        GUIEditor.label[1] = guiCreateLabel(0.10, 0.10, 1.00, 0.04, "En ella puedes dejar tus armas (civil) y recoger", true, windowp)
        guiSetFont(GUIEditor.label[1], "default-bold-small")
        GUIEditor.label[1] = guiCreateLabel(0.30, 0.15, 1.00, 0.04, "tus otras armas (policia)", true, windowp)
        guiSetFont(GUIEditor.label[1], "default-bold-small")          
	 guiSetVisible(windowp, false)
    end
)
addEventHandler("onClientGUIClick", resourceRoot, function()
    local id = guiGridListGetItemData( armitas, guiGridListGetSelectedItem ( armitas ), 1 )
    local itenName = guiGridListGetItemText ( armitas, guiGridListGetSelectedItem ( armitas ), 2 )
    if source == cerrar then
        guiSetVisible(windowp, false)
	showCursor(false)
    elseif source == tomararma then
        if itenName ~="" then
           triggerServerEvent("buyarma", localPlayer, id, itenName)
        end
    end
end)
local cadetes = {
{3,"Porra"},
{24,"Deagle"},
{22,"9mm"},
{0,"Chaleco"},
--
}
local oficiales = {
{3,"Porra"},
{24,"Deagle"},
{22,"9mm"},
{29,"MP5"},
{25,"Escopeta"},
{0,"Chaleco"},
{31,"M4A1"},
}
local swat = {
{3,"Porra"},
{24,"Deagle"},
{22,"9mm"},
{29,"MP5"},
{25,"Escopeta"},
{31,"M4A1"},
{17,"Teargas"},
{0,"Chaleco"},
{34,"Sniper"},
}
addEvent("Openarm", true)
addEventHandler("Openarm", root, function()
	if guiGetVisible(windowp) == true then
		guiSetVisible(windowp, false)
		showCursor(false)
	else
		guiGridListClear( armitas )
		guiSetVisible(windowp, true)
		showCursor(true)
        
        if localPlayer:getData('Roleplay:faccion_division') == 'S.W.A.T' or  localPlayer:getData('Roleplay:faccion_rango') == 'Jefe de Policia' then
            for i, v in ipairs(swat) do
                local row = guiGridListAddRow(armitas)
                guiGridListSetItemText(armitas, row, 1, v[1], false, true)
                guiGridListSetItemText(armitas, row, 2, v[2], false, true)
        --
                guiGridListSetItemData(armitas, row, 1, v[1] )
                guiGridListSetItemData(armitas, row, 2, v[3] )
            end
        elseif localPlayer:getData('Roleplay:faccion_rango') == 'Oficial I' or localPlayer:getData('Roleplay:faccion_rango') == 'Oficial III' or localPlayer:getData('Roleplay:faccion_rango') == 'Oficial III+' or localPlayer:getData('Roleplay:faccion_rango') == 'Oficial II' or localPlayer:getData('Roleplay:faccion_rango') == 'Sargento I' or localPlayer:getData('Roleplay:faccion_rango') == 'Sargento II' or localPlayer:getData('Roleplay:faccion_rango') == 'Teniente' or localPlayer:getData('Roleplay:faccion_rango') == 'Capitan' or localPlayer:getData('Roleplay:faccion_rango') == 'Comandante' or localPlayer:getData('Roleplay:faccion_division') == 'CEI' then
            for i, v in ipairs(oficiales) do
                local row = guiGridListAddRow(armitas)
                guiGridListSetItemText(armitas, row, 1, v[1], false, true)
                guiGridListSetItemText(armitas, row, 2, v[2], false, true)
        --
                guiGridListSetItemData(armitas, row, 1, v[1] )
                guiGridListSetItemData(armitas, row, 2, v[3] )
            end
        elseif localPlayer:getData('Roleplay:faccion_rango') == 'Cadete' then
            for i, v in ipairs(cadetes) do
                local row = guiGridListAddRow(armitas)
                guiGridListSetItemText(armitas, row, 1, v[1], false, true)
                guiGridListSetItemText(armitas, row, 2, v[2], false, true)
        --
                guiGridListSetItemData(armitas, row, 1, v[1] )
                guiGridListSetItemData(armitas, row, 2, v[3] )
            end
        end
    end
end)
addEventHandler( "onClientRender", getRootElement(), 
	function()
		local x,y = getScreenFromWorldPosition(1578.8775634766, -1684.9056396484, 16.1953125, 0, true )
		local dist = getDistanceBetweenPoints3D(1578.8775634766, -1684.9056396484, 16.1953125, getElementPosition(localPlayer) )
		if x and dist <= 10 then
			x = x - (dxGetTextWidth( '/armas', 2-(dist/30)*2, "default-bold" )/2)
			
			dxDrawText('/armas', x-1, y-1, x+1, y+1, tocolor(0,0,0,255), 1.2-(dist/10), "default-bold","left","top",false,false,false,false,false)
			dxDrawText('/armas', x+1, y+1, x-1, y-1, tocolor(0,0,0,255), 1.2-(dist/10), "default-bold","left","top",false,false,false,false,false)
			dxDrawText('/armas', x, y, x, y, tocolor(2,172,240,255), 1.2-(dist/10), "default-bold","left","top",false,false,false,false,false)
		end
	end
)
