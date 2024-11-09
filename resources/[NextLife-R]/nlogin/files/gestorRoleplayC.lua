--[[

	███╗░░██╗███████╗██╗░░██╗████████╗  ██╗░░░░░██╗███████╗███████╗
	████╗░██║██╔════╝╚██╗██╔╝╚══██╔══╝  ██║░░░░░██║██╔════╝██╔════╝
	██╔██╗██║█████╗░░░╚███╔╝░░░░██║░░░  ██║░░░░░██║█████╗░░█████╗░░
	██║╚████║██╔══╝░░░██╔██╗░░░░██║░░░  ██║░░░░░██║██╔══╝░░██╔══╝░░
	██║░╚███║███████╗██╔╝╚██╗░░░██║░░░  ███████╗██║██║░░░░░███████╗
	╚═╝░░╚══╝╚══════╝╚═╝░░╚═╝░░░╚═╝░░░  ╚══════╝╚═╝╚═╝░░░░░╚══════╝ gestorRoleplay.lua by BR4

]]

local screenW, screenH = guiGetScreenSize()
local sx, sy = screenW/1366, screenH/768
local AntiSpamPersonajes = nil

GUINext = guiCreateWindow(463*sx, 134*sy, 440*sx, 500*sy, "Gestion de Personajes - NextLife RP", false)
guiWindowSetSizable(GUINext, false)
guiSetAlpha(GUINext, 1.00)

Grid_Personajes = guiCreateGridList(9*sx, 24*sy, 206*sx, 464*sy, false, GUINext)
guiGridListAddColumn(Grid_Personajes, "Cuentas Disponibles", 0.9)
Grid_Conectados = guiCreateGridList(220*sx, 24*sy, 208*sx, 140*sy, false, GUINext)
guiGridListAddColumn(Grid_Conectados, "Conectados", 0.5)
guiGridListAddColumn(Grid_Conectados, "Pers Creados.", 0.4)
Cambiar = guiCreateButton(220*sx, 212*sy, 209*sx, 36*sy, "Asignar", false, GUINext)
guiSetFont(Cambiar, "default-bold-small")
EditPers = guiCreateEdit(220*sx, 172*sy, 208*sx, 30*sy, "Mail/Nuevo ....", false, GUINext)
guiSetFont(EditPers, "default-bold-small")
Label_NextRP_1 = guiCreateLabel(220*sx, 256*sy, 208*sx, 50*sy, "*Si deseas asignar un cambio de personaje\na una mail\nRellena el espacio en blanco*", false, GUINext)
guiSetFont(Label_NextRP_1, "default-bold-small")
guiLabelSetHorizontalAlign(Label_NextRP_1, "center", true)
guiLabelSetVerticalAlign(Label_NextRP_1, "center")
CerrarGUI = guiCreateButton(220*sx, 452*sy, 209*sx, 36*sy, "Cerrar", false, GUINext)
guiSetFont(CerrarGUI, "default-bold-small")
Borrar = guiCreateButton(220*sx, 406*sy, 209*sx, 36*sy, "Eliminar Permanente", false, GUINext)
guiSetFont(Borrar, "default-bold-small")
Label_Next_RP_2 = guiCreateLabel(220*sx, 329*sy, 208*sx, 50*sy, "Si eliminas/asignas un personaje y el jugador se encuentra dentro, el mismo jugador serà reconectado.", false, GUINext)
guiSetFont(Label_Next_RP_2, "default-bold-small")
guiLabelSetColor(Label_Next_RP_2, 244, 93, 10)
guiLabelSetHorizontalAlign(Label_Next_RP_2, "center", true)
guiLabelSetVerticalAlign(Label_Next_RP_2, "center")

guiSetVisible(GUINext, false)

function isSelected(grid)
	local data = guiGridListGetItemData(grid, guiGridListGetSelectedItem(grid), 1)
	if data ~= nil then
		return {unpack(data)}
	else
		return false
	end
end

