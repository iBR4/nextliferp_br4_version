local ArmasMarcador = {}
local TiendasArmas = {
{296.23471069336, -80.811370849609, 1001.515625, int = 4, dim = 0},
{295.87588500977, -38.510353088379, 1001.515625, int = 1, dim = 0}
}
addEventHandler("onResourceStart", resourceRoot, function()
	for i, v in ipairs(TiendasArmas) do
		p = Pickup(v[1], v[2], v[3], 3, 1274, 0)
		p:setData("pickup.infoshops", "Armas")
		p:setInterior(v.int)
		p:setDimension(v.dim)
		--
		ArmasMarcador[i] = Marker(v[1], v[2], v[3]-1, "cylinder", 1.5, 100, 100, 50, 0)
		ArmasMarcador[i]:setInterior(v.int)
		ArmasMarcador[i]:setDimension(v.dim)
		--
		addEventHandler("onMarkerHit", ArmasMarcador[i], function(hitElement)
			if hitElement:getType() == "player" then
				if not hitElement:isInVehicle() then
					bindKey ( hitElement, "F", "down", OpenWindWeapon )
					addCommandHandler("comprar", OpenWindWeapon)
				end
			end
		end)
		addEventHandler("onMarkerLeave", ArmasMarcador[i], function(hitElement)
			if hitElement:getType() == "player" then
				if not hitElement:isInVehicle() then
					unbindKey ( hitElement, "F", "down", OpenWindWeapon )
				end
			end
		end)
	end
end)
function OpenWindWeapon( player )
	if not player:isInVehicle() then
	local g = getElementData(player,"Roleplay:Licencia_Arma")
	if (g >= 1) then
		player:triggerEvent("Armas:setWindow", player)
		unbindKey(player, "F", "down", OpenWindWeapon)
	else
	outputChatBox("No tienes licencia de armas",player,255,255,255,true)
		end
	end
end
addEvent("buyWeapon", true)
addEventHandler("buyWeapon", root, function(id, itemName, costo, descripcion, valor)
	print(id, valor)
	if source:getMoney() >= tonumber(costo) then
		if itemName == "Chaleco" then
			exports["Notificaciones"]:setTextNoti(source, "Usted ha comprado chaleco anti balas por "..convertNumber(costo), 50, 150, 50)
			source:setArmor(100)
			source:takeMoney(costo)
		else
			exports["Notificaciones"]:setTextNoti(source, "Usted ha comprado "..itemName.." por "..convertNumber(costo), 50, 150, 50)
			giveWeapon(source, id, valor, true)
			source:takeMoney(costo)
		end
		else
		exports["Notificaciones"]:setTextNoti(source, "No tienes suficiente dinero para comprar ", 150, 50, 50)
	end	
end)