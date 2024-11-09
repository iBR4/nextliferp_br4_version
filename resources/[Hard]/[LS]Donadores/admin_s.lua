--#	Variables: Feature
local planes = { "VIP", "VIP+" }
--#	Evento: Al iniciar el recurso
addEventHandler("onResourceStart", resourceRoot,
function()
	for i, plan in ipairs(planes) do
		if ( not aclGetGroup(plan) ) then
			aclCreateGroup(plan);
			outputDebugString("* El Grupo ACL '"..plan.."' no existia, por ello se ha creado");
		end
	end
end
)
addCommandHandler("vips",
function ( player )
	local account = getPlayerAccount(player)
	if ( isObjectInACLGroup("user."..getAccountName(account), aclGetGroup("Desarrollador")) ) then
		triggerEvent("vip:execute", player, "open-close")
	end
end
)
local month_limit = {
	[1] = 31,
	[2] = 28,
	[3] = 31,
	[4] = 30,
	[5] = 31,
	[6] = 30,
	[7] = 31,
	[8] = 31,
	[9] = 30,
	[10] = 31,
	[11] = 30,
	[12] = 31,
}
function getDate( date )
	if ( not date ) then date = "today" end
	if ( date == "today" ) then
		local t = getRealTime()
		local dd = t.monthday
		local mm = t.month + 1
		local yyyy = t.year + 1900
		---
		return dd.."/"..mm.."/"..yyyy
	else
		if ( type(date) == "number" ) or ( tonumber(date) ) then
			local t = getRealTime()
			local dd = t.monthday
			local mm = t.month + 1
			local yyyy = t.year + 1900
			---
			dd = dd + date
			---
			while ( dd >= month_limit[mm] ) do
				dd = dd - month_limit[mm]
				---
				if ( mm >= 12 ) then
					mm = 1
					yyyy = yyyy + 1
				else
					mm = mm + 1
				end
			end
			---
			outputDebugString(dd.."/"..mm.."/"..yyyy)
			return dd.."/"..mm.."/"..yyyy
		end
	end
end
--#	Function Util: Detecta el tiempo faltante
function getTimeLeft( today, endOf )
	if ( today ) and ( endOf ) then
		local t = split(today, "/")
		local e = split(endOf, "/")
		---
		t[1] = tonumber(t[1]) -- Dia hoy
		t[2] = tonumber(t[2]) -- Mes hoy
		t[3] = tonumber(t[3]) -- Año hoy
		---
		e[1] = tonumber(e[1]) -- Dia final de VIP
		e[2] = tonumber(e[2]) -- Mes final de VIP
		e[3] = tonumber(e[3]) -- Año final de VIP
		---
		if ( e[2] > t[2] ) then -- Si el mes final, es mayor al mes inicial..
			e[1] = e[1] + month_limit[t[2]] -- Le sumamos los dias totales a este para poder hacer la resta correcta
		end
		---
		local left = e[1] - t[1];
		---
		return left
	end
end
--#	Funcion Util: Detecta todas las cuentas dentro de los 3 grupos VIP
function getAllVIPAccounts( ... )
	local accounts = {}
	for plansKey, plan in ipairs(planes) do
		for accountKey, account in ipairs(getAccounts()) do
			local account_name = getAccountName(account)
			if ( isObjectInACLGroup("user."..account_name, aclGetGroup(plan)) ) then
				local time_set = getAccountData(account, "vip:time_set") or getDate("today")
				local time_left = getAccountData(account, "vip:time_left") or getDate(31)
				local days_left = getTimeLeft(time_set, time_left)
				local last_nick = getAccountData(account, "data:last_nick") or "Not listed"
				if ( getAccountPlayer(account) ) then last_nick = getPlayerName(getAccountPlayer(account)):gsub("#%x%x%x%x%x%x", "") end
				table.insert(accounts, {account_name, last_nick, plan, time_set, days_left})
			end
		end
	end
	---
	return accounts
