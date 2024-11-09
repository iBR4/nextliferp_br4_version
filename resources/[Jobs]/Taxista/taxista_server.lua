loadstring(exports.MySQL:getMyCode())()
import('*'):init('MySQL')

local MarkersTaxista = {}
local care = {}
local car = {}

addEventHandler("onResourceStart", resourceRoot, function()
	for i, v in ipairs(getJobsTaxista()) do
		--
		Blip( v[1], v[2], v[3], 56, 2, 255, 0, 0, 255, 0, 200, getRootElement() )
		--
		Pickup(v[1], v[2], v[3], 3, 1210, 0)
		MarkersTaxista[i] = Marker(v[1], v[2], v[3]-1, "cylinder", 1.5, 100, 100, 100, 0)
		MarkersTaxista[i]:setInterior(v.int)
		MarkersTaxista[i]:setDimension(v.dim)
		MarkersTaxista[i]:setData("MarkerJob", "Taxista")
	end
end)

-- addEventHandler("onPickupHit",pick,function(source)
-- 	bindKey(source,"F", "down",crearveh)
-- end)
-- addEventHandler("onPickupLeave",pick,function(source)
-- 	unbindKey(source,"F", "down",crearveh)
-- end)
-- addEventHandler("onPickupHit",pick2,function(source)
-- 	bindKey(source,"F", "down",destroy)
-- end)
-- addEventHandler("onPickupLeave",pick2,function(source)
-- 	unbindKey(source,"F", "down",destroy)
-- end)

local taxis = {
{420},
{438},
}

