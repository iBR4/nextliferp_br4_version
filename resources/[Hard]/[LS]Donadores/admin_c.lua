--# Variables: Feature
local VIPSystem = { gridlist = {}, window = {}, button = {}, label = {} }
addEventHandler("onClientResourceStart", resourceRoot,
	function()
		VIPSystem.window[1] = guiCreateWindow(0.10, 0.16, 0.81, 0.68, "Malos aires - Vips", true)
		guiWindowSetSizable(VIPSystem.window[1], false)
		guiSetVisible(VIPSystem.window[1], false)
		VIPSystem.gridlist[1] = guiCreateGridList(0.02, 0.06, 0.50, 0.92, true, VIPSystem.window[1])
		guiGridListAddColumn(VIPSystem.gridlist[1], "Nombre", 0.4)
		guiGridListAddColumn(VIPSystem.gridlist[1], "Cuenta", 0.3)
		guiGridListAddColumn(VIPSystem.gridlist[1], "Tiempo establecido", 0.25)
		guiGridListAddColumn(VIPSystem.gridlist[1], "Tiempo restante", 0.25)
		guiGridListAddColumn(VIPSystem.gridlist[1], "Plan VIP", 0.4)
		guiSetProperty(VIPSystem.gridlist[1], "Font", "default-bold-small")
		VIPSystem.gridlist[4] = guiCreateGridList(0.53, 0.06, 0.45, 0.24, true, VIPSystem.window[1])
		guiGridListAddColumn(VIPSystem.gridlist[4], "Cuenta", 0.5) 
		guiGridListAddColumn(VIPSystem.gridlist[4], "Nick", 0.5) 
		guiSetProperty(VIPSystem.gridlist[4], "Font", "default-bold-small")
		VIPSystem.gridlist[3] = guiCreateGridList(0.53, 0.33, 0.45, 0.24, true, VIPSystem.window[1])
		guiGridListAddColumn(VIPSystem.gridlist[3], "Dias", 0.8)
		guiSetProperty(VIPSystem.gridlist[3], "Font", "default-bold-small")
		VIPSystem.gridlist[2] = guiCreateGridList(0.53, 0.59, 0.45, 0.24, true, VIPSystem.window[1])
		guiGridListAddColumn(VIPSystem.gridlist[2], "Planes VIP", 0.9)
		guiSetProperty(VIPSystem.gridlist[2], "Font", "default-bold-small")
		VIPSystem.button[1] = guiCreateButton(0.53, 0.87, 0.16, 0.08, "Poner VIP", true, VIPSystem.window[1])		
		guiSetFont(VIPSystem.button[1], "default-bold-small")
		guiSetProperty(VIPSystem.button[1], "HoverTextColour", "FF00FF00")
		guiSetProperty(VIPSystem.button[1], "NormalTextColour", "FFAAAAAA")
		
		VIPSystem.button[2] = guiCreateButton(0.71, 0.87, 0.16, 0.08, "Remover VIP", true, VIPSystem.window[1])
		guiSetFont(VIPSystem.button[2], "default-bold-small")
		guiSetProperty(VIPSystem.button[2], "HoverTextColour", "FFFF0000")
		guiSetProperty(VIPSystem.button[2], "NormalTextColour", "FFAAAAAA")
		
		VIPSystem.button[3] = guiCreateButton(0.89, 0.87, 0.09, 0.08, "X", true, VIPSystem.window[1])
		guiSetFont(VIPSystem.button[3], "default-bold-small")
		guiSetProperty(VIPSystem.button[3], "HoverTextColour", "FFFF0000")
		guiSetProperty(VIPSystem.button[3], "NormalTextColour", "FFAAAAAA")     
	end
)
addEvent("vip:openInterface", true)
addEventHandler("vip:openInterface", root,
function()
   open_close() 
end
)
function refreshLists( ... )
    guiGridListClear(VIPSystem.gridlist[1])
    for i, k in ipairs(local_vips) do
        local row = guiGridListAddRow(VIPSystem.gridlist[1])
        guiGridListSetItemText(VIPSystem.gridlist[1], row, 1, k[2], false, false)
        guiGridListSetItemText(VIPSystem.gridlist[1], row, 2, k[1], false, false)
        guiGridListSetItemText(VIPSystem.gridlist[1], row, 3, k[4], false, false)
        guiGridListSetItemText(VIPSystem.gridlist[1], row, 4, k[5].." Dia"..(tonumber(k[5]) == 1 and "" or "s"), false, false)
        guiGridListSetItemText(VIPSystem.gridlist[1], row, 5, k[3], false, false)
    end
    ---
    guiGridListClear(VIPSystem.gridlist[4])
    for i, k in ipairs(local_accounts) do
        local row = guiGridListAddRow(VIPSystem.gridlist[4])
        guiGridListSetItemText(VIPSystem.gridlist[4], row, 1, k[1], false, false)
        guiGridListSetItemText(VIPSystem.gridlist[4], row, 2, k[2], false, false)
    end
    ---
    guiGridListClear(VIPSystem.gridlist[3])
    for i=1, 31 do
        local row = guiGridListAddRow(VIPSystem.gridlist[3])
        guiGridListSetItemText(VIPSystem.gridlist[3], row, 1, i, false, false)
    end
    ---
    guiGridListClear(VIPSystem.gridlist[2])
    for i=1, #local_planes do
        local row = guiGridListAddRow(VIPSystem.gridlist[2])
        guiGridListSetItemText(VIPSystem.gridlist[2], row, 1, local_planes[i], false, false)
    end
