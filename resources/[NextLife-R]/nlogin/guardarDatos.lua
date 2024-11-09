mysql = exports.MySQL

JData = {}


local posicionesJail = {

	[1]={197.42677307129, 174.26026916504, 1003.0234375},

	[2]={193.36796569824, 174.16159057617, 1003.0234375},

	[3]={189.07911682129, 174.79206848145, 1002.9435424805},

	[4]={189.89344787598, 161.89308166504, 1002.9435424805},

	[5]={194.32360839844, 161.94566345215, 1002.9435424805},

	[6]={198.79176330566, 162.10108947754, 1003.0299682617},

}

local valores= {

	{70},

	{71},

	{72},

	{73},

	{74},

	{76},

	{77},

	{78},

	{79},

}

function getCharacterData(source,value)
	if JData[source] then
		return JData[source][value]
	end
	return false
end

function setCharacterData(source,value,newValue)
	if JData[source] then
		JData[source][value] = newValue
		if value == "Nivel" then
			source:setData("Nivel",tonumber(newValue))
			triggerClientEvent(source,"addPlayerUpdatePresence",source,source,getPlayerName(source),tonumber(newValue))
		end
		return JData[source][value]
	end
	return false
end



function set(source,comando,argumento)
	JData[source]["TaxistaLv"] = 1
	JData[source]["TaxistaExp"] = 0

	JData[source]["CamioneroLv"] = 1
	JData[source]["CamioneroExp"] = 0

	JData[source]["CarpinteroLv"] = 1
	JData[source]["CarpinteroExp"] = 0

	JData[source]["JardineroLv"] = 1
	JData[source]["JardineroExp"] = 0

	JData[source]["MeseroLv"] = 1
	JData[source]["MeseroExp"] = 0

	JData[source]["PizzeroLv"] = 1
	JData[source]["PizzeroExp"] = 0

	JData[source]["MineroLv"] = 1
	JData[source]["MineroExp"] = 0
end
-- addCommandHandler("comando", set)


function updateHambre(player)
	if getElementHealth(player) > 10 then
		-- print(player:getHealth(),"old")
		-- if player:getData("Muerto") == false and player:getData("AceptarMuertoo") == false then
		if getElementData(player,"Agua") and getElementData(player,"Comida") then
			local health = player:getHealth()
			if getElementData(player,"Comida") <= 0 then
				player:setHealth(player:getHealth() - 0.5)
				-- print(player:getHealth(),"newComida")
			else
				local randomc = math.random(1.4,1.5)
				setElementData(player,'Comida', ( getElementData(player,"Comida") - randomc ) )
				-- print(getElementData(player,"Comida"),"newComida1")
			end
		end
		-- end
	end
end

function updateSed(player)
	if getElementHealth(player) > 10 then
		-- print(player:getHealth(),"old")
		-- if player:getData("Muerto") == false and player:getData("AceptarMuertoo") == false then
		if getElementData(player,"Agua") and getElementData(player,"Comida") then
			local health = player:getHealth()
			if getElementData(player,"Agua") <= 0 then
				player:setHealth(player:getHealth() - 0.5)
				-- print(player:getHealth(),"newAgua")
			else
				local randomag = math.random(1.1,1.6)
				setElementData(player,'Agua', ( getElementData(player,"Agua") - randomag ) )
				-- print(getElementData(player,"Agua"),"newAgua1")
			end
		end
		-- end
	end
end

Timers = {}

