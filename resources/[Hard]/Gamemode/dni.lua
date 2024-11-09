addCommandHandler("dardni", function(player, cmd, who)
	if not notIsGuest(player) then
		local thePlayer = getFromName( player, who )
		if (thePlayer) then
			local posicion = Vector3(player:getPosition()) -- source
			local x2, y2, z2 = posicion.x, posicion.y, posicion.z
			local pos = Vector3(thePlayer:getPosition())
			local x, y, z = pos.x, pos.y, pos.z
			if getDistanceBetweenPoints3D(x2, y2, z2, x, y, z) < 1.5 then -- 5
			MensajeRol(player, " le muestra su dni a ".._getPlayerNameR(thePlayer).."", 0)
			--
			thePlayer:outputChat("=== #A44B00D.N.I de ".._getPlayerNameR(player).." #FFFFFF===", 255, 255, 255, true)
			local s = query("SELECT * From datos_personajes where Cuenta = ?", AccountName(player))
			if not ( type( s ) == "table" and #s == 0 ) or not s then
				thePlayer:outputChat("Nombre: #2E2E82".. player:getName(), 255, 255, 255, true)
				thePlayer:outputChat("Edad: #2E2E82"..s[1]["Edad"], 255, 255, 255, true)
				thePlayer:outputChat("Sexo: #2E2E82"..s[1]["Sexo"], 255, 255, 255, true)
				thePlayer:outputChat("D.N.I: #2E2E82"..s[1]["DNI"], 255, 255, 255, true)
			end
		else
			player:outputChat("#FE6666Esta persona esta muy lejos como para mostrare Tu DNI", 255, 255, 255, true)
			end
		else
			player:outputChat("Syntax: /dardni [ID] ", 255, 255, 255, true)
		end
	end
end)
addCommandHandler("mostrarplaca", function(player, cmd, who)
	if not notIsGuest(player) then
		if getPlayerFaction( player, "Policia" ) or getPlayerFaction( player, "Mecanico" ) or getPlayerFaction( player, "Medico" ) or getPlayerFaction( player, "Aseguradora" ) then
		local thePlayer = getFromName( player, who )
		if (thePlayer) then
			local posicion = Vector3(player:getPosition()) -- source
			local x2, y2, z2 = posicion.x, posicion.y, posicion.z
			local pos = Vector3(thePlayer:getPosition())
			local x, y, z = pos.x, pos.y, pos.z
			if getDistanceBetweenPoints3D(x2, y2, z2, x, y, z) < 1.5 then -- 5
			MensajeRol(player, " le muestra su placa a ".._getPlayerNameR(thePlayer).."", 0)
			--
			thePlayer:outputChat("#FF9B00=== #FFFFFFPlaca faccionaria de #00FF04".._getPlayerNameR(player).." #FF9B00===", 255, 255, 255, true)
			local s = query("SELECT * From datos_personajes where Cuenta = ?", AccountName(player))
			if not ( type( s ) == "table" and #s == 0 ) or not s then
				thePlayer:outputChat("Nombre: #00FF04".. player:getName(), 255, 255, 255, true)
				thePlayer:outputChat("Edad: #00FF04"..s[1]["Edad"], 255, 255, 255, true)
				thePlayer:outputChat("Sexo: #00FF04"..s[1]["Sexo"], 255, 255, 255, true)
				--thePlayer:outputChat("D.N.I: #2E2E82"..s[1]["DNI"], 255, 255, 255, true)
				thePlayer:outputChat("Faccion: #00FF04"..(player:getData("Roleplay:faccion") or ""), 255, 255, 255, true)
				thePlayer:outputChat("Rango: #00FF04"..(player:getData("Roleplay:faccion_rango") or ""), 255, 255, 255, true)
			end
		else
			player:outputChat("#FE6666Esta persona esta muy lejos como para mostrare la placa", 255, 255, 255, true)
				end
			else
				player:outputChat("Syntax: /mostrarplaca [ID] ", 255, 255, 255, true)
			end
		else
			player:outputChat("#FE6666No perteneces a ninguna faccion, ¡no tienes una placa!", 255, 255, 255, true)
		end
	end
end)