end
--#	Function Util: Detecta todas las cuentas y sus nicks anteriores
function getAllAccountsWithLastNickName( ... )
	local accounts = {}
	for i, k in ipairs(getAccounts()) do
		local account_name = getAccountName(k)
		local last_nick = getAccountData(k, "data:last_nick") or "Not listed"
		if ( getAccountPlayer(k) ) then last_nick = getPlayerName(getAccountPlayer(k)):gsub("#%x%x%x%x%x%x", "") end
		table.insert(accounts, {account_name, last_nick})
	end
	---
	return accounts;
end
--#	Funcion Util: Detecta si la cuenta ya es VIP
function isPlayerVIP( account )
	for i, k in ipairs(planes) do
		if ( isObjectInACLGroup("user."..account, aclGetGroup(k)) ) then
			return true;
		end
	end
	---
	return false;
end
--#	Verificador: Si el VIP termino
setTimer(function()
	for i, k in ipairs(getAccounts()) do
		local account_name = getAccountName(k);
		if ( isPlayerVIP(account_name) ) then
			local today = getDate("today")
			local time_left = getAccountData(k, "vip:time_left") or getDate("today")
			local plan = getAccountData(k, "vip:plan") or "-"
			---
			if ( time_left == today ) then
				triggerEvent("vip:execute", getRootElement(), "take", {account_name, plan})
				outputDebugString("* El VIP de "..account_name.." ha finalizado!")
			end
		end
	end
end, 1000, 0)
function saveNick()
	local nick = getPlayerName(source):gsub("#%x%x%x%x%x%x", "")
	local account = getPlayerAccount(source)
	setAccountData(account, "data:last_nick", nick)
end
addEventHandler("onPlayerLogin", root, saveNick)
addEventHandler("onPlayerQuit", root, saveNick)
addEventHandler("onPlayerChangeNick", root, saveNick)
function addVipPlayer(vars)
	if ( getAccount(vars[1]) ) then
		if ( not isPlayerVIP(vars[1]) ) then
			exports.nlogin:setCharacterData(vars[4],"Monedas",exports.nlogin:getCharacterData(vars[4],"Monedas") - vars[5] )
			setAccountData(getAccount(vars[1]), "vip:time_set", getDate("today"))
			setAccountData(getAccount(vars[1]), "vip:time_left", getDate(tonumber(vars[2])))
			setAccountData(getAccount(vars[1]), "vip:plan", vars[3])
			--
			aclGroupAddObject(aclGetGroup(vars[3]), "user."..vars[1])
			
			outputChatBox("#ffffff¡Gracias por apoyar el servidor!",vars[4], 255, 150, 0, true)
			outputChatBox("#ffffffAhora #1BFF00"..vars[1].." #ffffffes #FFFF00"..vars[3].."", vars[4], 255, 150, 0, true)
			--
			exports.Texts:output("*NLCoins Le han dado VIP '"..vars[3].."' a la cuenta '"..vars[1].."' exitosamente!", vars[4], 0, 255, 150, true)
			outputDebugString("*NLCoins Le han dado VIP '"..vars[3].."' a la cuenta '"..vars[1].."' exitosamente!")
			triggerClientEvent(vars[4],"NL:ShowCoins",vars[4],vars[4],tonumber(exports.nlogin:getCharacterData(vars[4],"Monedas")))
			
			--
			local beneficier = getAccountPlayer(getAccount(vars[1]))
			if ( beneficier ) then
				--outputChatBox("#ffffff¡Gracias por apoyar el servidor!",beneficier, 255, 150, 0, true)
				outputChatBox("#ffffff¡Ahora eres #FFFF00"..vars[3].."!", beneficier, 0, 255, 150,true)
				outputChatBox("#ffffffFecha de inicio:#1BFF00"..getDate("today"), beneficier, 0, 255, 150,true)
				outputChatBox("#ffffffFecha de finalizacion:#1BFF00"..getDate(tonumber(vars[2])).." / Tiempo Dado: "..getTimeLeft(getDate("today"), getDate(tonumber(vars[2]))).." Dia(s)", beneficier, 0, 255, 150,true)
				--exports.killmessages:outputMessage("* Reconecta para que el vip tome efecto ", beneficier, 0, 255, 150, "default")
				playSoundFrontEnd(beneficier, 3)
			end
		else
			outputChatBox("* El usuario ya pertenece a los VIP!", vars[4], 255, 150, 0, true)
			return false
		end
	end
