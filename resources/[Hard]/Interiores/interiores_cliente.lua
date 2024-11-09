addEvent("onClientInteriorEnter", true)
addEvent("onClientInteriorExit", true)
addEventHandler("onClientRender", getRootElement(), function()
	for k, v in ipairs(getElementsByType("pickup")) do
		local pick = v:getData("pickup.interior")
		
		if pick == true then
			tx, ty, tz = getElementPosition( v )
			local px, py, pz = getElementPosition(localPlayer)
			dist = math.sqrt( ( px - tx ) ^ 2 + ( py - ty ) ^ 2 + ( pz - tz ) ^ 2 )
			if dist < 8 then
				if isLineOfSightClear( px, py, pz, tx, ty, tz, true, false, false, true, false, false, false,localPlayer ) then
					local sx, sy, sz = getElementPosition( v )
					local x, y = getScreenFromWorldPosition( sx, sy, sz)
					if x and y then
						
						dxDrawBorderedText ("#FFFB89Usa la #ffffff'F' #FFFB89para interactuar", x-150, y+20, 200 + x-80, 40 + y-60, tocolor ( 255, 255, 255, 255 ),1, "default-bold","center", "center" )
						
					end
				
				end
			end
		end
	end
end)
function dxDrawBorderedText( text, x, y, w, h, color, scale, font, alignX, alignY, clip, wordBreak, postGUI )
	dxDrawText(text:gsub('#%x%x%x%x%x%x', ''), (x) - 1, (y) + 1, (w) - 1, (h) + 1, tocolor ( 0, 0, 0, 255 ), scale, font, alignX, alignY, clip, wordBreak, postGUI, true)
	dxDrawText(text:gsub('#%x%x%x%x%x%x', ''), (x) + 1, (y) + 1, (w) + 1, (h) + 1, tocolor ( 0, 0, 0, 255 ), scale, font, alignX, alignY, clip, wordBreak, postGUI, true)
	dxDrawText(text, x, y, w, h, color, scale, font, alignX, alignY, clip, wordBreak, postGUI, true)
end