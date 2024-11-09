loadstring(exports.MySQL:getMyCode())()
import('*'):init('MySQL')
mysql = exports.MySQL
local Weapons = {}
Weapons.ID = {
	[1] = 331,
	[2] = 333,
	[3] = 334,
	[4] = 335,
	[5] = 336,
	[6] = 337,
	[7] = 338,
	[8] = 339,
	[9] = 341,
	[16] = 342,
	[17] = 343,
	[18] = 344,
	[22] = 346,
	[23] = 347,
	[24] = 348,
	[25] = 349,
	[26] = 350,
	[27] = 351,
	[28] = 352,
	[29] = 353,
	[32] = 372,
	[30] = 355,
	[31] = 356,
	[33] = 357,
	[34] = 358,
	[35] = 359,
	[36] = 360,
	[37] = 361,
	[38] = 362,
	[39] = 363,
	[41] = 365,
	[42] = 366,
	[43] = 367,
}
local weaponNames = {
	[331] = "Puñal",
	[333] = "Palo de Golf",
	[334] = "Porra de Policia",
	[335] = "Cuchillo",
	[336] = "Bate",
	[337] = "Pala",
	[338] = "Palo de billar",
	[339] = "Katana",
	[341] = "Moto sierra",
	[342]=  "Granada",
	[343] = "Gases lacrimógenos",
	[344] = "Molotov",
	[346] = "Colt 45",
	[347] = "Silenciador",
	[348] = "Desert Deagle",
	[349] = "Escopeta",
	[350] = "Escopeta Recortada",
	[351] = "SPAS 12",
	[352] = "Uzi",
	[353] = "MP5",
	[372] = "Tec-9",
	[355] = "AK-47",
	[356] = "M4",
	[357] = "Rifle",
	[358] = "Sniper",
	[359] = "Lanza Cohetes",
	[360] = "Lanza Cohetes HS",
	[361] = "Lanza llamas",
	[362] = "Minigun",
	[363] = "C-4",
	[365] = "Spray",
	[366] = "Extintor",
	[367] = "Camara",
    -- Añade los nombres correspondientes para los IDs de las armas restantes
}
local antiSpamW  = {} 
addEvent('onGiveWeapon', true)
function getPedWeapons(ped)
	local playerWeapons = {}
	if ped and isElement(ped) and getElementType(ped) == "ped" or getElementType(ped) == "player" then
		for i=2,9 do
			local wep = getPedWeapon(ped,i)
			if wep and wep ~= 0 then
				table.insert(playerWeapons,wep)
			end
		end
	else
		return false
	end
	return playerWeapons
end
function createWeaponGround(wep_id, ammo, x, y, z, int, dim, huellas)
	if wep_id ~= 0 then
		if wep_id >= 22 then
			local ID = Weapons.ID[wep_id]
			z = z - 1
			local weapon = Object(ID, x, y, z)
			local col = ColShape.Sphere(x , y, z +.5,1)
			setElementInterior(weapon, int)
			setElementDimension(weapon, dim)
			weapon:setRotation(86,270,180)
			--
			col:setData('weapon_data',{weapon,wep_id, ammo,col, corona, huellas})
		end
	end
end
function guardarma(ped)
	for i=0, 12 do 
		local v = getPedWeapon( ped, i )
		local muni = getPedTotalAmmo(ped,i)
		if v and v ~= 0 then
			if muni and muni ~= 0 then
				if getPedWeapon( ped, i ) then
					takeWeapon( ped, v )
					giveWeapon( ped, v , muni )
				end	
			end
		end
	end
end
function armaslot(id)
	if id == 30 or id == 31 then
		return 5
	elseif id == 25 then
		return 3
	end
	return false
