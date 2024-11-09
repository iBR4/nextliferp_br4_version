	loadstring(exports.MySQL:getMyCode())()
import('*'):init('MySQL')
local MarkersPizzero = {}
local pick = Pickup(0, 0, 0,3, 1239, 0)
local pick2 = Pickup(0, 0, 0,3,1239,0)
local mope = {}
local moto = {}
addEventHandler("onResourceStart", resourceRoot, function()
	for i, v in ipairs(getJobsPizzero()) do
		--
		Blip( v[1], v[2], v[3], 56, 2, 255, 0, 0, 255, 0, 200, getRootElement() )
		--
		Pickup(v[1], v[2], v[3], 3, 1210, 0)
		MarkersPizzero[i] = Marker(v[1], v[2], v[3]-1, "cylinder", 1.5, 100, 100, 100, 0)
		MarkersPizzero[i]:setInterior(v.int)
		MarkersPizzero[i]:setDimension(v.dim)
		MarkersPizzero[i]:setData("MarkerJob", "Pizzero")
	end
end)
addEventHandler("onPickupHit",pick,function(source)
	bindKey(source,"F", "down",crearveh)
end)
addEventHandler("onPickupLeave",pick,function(source)
	unbindKey(source,"F", "down",crearveh)
end)
addEventHandler("onPickupHit",pick2,function(source)
	bindKey(source,"F", "down",destroy)
end)
addEventHandler("onPickupLeave",pick2,function(source)
	unbindKey(source,"F", "down",destroy)
end)
function crearveh(source)
	if source:getData("Roleplay:trabajo") == "Pizzero" then
		if mope[source] == nil then
			mope[source] = true
			local x,y,z = getElementPosition(source)
			moto[source] = createVehicle(448,x,y+3,z)
			moto[source]:setPlateText("Pizzero")
			moto[source]:setData('Locked', 'Cerrado')
			moto[source]:setData('Motor','apagado')
			moto[source]:setData("VehiculoPublico", "Pizzero")
			moto[source]:setData('Fuel',100)
			moto[source]:setLocked(true)
			moto[source]:setEngineState(false)
		else
			source:outputChat("",255, 100, 100, true)
		end
	else
		source:outputChat("",255, 100, 100, true)
	end
end
function destroy(source)
	if mope[source] == true then
		if source:isInVehicle() then
			if isElement(moto[source]) then
				mope[source] = nil
				moto[source]:destroy()
			end
		else
			source:outputChat("",255, 100, 100, true)
		end
	else
		source:outputChat("",255, 100, 100, true)
	end
