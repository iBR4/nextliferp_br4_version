loadstring(exports.MySQL:getMyCode())()
import('*'):init('MySQL')

permisos = {
["Admin"]=true,
["Moderador"]=true,
["SuperMod"]=true,
}


addEventHandler("onResourceStart", resourceRoot, function()
	Pickup = Pickup(1560.6409912109, -1676.1536865234, 16.1953125, 3, 1274, 0)
	Pickup:setInterior(0)
	MarcadoresMulta = Marker(1560.6409912109, -1676.1536865234, 16.1953125, "cylinder", 1.3, 100, 50, 50, 0)
	MarcadoresMulta:setInterior(0)
end)
--
addCommandHandler("pagarmulta", function(player, cmd, id)
	if isElement( player ) then
		if not notIsGuest(player) then
			if player:isWithinMarker(MarcadoresMulta) then
				if not player:isInVehicle() then
					if tonumber(id) then
						local s = query("SELECT * From Multas where ID = ? and Cuenta = ?", id, AccountName(player))
						if not ( type( s ) == "table" and #s == 0 ) or not s then
							if player:getMoney() >= tonumber(s[1]["Cantidad"]) then
								--
								player:outputChat("Acabas de pagar tu mulda de: #004500$"..convertNumber(tonumber(s[1]["Cantidad"])).." dólares. #FFFFFFNúmero expediente: #A44B00"..s[1]["ID"].."", 255, 255, 255, true)
								--
								delete("DELETE FROM Multas WHERE ID=? and Cuenta = ?", id, AccountName(player))
								--
								player:takeMoney(tonumber(s[1]["Cantidad"]))
								--
							else
								exports["Notificaciones"]:setTextNoti(player, "No tienes suficiente dinero.", 150, 50, 50, true)
							end
						end
					end
				end
			end
		end
	end
end)

--
addCommandHandler("multas", function(player, cmd, who)
	if isElement(player) then
		if not notIsGuest(player) then
			local thePlayer = exports["Gamemode"]:getFromName( player, who )
			if (thePlayer) then
				if getPlayerFaction(player, "Policia") or permisos[getACLFromPlayer(player)] == true then
					local s = query("SELECT * From Multas where Cuenta=?", AccountName(thePlayer))
					if not ( type( s ) == "table" and #s == 0 ) or not s then
						player:outputChat("=== #A44B00Multas de "..thePlayer:getName():gsub("_"," ").." #FFFFFF===", 255, 255, 255, true)
						for i, v in ipairs(s) do
							player:outputChat("Número expediente: #A44B00"..v.ID.." #FFFFFFMulta de: #004500$"..convertNumber(v.Cantidad).." dólares.", 255, 255, 255, true)
						end
					else
						player:outputChat("El Jugador no tiene Multas", 255, 50, 50, true)
					end
				end
			else
				local s = query("SELECT * From Multas where Cuenta=?", AccountName(player))
				if not ( type( s ) == "table" and #s == 0 ) or not s then
					player:outputChat("=== #A44B00Multas #FFFFFF===", 255, 255, 255, true)
					for i, v in ipairs(s) do
						player:outputChat("Número expediente: #A44B00"..v.ID.." #FFFFFFMulta de: #004500$"..convertNumber(v.Cantidad).." dólares.", 255, 255, 255, true)
					end
				else
					player:outputChat("No tienes Multas", 255, 50, 50, true)
				end
			end
		end
	end
end)
--

addCommandHandler("multar", function(player, cmd, who, money)
	if isElement(player) then
		if not notIsGuest(player) then
			if getPlayerFaction(player, "Policia") then
				if tonumber(who) then
					if tonumber(money) then
						local thePlayer = exports["Gamemode"]:getFromName( player, who )
						if (thePlayer) then
							local posicion = Vector3(player:getPosition()) -- player
							local posicion2 = Vector3(thePlayer:getPosition()) -- jugador
							local x, y, z = posicion.x, posicion.y, posicion.z -- jugador
							local x2, y2, z2 = posicion2.x, posicion2.y, posicion2.z -- player
							if getDistanceBetweenPoints3D(x, y, z, x2, y2, z2) < 10 then -- 5
								local id = math.random(100000,999999)
								insert("INSERT INTO Multas VALUES(?,?,?)", id, tonumber(money), AccountName(thePlayer))
								--
								thePlayer:outputChat("Acabas de ser multado por: #FFFFFF"..player:getName().."", 150, 50, 50, true)
								--
								thePlayer:outputChat("Número expediente: #A44B00"..id, 255, 255, 255, true)
								thePlayer:outputChat("Multa de: #ee0000$"..convertNumber(money).." dólares.", 255, 255, 255, true)
								--
								player:outputChat("Acabas de multar a "..thePlayer:getName().."", 50, 150, 50, true)
							end
						else
							player:outputChat("Syntax: /multar [id] [cantidad]", 255, 50, 50, true)
						end
					else
						player:outputChat("Syntax: /multar [id] [cantidad]", 255, 50, 50, true)
					end
				else
					player:outputChat("Syntax: /multar [id] [cantidad]", 255, 50, 50, true)
				end
			end
		end
	end
end)

addCommandHandler("nmulta",function(player,cmd,who,id)
	if getPlayerFaction(player, "Policia") or permisos[getACLFromPlayer(player)] == true then
		local thePlayer = exports["Gamemode"]:getFromName( player, who )
		if (thePlayer) then
			if tonumber(id) then
				local s = query("SELECT * From Multas where ID = ? and Cuenta = ?", id, AccountName(thePlayer))
				if not ( type( s ) == "table" and #s == 0 ) or not s then
					player:outputChat("Has borrado la multa #A44B00#"..id.." #FFFFFFdel jugador #A44B00"..thePlayer:getName():gsub("_"," "),255,255,255,true)
					thePlayer:outputChat("Te han borrado la multa #A44B00#"..id,255,255,255,true)
					delete("DELETE FROM Multas WHERE ID=? and Cuenta = ?", id, AccountName(thePlayer))
				end
			elseif id == "all" then
				local s = query("SELECT * From Multas where Cuenta = ?",AccountName(thePlayer))
				if not ( type( s ) == "table" and #s == 0 ) or not s then
					player:outputChat("Has borrado todas las multas del jugador #A44B00"..thePlayer:getName():gsub("_"," "),255,255,255,true)
					thePlayer:outputChat("Te han borrado todas las multas",50,255,50,true)
					delete("DELETE FROM Multas WHERE Cuenta = ?", AccountName(thePlayer))
				end
			end
		end
	end
end)