function updateDatas(tab,data)
	if data == 'user' then
		guiGridListClear(Grid_Conectados)
		for index,datas in pairs(tab) do
			local row = guiGridListAddRow(Grid_Conectados)
	        guiGridListSetItemText(Grid_Conectados, row, 1, getPlayerName(datas[1]),false,false)
	        guiGridListSetItemText(Grid_Conectados, row, 2, datas[2],false,false)
	        guiGridListSetItemData(Grid_Conectados, row, 1, {datas[1],datas[2]})
	        guiGridListSetItemColor(Grid_Conectados, row, 1, 244, 93, 10, 250)
	        guiGridListSetItemColor(Grid_Conectados, row, 2, 244, 93, 10, 250)
		end
	elseif data == 'data' then
		guiGridListClear(Grid_Personajes)
		local row = guiGridListAddRow(Grid_Personajes)
		guiGridListSetItemText(Grid_Personajes,row,1, "Personajes Actuales ("..#tab..")",true,false)
		for i,pers in pairs(tab) do
			local row = guiGridListAddRow(Grid_Personajes)
	        guiGridListSetItemText(Grid_Personajes,row,1, (pers.Nick).. " ("..(pers.Correo)..")",false,false)
	        guiGridListSetItemData(Grid_Personajes,row,1, {pers.Correo,pers.Cuenta,pers.Nick})
	        guiGridListSetItemColor(Grid_Personajes,row,1, 254,254,254, 250)
		end
	end
end

function GUIBotones()
	if source == Cambiar then
		local Data = isSelected(Grid_Personajes)
		if Data then
			if not tick_antes or ( getTickCount() - tick_antes ) > 2000 then -- AntiSpam (2 Segundos)
                tick_antes = getTickCount()
                if ( guiGetText( EditPers ) ~= "" or guiGetText(EditPers) ~= "Mail/Nuevo ...." ) then
                	if Data[3] ~= guiGetText(EditPers) then
                		triggerServerEvent("NL:ShowGestorUpdate:Server",localPlayer,localPlayer,"update",Data[1],Data[2],Data[3],tostring(guiGetText(EditPers)))
                	else
                		triggerEvent("addTextMessage3D",localPlayer,"[Next-RP] #F58A02Estas asignandolo al mismo correo#ffffff!",255,255,255)
                	end
                else
                	triggerEvent("addTextMessage3D",localPlayer,"[Next-RP] #F58A02Asigna algún correo#ffffff!",255,255,255)
            	end
            else
            	triggerEvent("addTextMessage3D",localPlayer,"[Next-RP] #F58A02Tomatelo con calma#ffffff y espera unos segundos!",255,255,255)
            end
		else
			triggerEvent("addTextMessage3D",localPlayer,"[Next-RP] #F58A02Selecciona algo#ffffff!",255,255,255)
		end
	elseif source == Borrar then
		local Data = isSelected(Grid_Personajes)
		if Data then
			if not tick_antes or ( getTickCount() - tick_antes ) > 2000 then -- AntiSpam (2 Segundos)
                tick_antes = getTickCount()
                triggerServerEvent("NL:ShowGestorUpdate:Server",localPlayer,localPlayer,"delete",Data[1],Data[2],Data[3])
            else
            	triggerEvent("addTextMessage3D",localPlayer,"[Next-RP] #F58A02Tomatelo con calma#ffffff y espera unos segundos!",255,255,255)
            end
		else
			triggerEvent("addTextMessage3D",localPlayer,"[Next-RP] #F58A02Selecciona algo#ffffff!",255,255,255)
		end	
	elseif source == CerrarGUI then
		showCursor(false)
		guiSetVisible(GUINext, false)
		guiSetInputEnabled( false )
	end
end
addEventHandler( "onClientGUIClick", resourceRoot, GUIBotones)

addEventHandler("onClientGUIChanged", resourceRoot, function()
    if source == EditPers then
        local currText = guiGetText(source)
        local newText = string.gsub(currText, "%s+", "") -- Elimina los Espacios.
        if newText ~= currText then
            guiSetText(source, newText)
        end
    end
end)

addEvent("NL:ShowGestorUpdate",true)
addEventHandler("NL:ShowGestorUpdate",root,
function(player,tab)
	if isElement(player) then
		if guiGetVisible(GUINext) then
			updateDatas(tab,'data')
		end
	end
end)


addEvent("NL:ShowGestor",true)
addEventHandler("NL:ShowGestor",root,
function(player,tab,tab2)
	if localPlayer == player then
		if isElement(player) then
			if guiGetVisible(GUINext) == false then
				guiSetVisible(GUINext, true)
				showCursor(true)
				updateDatas(tab,'user')
				updateDatas(tab2,'data')
				guiSetInputEnabled(true)
			else
				showCursor(false)
				guiSetVisible(GUINext, false)
				guiSetInputEnabled(false)
			end
		end
	end
end)

addEventHandler( "onClientResourceStop", getResourceRootElement(getThisResource()), function()  
	if guiGetVisible(GUINext) == true then
		guiSetInputEnabled( false )
	end
end)