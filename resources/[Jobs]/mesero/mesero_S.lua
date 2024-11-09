loadstring(exports.MySQL:getMyCode())()
import('*'):init('MySQL')
local MarkersMesero = {}
addEventHandler("onResourceStart", resourceRoot, function()
	for i, v in ipairs(getJobsMesero()) do
		--
		Blip( v[1], v[2], v[3], 56, 2, 255, 0, 0, 255, 0, 200, getRootElement() )
		--
		Pickup(v[1], v[2], v[3], 3, 1210, 0)
		MarkersMesero[i] = Marker(v[1], v[2], v[3]-1, "cylinder", 1.5, 100, 100, 100, 0)
		MarkersMesero[i]:setInterior(v.int)
		MarkersMesero[i]:setDimension(v.dim)
		MarkersMesero[i]:setData("MarkerJob", "Mesero")
	end
end)
addCommandHandler("trabajar", function(player, cmd)
	if not notIsGuest(player) then
		if not player:isInVehicle() then
			if (player:getData("Roleplay:trabajo") == "") or (player:getData("Roleplay:trabajoVIP") == "") then
				for i, marker in ipairs(MarkersMesero) do
					if player:isWithinMarker(marker) then
						local job = marker:getData("MarkerJob")
						if job == "Mesero" then
							if (player:getData("Roleplay:trabajo") == "Mesero") or (player:getData("Roleplay:trabajoVIP") == "Mesero") then
								player:outputChat("¡Ya estas trabajando aquí!", 150, 50, 50, true)
							else
								player:setData("Roleplay:trabajo", "Mesero")
								--
								player:triggerEvent("IniciarPizzero", player)
								player:setData("PizzeroPedidos", false)
								--
								player:outputChat("¡Bienvenido al trabajo de #ffff00mesero#ffffff!", 255, 255, 255, true)
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
				for i, marker in ipairs(MarkersMesero) do
					if player:isWithinMarker(marker) then
						local job = marker:getData("MarkerJob")
						if job == "Mesero" then
							if (player:getData("Roleplay:trabajo") == "Mesero") or (player:getData("Roleplay:trabajoVIP") == "Mesero") then
								player:outputChat("¡Ya estas trabajando aquí!", 150, 50, 50, true)
							else
								player:setData("Roleplay:trabajoVIP", "Mesero")
								--
								--
								player:outputChat("¡Bienvenido al trabajo de #ffff00mesero#ffffff!", 255, 255, 255, true)
								end							
							end
						end
					end
				end
				--else
				--player:outputChat("#ffffffYa no tienes mas slots para #FF8700trabajos#ffffff, si quieres adquirir mas usa #3EFF00/ayuda vip", 255, 255, 255, true)
			end
		end
	end
end)
--
addCommandHandler("renunciar", function(player, cmd)
	if not notIsGuest(player) then
		if not player:isInVehicle() then
				if (getElementData(player, "Roleplay:trabajo") == "Mesero") then
				for i, v in ipairs(MarkersMesero) do
					if player:isWithinMarker(v) then
						local job = v:getData("MarkerJob")
						if job == "Mesero" then
							if (getElementData(player, "Roleplay:trabajo") == "Mesero") then
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
				if (getElementData(player, "Roleplay:trabajoVIP") == "Mesero") then
				for i, v in ipairs(MarkersMesero) do
					if player:isWithinMarker(v) then
						local job = v:getData("MarkerJob")
						if job == "Mesero" then
							if (getElementData(player, "Roleplay:trabajoVIP") == "Mesero") then
								player:outputChat("¡Acabas de renunciar!", 50, 150, 50, true)
								player:setData("Roleplay:trabajoVIP", "")
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
local N_Mesero = {
	[10] = 1,
	[20] = 2,
	[30] = 3,
	[40] = 4,
	[50] = 5,
}
function getMeseroLv(player,exp)
	if N_Mesero[exp] then
		return true
	end
	return false
end
addEvent("givePlayerMoney", true)
addEventHandler("givePlayerMoney", root, function(money, gp)
    if not tonumber(money) or not tonumber(gp) then return end
    local exp = exports.nlogin:getCharacterData(source,"MeseroExp")
    exports.nlogin:setCharacterData(source,"MeseroExp",exp+1)
    player:outputChat("¡Recibiste: #dd80ff +1 de EXP #FFFFFFfelicidades!!", 255, 255, 255, true)
    local Nivel = getMeseroLv(player,exp)
    if Nivel ~= false then
		player:outputChat("¡Recibiste: #dd80ff +1 de Nivel #FFFFFFpor trabajar demás", 255, 255, 255, true)
		local nivel = exports.nlogin:getCharacterData(source,"MeseroLv")
		exports.nlogin:setCharacterData(source,"MeseroLv",nivel+1)
    end
    local sctera = getElementData(source, "GP") or 0
    plata = math.random(80, 200)
    propina = math.random(10, 50)
    givePlayerMoney ( source, plata )
    givePlayerMoney ( source, propina )
    --givePlayerMoney(source, money)
    
end)