function crearveh(source)
	if source:getData("Roleplay:trabajo") == "Taxista" then
		if care[source] == nil then
			care[source] = true
			local x,y,z = getElementPosition(source)
			local veh = taxis[math.random(1,#taxis)]
			car[source] = createVehicle(veh[1],x+15,y,z)
			car[source]:setPlateText("Taxista")
			car[source]:setData('Locked', 'Cerrado')
			car[source]:setData('Motor','apagado')
			car[source]:setData("VehiculoPublico", "Taxista")
			car[source]:setData('Fuel',100)
			car[source]:setLocked(true)
			car[source]:setEngineState (false)
			car[source]:setFrozen(true)
		else
			source:outputChat("[ERROR] Ya tienes una Taxi Respawneada",255, 100, 100, true)
		end
	else
		source:outputChat("[ERROR] NO tienes Este trabajo",255, 100, 100, true)
	end
end

function destroy(source)
	if care[source] == true then
		if source:isInVehicle() then
			if isElement(car[source]) then
				care[source] = nil
				car[source]:destroy()
			end
		else
			source:outputChat("[ERROR] Tienes que estar encima de tu vehiculo",255, 100, 100, true)
		end
	else
		source:outputChat("[ERROR] No tienes un taxi por eliminar",255, 100, 100, true)
	end
end

addEvent("vehTaxista",true)
addEventHandler("vehTaxista",root,function()
	for i,source in ipairs(Element.getAllByType("player")) do
		if care[source] == true then
			care[source] = nil
		end
	end
end)

addCommandHandler("trabajar", function(player, cmd)
local nivel = getElementData(player,"Nivel") or 0
	if not notIsGuest(player) then
		if not player:isInVehicle() then
			if (player:getData("Roleplay:trabajo") == "") or (player:getData("Roleplay:trabajoVIP") == "") then
				for i, marker in ipairs(MarkersTaxista) do
					if player:isWithinMarker(marker) then
						local job = marker:getData("MarkerJob")
						if job == "Taxista" then
							if (player:getData("Roleplay:trabajo") == "Taxista") or (player:getData("Roleplay:trabajoVIP") == "Taxista") then
								player:outputChat("¡Ya estas trabajando aquí!", 150, 50, 50, true)
							else
								if (nivel >= 5) then
								player:setData("Roleplay:trabajo", "Taxista")
								player:outputChat("¡Bienvenido al trabajo de #ffff00Taxista#ffffff!", 255, 255, 255, true)
							else
							player:outputChat("#ffff00[Taxista]#ffffff ¡Necesitas #FF646Enivel 5 #ffffffpara poder trabajar como taxista!", 50, 150, 50, true)
								end
							end
						end
					end
				end
			end
		end
	end
end)

addCommandHandler("trabajar2", function(player, cmd)
local nivel = getElementData(player,"Nivel") or 0
	if not notIsGuest(player) then
		if not player:isInVehicle() then
			if (player:getData("Roleplay:trabajo") == "") or (player:getData("Roleplay:trabajoVIP") == "") then
				for i, marker in ipairs(MarkersTaxista) do
					if player:isWithinMarker(marker) then
						local job = marker:getData("MarkerJob")
						if job == "Taxista" then
							if (player:getData("Roleplay:trabajo") == "Taxista") or (player:getData("Roleplay:trabajoVIP") == "Taxista") then
								player:outputChat("¡Ya estas trabajando aquí!", 150, 50, 50, true)
							else
								if (nivel >= 5) then
								player:setData("Roleplay:trabajoVIP", "Taxista")
								player:outputChat("¡Bienvenido al trabajo de #ffff00Taxista#ffffff!", 255, 255, 255, true)
							else
							player:outputChat("#ffff00[Taxista]#ffffff ¡Necesitas #FF646Enivel 5 #ffffffpara poder trabajar como taxista!", 50, 150, 50, true)
								end
							end
						end
					end
				end
			end
		end
	end
end)

addCommandHandler("infotaxista", function(player, cmd)
	if not notIsGuest(player) then
		if not player:isInVehicle() then
			for i, v in ipairs(MarkersTaxista) do
				if player:isWithinMarker(v) then
					local job = v:getData("MarkerJob")
					if job == "Taxista" then 
						player:outputChat("¡Bienvenidos al trabajo de #ffff00Taxista#ffffff!", 255, 255, 255, true)
						player:outputChat("Si te sientes un anciano súbete a un taxi y pasea por Los Santos en busca de clientes.", 255, 255, 255, true)
						player:outputChat("No te olvides de tener una licencia de conducir vigente, la policía puede sancionarte.", 255, 255, 255, true)
						player:outputChat("Recuerda que puedes enviar un anuncio con el comando #ffff00/taxi", 255, 255, 255, true)
						player:outputChat(" ", 255, 255, 255, true)
						player:outputChat("Puedes trabajar con NPC´S Utilizando #ffff00/iniciartaxi #ffffff- #ffff00/cancelartaxi #ffffffo trabajar con usuarios comunes", 255, 255, 255, true)
						player:outputChat(" ", 255, 255, 255, true)
						outputChatBox("#ffffffPara poder trabajar aqui necesitaras ser #FF646Enivel 5", player, 150, 50, 50, true)
					end
				end
			end
		end
	end
end)

addCommandHandler("renunciar", function(player, cmd)
	if not notIsGuest(player) then
		if not player:isInVehicle() then
			if (getElementData(player, "Roleplay:trabajo") == "Taxista") then
				for i, v in ipairs(MarkersTaxista) do
					if player:isWithinMarker(v) then
						local job = v:getData("MarkerJob")
						if job == "Taxista" then
							if (getElementData(player, "Roleplay:trabajo") == "Taxista") then
								player:outputChat("¡Acabas de renunciar!", 50, 150, 50, true)
								player:setData("Roleplay:trabajo", "")
							else
								player:outputChat("¡No has trabajado en este lugar, no puedes renunciar aquí!", 150, 50, 50, true)
								--player:outputChat("Tu trabajo actual es de: #ffff00"..player:getData("Roleplay:trabajo"), 255, 255, 255, true)
							end
						end
					end
				end
			end
		end
	end
end)

addCommandHandler("renunciar", function(player, cmd)
	if not notIsGuest(player) then
		if not player:isInVehicle() then
			if (getElementData(player, "Roleplay:trabajoVIP") == "Taxista") then
				for i, v in ipairs(MarkersTaxista) do
					if player:isWithinMarker(v) then
						local job = v:getData("MarkerJob")
						if job == "Taxista" then
							if (getElementData(player, "Roleplay:trabajoVIP") == "Taxista") then
								player:outputChat("¡Acabas de renunciar!", 50, 150, 50, true)
								player:setData("Roleplay:trabajoVIP", "")
							else
								player:outputChat("¡No has trabajado en este lugar, no puedes renunciar aquí!", 150, 50, 50, true)
								--player:outputChat("Tu trabajo actual es de: #ffff00"..player:getData("Roleplay:trabajo"), 255, 255, 255, true)
							end
						end
					end
				end
			end
		end
	end
end)
