local inCol = false
addEventHandler( "onClientColShapeHit", root, 
	function(element)
		if element and element.type == 'player' then
			if source:getData('weapon_data') then	
				inCol = source
			end
		end
	end
)
addEventHandler( "onClientColShapeLeave", root, 
	function(element)
		if element and element.type == 'player' then
			if source:getData('weapon_data') then
				inCol = false
			end
		end
	end
)
addEventHandler( "onClientRender", getRootElement(), 
	function()
		if inCol and inCol ~= nil and inCol ~= false then
			if isElement(inCol) then
				if localPlayer:isWithinColShape(inCol) then
					local sx,sy = getScreenFromWorldPosition(inCol.position.x,inCol.position.y,inCol.position.z+.6)
					local w = dxGetTextWidth( 'Pulsa K para recoger esta arma', 1, 'default-bold')
					dxDrawText('Pulsa K para recoger esta arma',sx-w/2,sy,sx,sy,tocolor(255,255,255,255),1,'default-bold')
				end
			end
		end
	end
)
--setElementRotation(inCol:getData('weapon_data')[1], 90,y,z)
addEventHandler("onClientKey", getRootElement(),
    function(key, press)
        if inCol and inCol ~= nil and inCol ~= false and isElement(inCol) and localPlayer:isWithinColShape(inCol) then
            if #getElementsWithinColShape(inCol, 'player') == 1 and key == 'k' and press then
                local weaponData = inCol:getData('weapon_data')
                if weaponData then
                    local weaponID = weaponData[2] or 0
                    local ammoCount = weaponData[3] or 0
                    local weaponName = getWeaponNameFromID(weaponID) or "Unknown Weapon"
                    triggerLatentServerEvent('onGiveWeapon', 5000, false, resourceRoot, weaponData)
                    inCol = false
                    outputChatBox("#FFFFFF[#E59404Armas#FFFFFF]#FFFFFF Has recogido un arma #FF0000" .. weaponName .. "#FFFFFF con #0EB104" .. ammoCount .. " #FFFFFFbalas", 255, 255, 255, true)
                    
                    -- Obtener el nombre del jugador y enviarlo junto con los detalles del arma al servidor
                    local playerName = getPlayerName(localPlayer)
                    triggerServerEvent("sendDiscordLogMessageFromClient", resourceRoot, weaponName, ammoCount, playerName)
                else
                    outputChatBox("No se pudo obtener información del arma dejada. Inténtalo de nuevo.", 255, 0, 0)
                end
            end
        end
    end
)
Timer(function()
	for k,v in pairs(getElementsByType('player')) do
		if v.health <=30 then
			setPedFootBloodEnabled(v, true)
		else
			setPedFootBloodEnabled(v, false)
		end
	end
end,100,0)
