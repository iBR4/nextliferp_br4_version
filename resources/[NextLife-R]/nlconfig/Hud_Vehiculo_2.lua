local smothedRotation = 0
NextMp = nil
speedometerEnabled = true

Width, Height = guiGetScreenSize()
BSWidth = 225
BSHeight = 225
BSPosX = (Width - 20)
BSPosY = (Height - 45)

font_veh = dxCreateFont("files/hudveh/font.otf", 20)
font_veh_2 = dxCreateFont("files/hudveh/font.otf", 13)

function isCustomSpeedometerEnabled(state)
	speedometerEnabled = state
end

function getElementSpeed2(element,unit)
    if (unit == nil) then unit = 0 end
    if (isElement(element)) then
        local x,y,z = getElementVelocity(element)
        if (unit=="mph" or unit==1 or unit =='1') then
            return math.floor((x^2 + y^2 + z^2) ^ 0.5 * 100)
        else
            return math.floor((x^2 + y^2 + z^2) ^ 0.5 * 100 * 1.609344)
        end
    else
        return false
    end
end

function getVehicleRPM(vehicle)
	local vehicleRPM = 0
    if (vehicle) then  
        if (getVehicleEngineState(vehicle) == true) then
            if getVehicleCurrentGear(vehicle) > 0 then             
                vehicleRPM = math.floor(((getElementSpeed2(vehicle, "kmh")/getVehicleCurrentGear(vehicle))*150) + 0.5) 
                if (vehicleRPM < 650) then
                    vehicleRPM = math.random(650, 750)
                elseif (vehicleRPM >= 9800) then
                    vehicleRPM = math.random(9800, 9900)
                end
            else
                vehicleRPM = math.floor((getElementSpeed2(vehicle, "kmh")*150) + 0.5)
                if (vehicleRPM < 650) then
                    vehicleRPM = math.random(650, 750)
                elseif (vehicleRPM >= 9800) then
                    vehicleRPM = math.random(9800, 9900)
                end
            end
        else
            vehicleRPM = 0
        end
        return tonumber(vehicleRPM)
    else
        return 0
    end
end


function getFormatGear()
    local gear = getVehicleCurrentGear(getPedOccupiedVehicle(localPlayer))
    local rear = "R"
	local neutral = "N"
    if (gear > 0) then 
        return gear
    else
        return rear
    end
end

function getFormatNeutral()
	local neutral = "N"
	return neutral
end

function getVehicleSpeed()
local theVehicle = getPedOccupiedVehicle(localPlayer)
	if theVehicle then
		local vx, vy, vz = getElementVelocity (theVehicle)
		return math.sqrt(vx^2 + vy^2 + vz^2) * 225
	end
    return 0
end

local damageTimer = setTimer(function() end, 1000, 0)

