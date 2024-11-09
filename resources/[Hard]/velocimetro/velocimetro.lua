addEventHandler( "onClientVehicleEnter", resourceRoot,
	function( player, seat )
		-- restore the engine state
		if engineState then
			if seat == 0 and player == localPlayer and engineState.vehicle == source then
				setVehicleEngineState( source, engineState.state )
			end
			engineState = nil
		end
	end
)

local unitStr = "Km/h"
local speedMultiplier = 180
local g_Me = getLocalPlayer()

function getspeed()
    local velX, velY, velZ = getElementVelocity(getPedOccupiedVehicle(g_Me))
    return math.sqrt((velX * velX) + (velY * velY) + (velZ * velZ)) * speedMultiplier
end

function getElementSpeed(element, unit)
    if unit == nil then unit = "Km/h" end
    if isElement(element) then
        local x, y, z = getElementVelocity(element)
        if unit == "Km/h" then
            return math.floor(math.sqrt(x * x + y * y + z * z) * speedMultiplier)
        else
            return 0 -- Si se proporciona una unidad no válida, se devuelve 0
        end
    else
        return 0
    end
end


local screenW, screenH = guiGetScreenSize()

addEventHandler("onClientRender", getRootElement(),
    function()
    	if isPedInVehicle( getLocalPlayer() ) then
    		local vehiculo = getPedOccupiedVehicle( getLocalPlayer() )
    		if vehiculo then
    			local vehicle = getPedOccupiedVehicle(getLocalPlayer())
    			local speedkmh = getElementSpeed(vehicle, 0.1)
    			local roundedSpeedkmh = tostring( math.floor( getspeed() ) )
    			
    			-- Obtener la cantidad de gasolina del vehículo
    			local gas = vehiculo:getData("Fuel") or 0
    			
    			if roundedSpeedkmh and gas then
        			dxDrawRectangle(screenW * 0.7765, screenH * 0.7539, screenW * 0.1721, screenH * 0.0690, tocolor(0, 0, 0, 185), false)
        			dxDrawText(roundedSpeedkmh.." KM/H - "..math.floor(gas).."%", screenW * 0.7765, screenH * 0.7539, screenW * 0.9485, screenH * 0.8229, tocolor(255, 255, 255, 255), 0.70, "bankgothic", "center", "center", false, false, false, false, false)
    			end
    		end
    	end
    end
)
