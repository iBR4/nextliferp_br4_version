addEventHandler("onClientRender", getRootElement(), function()
	local playerX2, playerY2, playerZ2 = getElementPosition ( localPlayer )
	for ExpendedoraName, info in pairs(getExpendedoras()) do
		for i, v in ipairs(info) do
			local playerX, playerY, playerZ = v.pos[1], v.pos[2], v.pos[3]-1
			local sx, sy = getScreenFromWorldPosition(playerX, playerY, playerZ + 0.5)
			if sx and sy then
				local cx, cy, cz = getCameraMatrix()
				local distance = getDistanceBetweenPoints3D(playerX2, playerY2, playerZ2, playerX, playerY, playerZ + 0.5)
				if distance < 20 then
					dxDrawBorderedText3 ( ""..v.money.."", sx, sy, sx, sy , tocolor (0, 255, 0, 255 ),1, "default-bold","center", "center" ) 
				end
			end
		end
	end
end)

function dxDrawBorderedText3( text, x, y, w, h, color, scale, font, alignX, alignY, clip, wordBreak, postGUI )
	dxDrawText(text:gsub('#%x%x%x%x%x%x', ''), (x) + 1, (y) + 1, (w) + 1, (h) + 1, tocolor ( 0, 0, 0, 255 ), scale, font, alignX, alignY, clip, wordBreak, postGUI, true)
	dxDrawText(text, x, y, w, h, color, scale, font, alignX, alignY, clip, wordBreak, postGUI, true)
end