end
local antiSpamW = {} -- Debes definir la tabla antiSpamW
-- Función para dar armas y munición
function dararma(source, cmd, who, ammo)
    if source then
        local player = getPlayerFromName(who) -- Usamos getPlayerFromName para obtener el jugador por nombre
        if player then
            local tick = getTickCount()
            if antiSpamW[source] and antiSpamW[source][1] and tick - antiSpamW[source][1] < 2000 then
                outputChatBox("Espera un momento antes de usar este comando nuevamente.", source, 255, 0, 0)
                return
            end
            
            local x, y, z = getElementPosition(source)
            local px, py, pz = getElementPosition(player)
            
            if getDistanceBetweenPoints3D(x, y, z, px, py, pz) < 5 and getElementDimension(player) == getElementDimension(source) and getElementInterior(player) == getElementInterior(source) then
                if player ~= source then
                    local playerName = getPlayerName(source)
                    local weaponID = getPedWeapon(source)
					local weaponName = weaponNames[Weapons.ID[weaponID]] or "Arma Desconocida"
                    
                    if weaponID > 0 then
                        if tonumber(ammo) then
                            local totalAmmo = getPedTotalAmmo(source)
                            
                            if tonumber(ammo) >= 1 and tonumber(totalAmmo) >= tonumber(ammo) then
                                giveWeapon(player, weaponID, ammo, true)
                                takeWeapon(source, weaponID, ammo)
                                
                                outputDebugString("El jugador " .. playerName .. " le dio un arma a " .. getPlayerName(player) .. " con " .. ammo .. " balas", 0, 165, 242, 255)
								exports["logs-armas"]:sendDiscordLogMessage("El jugador [" .. playerName .. "] le dio un arma ["..weaponName.."] a [" .. getPlayerName(player) .. "] con [" .. ammo .. "] balas")  
                                outputChatBox("#FFFFFF[#E59404Armas#FFFFFF] Has dado un #FF0000"..weaponName.." #FFFFFFa #8B908B" .. getPlayerName(player) .. "#FFFFFF con #0EB104" .. ammo .. " #FFFFFFbalas", source, 255, 255, 255, true)
                                outputChatBox("#FFFFFF[#E59404Armas#FFFFFF] #8B908B" .. playerName .. " #FFFFFFte ha dado un #FF0000"..weaponName.." #FFFFFFcon #0EB104" .. ammo .. "#FFFFFF balas", player, 255, 255, 255, true)
                            else
                                outputChatBox("No tienes suficientes balas, solo tienes " .. totalAmmo .. " balas", source, 255, 0, 0)
                            end
                        else
                            outputChatBox("La cantidad de munición no es válida.", source, 255, 0, 0)
                        end
                    else
                        outputChatBox("No tienes un arma equipada.", source, 255, 0, 0)
                    end
                else
                    outputChatBox("No puedes darte un arma a ti mismo.", source, 255, 0, 0)
                end
            else
                outputChatBox("El jugador objetivo está demasiado lejos o en una dimensión/interior diferente.", source, 255, 0, 0)
            end
        else
            outputChatBox("No se encontró al jugador objetivo.", source, 255, 0, 0)
        end
        
        if not antiSpamW[source] then
            antiSpamW[source] = {}
        end
        antiSpamW[source][1] = tick
    end
