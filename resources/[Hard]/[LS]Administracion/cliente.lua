GUIEditor = {
    gridlist = {},
    window = {},
    button = {}
}
addEventHandler("onClientResourceStart", resourceRoot,
    function()
        GUIEditor.window[1] = guiCreateWindow(0.33, 0.25, 0.35, 0.50, "", true)
        guiWindowSetSizable(GUIEditor.window[1], false)
        guiSetVisible(GUIEditor.window[1], false)
        GUIEditor.button[1] = guiCreateButton(192, 342, 91, 29, "X", false, GUIEditor.window[1])
        guiSetProperty(GUIEditor.button[1], "NormalTextColour", "FFAAAAAA")
        GUIEditor.gridlist[1] = guiCreateGridList(0.02, 0.06, 0.96, 0.81, true, GUIEditor.window[1])   
        guiGridListAddColumn(GUIEditor.gridlist[1], "Cantidad", 0.3)
        guiGridListAddColumn(GUIEditor.gridlist[1], "", 0.3)
        guiGridListAddColumn(GUIEditor.gridlist[1], "Fecha", 0.3)  
    end
)
addEventHandler("onClientGUIClick", resourceRoot, function()
	if source == GUIEditor.button[1] then
        guiSetVisible(GUIEditor.window[1], false)
		showCursor(false)
		guiSetText(GUIEditor.window[1], "")
	end
end)

addEvent("NL:CopyData",true)
addEventHandler("NL:CopyData",root,
function(player,copy)
    if isElement(player) then
        if localPlayer == player then
            setClipboard( copy )
        end
    end
end)

addEvent("setVisibl", true)
addEventHandler("setVisibl", root, function(typ, s, thePlayer)
	if guiGetVisible(GUIEditor.window[1]) == true then
		guiSetVisible(GUIEditor.window[1], false)
		showCursor(false)
	else
		guiSetText(GUIEditor.window[1], "["..typ.."] Log de "..thePlayer:getName())
		if typ:find("Banco") then
			for i, v in ipairs(s) do
				local row = guiGridListAddRow(GUIEditor.gridlist[1])
				guiGridListSetItemText(GUIEditor.gridlist[1], row, 1, v.Cantidad, false, false)
				guiGridListSetItemText(GUIEditor.gridlist[1], row, 2, v.Valor, false, false)
				guiGridListSetItemText(GUIEditor.gridlist[1], row, 3, v.Fecha, false, false)
				if v.Valor == "Deposito" then
					for i=1,3 do
						guiGridListSetItemColor( GUIEditor.gridlist[1], row, i, 50, 150, 50, 255 )
					end
				else
					for i=1,3 do
						guiGridListSetItemColor( GUIEditor.gridlist[1], row, i, 150, 50, 50, 255 )
					end
				end
			end
		end
		guiSetVisible(GUIEditor.window[1], true)
		showCursor(true)
	end
end)
--loadstring(exports["[LS]NewData"]:getMyCode())()
--import('getDato,setDato,getDatos'):init('[LS]NewData')
addEventHandler("onClientRender", root, function()
    local time = localPlayer:getData("JailOOC") or 0
    local arrestingOfficer = localPlayer:getData("ArrestingOfficer") or "Desconocido"
    local arrestReason = localPlayer:getData("ArrestReason") or "Sin motivo"
    if time and tonumber(time) >= 1 then
        local minutes = math.floor(time / 60)
        local seconds = time % 60
        local timeText = string.format("Tiempo Restante: %02d:%02d", minutes, seconds)
        local arrestingOfficerText = "Arrestado por: " .. arrestingOfficer
        local arrestReasonText = "Motivo: \n" .. arrestReason
        local logoPath = "logo.png" -- Reemplaza con la ruta de tu logo PNG
        local textWidth = math.max(dxGetTextWidth(timeText, 1.5, "default"), dxGetTextWidth(arrestingOfficerText, 1.5, "default"), dxGetTextWidth(arrestReasonText, 1.5, "diploma"))
        local boxWidth = 400
        local boxHeight = 350
        local boxMargin = 20
        local sx_, sy_ = guiGetScreenSize()
        local sx, sy = sx_ / 1360, sy_ / 768
        local boxX = sx_ - boxWidth - boxMargin
        local boxY = (sy_ - boxHeight) / 2
        dxDrawRectangle(boxX, boxY, boxWidth * sx, boxHeight * sy, tocolor(0, 0, 0, 150))
        local textX = boxX + ((boxWidth * sx) - textWidth) / 2
        local textY = boxY + ((boxHeight * sy) - 200) / 2
        dxDrawBorderedText2(timeText, textX, textY, textX + textWidth, textY + 10, tocolor(238, 199, 0), 1.2, "default", "center", "center", false, false, false, false, false)
        dxDrawBorderedText2(arrestingOfficerText, textX, textY + 30, textX + textWidth, textY + 40, tocolor(255, 255, 255), 1.2, "default", "center", "center", false, false, false, false, false)
        dxDrawBorderedText2(arrestReasonText, textX, textY + 60, textX + textWidth, textY + 70, tocolor(255, 255, 255), 1.2, "default", "center", "center", false, false, false, false, false)
        
        local logoWidth = 150 -- Ancho del logo
        local logoHeight = 150 -- Alto del logo
        local logoX = textX + (textWidth - logoWidth) / 2 -- Posición X del logo
        local logoY = textY + 145 -- Posición Y del logo
        dxDrawImage(logoX, logoY, logoWidth, logoHeight, logoPath)
    end
end)
local screenW, screenH = guiGetScreenSize()
addEventHandler("onClientRender", getRootElement(), function()
	if (localPlayer:getData("Admin:Disponible") or false) == true then
        dxDrawText("Estas en modo STAFF", (screenW * 0.8543) + 1, (screenH * 0.8776) + 1, (screenW * 0.9751) + 1, (screenH * 0.9245) + 1, tocolor(0, 0, 0, 255), 1.00, "default-bold", "left", "top", false, false, false, false, false)
        dxDrawText("Estas en modo STAFF", screenW * 0.8543, screenH * 0.8776, screenW * 0.9751, screenH * 0.9245, tocolor(19, 187, 2, 255), 1.00, "default-bold", "left", "top", false, false, false, false, false)
	end
end
)
function dxDrawBorderedText2( text, x, y, w, h, color, scale, font, alignX, alignY, clip, wordBreak, postGUI )
	dxDrawText(text:gsub('#%x%x%x%x%x%x', ''), (x) - 1, (y) + 1, (w) - 1, (h) + 1, tocolor ( 0, 0, 0, 255 ), scale, font, alignX, alignY, clip, wordBreak, postGUI, true)
	dxDrawText(text:gsub('#%x%x%x%x%x%x', ''), (x) + 1, (y) + 1, (w) + 1, (h) + 1, tocolor ( 0, 0, 0, 255 ), scale, font, alignX, alignY, clip, wordBreak, postGUI, true)
	dxDrawText(text, x, y, w, h, color, scale, font, alignX, alignY, clip, wordBreak, postGUI, true)
end
addEventHandler ( "onClientPlayerDamage",root,
    function ()
        if getElementData(source,"invincible") then
            cancelEvent()
        end
    end)
     
    addEventHandler("onClientPlayerStealthKill",localPlayer,
    function (targetPlayer)
        if getElementData(targetPlayer,"invincible") then
            cancelEvent()
        end
    end) 
