local sx_, sy_ = guiGetScreenSize()
local sx, sy = sx_/1360, sy_/768
local screenX, screenY = guiGetScreenSize() 
local bicicletas = {
[510]=true,
[481]=true,
[509]=true,
}
local CambioTable = {
[2]="1",
[50]="2",
[80]="3",
[105]="4",
[130]="5",
[160]="6",
}
addEventHandler("onClientRender", getRootElement(), function()
	if not isPlayerMapVisible( ) then
		local veh = getPedOccupiedVehicle(localPlayer)
		if veh then
			if not bicicletas[veh:getModel()] then
				local gas = veh:getData("Fuel") or 0
				if gas then
					local x, y, z = getElementPosition(localPlayer)
					local screenW, screenH = guiGetScreenSize()
					--Ubicación: "..getZoneName(x,y,z).."\nGasolina: "..gas.."%
					local vida = veh:getHealth()
					local kmh = math.ceil(getElementSpeed(veh))
					--
					if CambioTable[kmh] then
						cambio = CambioTable[kmh]
					end
					if kmh <= 1 then
						cambio = "N"
					end
					--
                            
                    --dxDrawRectangle(screenW * 0.7687, screenH * 0.8034, screenW * 0.1991, screenH * 0.0521, tocolor(0, 0, 0, 178), false)
                    --dxDrawText("" ..(kmh).."km/h - " ..gas.. "%", screenW * 0.7760, screenH * 0.8073, screenW * 0.9283, screenH * 0.8424, tocolor(255, 255, 255, 255), 1.00, "bankgothic", "left", "top", false, false, false, false, false)
                    --dxDrawText(""..math.floor(gas).."", screenX-125, screenY-100, 170, 300,tocolor ( 255,150,0 ),0.6,myFont)
                    dxDrawText("\n\nCambio: "..(cambio or "N").."", (screenW * 0.0051) - 1, (screenH * 0.6120) - 1, (screenW * 0.0922) - 1, (screenH * 0.6419) - 1, tocolor(0, 0, 0, 255), 1.00, "default-bold", "left", "top", false, false, false, false, false)
                    dxDrawText("\n\nCambio: "..(cambio or "N").."", (screenW * 0.0051) + 1, (screenH * 0.6120) - 1, (screenW * 0.0922) + 1, (screenH * 0.6419) - 1, tocolor(0, 0, 0, 255), 1.00, "default-bold", "left", "top", false, false, false, false, false)
                    dxDrawText("\n\nCambio: "..(cambio or "N").."", (screenW * 0.0051) - 1, (screenH * 0.6120) + 1, (screenW * 0.0922) - 1, (screenH * 0.6419) + 1, tocolor(0, 0, 0, 255), 1.00, "default-bold", "left", "top", false, false, false, false, false)
                    dxDrawText("\n\nCambio: "..(cambio or "N").."", (screenW * 0.0051) + 1, (screenH * 0.6120) + 1, (screenW * 0.0922) + 1, (screenH * 0.6419) + 1, tocolor(0, 0, 0, 255), 1.00, "default-bold", "left", "top", false, false, false, false, false)
                    dxDrawText("\n\nCambio: "..(cambio or "N").."", screenW * 0.0051, screenH * 0.6120, screenW * 0.0922, screenH * 0.6419, tocolor(255, 255, 255, 255), 1.00, "default-bold", "left", "top", false, false, false, false, false
)
				end
			end
		end
	end
	if Rentados then
		for _, rentado in ipairs(Rentados) do
			if not rentado:getData('InRenta') then
				local pos = rentado.position
				local cx,cy,cz = getCameraMatrix()
				local dist = getDistanceBetweenPoints3D( pos, cx,cy,cz )
				local maxDist = 15
				local precio = rentado:getData('Vehiculo:Rentable:Precio')
				local x,y = getScreenFromWorldPosition(pos, 0, false)
				local up = (getElementRadius( rentado ) or 1) * 30
				if dist <= maxDist then
					if x and y then
						dxDrawBourdeText(1, 'Vehiculo Rentable', x, y-up, x, y, tocolor(255,255,255), tocolor(0,0,0), 1.5-(dist/maxDist), 'default-bold', 'center','center', false, false, false,true)
					end
				end
			elseif rentado:getData('InRenta') == localPlayer then
				
				local segundos = rentado:getData('Vehiculo:Rentable:Duracion')
				local minutos = math.abs(math.floor(segundos/60))
				local tiempo = minutos..' Min ' ..(segundos-(60*minutos))..' Seg'
				local sW = sx_/1280
				dxDrawBourdeText(1, 'Vehiculo Rentado\nDuracion '..tiempo,  96*sW, 502*sy, 251*sW, 532*sy, tocolor(255,255,255), tocolor(0,0,0), 1, 'default-bold', 'center','center', false, false, false,true)
			end
		end
	end
end)
addEvent('onClienVehicleRentaText', true)
addEventHandler('onClienVehicleRentaText', root,
	function(array)
		Rentados = array
	end
)
function getElementSpeed( element )
	if isElement( element ) then
		do
			local x, y, z = getElementVelocity( element )
			return (x ^ 2 + y ^ 2 + z ^ 2) ^ 0.5 * 1.61 * 100
		end
	else
		outputDebugString("Not an element. Can't get speed")
		return false
	end
