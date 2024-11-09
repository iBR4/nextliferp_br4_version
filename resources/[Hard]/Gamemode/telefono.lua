function telefonoa ( source )
	if not notIsGuest( source ) then
		local cuenta = AccountName(source)
		local accounts = query("SELECT * FROM Datos_Personajes where Cuenta = ?", cuenta)
		if not ( type( accounts ) == "table" and #accounts == 0 ) or not accounts then
			local nombre = accounts[1]["Cuenta"]
			local edad = accounts[1]["Edad"]
			local sexo = accounts[1]["Sexo"]
			local dni2 = accounts[1]["DNI"]
			local nacio = accounts[1]["Nacionalidad"]
			if dni2 == "0" then
				dni = "No"
			else
				dni = dni2
			end
			local telefono =  source:getData("Roleplay:Telefono") or "No"
			if telefono == "Si" then--
			    source:outputChat("#969696-------- Este es el numero de telefono de: #FF6666"..cuenta.." #969696--------", 150, 150, 150, true)
				source:outputChat("#FFCACATu telefono es: #EDFFA9"..(source:getData("Roleplay:NumeroTelefono") or 0).."", 150, 150, 150, true)
			end
			local agenda = source:getData("Roleplay:Agenda") or "No" -- 
			--
			if (source:getData("Roleplay:tarjeta_credito") or 0) == 1 then
				tarjeta = "Si"
			else
				tarjeta = "No"
			end--
			--Licencias
			if (source:getData("Roleplay:Licencia_Conducir") or 0) == 1 then
				conducir = "Si"
			else
				conducir = "No"
			end
		end
	end
end
addCommandHandler("telefono", telefonoa)
addCommandHandler("minumero", telefonoa)
addCommandHandler("numero", telefonoa)