end
addCommandHandler("dararma", dararma)
function darchaleco(source, cmd, who)
    if source then
        local player = getPlayerFromName(who)
        if player then
            local tick = getTickCount()
            if antiSpamW[source] and antiSpamW[source][1] and tick - antiSpamW[source][1] < 10000 then
                return
            end
            if player ~= source then
                local total = getPedArmor(source)
                if total and total > 0 then
                    setPedArmor(source, 0)  -- Establecer el chaleco del jugador que lo da a 0
                    setPedArmor(player, total)  -- Dar todo el chaleco al jugador receptor
                    outputDebugString("El jugador " .. getPlayerName(source) .. " le dio su chaleco a " .. getPlayerName(player), 0, 165, 242, 255)
                    exports["logs-armas"]:sendDiscordLogMessage("El jugador [" .. getPlayerName(source) .. "] le dio su chaleco a [" .. getPlayerName(player) .. "]")
                    outputChatBox("#FFFFFF[#E59404Chaleco#FFFFFF] #FFFFFFLe has dado tu chaleco a #8B908B" .. getPlayerName(player), source, 255, 255, 255, true)
                    outputChatBox("#FFFFFF[#E59404Chaleco#FFFFFF] #FFFFFFEl jugador #8B908B" .. getPlayerName(source) .. " #FFFFFFte ha dado su chaleco", player, 255, 255, 255, true)
                else
                    outputChatBox("#FA0707No tienes chaleco para dar", source, 255, 255, 255, true)
                end
            end
            if not antiSpamW[source] then
                antiSpamW[source] = {}
            end
            antiSpamW[source][1] = getTickCount()
        else
			outputChatBox("#FFFFFF[#E59404Chaleco#FFFFFF] #0478F3Syntax#FFFFFF:  #FFFFFF/darchaleco NombreIC",root,255, 255, 255, true)
		end
    end
end
addCommandHandler("darchaleco", darchaleco)
--dañoarmas
addEventHandler("onResourceStart", resourceRoot, function()
setWeaponProperty(24, "poor", "damage", 15)
setWeaponProperty(22, "poor", "damage", 10)
setWeaponProperty(25, "poor", "damage", 25)
setWeaponProperty(28, "poor", "damage", 30)
setWeaponProperty(29, "poor", "damage", 30)
setWeaponProperty(32, "poor", "damage", 16)
setWeaponProperty(30, "poor", "damage", 15)
setWeaponProperty(31, "poor", "damage", 15)
setWeaponProperty(34, "poor", "damage", 80)
setWeaponProperty(33, "poor", "damage", 70)
end)
addEventHandler("onResourceStop", resourceRoot, function()
setWeaponProperty(24, "poor", "damage", nil)
setWeaponProperty(22, "poor", "damage", nil)
setWeaponProperty(25, "poor", "damage", nil)
setWeaponProperty(28, "poor", "damage", nil)
setWeaponProperty(29, "poor", "damage", nil)
setWeaponProperty(32, "poor", "damage", nil)
setWeaponProperty(30, "poor", "damage", nil)
setWeaponProperty(31, "poor", "damage", nil)
setWeaponProperty(34, "poor", "damage", nil)
setWeaponProperty(33, "poor", "damage", nil)
end)
addCommandHandler("huellas", function(p)
	if not notIsGuest( p ) then
		if getPlayerDivision(p, "S.W.A.T.") or getPlayerDivision(p, "DIC") then
			local pos = Vector3(p:getPosition())
			local x, y, z = pos.x, pos.y, pos.z
			for i, v in ipairs(Element.getAllByType("colshape")) do
				if v:getData("weapon_data") then
					if isElementInRange(v, x, y, z, 2) then
						p:outputChat("* Esta arma tiene las huellas de "..v:getData("weapon_data")[6].."", 150, 50, 50, true)
					end
				end
			end
		end
	end
end)
function isElementInRange(ele, x, y, z, range)
   if isElement(ele) and type(x) == "number" and type(y) == "number" and type(z) == "number" and type(range) == "number" then
      return getDistanceBetweenPoints3D(x, y, z, getElementPosition(ele)) <= range -- returns true if it the range of the element to the main point is smaller than (or as big as) the maximum range.
   end
   return false
