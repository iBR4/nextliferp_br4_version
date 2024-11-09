-- Notifications system
local sx,sy = guiGetScreenSize()
local r,g,b = 255, 60, 0
local lisrMSG = {}
-- The same function as outputChatBoxing to make it more easier.
function showText(message)
	if not (message and type(message) == "string") then error("Bad argument @ 'showText' [Expected player at argument 1, got "..type(message).."]") return false end
	return table.insert(lisrMSG, {message, getTickCount()})
end
addEvent("onClientShowText",true)
addEventHandler("onClientShowText", root, showText)
alpha1 = 0;
-- Rendering.
addEventHandler("onClientRender", root,
function ()
	if (#lisrMSG > 0) then
		for i, messages in ipairs(lisrMSG) do
			text, started = unpack(messages)
			now = getTickCount()
			progress = (now-started)/1200
			x, w, h = sx/2-(360/2), 360, 20
			scale = 1
			font = "default-bold"
			length = dxGetTextWidth(text, scale, font, true)
			_, y, alpha = interpolateBetween(0, sy, 0, 0, sy-(80+(h*i)), 255, progress, "OutBack")
				if (progress >= 8) then
					table.remove(lisrMSG, i)
						if alpha1 >= 255 then
							alpha1 = 255
						end
				end
			alpha1 = alpha1 + 3;
				if alpha1 >= 255 then
					alpha1 = 255;
				end
				
    		dxDrawRectangle((x-5)-(tonumber(length)/2)+180, y-1, tonumber(length)+8, h+2, tocolor(r, g, b, alpha1), false)
    		dxDrawRectangle((x-4)-(tonumber(length)/2)+180, y, tonumber(length)+6, h, tocolor(22, 22, 22, alpha1), false)
    		dxDrawText(tostring(text), x, y, w+x, h+y, tocolor(255, 255, 255, alpha1), scale, font, "center", "center", false, false, false, true, false)
    	end
	end
end)
addEventHandler('onClientPlayerJoin', root,
function()
	showText(getPlayerName(source).." #0078ffEntro #666666Al #0078ffServidor")
end)     
	
addEventHandler('onClientPlayerQuit', root,
function(reason)
	showText(getPlayerName(source).." #666666Se Desconecto #666666Del #0078ffServidor #0078ff("..reason..").")
end)