end
function dxDrawBorderedText( text, x, y, w, h, color, scale, font, alignX, alignY, clip, wordBreak, postGUI )
	dxDrawText(text:gsub('#%x%x%x%x%x%x', ''), (x) + 1, (y) + 1, (w) + 1, (h) + 1, tocolor ( 0, 0, 0, 255 ), scale, font, alignX, alignY, clip, wordBreak, postGUI, true)
	dxDrawText(text, x, y, w, h, color, scale, font, alignX, alignY, clip, wordBreak, postGUI, true)
end
addEvent('SonidoEncenderVeh',true)
addEventHandler('SonidoEncenderVeh', localPlayer,
	function(type)
		local sound = playSound3D( ':resources/motor.mp3', source.position )
		sound:setVolume(0.70)
		--setTimer(destroyElement, 3000, 1, sound)
	end
)
addEvent('SonidoBloquearVeh',true)
addEventHandler('SonidoBloquearVeh', localPlayer,
	function(type)
		local sound = playSound3D( ':resources/CarAlarmChirp.mp3', source.position )
		sound:setVolume(0.70)
		--setTimer(destroyElement, 3000, 1, sound)
	end
)
addEvent('MaleteroAbrir',true)
addEventHandler('MaleteroAbrir', localPlayer,
	function(type)
		local sound = playSound3D( ':resources/maletero2.mp3', source.position )
		sound:setVolume(0.70)
		--setTimer(destroyElement, 3000, 1, sound)
	end
)
addEvent('MaleteroCerrar',true)
addEventHandler('MaleteroCerrar', localPlayer,
	function(type)
		local sound = playSound3D( ':resources/maletero.mp3', source.position )
		sound:setVolume(0.70)
		--setTimer(destroyElement, 3000, 1, sound)
	end
)
toggleControl('horn', true )
local bikes = {
[581]=true,
[462]=true,
[521]=true,
[463]=true,
[522]=true,
[461]=true,
[448]=true,
[468]=true,
[586]=true,
[523]=true,
[471]=true,
}
local bicicletas = {
[510]=true,
[481]=true,
[509]=true,
}
addEventHandler("onClientVehicleStartEnter", getRootElement(), function(player,seat,door)
	if seat == 0 then
		if player:getData('Roleplay:faccion') == source:getData("VehiculoPublico") or player:getData("Roleplay:trabajo") == source:getData("VehiculoPublico") or player:getData("Roleplay:Mision") == source:getData("VehiculoPublico") then
			if bikes[source:getModel()] then
				if source:getData("LockedVeh") then
					cancelEvent()
				end
				if source:getData("Locked") == "Cerrado" then
					cancelEvent(  )
					outputChatBox("¡Este vehiculo esta cerrado!", 200, 0, 0)
				end
			end
			if bicicletas[source:getModel()] then
				if source:getData("LockedVeh") then
					cancelEvent()
				end
				if source:getData("CandadoBicicleta") == true then
					setElementFrozen(source, false)
				else
					setElementFrozen(source, true)
				end
			end
		else
			if bikes[source:getModel()] then
				if source:getData("LockedVeh") then
					cancelEvent()
				end
				if source:getData("Locked") == "Cerrado" then
					cancelEvent(  )
					outputChatBox("¡Este vehiculo esta cerrado!", 200, 0, 0)
				end
			end
			if bicicletas[source:getModel()] then
				if source:getData("LockedVeh") then
					cancelEvent()
				end
				if source:getData("CandadoBicicleta") == true then
					setElementFrozen(source, true)
				else
					setElementFrozen(source, false)
				end
			end
		end
	else
		if bikes[source:getModel()] then
			if source:getData("LockedVeh") then
				cancelEvent()
			end
			if source:getData("Locked") == "Cerrado" then
				cancelEvent(  )
				outputChatBox("¡Este vehiculo esta cerrado!", 200, 0, 0)
			end
		end
		if bicicletas[source:getModel()] then
			if source:getData("LockedVeh") then
				cancelEvent()
			end
			if source:getData("CandadoBicicleta") == true then
				setElementFrozen(source, true)
			else
				setElementFrozen(source, false)
			end
		end
	end
end)
addEventHandler("onClientVehicleEnter", getRootElement(), function(player, seat)
	if bicicletas[source:getModel()] then
		if source:getData("CandadoBicicleta") == true then
			setElementFrozen(source, false)
		else
			setElementFrozen(source, true)
		end
	end
end)
function dxDrawBourdeText(lines, text, x, y, sx, sy, color, color2, size, font, alignX, alignY,clip, wordBreak, postGUI, colorCoded, subPixelPositioning, fRotation, fRotationCenterX, fRotationCenterY)
	local lines = lines or 2
	for i= -lines, lines, lines do
		for j= -lines, lines, lines do
			dxDrawText( text:gsub('#%x%x%x%x%x%x',''), x + i, y + j, sx + i, sy + j, color2, size, font, alignX, alignY, clip, wordBreak, postGUI, colorCoded, subPixelPositioning, fRotation, fRotationCenterX, fRotationCenterY)
		
		end
	end
	dxDrawText( text, x, y, sx, sy, color, size, font, alignX, alignY, clip, wordBreak, postGUI, colorCoded, subPixelPositioning, fRotation, fRotationCenterX, fRotationCenterY)
end