end
addEventHandler('onGiveWeapon', root,
	function(t)
		client:setAnimation("BOMBER", "BOM_Plant", -1,true, false, false)
		--
		setTimer(function(client)
			setPedAnimation(client)
		end, 500, 1, client)
		giveWeapon(client, t[2], t[3], true )
		if isElement(t[4]) then
			t[4]:destroy()
		end
		if isElement(t[5]) then
			t[5]:destroy()
		end
		if isElement(t[1]) then
			t[1]:destroy()
		end
	end
)
addEventHandler ("onPlayerWeaponFire", root, 
   function (weapons)
   	     if isObjectInACLGroup ("user."..getAccountName(getPlayerAccount(source)), aclGetGroup ( "Everyone" ) ) then 
         if not (getElementData(source, "Fire")) then
		 setElementData(source, "Fire", true)
		 x,y,z = getElementPosition(source)
		 local weaponName = getWeaponNameFromID(weapons)
		 local localidade = getZoneName(x, y, z)
		 if (weaponName == "Silenced") then
		     local weaponName = "Teaser"
		 end
		 outputChatBox("#008108* Escuchas disparos cerca de tu posicion *",root,255,255,255,true)	
		 setTimer(setElementData, 25000, 1, source, "Fire", false)
		 end
   end 
end
)
function addRednessOnDamage ( )
    fadeCamera ( source, false, 1.0, 255, 0, 0 )        
    setTimer ( fadeCameraDelayed, 500, 1, source )   
end
addEventHandler ( "onPlayerDamage", root, addRednessOnDamage )
 
function fadeCameraDelayed(player)
      if (isElement(player)) then
            fadeCamera(player, true, 0.5)
      end
end
addCommandHandler("dejar",
    function(player, cmd)
        local tick = getTickCount()
        
        -- Verificar si el jugador NO está muerto
        if player:getData("Muerto") and not player:getData("AceptarMuertoo") then
            player:outputChat("No puedes dejar un arma estando muerto.", 255, 0, 0)
            return
        end
        if (antiSpamW[player] and antiSpamW[player][1] and tick - antiSpamW[player][1] < 2000) then
            return
        end
        local weaponID = player:getWeapon()
        if weaponID ~= 0 then
            if Weapons.ID[weaponID] then
                local weaponName = weaponNames[Weapons.ID[weaponID]] or "Arma Desconocida"
                local playerName = getPlayerName(player)
                local ammo = player:getTotalAmmo()
                local pos = player.position
                pos.z = pos.z - 1
                local weapon = Object(Weapons.ID[weaponID], pos)
                local col = ColShape.Sphere(pos.x, pos.y, pos.z + .5, 1)
                setElementInterior(weapon, getElementInterior(player))
                setElementDimension(weapon, getElementDimension(player))
                player:outputChat("#FFFFFF[#E59404Armas#FFFFFF] Has dejado un arma #FF0000"..weaponName.." #FFFFFFcon #0EB104"..ammo.." balas", 255, 255, 255, true)
                exports["logs-armas"]:sendDiscordLogMessage("El jugador "..playerName.." ha dejado un arma "..weaponName.." con ["..ammo.."] balas en el suelo")
                weapon:setRotation(86, 270, 180)
                local nick = _getPlayerNameR(player)
                col:setData('weapon_data', { weapon, weaponID, ammo, col, nick })
                takeWeapon(player, weaponID, ammo)
            end
        end
        if (not antiSpamW[player]) then
            antiSpamW[player] = {}
        end
        antiSpamW[player][1] = getTickCount()
    end
)
addEvent("sendDiscordLogMessageFromClient", true)
addEventHandler("sendDiscordLogMessageFromClient", resourceRoot,
    function(weaponName, ammoCount, playerName)
        -- Formar el mensaje con el nombre del jugador, el arma y la cantidad de balas
        local message = "¡" .. playerName .. " ha recogido un arma " .. weaponName .. " con " .. ammoCount .. " balas!"
        exports["logs-armas"]:sendDiscordLogMessage(message)
    end
)
--[[addEventHandler("onPlayerQuit",root,function(t)
	if isElement(t[4]) then
			t[4]:destroy()
		end
		if isElement(t[5]) then
			t[5]:destroy()
		end
		if isElement(t[1]) then
			t[1]:destroy()
		end
	end
)]]