end
--#	Evento: Recibir y ejecutar la peticion del cliente
addEvent("vip:execute", true)
addEventHandler("vip:execute", root,
function ( action, vars)
	if ( action == "open-close" ) then
		triggerClientEvent(source, "vip:refresh_tables", source, getAllVIPAccounts(), getAllAccountsWithLastNickName(), planes)
		triggerClientEvent(source, "vip:openInterface", source)
	elseif ( action == "take" ) then
		if ( getAccount(vars[1]) ) then
			if ( isObjectInACLGroup("user."..vars[1], aclGetGroup(vars[2])) ) then
				aclGroupRemoveObject(aclGetGroup(vars[2]), "user."..vars[1])
			else
				outputChatBox("* El usuario no se encuentra en el plan seleccionado!", source, 255, 150, 0, true)
			end
		else
			outputChatBox("* La cuenta seleccionada NO existe!", source, 255, 150, 0, true)
			---
			if ( isObjectInACLGroup("user."..vars[1], aclGetGroup(vars[2])) ) then
				aclGroupRemoveObject(aclGetGroup(vars[2]), "user."..vars[1])
			end
		end
		---
		triggerClientEvent(source, "vip:refresh_tables", source, getAllVIPAccounts(), getAllAccountsWithLastNickName(), planes)
	elseif ( action == "add" ) then
		if ( getAccount(vars[1]) ) then
			if ( not isPlayerVIP(vars[1]) ) then
				setAccountData(getAccount(vars[1]), "vip:time_set", getDate("today"))
				setAccountData(getAccount(vars[1]), "vip:time_left", getDate(tonumber(vars[2])))
				setAccountData(getAccount(vars[1]), "vip:plan", vars[3])
				--
				aclGroupAddObject(aclGetGroup(vars[3]), "user."..vars[1])
				
				
				outputChatBox("#ffffff¡Gracias por apoyar el servidor!",root, 255, 150, 0, true)
				outputChatBox("#ffffffAhora #1BFF00"..vars[1].." #ffffffes #FFFF00"..vars[3].."",root, 255, 150, 0, true)
				--
				exports.Texts:output("* Le haz dado VIP '"..vars[3].."' a la cuenta '"..vars[1].."' exitosamente!", source, 0, 255, 150, true)
				outputDebugString("* Le haz dado VIP '"..vars[3].."' a la cuenta '"..vars[1].."' exitosamente!")
				--
				local beneficier = getAccountPlayer(getAccount(vars[1]))
				if ( beneficier ) then
					--outputChatBox("#ffffff¡Gracias por apoyar el servidor!",beneficier, 255, 150, 0, true)
					outputChatBox("#ffffff¡Ahora eres #FFFF00"..vars[3].."!", beneficier, 0, 255, 150,true)
					outputChatBox("#ffffffFecha de inicio:#1BFF00"..getDate("today"), beneficier, 0, 255, 150,true)
					outputChatBox("#ffffffFecha de finalizacion:#1BFF00"..getDate(tonumber(vars[2])).." / Tiempo Dado: "..getTimeLeft(getDate("today"), getDate(tonumber(vars[2]))).." Dia(s)", beneficier, 0, 255, 150,true)
					--exports.killmessages:outputMessage("* Reconecta para que el vip tome efecto ", beneficier, 0, 255, 150, "default")
					playSoundFrontEnd(beneficier, 3)
				end
			else
				outputChatBox("* El usuario ya pertenece a los VIP!", 255, 150, 0, true)
			end
		else
			outputChatBox("* La cuenta seleccionada no existe!", 255, 150, 0, true)
		end
		---
		triggerClientEvent(source, "vip:refresh_tables", source, getAllVIPAccounts(), getAllAccountsWithLastNickName(), planes)
	end
end
)
