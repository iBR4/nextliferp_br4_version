local sx, sy = guiGetScreenSize( )
local sourceX, sourceY = 1920, 1080
local x, y = (sx/sourceX), (sy/sourceY)
local font = dxCreateFont( "fuente.ttf", 30 )
function isMouseInPosition ( x, y, width, height )
	if ( not isCursorShowing( ) ) then
		return false
	end
    local sx, sy = guiGetScreenSize ( )
    local cx, cy = getCursorPosition ( )
    local cx, cy = ( cx * sx ), ( cy * sy )
    if ( cx >= x and cx <= x + width ) and ( cy >= y and cy <= y + height ) then
        return true
    else
        return false
    end
end
local state = 1
local tarifas = { }
local t_actual = #tarifas > 0 and 1 or 1
local c_actual = tarifas and tarifas[t_actual] or 0
local botones = { {( sx - x*(-535) )/2, ( sy - y*(-710) )/2, x*55, y*15}, {( sx - x*(-545) )/2, ( sy - y*(-795) )/2, x*50, y*15},
{( sx - x*(-545) )/2, ( sy - y*(-875) )/2, x*50, y*15}, }
local dist = 0
local l_pos = { 0, 0, 0 }
local l_update = 0
addEvent( "actualizarTarifasVeh", true )
addEventHandler( "actualizarTarifasVeh", getRootElement( ),
	function( veh, vehtarifas )
		tarifas = vehtarifas
		t_actual = 1
		c_actual = tarifas[t_actual]
	end
)
function comprobarDatos(veh)
	if getElementData( veh, "tarifa" ) and getElementData( veh, "cantidad_a_pagar" ) and getElementData( veh, "distancia" ) then
		return true
	else
		return false
	end
end
addEvent( "asignarTarifasCoche", true )
addEventHandler( "asignarTarifasCoche", getRootElement( ),
	function( veh, lastarifas )
		if comprobarDatos(veh) then
			local tarifa, cantidad, distancia = getElementData( veh, "tarifa" ), getElementData( veh, "cantidad_a_pagar" ), getElementData( veh, "distancia" )
			if lastarifas then
				tarifas = lastarifas
				t_actual = tarifa
				dist = distancia
				c_actual = cantidad
			else
				tarifas = { }
				t_actual = #tarifas > 0 and 1 or 1
				c_actual = tarifas[t_actual] or 0
				dist = 0			
			end
		else
			t_actual = #tarifas > 0 and 1 or 1
			c_actual = #tarifas > 0 and tarifas[t_actual] or 0
			dist = 0				
		end
	end
)
addEventHandler( "onClientResourceStart", resourceRoot,
	function( )
		l_pos = { getElementPosition( localPlayer ) }
	end
)
addEventHandler( "onClientClick", getRootElement( ),
	function( b, s )
		if b == "left" and s == "down" then
			if isMouseInPosition( unpack(botones[1]) ) then
				local veh = getPedOccupiedVehicle( localPlayer )
				if state == 1 then 
					state = 0 
					if comprobarDatos(veh) then 
						setElementData( veh, "cantidad_a_pagar", nil )
						setElementData( veh, "tarifa", nil )
						setElementData( veh, "distancia", nil )
					end 
				else 
					local x, y, z = getElementPosition( veh ) l_pos = {x,y,z}
					state = 1 
				end
			elseif isMouseInPosition( unpack(botones[2]) ) then
				if t_actual == #tarifas then
					t_actual = 1
				else
					t_actual = t_actual + 1
				end
			elseif isMouseInPosition( unpack(botones[3]) ) then
				c_actual = #tarifas > 0 and tarifas[t_actual] or 0
			end
		end
	end
)
addEventHandler( "onClientRender", root,
	function( )
		local veh = getPedOccupiedVehicle(localPlayer)
		if veh and getVehicleNameFromModel( getElementModel( veh ) ) == "Taxi" then
			dxDrawImage( ( sx - x*650 )/2, ( sy - y*(-650) )/2, x*650, y*200, "taximetro.png" )
			dxDrawText( "ON/OFF", ( sx - x*(-540) )/2, ( sy - y*(-710) )/2, 0, 0, tocolor( 0, 0, 0 ), y*1, "default-bold" )
			dxDrawText( "Tarifa", ( sx - x*(-545) )/2, ( sy - y*(-795) )/2, 0, 0, tocolor( 0, 0, 0 ), y*1, "default-bold" )
			dxDrawText( "Reset", ( sx - x*(-545) )/2, ( sy - y*(-875) )/2, 0, 0, tocolor( 0, 0, 0 ), y*1, "default-bold" )
			dxDrawText( "•", ( sx - x*597 )/2, ( sy - y*(-653) )/2, x*50, y*50, tocolor( 0, 0, 0 ), y*2 )
			dxDrawText( "•", ( sx - x*600 )/2, ( sy - y*(-650) )/2, x*50, y*50, state == 0 and tocolor( 255, 0, 0 ) or tocolor( 0, 255, 0 ), y*2 )
			tick = getTickCount( )
			if tick - l_update > 1000 and #tarifas > 0 and state == 1 then
				local tx, ty, tz = getElementPosition( veh )
				dist = (math.floor(getDistanceBetweenPoints3D( tx, ty, tz, unpack( l_pos ) )) / 10)*tarifas[t_actual]
				l_pos = {tx, ty, tz}
				l_update = tick
			end
			if state == 1 then
				c_actual = c_actual+(dist/300)
				dxDrawText( #tarifas > 0 and t_actual or 0, x*815, y*984, sx, sy, tocolor( 255, 255, 255 ), y*1, font )
				dxDrawText( #tarifas > 0 and math.floor(c_actual) ..",00 $" or 0 ..",00 $", x*955, y*900, sx, sy, tocolor( 255, 255, 255 ), y*1, font )
				dxDrawText( #tarifas > 0 and tarifas[t_actual] ..",00 $" or 0 ..", 00 $", x*975, y*985, sx, sy, tocolor( 255, 255, 255 ), y*1, font )
				setElementData( veh, "cantidad_a_pagar", c_actual )
				setElementData( veh, "tarifa", t_actual )
				setElementData( veh, "distancia", dist )
			end
		end
	end
)