end
addEvent('destroypizz',true)
addEventHandler('destroypizz',root,function()
	if isElement(moto[source]) then
		mope[source] = nil
		moto[source]:destroy()
	end
end)
addEvent("vehPizzero",true)
addEventHandler("vehPizzero",root,function()
	for i,source in ipairs(Element.getAllByType("player")) do
		if mope[source] == true then
			mope[source] = nil
		end
	end
end)
--
addCommandHandler("trabajar", function(player, cmd)
	if not notIsGuest(player) then
		if not player:isInVehicle() then
			if (player:getData("Roleplay:trabajo") == "") or (player:getData("Roleplay:trabajoVIP") == "") then
				for i, marker in ipairs(MarkersPizzero) do
					if player:isWithinMarker(marker) then
						local job = marker:getData("MarkerJob")
						if job == "Pizzero" then
							if (player:getData("Roleplay:trabajo") == "Pizzero") or (player:getData("Roleplay:trabajoVIP") == "Pizzero") then
								player:outputChat("¡Ya estas trabajando aquí!", 150, 50, 50, true)
							else
								player:setData("Roleplay:trabajo", "Pizzero")
								--
								player:triggerEvent("IniciarPizzero", player)
								player:setData("PizzeroPedidos", false)
								--
								player:outputChat("¡Bienvenido al trabajo de #ffff00pizzero#ffffff!", 255, 255, 255, true)
							end
						end
					end
				end
			end
		end
	end
end)
addCommandHandler("trabajar2", function(player, cmd)
	if not notIsGuest(player) then
		if not player:isInVehicle() then
			local account = getPlayerAccount(player)
			if ( isObjectInACLGroup("user."..getAccountName(account), aclGetGroup("VIP")) ) or ( isObjectInACLGroup("user."..getAccountName(account), aclGetGroup("VIP+")) ) then
			if (player:getData("Roleplay:trabajo") == "") or (player:getData("Roleplay:trabajoVIP") == "") then
				for i, marker in ipairs(MarkersPizzero) do
					if player:isWithinMarker(marker) then
						local job = marker:getData("MarkerJob")
						if job == "Pizzero" then
							if (player:getData("Roleplay:trabajo") == "Pizzero") or (player:getData("Roleplay:trabajoVIP") == "Pizzero") then
								player:outputChat("¡Ya estas trabajando aquí!", 150, 50, 50, true)
							else
								player:setData("Roleplay:trabajoVIP", "Pizzero")
								--
								player:triggerEvent("IniciarPizzero", player)
								player:setData("PizzeroPedidos", false)
								--
								player:outputChat("¡Bienvenido al trabajo de #ffff00pizzero#ffffff!", 255, 255, 255, true)
								end							
							end
						end
					end
				end
				else
				player:outputChat("#ffffffYa no tienes mas slots para #FF8700trabajos#ffffff, si quieres adquirir mas usa #3EFF00/ayuda vip", 255, 255, 255, true)
			end
		end
	end
end)
--
addCommandHandler("renunciar", function(player, cmd)
	if not notIsGuest(player) then
		if not player:isInVehicle() then
				if (getElementData(player, "Roleplay:trabajo") == "Pizzero") then
				for i, v in ipairs(MarkersPizzero) do
					if player:isWithinMarker(v) then
						local job = v:getData("MarkerJob")
						if job == "Pizzero" then
							if (getElementData(player, "Roleplay:trabajo") == "Pizzero") then
								player:outputChat("¡Acabas de renunciar!", 50, 150, 50, true)
								player:setData("Roleplay:trabajo", "")
								player:setData("PizzeroPedidos", false)
								player:triggerEvent("failedMission", player)
								triggerEvent("destroypizz",player)
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
				if (getElementData(player, "Roleplay:trabajoVIP") == "Pizzero") then
				for i, v in ipairs(MarkersPizzero) do
					if player:isWithinMarker(v) then
						local job = v:getData("MarkerJob")
						if job == "Pizzero" then
							if (getElementData(player, "Roleplay:trabajoVIP") == "Pizzero") then
								player:outputChat("¡Acabas de renunciar!", 50, 150, 50, true)
								player:setData("Roleplay:trabajoVIP", "")
								player:setData("PizzeroPedidos", false)
								player:triggerEvent("failedMission", player)
								triggerEvent("destroypizz",player)
							else
								player:outputChat("¡No has trabajado en este lugar, no puedes renunciar aquí!", 150, 50, 50, true)
								--player:outputChat("Tu trabajo actual es de: #ffff00"..player:getData("Roleplay:trabajoVIP"), 255, 255, 255, true)
							end
						end
					end
				end
			end
		end
	end
end)
--
addEventHandler("onPlayerLogin",root,function(player)
	player:setData("Roleplay:trabajo","")
	player:setData("Roleplay:trabajoVIP","")
end)
addCommandHandler("t",function(player,cmd)
player:setData("Roleplay:trabajo","")
player:setData("Roleplay:trabajoVIP","")
end)
addEvent("giveMoneyPizzero", true)
function giveMoneyPizzero()
	local propinarandom = math.random(1,6)
	local exp = exports.nlogin:getCharacterData(source,"PizzeroLv") or 1
	local totalMoney = math.ceil(math.random(150,250)*exp/2)
	local propina = math.random(50,100)
	--
	if propinarandom == 4 then
		text = "#FFFFFFAcabas de ganar: #004500$"..convertNumber(totalMoney).." pesos #ffffff + #004500$"..convertNumber(propina).." #FFFFFF de propina por la entrega."
		source:giveMoney(tonumber(totalMoney + propina))
	elseif propinarandom == 5 then
		text = "#FFFFFFAcabas de ganar: #004500$"..convertNumber(totalMoney).." pesos #ffffff + #004500$"..convertNumber(propina).." #FFFFFF de propina por la entrega."
		source:giveMoney(tonumber(totalMoney + propina))
	else
		text = "#FFFFFFAcabas de ganar: #004500$"..convertNumber(totalMoney).." pesos #ffffffpor la entrega."
		source:giveMoney(tonumber(totalMoney))
	end
	source:outputChat(text, 255, 255, 255, true)
end
addEventHandler("giveMoneyPizzero", root, giveMoneyPizzero)
addEvent("FailedMissionPizzero", true)
function FailedMissionPizzero(placa)
	source:setData("PizzeroPedidos", false)
end
addEventHandler("FailedMissionPizzero", root, FailedMissionPizzero)
local Levels = {
{2000, 1},
{3000, 2},
{4000, 3},
{5000, 4},
}
function setNivel()
	local nivel = tonumber(exports.nlogin:getCharacterData(source,"PizzeroLv")) or 1
	local actualExp = exports.nlogin:getCharacterData(source,"PizzeroExp") or 0
	if nivel == #Levels then
		exports['Notificaciones']:setTextNoti(source, '¡Estas en tu nivel maximo #ff0000visio#ffffff!', 0,255,0, true)
	elseif nivel < #Levels then
		local nuevaExp = 100
		if actualExp + nuevaExp >= Levels[nivel][1] then
			--source:setData("Pizzero:Nivel",nivel+1)
			exports.nlogin:setCharacterData(source,"PizzeroLv",nivel+1)
			--source:setData("Pizzero:Exp",Levels[nivel][1]-(actualExp + nuevaExp))
			exports.nlogin:setCharacterData(source,"PizzeroExp",Levels[nivel][1]-(actualExp + nuevaExp))
			source:outputChat("¡Recibiste: #dd80ff +"..nuevaExp.." de exp #FFFFFFy subiste al #00FF00nivel "..(nivel+1).." #FFFFFFpor trabajar!", 255, 255, 255, true)
		elseif actualExp + nuevaExp < Levels[nivel][1] then
			--source:setData("Pizzero:Exp", actualExp+nuevaExp)
			exports.nlogin:setCharacterData(source,"PizzeroExp",actualExp+nuevaExp)
			source:outputChat("¡Recibiste: #dd80ff +100 de exp #FFFFFFpor trabajar", 255, 255, 255, true)
		end
	end
end
addEvent("givePizzeroExp",true)
addEventHandler("givePizzeroExp", root,setNivel)