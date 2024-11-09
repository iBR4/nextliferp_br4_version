local sx_, sy_ = guiGetScreenSize()
local sx, sy = sx_/1360, sy_/768
local ValoresTrabajo = {}
local PosicionAuto = {}
local MarcadoresRuta = {}
local BlipsRuta = {}
local PedsRuta = {}
local TimerK = {}
local tableN = {}
addEventHandler("onClientRender", getRootElement(), function()
	--
	local playerX2, playerY2, playerZ2 = getElementPosition ( localPlayer )
	for k, v in pairs(getJobsCarpintero()) do
		local playerX, playerY, playerZ = v[1], v[2], v[3]
		local sx, sy = getScreenFromWorldPosition(playerX, playerY, playerZ + 0.5)
		if sx and sy then
			local cx, cy, cz = getCameraMatrix()
			local distance = getDistanceBetweenPoints3D(playerX2, playerY2, playerZ2, playerX, playerY, playerZ + 0.5)
			if distance < 20 then
				dxDrawBorderedText3 ( v[4], sx, sy, sx, sy , tocolor (0, 139, 255, 255 ),1, "default-bold","center", "center" ) 
			end
		end
	end
end)
function dxDrawBorderedText3( text, x, y, w, h, color, scale, font, alignX, alignY, clip, wordBreak, postGUI )
	dxDrawText(text:gsub('#%x%x%x%x%x%x', ''), (x) + 1, (y) + 1, (w) + 1, (h) + 1, tocolor ( 0, 0, 0, 255 ), scale, font, alignX, alignY, clip, wordBreak, postGUI, true)
	dxDrawText(text, x, y, w, h, color, scale, font, alignX, alignY, clip, wordBreak, postGUI, true)
end
addEventHandler( "onClientRender", getRootElement(), 
	function()
		local x,y = getScreenFromWorldPosition( 2405.0534667969, -1315.2135009766, 25.267454147339, 0, true )
		local dist = getDistanceBetweenPoints3D(   2405.0534667969, -1315.2135009766, 25.267454147339, getElementPosition(localPlayer) )
		if x and dist <= 10 then
			if (getElementData(localPlayer, "Roleplay:trabajoVIP") == "Carpintero") or (getElementData(localPlayer, "Roleplay:trabajo") == "Carpintero") then
			x = x - (dxGetTextWidth( 'click izquierdo', 2-(dist/30)*2, "default-bold" )/2)
			
			dxDrawText('Click para agarrar madera', x-1, y-1, x+1, y+1, tocolor(0,0,0,255), 1.0-(dist/16), "default-bold","left","top",false,false,false,false,false)
			dxDrawText('Click para agarrar madera', x+1, y+1, x-1, y-1, tocolor(0,0,0,255), 1.0-(dist/16), "default-bold","left","top",false,false,false,false,false)
			dxDrawText('Click para agarrar madera', x, y, x, y, tocolor(251,255,120,255), 1.0-(dist/16), "default-bold","left","top",false,false,false,false,false)
			end
		end
	end
)
addEventHandler( "onClientRender", getRootElement(), 
	function()
		local x,y = getScreenFromWorldPosition( 2402.4873046875, -1306.521484375, 25.387882232666, 0, true )
		local dist = getDistanceBetweenPoints3D(2402.4873046875, -1306.521484375, 25.387882232666, getElementPosition(localPlayer) )
		if x and dist <= 10 then
			x = x - (dxGetTextWidth( '', 2-(dist/30)*2, "default-bold" )/2)
			
			dxDrawText('', x-1, y-1, x+1, y+1, tocolor(0,0,255,255), 1.5-(dist/10), "default-bold","left","top",false,false,false,false,false)
			dxDrawText('', x+1, y+1, x-1, y-1, tocolor(0,0,255,255), 1.5-(dist/10), "default-bold","left","top",false,false,false,false,false)
			dxDrawText('', x, y, x, y, tocolor(2,172,240,255), 1.5-(dist/10), "default-bold","left","top",false,false,false,false,false)
		end
	end
)
addEventHandler( "onClientRender", getRootElement(), 
	function()
		local x,y = getScreenFromWorldPosition(2398.861328125, -1306.4384765625, 25.514459609985, 0, true )
		local dist = getDistanceBetweenPoints3D(2398.861328125, -1306.4384765625, 25.514459609985, getElementPosition(localPlayer) )
		if x and dist <= 10 then
			x = x - (dxGetTextWidth( '', 2-(dist/30)*2, "default-bold" )/2)
			
			dxDrawText('', x-1, y-1, x+1, y+1, tocolor(0,0,255,255), 1.5-(dist/10), "default-bold","left","top",false,false,false,false,false)
			dxDrawText('', x+1, y+1, x-1, y-1, tocolor(0,0,255,255), 1.5-(dist/10), "default-bold","left","top",false,false,false,false,false)
			dxDrawText('', x, y, x, y, tocolor(2,172,240,255), 1.5-(dist/10), "default-bold","left","top",false,false,false,false,false)
		end
	end
)
addEventHandler( "onClientRender", getRootElement(), 
	function()
		local x,y = getScreenFromWorldPosition(2396.2631835938, -1315.2139892578, 25.491882324219, 0, true )
		local dist = getDistanceBetweenPoints3D(2396.2631835938, -1315.2139892578, 25.491882324219, getElementPosition(localPlayer) )
		if x and dist <= 10 then
			if (getElementData(localPlayer, "Roleplay:trabajoVIP") == "Carpintero") or (getElementData(localPlayer, "Roleplay:trabajo") == "Carpintero") then
			x = x - (dxGetTextWidth( 'Click para dejar el mueble', 2-(dist/30)*2, "default-bold" )/2)
			
			dxDrawText('Click para dejar el mueble', x-1, y-1, x+1, y+1, tocolor(0,0,0,255), 1.0-(dist/20), "default-bold","left","top",false,false,false,false,false)
			dxDrawText('Click para dejar el mueble', x+1, y+1, x-1, y-1, tocolor(0,0,0,255), 1.0-(dist/20), "default-bold","left","top",false,false,false,false,false)
			dxDrawText('Click para dejar el mueble', x, y, x, y, tocolor(70,255,0,255), 1.0-(dist/20), "default-bold","left","top",false,false,false,false,false)
			end
		end
	end
)
