local LicenciasArmas = {}



addEventHandler("onResourceStart", resourceRoot, function()

	for i, v in pairs( getLicenciaArmas() ) do

		LicenciasArmas[i] = Marker( v[1], v[2], v[3]-1, "cylinder", 1.5, 100, 100, 100, 0 )

		LicenciasArmas[i]:setInterior(v.int)

		LicenciasArmas[i]:setDimension(v.dim)

	end

end)



addCommandHandler("portearma", function(player, cmd)

	if not notIsGuest(player) then

		local nivel = getElementData(player,"Nivel") or 0
		local lic = player:getData("Roleplay:Licencia_Arma")

		if not player:isInVehicle() then

			for i, v in ipairs(LicenciasArmas) do

				if player:isWithinMarker(v) then
		
					if (nivel >= 5) then

							if player:getMoney() >= 30000 then

								player:setData("Roleplay:Licencia_Arma", player:getData("Roleplay:Licencia_Arma") + 1)

								player:outputChat("Acabas de obtener la licencia de armas por: #004500$30,000 dolares", 50, 150, 50, true)

								player:takeMoney(10000)
							else
								exports["Notificaciones"]:setTextNoti(player, "No tienes suficiente dinero.", 150, 50, 50, true)
							end
						else
							exports["Notificaciones"]:setTextNoti(player, "Debes tener nivel 5 para comprarla", 150, 50, 50, true)
					end
				end

			end

		end

	end

end)



function getPlayerYear(player)

	if isElement(player) then

		local s = query("SELECT * From datos_personajes where Cuenta = ?", AccountName(player))

		if s then

			if not ( type( s ) == "table" and #s == 0 ) or not s then

				return tonumber(s[1]["Edad"]) or 0

			end

		end

	end

end