function LoginSaveP( p, c, a )

	if not(mysql:notIsGuest(source)) then 

		--
		local trabajo = c:getData("Roleplay:trabajoVIP")

		if (trabajo) then

			local va = c:getData("Roleplay:trabajo")

			if va == "Licencia" then

				source:setData("Roleplay:trabajo", "")

			else

				source:setData("Roleplay:trabajo", va)
				source:setData("Roleplay:trabajoVIP", trabajo)

			end
		else
			source:setData("Roleplay:trabajoVIP", "")		
			source:setData("Roleplay:trabajo", "")		
		end

	


		--

		local x, y, z = 1743.0595703125, -1861.55078125, 13.57737827301
		
		local rx, ry, rz = 0, 0, 359.50836181641

		local int = 0

		local dim = 0

		local vida = 100

		local chaleco = 0

		local serial = source:getSerial()

		local skin = 1
		
		source:setData("Agua",100)
		-- print("Agua")
	
	    source:setData("Comida",100)
		-- print("Comida")
	
	

	    --source:getData("Nombre:staff")

		--

		for i, v in ipairs(valores) do

			source:setStat(v[1], 1000)

		end

		--

		local team = ""

		local save = mysql:query("SELECT * From save_system WHERE Cuenta = '"..mysql:AccountName(source).."'")

		if ( type ( save ) == "table" and #save == 0 ) or not save then

		else

			local g = fromJSON(save[1]["Extras"])

			setPlayerWantedLevel( source, (tonumber(g["PuntosA"]) or 0) )

			local e_ = fromJSON(save[1]["Empleos"])

			JData[source] = {}
			JData[source]["Horas"] = g["Tiempo"]
			JData[source]["Nivel"] = tonumber(save[1]["Nivel"]) or 1
			JData[source]["Empleo"] = save[1]["Empleo"] or "Desempleado"
			JData[source]["XP"] = save[1]["XP"] 
			JData[source]["Banco"] = g["Banco"] 
			JData[source]["PuntosRol"] = g["PuntosRol"]
			JData[source]["TarjetaBanco"] = g["TarjetaBanco"] or false
			
			JData[source]["Monedas"] = tonumber(save[1]["Monedas"])

			JData[source]["TaxistaLv"] = tonumber(e_["TaxistaLv"]) 
			JData[source]["TaxistaExp"] = tonumber(e_["TaxistaExp"])

			JData[source]["CamioneroLv"] = tonumber(e_["CamioneroLv"]) 
			JData[source]["CamioneroExp"] = tonumber(e_["CamioneroExp"])

			JData[source]["CarpinteroLv"] = tonumber(e_["CarpinteroLv"])
			JData[source]["CarpinteroExp"] = tonumber(e_["CarpinteroExp"])

			JData[source]["JardineroLv"] = tonumber(e_["JardineroLv"]) 
			JData[source]["JardineroExp"] = tonumber(e_["JardineroExp"])

			JData[source]["MeseroLv"] = tonumber(e_["MeseroLv"])
			JData[source]["MeseroExp"] = tonumber(e_["MeseroExp"])

			JData[source]["PizzeroLv"] = tonumber(e_["PizzeroLv"])
			JData[source]["PizzeroExp"] = tonumber(e_["PizzeroExp"])

			JData[source]["MineroLv"] = tonumber(e_["MineroLv"])
			JData[source]["MineroExp"] = tonumber(e_["MineroExp"])

			source:setData("PlayerNivel",tonumber(save[1]["Nivel"]) or 1)

			source:setData("Agua",tonumber(g["Sed"]))
			-- print("Agua")
		
		    source:setData("Comida",tonumber(g["Hambre"]))
			-- print("Comida")

			Timers[source] = {}

			Timers[source][1] = setTimer(updateHambre,65000,0,source,source)
			Timers[source][2] = setTimer(updateSed,85000,0,source,source)

			--JData[source]["Banco"] = save[1]["Banco"]

			local pos = fromJSON(save[1]["Posiciones"])

			local rot = fromJSON(save[1]["Rotaciones"])

			local dataT_ = fromJSON(save[1]["Pelea"]) or {}

			local vida2 = save[1]["Vida"]

			local chaleco2 = save[1]["Chaleco"]

			local skin2 = tonumber(save[1]["Skin"])

			local int2 = save[1]["Interior"]

			local money = save[1]["Money"]

			local dim2 = save[1]["Dimension"]

			local team2 = save[1]["Team"]

			local eat = tonumber(save[1]["Comida"]) or 100
			
			-- local water = tonumber(save[1]["Agua"]) or 100
			
			local staff = save[1]["Staff"]

			source:setRotation(rot["rx"], rot["ry"], rot["rz"])

			local correo = save[1]["Correo"]

			local staffnick = (getDatas(correo,"Cuenta") or "")
			source:setData("nombre:staff", staffnick)


			if exports["[LS]Administracion"]:isPlayerExists(source) then

				exports["[LS]Administracion"]:setPlayerJail(source)

				source:setPosition(pos["x"], pos["y"], pos["z"])

				source:spawn( pos["x"], pos["y"], pos["z"], rot["rz"], 0, int2, dim2)

			elseif exports["Facciones"]:isPlayerExistsArresto(source) then

				exports["Facciones"]:setPlayerJailPolice(source)

				local random = math.random(1,6)

				local x2, y2, z2 = posicionesJail[tonumber(random)][1], posicionesJail[tonumber(random)][2], posicionesJail[tonumber(random)][3]

				source:setPosition(x2, y2, z2)

				source:spawn( x2, y2, z2, rot["rz"], 0, int2, dim2)

			else

				source:setPosition(pos["x"], pos["y"], pos["z"])

				source:spawn( pos["x"], pos["y"], pos["z"], rot["rz"], 0, int2, dim2)
			end

--[[
			if tonumber(vida2) < 10 then
				--source:setHealth(9)
				--source:setData("Muerto",true)
			else
				source:setHealth(tonumber(vida2))
				--source:setData("Muerto",false)
			end
]]
	
			triggerClientEvent(source,"NextLife:ApplyConfig",source,source)
			
			source:setHealth(tonumber(vida2))

			source:giveMoney(tonumber(money))
			--outputConsole(inspect({source, skin2}))

			source:setArmor(chaleco2)
			-- if skin2 >= 20000 then
			-- 	setElementData(source, 'ModelCustomID', skin2)
			-- 	triggerClientEvent('Custom:applyModel', source, skin2)
			-- else
				setElementModel(source, skin2)
			--end

			source:setTeam(nil)

			-- source:setData("Comida",100)
			-- source:setData("Agua",100)

			source:setData("nombre:staff",staff)
			source:getData("Nombre:staff",staff)
			source:getData("Nombre:staff")

			local weapons = save[1]["Weapons"]
			if weapons and type(weapons) == "string" and string.len(weapons) > 0 then
				for index=0,12 do
					local coded_string = string.match(weapons, tostring(index).."=%d+,%d+")
					if coded_string then
						local weapon_start , weapon_end = string.find(coded_string, tostring(index).."=")
						local ammo_start, ammo_end = string.find(coded_string, tostring(index).."=%d+,")
						local decoded_weapon = string.match(coded_string, "%d+", weapon_end)
						local decoded_ammo = string.match(coded_string, "%d+", ammo_end)
						local wep = tonumber(decoded_weapon)
						local ammu = tonumber(decoded_ammo)
						if wep == 1 or wep == 2 or wep == 3 or wep == 4 or wep == 5 or wep == 6 or wep == 7 or wep == 8 or wep == 9 or wep == 10 or wep == 11 or wep == 12 or wep == 13 or wep == 14 or wep == 15 or wep == 40 or wep == 44 or wep == 45 or wep == 46 then
							giveWeapon (source, wep)
						else
							if ammu > 1 then
								giveWeapon(source, wep, ammu)
							end
						end
					else
						print("ERROR: Imposible recobrar arma en Slot: ".. tostring(index).."")
					end
				end
			end

			--

			if dataT_ then
				setPedFightingStyle ( source, dataT_["_pelea"] )
				setPedWalkingStyle( source, dataT_["_caminar"] ) 
			end
			

			source:fadeCamera(true, 0.5)

			source:setCameraTarget(source)


		end

	end

end

addEventHandler("onPlayerLogin", getRootElement(), LoginSaveP)


function getPlayerNearbyVehicle(player)
	if isElement(player) then
		for i,veh in ipairs(Element.getAllByType('vehicle')) do
			local vx,vy,vz = getElementPosition( veh )
			local px,py,pz = getElementPosition( player )
			if getDistanceBetweenPoints3D(vx,vy,vz, px,py,pz) < 3.3 then
				return veh
			end
		end
	end
	return false
end

function QuitSaveP( q, r, e )

	if not(mysql:notIsGuest(source)) then 

		local acc = source:getAccount()

		if acc then

			local vea = source:getData("Roleplay:trabajoVIP")

			acc:setData("Roleplay:trabajoVIP", vea)

			local va = source:getData("Roleplay:trabajo")

			acc:setData("Roleplay:trabajo", va)

		end

		local cuenta = mysql:AccountName(source)

		if cuenta then

			local x, y, z = getElementPosition(source)

			local rx, ry, rz = getElementRotation(source)

			local int = source:getInterior()

			local dim = source:getDimension()

			local vida = source:getHealth()

			local chaleco = source:getArmor()

			local serial = source:getSerial()

			local skin = getElementData(source, 'ModelCustomID') or getElementModel(source)

			local money = source:getMoney()
			
			local water = source:getData("Agua")
			
			local eat = source:getData("Comida")
			
			local staff = source:getData("nombre:staff")

			local estilo = getPedWalkingStyle(source)

			local pelea = source:getFightingStyle()

			local team = ""		

			local save = mysql:query("SELECT * From save_system WHERE Cuenta = '"..mysql:AccountName(source).."'")

			if ( type ( save ) == "table" and #save == 0 ) or not save then

				--mysql:insert("INSERT INTO save_system VALUES (?,?,?,?,?,?,?,?,?,?,?,?,?)", toJSON ( { x = x, y = y, z = z} ), toJSON ( { rx = rx, rx = rx, rx = rx} ), math.floor(vida), math.floor(chaleco), int, dim, skin, team, '5000', '', serial, mysql:AccountName(source),toJSON ( { _caminar = 118, _pelea = 15} ), "asdasldsal")

			else



				if JData[source] then

					local Extra_Data = {}

					Extra_Data["Banco"] = JData[source]["Banco"] or 0
					Extra_Data["Hambre"] = JData[source]["Hambre"] or 0
					Extra_Data["Sed"] = JData[source]["Sed"] or 0
					Extra_Data["PuntosRol"] = JData[source]["PuntosRol"] or 0
					Extra_Data["PuntosA"] = getPlayerWantedLevel(source) or 0

					Extra_Data["Sed"] = source:getData("Agua") or 0
					Extra_Data["Hambre"] = source:getData("Comida") or 0


					local Extra_Empleos = {}

					Extra_Empleos["TaxistaLv"] = JData[source]["TaxistaLv"] 
					Extra_Empleos["TaxistaExp"] = JData[source]["TaxistaExp"] 

					Extra_Empleos["CamioneroLv"] = JData[source]["CamioneroLv"] 
					Extra_Empleos["CamioneroExp"] = JData[source]["CamioneroExp"]

					Extra_Empleos["CarpinteroLv"] = JData[source]["CarpinteroLv"]
					Extra_Empleos["CarpinteroExp"] = JData[source]["CarpinteroExp"] 

					Extra_Empleos["JardineroLv"] = JData[source]["JardineroLv"]
					Extra_Empleos["JardineroExp"] = JData[source]["JardineroExp"]

					Extra_Empleos["MeseroLv"] = JData[source]["MeseroLv"] 
					Extra_Empleos["MeseroExp"] = JData[source]["MeseroExp"]

					Extra_Empleos["PizzeroLv"] = JData[source]["PizzeroLv"]
					Extra_Empleos["PizzeroExp"] = JData[source]["PizzeroExp"]

					Extra_Empleos["MineroLv"] = JData[source]["MineroLv"]
					Extra_Empleos["MineroExp"] = JData[source]["MineroExp"]

					mysql:update("UPDATE save_system SET Extras = ?  WHERE Cuenta = ?", toJSON(Extra_Data), mysql:AccountName(source))

					if source:getData("Roleplay:trabajo") then
						if source:getData("Roleplay:trabajo") == "" then
							mysql:update("UPDATE save_system SET Empleo = ?  WHERE Cuenta = ?", "Desempleado", mysql:AccountName(source))
						else
							mysql:update("UPDATE save_system SET Empleo = ?  WHERE Cuenta = ?", (source:getData("Roleplay:trabajo") or "Desempleado"), mysql:AccountName(source))
						end
					end

					mysql:update("UPDATE save_system SET Empleos = ?  WHERE Cuenta = ?", toJSON(Extra_Empleos), mysql:AccountName(source))
					mysql:update("UPDATE save_system SET Tiempo = ?  WHERE Cuenta = ?", (JData[source]["Horas"] or "00:00:00"), mysql:AccountName(source))

					mysql:update("UPDATE save_system SET XP = ?  WHERE Cuenta = ?", (JData[source]["XP"] or 0), mysql:AccountName(source))
					mysql:update("UPDATE save_system SET Nivel = ?  WHERE Cuenta = ?", (JData[source]["Nivel"] or 1), mysql:AccountName(source))
					mysql:update("UPDATE save_system SET Monedas = ?  WHERE Cuenta = ?", (JData[source]["Monedas"] or 0), mysql:AccountName(source))


					if Timers[source] then
						if isTimer(Timers[source][1]) then
							killTimer(Timers[source][1])
						end

						if isTimer(Timers[source][2]) then
							killTimer(Timers[source][2])
						end
						Timers[source] = nil
					end


				end

				--

				if not source:isDead() then

					--if getPlayerNearbyVehicle(source) == false then

						local weapons = ""
						for index=0,12 do
							local weapon = source:getWeapon(index)
							if weapon then
								local ammo = source:getTotalAmmo(index)
								weapons = weapons..tostring(index).."="..tostring(weapon)..","..tostring(ammo)..";"
							end
						end
						mysql:update("UPDATE save_system SET Weapons = ?  WHERE Cuenta = ?", weapons, mysql:AccountName(source))

					--end

				else

					mysql:update("UPDATE save_system SET Vida = ?  WHERE Cuenta = ?", 11, mysql:AccountName(source))

				end

				-- money

				mysql:update("UPDATE save_system SET Money = ?  WHERE Cuenta = ?", money, mysql:AccountName(source))

				-- Posiciones

				mysql:update("UPDATE save_system SET Posiciones = ?  WHERE Cuenta = ?", toJSON ( { x = x, y = y, z = z} ), mysql:AccountName(source))

				-- Rotaciones

				mysql:update("UPDATE save_system SET Rotaciones = ?  WHERE Cuenta = ?", toJSON ( { rx = rx, ry = ry, rz = rz} ), mysql:AccountName(source))

				-- Vida y Chaleco

				mysql:update("UPDATE save_system SET Vida = ?  WHERE Cuenta = ?", math.floor(vida), mysql:AccountName(source))

				mysql:update("UPDATE save_system SET Chaleco = ?  WHERE Cuenta = ?", math.floor(chaleco), mysql:AccountName(source))

				-- interior y dimension

				mysql:update("UPDATE save_system SET Interior = ?  WHERE Cuenta = ?", int, mysql:AccountName(source))

				mysql:update("UPDATE save_system SET Dimension = ?  WHERE Cuenta = ?", dim, mysql:AccountName(source))

				-- Skin y Team

				mysql:update("UPDATE save_system SET Skin = ?  WHERE Cuenta = ?", skin, mysql:AccountName(source))

				mysql:update("UPDATE save_system SET Team = ?  WHERE Cuenta = ?", team, mysql:AccountName(source))

				-- Estilo de Peleas

				mysql:update("UPDATE save_system SET Pelea = ?  WHERE Cuenta = ?", toJSON ( { _caminar = estilo, _pelea = pelea} ), mysql:AccountName(source))

				-- Serial

				mysql:update("UPDATE save_system SET Serial = ?  WHERE Cuenta = ?", serial, mysql:AccountName(source))

				-- Save

				JData[source] = nil

			end
		end

	end

end

addEvent ("onPlayerStopResource", true)

addEventHandler("onPlayerQuit", getRootElement(), QuitSaveP)

addEventHandler ("onPlayerStopResource", getRootElement(), QuitSaveP)

setTimer ( 
	function ( )
		for _, player in ipairs ( getElementsByType ( "player" ) ) do
			if mysql:AccountName(player) then
				if JData[player] then
				    local Tiempo = JData[player]["Horas"] or "00:00:00"
					local hours, mins, secs = unpack ( split (Tiempo, ":" ) or { } )
					local hours = tonumber ( hours ) or 0
					local mins = tonumber ( mins ) or 0
					local secs = tonumber ( secs ) or 0
					if ( hours and mins and secs ) then
						local newsecs = ( secs + 1 )
						if ( newsecs >= 60 ) then
							newsecs = 0
							mins = ( mins + 1 )
						end
						if ( mins >= 60 ) then
							mins = 0
							hours = ( hours + 1 )
						end
						JData[player]["Horas"] = string.format ( "%02d:%02d:%02d", hours, mins, newsecs )
					end
				end
			end
		end
	end
	,1000, 0
)

function StopP ()

	for k, v in ipairs (Element.getAllByType("player")) do

		if not (mysql:notIsGuest(v)) then

   			triggerEvent ("onPlayerStopResource", v)

		end

	end

end

addEventHandler ("onResourceStop", resourceRoot, StopP)