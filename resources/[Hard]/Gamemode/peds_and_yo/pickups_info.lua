local pickups_infos = {
					  
                     { info = "(( ¡Renta tu vehículo, recuerda mantenerlo en buen estado, usa #0FFF00/alquilarveh#ffffff! ))", 1654.4733886719, -1900.1300048828, 13.552103996277, r = 255, g = 255, b = 255, font = "default-bold" },
					
					  }
addEventHandler("onClientResourceStart", resourceRoot, function()
	for i, v in pairs( pickups_infos ) do
		Pickup( v[1], v[2], v[3], 3, 1239, 0 )
	end
end)
addEventHandler("onClientRender", getRootElement(), function()
	local playerX2, playerY2, playerZ2 = getElementPosition ( localPlayer )
	for k, v in pairs(pickups_infos) do
		local playerX, playerY, playerZ = v[1], v[2], v[3]
		local sx, sy = getScreenFromWorldPosition(playerX, playerY, playerZ + 0.5)
		if sx and sy then
			local cx, cy, cz = getCameraMatrix()
			local distance = getDistanceBetweenPoints3D(playerX2, playerY2, playerZ2, playerX, playerY, playerZ + 0.5)
			if distance < 20 then
				dxDrawBorderedText3 ( v.info, sx, sy, sx, sy , tocolor ( v.r, v.g, v.b, 255 ),1, v.font,"center", "center" ) 
			end
		end
	end
end)
function dxDrawBorderedText3( text, x, y, w, h, color, scale, font, alignX, alignY, clip, wordBreak, postGUI )
	dxDrawText(text:gsub('#%x%x%x%x%x%x', ''), (x) + 1, (y) + 1, (w) + 1, (h) + 1, tocolor ( 0, 0, 0, 255 ), scale, font, alignX, alignY, clip, wordBreak, postGUI, true)
	dxDrawText(text, x, y, w, h, color, scale, font, alignX, alignY, clip, wordBreak, postGUI, true)
end
local posxD = {
			  }
addEventHandler("onClientRender", getRootElement(), function()
	if localPlayer:getInterior() == 3 and localPlayer:getDimension() == 0 then
	for k, v in ipairs(posxD) do
		tx, ty, tz = v[1], v[2], v[3]
		local px, py, pz = getElementPosition(localPlayer)
		dist = math.sqrt( ( px - tx ) ^ 2 + ( py - ty ) ^ 2 + ( pz - tz ) ^ 2 )
		if dist < 10 then
			if isLineOfSightClear( px, py, pz, tx, ty, tz, true, false, false, true, false, false, false,localPlayer ) then
				local sx, sy, sz = v[1], v[2], v[3]
				local x, y = getScreenFromWorldPosition( sx, sy, sz)
				if x and y then
					BorderedText ( tostring(v[4]), x-80, y-120, 200 + x-80, 40 + y-120, tocolor ( 253, 206, 97, 255 ),1, "default-bold","center", "center", false, false, false, true, false )
				end
			end
		end
	end
	end
end)
function BorderedText( text, x, y, w, h, color, scale, font, alignX, alignY, clip, wordBreak, postGUI )
	dxDrawText(text:gsub('#%x%x%x%x%x%x', ''), (x) - 1, (y) + 1, (w) - 1, (h) + 1, tocolor ( 0, 0, 0, 255 ), scale, font, alignX, alignY, clip, wordBreak, postGUI, true)
	dxDrawText(text:gsub('#%x%x%x%x%x%x', ''), (x) + 1, (y) + 1, (w) + 1, (h) + 1, tocolor ( 0, 0, 0, 255 ), scale, font, alignX, alignY, clip, wordBreak, postGUI, true)
	dxDrawText(text, x, y, w, h, color, scale, font, alignX, alignY, clip, wordBreak, postGUI, true)
end