function speedoMeter()
	local vehicle = getPedOccupiedVehicle(localPlayer)
	if isPedInVehicle(localPlayer) and vehicle and (Save.HudVehsSecundario and Save.HudVehsSecundario == 'Si') then
		local speed = ("%003d"):format(getElementSpeed2(vehicle, "kmh"))
		local rot = math.floor(((270/9800)* getVehicleRPM(vehicle)) + 0.5)
		local vehicleSpeed = getVehicleSpeed()
		if (isPlayerMapVisible() or not NextMp or not speedometerEnabled) then return end
		if (smothedRotation < rot) then
			smothedRotation = smothedRotation + 1.5
		end
		if (smothedRotation > rot) then
			smothedRotation = smothedRotation - 1.5
		end
		if smothedRotation > 230 then
			smothedRotation = 230
		end
		if smothedRotation < -180 then
			smothedRotation = -180
		end
		dxDrawImage(BSPosX-BSWidth,BSPosY-BSHeight,BSWidth,BSHeight,"files/hudveh/panel.png")
		dxDrawImage(BSPosX-BSWidth,BSPosY-BSHeight,BSWidth,BSHeight,"files/hudveh/ibre.png", smothedRotation, -0.5, 8, tocolor(255,255,255,225))
		
		-- HIZ SAYAC --
		if ( tonumber(speed) <= tonumber(999) ) then
			dxDrawText(speed, BSPosX-137, BSPosY-155, 30, 20, tocolor(255,255,255,255), 1, font_veh)
		else
			dxDrawText("999", BSPosX-137, BSPosY-155, 30, 20, tocolor(255,255,255,255), 1, font_veh)
		end
		
		-- VİTES --
		if ( vehicleSpeed == 0 ) then
			dxDrawText(getFormatNeutral().."", BSPosX-118, BSPosY-100, 40, 30, tocolor(255,255,255,255), 1, font_veh_2)
			dxDrawText("R", BSPosX-138, BSPosY-100, 40, 30, tocolor(255,255,255,100), 1, font_veh_2)
			dxDrawText("1", BSPosX-98, BSPosY-100, 40, 30, tocolor(255,255,255,100), 1, font_veh_2)
		elseif ( getFormatGear() == "R" ) then
			dxDrawText(getFormatGear().."", BSPosX-118, BSPosY-100, 40, 30, tocolor(255,255,255,255), 1, font_veh_2)
			dxDrawText("N", BSPosX-98, BSPosY-100, 40, 30, tocolor(255,255,255,100), 1, font_veh_2)
		elseif ( vehicleSpeed > 0 ) then
			local vites = getFormatGear()
			local onceki,sonraki
			onceki = vites -1
			sonraki = vites +1
			if vites == 1 then onceki = "N"	end
			if sonraki > 5 then sonraki = "" end
			dxDrawText(getFormatGear().."", BSPosX-118, BSPosY-100, 40, 30, tocolor(255,255,255,255), 1, font_veh_2)
			dxDrawText(tostring(sonraki), BSPosX-98, BSPosY-100, 40, 30, tocolor(255,255,255,100), 1, font_veh_2)
			dxDrawText(tostring(onceki), BSPosX-138, BSPosY-100, 40, 30, tocolor(255,255,255,100), 1, font_veh_2)
		end
		-- MOTOR --
		if(getVehicleEngineState(vehicle))then
			dxDrawImage(BSPosX-200,BSPosY-47,32,27,"files/hudveh/engine.png",0,0,0,tocolor(255,255,255,255))
		else
			dxDrawImage(BSPosX-200,BSPosY-47,32,27,"files/hudveh/engine.png",0,0,0,tocolor(54,54,54,255))
		end
		-- Luces
		if getVehicleOverrideLights(vehicle) == 2 then
			dxDrawImage(BSPosX-155,BSPosY-37,32,27,"files/hudveh/light.png",0,0,0,tocolor(255,255,255,255))
		else
			dxDrawImage(BSPosX-155,BSPosY-37,32,27,"files/hudveh/light.png",0,0,0,tocolor(54,54,54,255))
		end
		-- Bloqueos
		if isVehicleLocked(vehicle)then
			dxDrawImage(BSPosX-105,BSPosY-37,32,27,"files/hudveh/lock.png",0,0,0,tocolor(255,255,255,255))
		else
			dxDrawImage(BSPosX-105,BSPosY-37,32,27,"files/hudveh/lock.png",0,0,0,tocolor(54,54,54,255))
		end
		-- 
		if isElementFrozen(vehicle) then
			dxDrawImage(BSPosX-58,BSPosY-47,32,27,"files/hudveh/handbrake.png",0,0,0,tocolor(255,0,0,255))
		else
			dxDrawImage(BSPosX-58,BSPosY-47,32,27,"files/hudveh/handbrake.png",0,0,0,tocolor(54,54,54,255))
		end
		-- 
		local r1,g1,b1, r2,g2,b2, a
		local vehicleHealth = getElementHealth(vehicle ) / 10  -- Divide entre 10, por defecto el denominador es 1000
		if (vehicleHealth > 35) then
			r1,g1,b1 = 255,255,255
			a = 0
		else
			r1,g1,b1 = 255,0,0
			local aT = getTimerDetails(damageTimer)
			if (aT > 500) then
				a = (aT-500)/500*255
			else
				a = (500-aT)/500*255
			end
		end
		dxDrawImage(BSPosX-BSWidth,BSPosY-BSHeight,BSWidth,BSHeight,"files/hudveh/red.png", 0, 0, 0, tocolor(r1,g1,b1,a))
	end
end



addEventHandler("onClientKey", root,function(key, state) 
	if (state) then
		if (key == 'F11') then
			NextMp = not NextMp
		end
	end
end)

addEventHandler("onClientVehicleEnter",root,function(player)
	if(player == getLocalPlayer())then
		removeEventHandler("onClientRender",root,speedoMeter)
		addEventHandler("onClientRender",root,speedoMeter)
		NextMp = true
	end
end)
addEventHandler("onClientVehicleExit",root,function(player)
	if(player == getLocalPlayer())then
		removeEventHandler("onClientRender",root,speedoMeter)
		NextMp = false
	end
end)
addEventHandler("onClientVehicleExplode",root,function(player)
	if getElementType(source) == "vehicle" and getPedOccupiedVehicle(getLocalPlayer()) == source then
		removeEventHandler("onClientRender",root,speedoMeter)
		NextMp = false
	end
end)
addEventHandler("onClientElementDestroy", getRootElement(), function(player)
	if getElementType(source) == "vehicle" and getPedOccupiedVehicle(getLocalPlayer()) == source then
		removeEventHandler("onClientRender",root,speedoMeter)
		NextMp = false
	end
end)