end
addEvent("vip:refresh_tables", true)
addEventHandler("vip:refresh_tables", root,
function ( vips, accounts, planes )
    local_vips = vips;
    local_accounts = accounts;
    local_planes = planes;
    refreshLists()
end
)
function open_close( )
    local v = guiGetVisible(VIPSystem.window[1])
    guiSetVisible(VIPSystem.window[1], not v)
    showCursor(not v)
    ---
    if ( not v ) then
        refreshLists()
    end
end
addEventHandler("onClientGUIClick", root,
function ( ... )
    if ( source == VIPSystem.button[1] ) then -- Poner VIP
        if ( guiGridListGetSelectedItem(VIPSystem.gridlist[4]) ~= -1 ) then
            if ( guiGridListGetSelectedItem(VIPSystem.gridlist[3]) ~= -1 ) then
                if ( guiGridListGetSelectedItem(VIPSystem.gridlist[2]) ~= -1 ) then
                    local account = guiGridListGetItemText(VIPSystem.gridlist[4], guiGridListGetSelectedItem(VIPSystem.gridlist[4]), 1)
                    local days = guiGridListGetItemText(VIPSystem.gridlist[3], guiGridListGetSelectedItem(VIPSystem.gridlist[3]), 1)
                    local plan = guiGridListGetItemText(VIPSystem.gridlist[2], guiGridListGetSelectedItem(VIPSystem.gridlist[2]), 1)
                    ---
                    triggerServerEvent("vip:execute", localPlayer, "add", {account, days, plan})
                else
                    outputChatBox("* Debes seleccionar un plan de la lista!", 255, 0, 0, true)
                end
            else
                outputChatBox("* Debes seleccionar una cantidad de dias de la lista!", 255, 0, 0, true)
            end
        else
            outputChatBox("* Debes seleccionar una cuenta de la lista!", 255, 0, 0, true)
        end
    elseif ( source == VIPSystem.button[2] ) then -- Quitar VIP
        if ( guiGridListGetSelectedItem(VIPSystem.gridlist[1]) ~= -1 ) then
            local account = guiGridListGetItemText(VIPSystem.gridlist[1], guiGridListGetSelectedItem(VIPSystem.gridlist[1]), 2)
            local plan = guiGridListGetItemText(VIPSystem.gridlist[1], guiGridListGetSelectedItem(VIPSystem.gridlist[1]), 5)
            triggerServerEvent("vip:execute", localPlayer, "take", {account, plan})
            refreshLists();
        else
            outputChatBox("* Debes seleccionar un usuario de la lista para seguir!");
        end
    elseif ( source == VIPSystem.button[3] ) then  
        open_close();
    end
end)