addEventHandler("onClientRender", getRootElement(), function()
	local playerX2, playerY2, playerZ2 = getElementPosition ( localPlayer )
	local playerX, playerY, playerZ = 1560.6409912109, -1676.1536865234, 16.1953125
	local sx, sy = getScreenFromWorldPosition(playerX, playerY, playerZ + 0.5)
	if sx and sy then
		local cx, cy, cz = getCameraMatrix()
		local distance = getDistanceBetweenPoints3D(playerX2, playerY2, playerZ2, playerX, playerY, playerZ + 0.5)
		if distance < 5 then
			dxDrawBorderedText3 ( "#FFFF00Para pagar tus multas usa\n#00FF00/pagarmulta <numero>", sx, sy, sx, sy , tocolor (0, 255, 0, 255 ),1, "default-bold","center", "center" ) 
		end
	end
end)

function dxDrawBorderedText3( text, x, y, w, h, color, scale, font, alignX, alignY, clip, wordBreak, postGUI )
	dxDrawText(text:gsub('#%x%x%x%x%x%x', ''), (x) + 1, (y) + 1, (w) + 1, (h) + 1, tocolor ( 0, 0, 0, 255 ), scale, font, alignX, alignY, clip, wordBreak, postGUI, true)
	dxDrawText(text, x, y, w, h, color, scale, font, alignX, alignY, clip, wordBreak, postGUI, true)
end