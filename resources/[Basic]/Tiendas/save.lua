-- save system in data account
function saveAllDatas( p, t, a )
	if not notIsGuest( source ) then
		-- celular
		local telefono = t:getData("Roleplay:Telefono")
		if ( telefono ) then
			local telefonoxd = t:getData ("Roleplay:Telefono")
			source:setData("Roleplay:Telefono", telefonoxd)
		else
			source:setData("Roleplay:Telefono", "No")
		end
		-- numero celular
		local telefonoNumber = t:getData("Roleplay:NumeroTelefono")
		if ( telefonoNumber ) then
			local telefonoNumber2 = t:getData ("Roleplay:NumeroTelefono")
			source:setData("Roleplay:NumeroTelefono", telefonoNumber2)
		else
			source:setData("Roleplay:NumeroTelefono", 0)
		end
		-- agenda
		local agenda = t:getData("Roleplay:Agenda")
		if ( agenda ) then
			local agenda2 = t:getData ("Roleplay:Agenda")
			source:setData("Roleplay:Agenda", agenda2)
		else
			source:setData("Roleplay:Agenda", "No")
		end
		-- agenda texto
		local agendatext = t:getData("Roleplay:AgendaTexto")--
		if ( agendatext ) then
			local agendatext = t:getData ("Roleplay:AgendaTexto")
			source:setData("Roleplay:AgendaTexto", agendatext)
		else
			source:setData("Roleplay:AgendaTexto", "")
		end
		
		-- radio
			local radio = t:getData("frecuencia")
		if ( radio ) then
			local radio = t:getData ("frecuencia")
			source:setData("frecuencia", radio)
		else
			source:setData("frecuencia", "No")
		end
		--exp	
			local exp = t:getData("Roleplay:ExpJobPescador") or 1
		
		if ( exp ) then
			local exp = t:getData("Roleplay:ExpJobPescador") or 1
			source:setData("Roleplay:ExpJobPescador", exp)
		else
			source:setData("Roleplay:ExpJobPescador", "No")
		end
	end
end
addEventHandler("onPlayerLogin", getRootElement(), saveAllDatas)
function quitDatas( q, r, e )
	if not notIsGuest( source ) then
		local account = source:getAccount()
		if ( account ) then
			local telefono = source:getData("Roleplay:Telefono")
			account:setData("Roleplay:Telefono", telefono)
			--
			local telefonoNumber = source:getData("Roleplay:NumeroTelefono")
			account:setData("Roleplay:NumeroTelefono", telefonoNumber)
			--
			local agenda = source:getData("Roleplay:Agenda")
			account:setData("Roleplay:Agenda", agenda)
			--
			local Parlante = source:getData("Roleplay:Parlante")
			account:setData("Roleplay:Parlante", Parlante)
			--
			local agendatext = source:getData("Roleplay:AgendaTexto")
			account:setData("Roleplay:AgendaTexto", agendatext)
			
			local exp = source:getData("Roleplay:ExpJobPescador")
			account:setData("Roleplay:ExpJobPescador", exp)
			
			
			local exp = source:getData("frecuencia")
			account:setData("frecuencia", exp)
		end
	end--
end
addEvent("onPlayerSaveQuit", true)
addEventHandler("onPlayerQuit", getRootElement(), quitDatas)
addEventHandler("onPlayerSaveQuit", getRootElement(), quitDatas)
--- onResourceStop
function stopDatas( )
	for i, v in ipairs( Element.getAllByType("player") ) do
		if not notIsGuest( v ) then
			triggerEvent("onPlayerSaveQuit", v)
		end
	end
end
addEventHandler("onResourceStop", resourceRoot, stopDatas)