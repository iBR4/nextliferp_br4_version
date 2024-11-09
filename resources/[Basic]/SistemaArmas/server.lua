loadstring(exports.MySQL:getMyCode())()
import('*'):init('MySQL')
if getResourceFromName( '[LS]NewData' ):getState() ~= 'running' then 
	return outputDebugString( 'Activa el recurso [LS]NewData', 3, 255, 255, 255 )
end
loadstring(exports["[LS]NewData"]:getMyCode())()
import('*'):init('[LS]NewData')
local Pickup = Pickup(1578.8984375, -1684.7421875, 16.1953125, 3, 348, 0)
setElementInterior(Pickup, 0)
setElementDimension(Pickup, 0)
local Marcador = Marker(1578.8984375, -1684.7421875, 16.1953125, "cylinder", 1.3, 100, 100, 100, 0)
setElementInterior(Marcador, 0)
setElementDimension(Marcador, 0)
addCommandHandler("armas", function(player, cmd)
	if isElement(player) then
		if not notIsGuest(player) then
			if isElementWithinMarker(player,Marcador) then
				if getPlayerFaction(player, "Policia") then
					player:triggerEvent("Openarm", player)
				end
			end
		end
	end
end)
addCommandHandler("armas", function(player, cmd)
	if isElement(player) then
		if not notIsGuest(player) then
			if isElementWithinMarker(player,Marcador) then
				if getPlayerFaction(player, "Gobierno") then
					player:triggerEvent("Openarm", player)
				end
			end
		end
	end
end)
addEvent("buyarma", true)
addEventHandler("buyarma", root, function(id, itemName)
	print(id, itemName)
	if itemName == "Chaleco" then
		exports["Notificaciones"]:setTextNoti(source, "Usted ha tomado un chaleco anti balas de la armeria", 50, 150, 50)
		outputChatBox ( "#13FF00Usted ha tomado un chaleco anti balas de la armeria", source, 255, 255, 255, true )
		source:setArmor(100)
	elseif itemName == "Taser" then
		outputChatBox ( "#13FF00Usted ha tomado un/a "..itemName.." de la armeria", source, 255, 255, 255, true )
		giveWeapon(source, id, 5, true)
	else
		outputChatBox ( "#13FF00Usted ha tomado un/a "..itemName.." de la armeria", source, 255, 255, 255, true )
		giveWeapon(source, id, 50, true)
	end
end)