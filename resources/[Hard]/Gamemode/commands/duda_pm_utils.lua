
permisos = {
["Desarrollador"]=true,
["Administrador.General"]=true,
["Admin"]=true,
["Sup.Staff"]=true,
["SuperModerador"]=true,
["Moderador"]=true,
["Moderador A Pruebas"]=true,
}

------------------------------------------------- Pagar dinero
local caminatas = {
["Hombre"] = {"Hombre", 118},
["Mujer"] = {"Mujer", 129},
["Mujer2"] = {"Mujer2", 131},
["Mujer3"] = {"Mujer3", 132},
["Borracho"] = {"Borracho", 126},
["Prostituta"] = {"Prostituta", 133},
["Gang"] = {"Gang", 121},
["Gang2"] = {"Gang2", 122},
["Gordo"] = {"Gordo", 55},
["Viejo"] = {"Viejo", 120},
}

addCommandHandler({"caminar", "estilo"}, function(p, cmd, ...)
	if not notIsGuest(p) then
		local walk = table.concat({...}, " ")
		if walk ~="" and walk ~=" " then
			local s = trunklateText( p, walk )
			if s:find("Hombre") or s:find("hombre") or s:find("Mujer") or s:find("mujer") or s:find("Borracho") or s:find("borracho") or s:find("Prostituta") or s:find("prostituta") or s:find("Gang") or s:find("gang") or s:find("Gang2") or s:find("gang2") or s:find("Gordo") or s:find("Mujer2") or s:find("Mujer3") or s:find("Viejo") then
				p:outputChat("#FFFFFFEstilo Cambiado a: #FF0000"..tostring(caminatas[s][1]), 30, 150, 30, true)
				p:setWalkingStyle(caminatas[s][2])
			else
				p:outputChat("Solamente puedes poner estos estilos: ", 150, 50, 50, true)
				for i, v in pairs(caminatas) do
					p:outputChat(caminatas[i][1], 60, 30, 100, true)
				end
			end
		else 
			p:outputChat("Solamente puedes poner estos estilos: ", 150, 50, 50, true)
			for i, v in pairs(caminatas) do
				p:outputChat(caminatas[i][1], 60, 30, 100, true)
			end
		end
	end
end)

addCommandHandler("c",function (p,cmd,ca)
	p:setWalkingStyle(tonumber(ca))
end)

------------------------------------------------- Bug
local antiSpamBug  = {} 
function bug_comando ( source )
	if not notIsGuest( source ) then
	if source:getDimension() == 0 then
	if source:getData("Jaileado") == false then
		local tick = getTickCount()
		if (antiSpamBug[source] and antiSpamBug[source][1] and tick - antiSpamBug[source][1] < 60000) then
			source:outputChat("No puedes usar este comando después de 60 segundos", 150, 0, 0)
			return
		end
		local posicion = Vector3(source:getPosition())
		local x, y, z = posicion.x, posicion.y, posicion.z
		source:setInterior(0)
		source:setDimension(0)
		source:setPosition(x, y, z+2)
		source:setAnimation()
		if (not antiSpamBug[source]) then
			antiSpamBug[source] = {}
		source:outputChat("#F43C33[UN-STUCK] #FFFFFFSi sigues bugeado llama a un STAFF usando el #F43C33/re",255,255,255,true)	
		end
		antiSpamBug[source][1] = getTickCount()
		end
	else
	source:outputChat("#F43C33[UN-STUCK] #FFFFFFNo puedes utilizar este #F43C33comando.",255,0,0,true)	
		end
	end
end
addCommandHandler({"bug", "bugeado" , "desbug"}, bug_comando)
------------------------------------------------- PAyuda

local responderRe = {}
local antiSpamAyuda  = {} 

function payuda ( source,cmd,... )
	if not notIsGuest( source ) then
		local tick = getTickCount()
		if (antiSpamAyuda[source] and antiSpamAyuda[source][1] and tick - antiSpamAyuda[source][1] < 5000) then
			source:outputChat("No puedes usar este comando después de 5 segundos", 150, 0, 0)
			return
		end
		local msg = table.concat({...}, " ")
		if msg ~= "" and msg ~= " " then
			source:outputChat("#903E02[Reporte] #D85B00Reporte enviado , espera que un administrador te atienda", 150, 0, 0,true)
			message_staffs(source,msg)
			message_staffs(source)
			--responderRe[source] = true 
			if (not antiSpamAyuda[source]) then
				antiSpamAyuda[source] = {}
			end
			antiSpamAyuda[source][1] = getTickCount()
			else
			source:outputChat("Syntax: /re [MENSAJE]", 255, 255, 255)
		end
	end	
end
addCommandHandler({"aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaga", "payuaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaagada", "aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaga"}, payuda)

function message_staffs(player,msg)
		if isElement(player) then
			for i, v in ipairs(getElementsByType("player")) do
			local accName = getAccountName ( getPlayerAccount ( v ) )
				if isObjectInACLGroup ("user."..accName, aclGetGroup ( "Admin" ) ) or isObjectInACLGroup ("user."..accName, aclGetGroup ( "GameOperator" ) ) or isObjectInACLGroup ("user."..accName, aclGetGroup ( "SuperModerador" ) )  or isObjectInACLGroup ("user."..accName, aclGetGroup ( "Moderador" ) ) or isObjectInACLGroup ("user."..accName, aclGetGroup ( "EncFacciones" ) ) or isObjectInACLGroup ("user."..accName, aclGetGroup ( "EncAyuda" ) ) or isObjectInACLGroup ("user."..accName, aclGetGroup ( "EncFamilias" ) ) or isObjectInACLGroup ("user."..accName, aclGetGroup ( "Desarrollador" ) ) or isObjectInACLGroup ("user."..accName, aclGetGroup ( "Administrador.General" )  ) or isObjectInACLGroup ("user."..accName, aclGetGroup ( "Ayudante" ) ) or isObjectInACLGroup ("user."..accName, aclGetGroup ( "EncStaff" ) ) or isObjectInACLGroup ("user."..accName, aclGetGroup ( "Moderador A Pruebas" ) )  then
				v:outputChat("#FC921AEl Jugador: #00FF00*["..player:getData("ID").."]".. removeColorCoding(_getPlayerNameR(player)).." #FC921Anecesita ayuda", 255, 255, 255, true)
				v:outputChat("#00FF00Reporte: #FFFFFF"..msg.." #00FF00",255,255,255,true)
				v:outputChat("¡Usa /ir [Nombre_Apellido o ID] para ir donde el!", 255, 255, 255, true)
				v:outputChat("Para terminar el Reporte /terminar [ID O NOMBRE]", 255, 255, 255, true)
			end
		end
	end
	return false
end
------------------------------------------------- LimpiarChat

local antiSpamChat  = {} 
function limpiar_chat( source )
	local tick = getTickCount()
	if (antiSpamChat[source] and antiSpamChat[source][1] and tick - antiSpamChat[source][1] < 2000) then
		return
	end
	clearChatBox(source)
	if (not antiSpamChat[source]) then
		antiSpamChat[source] = {}
	end
	antiSpamChat[source][1] = getTickCount()
end
addCommandHandler({"cc", "limpiarchat"}, limpiar_chat)

------------------------------------------------- Staffs Disponibles

function staffs_onServer(source)
	if not notIsGuest( source ) then
		source:outputChat("== MIEMBROS DEL EQUIPO #60FE20CONECTADOS #FFFFFF==", 255, 255, 255 ,true)
		for _, v in ipairs(Element.getAllByType("player")) do
			local accName = getAccountName ( getPlayerAccount ( v ) )
			if isObjectInACLGroup ("user."..accName, aclGetGroup ( "Desarrollador" ) ) then
				if v:getData("Admin:Disponible") == false or true then
					source:outputChat("Desarrollador: #FFFFFF "..v:getData("Nombre:staff").." ["..v:getData("ID").."]", 150, 50, 50, true)
				else
					source:outputChat("", 150, 50, 50, true)
				end
			end
			if isObjectInACLGroup ("user."..accName, aclGetGroup ( "Administrador.General" ) ) then
				if v:getData("Admin:Disponible") == false or true then
					source:outputChat("A.General: #FFFFFF "..v:getData("Nombre:staff").." ["..v:getData("ID").."]", 150, 50, 50, true)
				else
					source:outputChat("", 150, 50, 50, true)
				end
			end
			if isObjectInACLGroup ("user."..accName, aclGetGroup ( "Admin" ) ) then
				if v:getData("Admin:Disponible") == false or true then
					source:outputChat("Administrador: #FFFFFF "..v:getData("Nombre:staff").." ["..v:getData("ID").."]", 150, 50, 50, true)
				else
					source:outputChat("", 150, 50, 50, true)
				end
			end
			if isObjectInACLGroup ("user."..accName, aclGetGroup ( "Sup.Staff" ) ) then
				if v:getData("Admin:Disponible") == false or true then
					source:outputChat("E.Staff: #FFFFFF "..v:getData("Nombre:staff").." ["..v:getData("ID").."]", 150, 50, 50, true)
				else
					source:outputChat("", 150, 50, 50, true)
				end
			end
			if isObjectInACLGroup ("user."..accName, aclGetGroup ( "SuperModerador" ) ) then
				if v:getData("Admin:Disponible") == false or true then
					source:outputChat("#23FF00S.Moderador: #FFFFFF "..v:getData("Nombre:staff").." ["..v:getData("ID").."]", 150, 50, 50, true)
				else
					source:outputChat("", 150, 50, 50, true)
				end
			end
			if isObjectInACLGroup ("user."..accName, aclGetGroup ( "Moderador" ) ) then
				if v:getData("Admin:Disponible") == false or true then
					source:outputChat("#0AA700Moderador: #FFFFFF "..v:getData("Nombre:staff").." ["..v:getData("ID").."]", 150, 50, 50, true)
				else
					source:outputChat("", 150, 50, 50, true)
				end
			end
			if isObjectInACLGroup ("user."..accName, aclGetGroup ( "Moderador A Pruebas" ) ) then
				if v:getData("Admin:Disponible") == false or true then
					source:outputChat("#928D00Moderador a Pruebas: #FFFFFF "..v:getData("Nombre:staff").." ["..v:getData("ID").."]", 150, 50, 50, true)
				else
					source:outputChat("", 150, 50, 50, true)
				end
			end
		end
	end
end
addCommandHandler({"admins", "staff"}, staffs_onServer)

------------------------------------------------- PM
------------------------------------------------- Sistema de reportes

local sql = dbConnect("sqlite", "staff.db");
dbExec(sql, "CREATE TABLE IF NOT EXISTS reportes(accountName,cantidad)")

function getPlayerReportes(player)
    local meterselo = dbPoll(dbQuery(sql, "SELECT * FROM reportes WHERE accountName = ?", player:getData("Nombre:staff") ), -1)
    if meterselo[1] ~= nil then
    	for k, v in ipairs(meterselo) do
    		return v.cantidad
    	end
    end
end

function getAccountReportes(player)
    local meterselo = dbPoll(dbQuery(sql, "SELECT * FROM reportes WHERE accountName = ?", player), -1)
    if meterselo[1] ~= nil then
    	for k, v in ipairs(meterselo) do
    		return v.cantidad
    	end
    end
end

function sumarReporte(player)
	if player then
		if getPlayerReportes(player) then
            dbExec(sql,"UPDATE reportes SET cantidad=? WHERE accountName=?", tonumber(getPlayerReportes(player)) + 1, player:getData("Nombre:staff") )
	    else
            dbExec(sql,"INSERT INTO reportes(accountName, cantidad) VALUES(?,?)", player:getData("Nombre:staff") , 1)
		end
	end
end

function verReportesContestados(p, cmd, o)
	if not o then
		if getPlayerReportes(p) then
			outputChatBox("#FFFFFFHas contestado #9CFF97"..getPlayerReportes(p).." reportes#FFFFFF.", p, 0,0,0, true)
		else
			outputChatBox("#FFFFFFHas contestado #9CFF970 reportes#FFFFFF.", p, 0,0,0, true)
		end
	elseif o:find("_") then
		if getPlayerFromName(o) then
			if getPlayerReportes(getPlayerFromName(o)) then
				outputChatBox("#9CFF97"..o.." #FFFFFFha contestado #9CFF97"..getPlayerReportes(getPlayerFromName(o)).." reportes#FFFFFF.", p, 0,0,0, true)
			else
				outputChatBox("#9CFF97"..o.." #FFFFFFha contestado #9CFF970 reportes#FFFFFF.", p, 0,0,0, true)
			end
		end
	end	
	if getAccountReportes(o) then
		outputChatBox("#9CFF97"..o.." #FFFFFFha contestado #9CFF97"..getAccountReportes(o).." reportes#FFFFFF.", p, 0,0,0, true)
	else
		outputChatBox("#9CFF97"..o.." #FFFFFFha contestado #9CFF970 reportes#FFFFFF.", p, 0,0,0, true)
	end
end
addCommandHandler("vreportes", verReportesContestados)

local antiSpamre  = {}
local responderre = {}
local adminre = {}
local dudas = {}

function re_command( thePlayer, commandName, ... )
	if not notIsGuest( thePlayer ) then
		local msg = table.concat({...}, " ")
		if msg ~= "" and msg ~= " " then
			local tick = getTickCount()
			if (antiSpamre[thePlayer] and antiSpamre[thePlayer][1] and tick - antiSpamre[thePlayer][1] < 30000) then
				return
				thePlayer:outputChat("Espera 30 segundos para enviar un /re", 150, 0, 0, true)
			end
			thePlayer:outputChat("El reporte fue enviado a todos los #FEFEA6staff #FFFFFFactivos.", 255, 255, 255, true)
			thePlayer:outputChat("Si tu reporte esta relacionado con #FEFEA6PG/MG #FFFFFFo acciones que ya sucedieron, realiza el reporte en foro.", 255, 255, 255, true)
			-- admins
			message_admins_re(thePlayer, msg)
		end
		if (not antiSpamre[thePlayer]) then
			antiSpamre[thePlayer] = {}
		end
		antiSpamre[thePlayer][1] = getTickCount()
	end
end
addCommandHandler({"re","reportar"}, re_command)

function message_admins_re(player, msg)
	if isElement(player) then
		for i, v in ipairs(getElementsByType("player")) do
			local accName = getAccountName ( getPlayerAccount ( v ) )
			if permisos[getACLFromPlayer(v)] == true then
				v:outputChat("#FFFF00[RE] #FCFC67".. removeColorCoding(_getPlayerNameR(player)).." ["..player:getData("ID").."]: #FFFFFF"..msg, 255, 255, 255, true)
				triggerClientEvent( v, "reporte", v )
				responderre[v] = true
				adminre[v] = _getPlayerNameR(player)
			end
		end
	end
	return false
end

addCommandHandler("verre",function (player,cmd)
	local accName = getAccountName ( getPlayerAccount ( player ) )
	if permisos[getACLFromPlayer(player)] == true then
		player:outputChat("reportes pendientes",0,255,0,true)
		for i,v in ipairs(reportes) do
			player:outputChat("#FFFFFF"..v[1].."#FFD908 | #FFFFFF"..v[2].."[#FF0005"..v[3].."#FFFFFF]",0,255,0,true)
		end
	end
end)

function responder_re( player, cmd, p, ... )
	local msg = table.concat({...}, " ")
	local accName = getAccountName ( getPlayerAccount ( player ) )
	if permisos[getACLFromPlayer(player)] == true then
		if responderre[player] == true then
			if tonumber(p) then
				local jugador = getFromName( player, p )
				if (jugador) then
					jugador:outputChat("#FEFEA6"..player:getData("Nombre:staff").." ["..player:getData("ID").."] #FEFEA6ha tomado tu reporte. en breve se contactará contigo.", 255, 255, 255, true)
					jugador:outputChat("#FEFEA6Una vez el Staff termine de ayudarte, podras ponerle un puntaje del 1 al 10 con #FFFFFF/calificar", 255, 255, 255, true) 
					message_admins("#F7FF59[RE] #FEFEA6"..player:getData("Nombre:staff").." ["..player:getData("ID").."] #FEFEA6aceptó el reporte de "..adminre[player]..".", 50, 150, 50, true)
					sumarReporte(player)
				end
			else
				local jugador = exports["Gamemode"]:getFromName( player, p )
				if (jugador) then
					jugador:outputChat("#FEFEA6"..player:getData("Nombre:staff").." ["..player:getData("ID").."] #FEFEA6ha tomado tu reporte. en breve se contactará contigo.", 255, 255, 255, true)
					jugador:outputChat("#FEFEA6Una vez el Staff termine de ayudarte, podras ponerle un puntaje del 1 al 10 con #FFFFFF/calificar", 255, 255, 255, true) 
					message_admins("#F7FF59[RE] #FEFEA6"..player:getData("Nombre:staff").." ["..player:getData("ID").."] #FEFEA6aceptó el reporte de "..adminre[player]..".", 50, 150, 50, true)
					sumarReporte(player)
				end
			end
			adminre[player] = nil
			responderre[player] = nil
		end
	end
end
addCommandHandler({"reaceptar", "rea"}, responder_re)

function responder_re(  player, cmd, p, ... )
	local msg = table.concat({...}, " ")
	local accName = getAccountName ( getPlayerAccount ( player ) )
	if permisos[getACLFromPlayer(player)] == true then
		if responderre[player] == true then
			if tonumber(p) then
				local jugador = getFromName( player, p )
				if (jugador) then
					jugador:outputChat("#FEFEA6"..player:getData("Nombre:staff").." ["..player:getData("ID").."] #FEFEA6rechazó tu reporte.", 255, 255, 255, true)
					message_admins("#F7FF59[RE] #FEFEA6"..player:getData("Nombre:staff").." ["..player:getData("ID").."] #FEFEA6rechazó el reporte de "..adminre[player]..".", 50, 150, 50, true)
				end
			else
				local jugador = getFromName( player, p )
				if (jugador) then
					jugador:outputChat("#FEFEA6"..player:getData("Nombre:staff").." ["..player:getData("ID").."] #FEFEA6rechazó tu reporte.", 255, 255, 255, true)
					message_admins("#F7FF59[RE] #FEFEA6"..player:getData("Nombre:staff").." ["..player:getData("ID").."] #FEFEA6rechazó el reporte de "..adminre[player]..".", 50, 150, 50, true)
				end
			end
			adminre[player] = nil
			responderre[player] = nil
		end
	end
end
addCommandHandler({"rerechazar", "rer"}, responder_re)

function message_admins(msg, r, g, b, val)
	for i, v in ipairs(getElementsByType("player")) do
		local accName = getAccountName ( getPlayerAccount ( v ) )
		if isObjectInACLGroup ("user."..accName, aclGetGroup ( "Desarrollador" ) ) or isObjectInACLGroup ("user."..accName, aclGetGroup ( "Admin" ) ) or isObjectInACLGroup ("user."..accName, aclGetGroup ( "Sup.staff" ) ) or isObjectInACLGroup ("user."..accName, aclGetGroup ( "SuperModerador" ) ) or isObjectInACLGroup ("user."..accName, aclGetGroup ( "SuperModerador" ) ) or isObjectInACLGroup ("user."..accName, aclGetGroup ( "Moderador" ) ) or isObjectInACLGroup ("user."..accName, aclGetGroup ( "EncFacciones" ) ) or isObjectInACLGroup ("user."..accName, aclGetGroup ( "EncAyudas" ) ) or isObjectInACLGroup ("user."..accName, aclGetGroup ( "EncFamilias" ) ) or isObjectInACLGroup ("user."..accName, aclGetGroup ( "Desarrollador" ) ) or isObjectInACLGroup ("user."..accName, aclGetGroup ( "Administrador.General" )  ) or isObjectInACLGroup ("user."..accName, aclGetGroup ( "Ayudante" ) ) or isObjectInACLGroup ("user."..accName, aclGetGroup ( "Moderador A Pruebas" ) )   then
			v:outputChat(msg, r, g, b, val)
		end
	end
	return false
end

function math.round(num, idp)
	local mult = 10^(idp or 0)
	return math.floor(num * mult + 0.5) / mult
end

--------------------------------------------------------------------------------
local sql = dbConnect("sqlite", "staff.db");
dbExec(sql, "CREATE TABLE IF NOT EXISTS dudas(accountName,cantidad)")

function getPlayerDudas(player)
    local meterselo = dbPoll(dbQuery(sql, "SELECT * FROM dudas WHERE accountName = ?", player:getData("Nombre:staff") ), -1)
    if meterselo[1] ~= nil then
    	for k, v in ipairs(meterselo) do
    		return v.cantidad
    	end
    end
end

function getAccountDudas(player)
    local meterselo = dbPoll(dbQuery(sql, "SELECT * FROM dudas WHERE accountName = ?", player), -1)
    if meterselo[1] ~= nil then
    	for k, v in ipairs(meterselo) do
    		return v.cantidad
    	end
    end
end

function sumarDuda(player)
	if player then
		if getPlayerDudas(player) then
            dbExec(sql,"UPDATE dudas SET cantidad=? WHERE accountName=?", tonumber(getPlayerDudas(player)) + 1, player:getData("Nombre:staff") )
	    else
            dbExec(sql,"INSERT INTO dudas(accountName, cantidad) VALUES(?,?)", player:getData("Nombre:staff") , 1)
		end
	end
end

function verDudasContestadas(p, cmd, o)
	if not o then
		if getPlayerDudas(p) then
			outputChatBox("#FFFFFFHas contestado #FF7800"..getPlayerDudas(p).." duda/s#FFFFFF.", p, 0,0,0, true)
		else
			outputChatBox("#FFFFFFHas contestado #FF78000 dudas#FFFFFF.", p, 0,0,0, true)
		end
	elseif o:find("_") then
		if getPlayerFromName(o) then
			if getPlayerDudas(getPlayerFromName(o)) then
				outputChatBox("#FF7800"..o.." #FFFFFFha contestado #FF7800"..getPlayerDudas(getPlayerFromName(o)).." duda/s#FFFFFF.", p, 0,0,0, true)
			else
				outputChatBox("#FF7800"..o.." #FFFFFFha contestado #FF78000 dudas#FFFFFF.", p, 0,0,0, true)
			end
		end
	end
	if getAccountDudas(o) then
		outputChatBox("#FF7800"..o.." #FFFFFFha contestado #FF7800"..getAccountDudas(o).." duda/s#FFFFFF.", p, 0,0,0, true)
	else
		outputChatBox("#FF7800"..o.." #FFFFFFha contestado #FF78000 dudas#FFFFFF.", p, 0,0,0, true)
	end
end
addCommandHandler("dudas", verDudasContestadas)

local antiSpamDuda  = {}
local responderDuda = {}
local adminDuda = {}
local dudas = {}

function dude_command( thePlayer, commandName, ... )
	if not notIsGuest( thePlayer ) then
		local msg = table.concat({...}, " ")
		if msg ~= "" and msg ~= " " then
			local tick = getTickCount()
			if (antiSpamDuda[thePlayer] and antiSpamDuda[thePlayer][1] and tick - antiSpamDuda[thePlayer][1] < 30000) then
				return
				thePlayer:outputChat("Espera 30 segundos para enviar una duda", 150, 0, 0, true)
			end
			thePlayer:outputChat("#903E02[DUDA] #D85B00Duda enviada, un miembro del Staff ya te responderá", 255, 255, 255, true)
			-- admins
			message_admins_duda(thePlayer, msg)
		end
		if (not antiSpamDuda[thePlayer]) then
			antiSpamDuda[thePlayer] = {}
		end
		antiSpamDuda[thePlayer][1] = getTickCount()
	end
end
addCommandHandler({"duda"}, dude_command)

function message_admins_duda(player, msg)
	if isElement(player) then
		for i, v in ipairs(getElementsByType("player")) do
			local accName = getAccountName ( getPlayerAccount ( v ) )
			if permisos[getACLFromPlayer(v)] == true then
				v:outputChat("#FF4900[DUDA] ".. removeColorCoding(_getPlayerNameR(player)).." ["..player:getData("ID").."]: #FFAF6C"..msg, 255, 255, 255, true)
				v:outputChat("#FFEE70/responderduda #FFFFFFo #FFEE70/rduda #FFFFFF[Nombre_Apellido o ID] [Respuesta]", 255, 255, 255, true)
				triggerClientEvent( v, "duda", v )
				responderDuda[v] = true
				adminDuda[v] = _getPlayerNameR(player)
			end
		end
	end
	return false
end

function canceduda(player,cmd)
	player:setData("miduda",false)
	local name = player:getName()
	for _, v in ipairs(dudas) do
		if v[2] == name then
		table.remove(dudas, _)
		player:setData("miduda",false)
		player:outputChat("Has cancelado tu duda",0,255,0,true)
		end
	end
end
addCommandHandler("cduda",canceduda)

-- addEventHandler("onPlayerQuit",canceduda)

addCommandHandler("verdudas",function (player,cmd)
	local accName = getAccountName ( getPlayerAccount ( player ) )
	if permisos[getACLFromPlayer(player)] == true then
		player:outputChat("Dudas pendientes",0,255,0,true)
		for i,v in ipairs(dudas) do
			player:outputChat("#FFFFFF"..v[1].."#FFD908 | #FFFFFF"..v[2].."[#FF0005"..v[3].."#FFFFFF]",0,255,0,true)
		end
	end
end)

function responder_duda( player, cmd, p, ... )
	local msg = table.concat({...}, " ")
	local accName = getAccountName ( getPlayerAccount ( player ) )
	if permisos[getACLFromPlayer(player)] == true then
		if responderDuda[player] == true then
			if tonumber(p) then
				local jugador = exports["Gamemode"]:getFromName( player,p)
				if (jugador) then
					jugador:outputChat("#FF4900[DUDA] "..player:getData("Nombre:staff").." #FFAF6Crespondió tu duda:", 255, 255, 255, true)
					message_admins("#FF4900[DUDA] #FF7400".._getPlayerNameR(player).." ["..player:getData("Nombre:staff").."] #FFAF6CRespondió la duda de "..adminDuda[player].."", 50, 150, 50, true)
					jugador:outputChat("#FF4900[DUDA] #B6B6B6"..msg..".", 255, 255, 255, true)
					sumarDuda(player)
				end
			else
				local jugador = getPlayerFromName(p)
				if (jugador) then
					jugador:outputChat("#FF4900[DUDA] "..player:getData("Nombre:staff").." #FFAF6Crespondió tu duda:", 255, 255, 255, true)
					message_admins("#FF4900[DUDA] #FF7400".._getPlayerNameR(player).." ["..player:getData("Nombre:staff").."] #FFAF6CRespondió la duda de "..adminDuda[player].."", 50, 150, 50, true)
					jugador:outputChat("#FF4900[DUDA] #B6B6B6"..msg..".", 255, 255, 255, true)
					sumarDuda(player)
				end
			end
			adminDuda[player] = nil
			responderDuda[player] = nil
		end
	end
end
addCommandHandler({"responderduda", "rduda"}, responder_duda)

function message_admins(msg, r, g, b, val)
	for i, v in ipairs(getElementsByType("player")) do
		local accName = getAccountName ( getPlayerAccount ( v ) )
		--if isObjectInACLGroup ("user."..accName, aclGetGroup ( "Admin" ) ) or isObjectInACLGroup ("user."..accName, aclGetGroup ( "GameOperator" ) ) or isObjectInACLGroup ("user."..accName, aclGetGroup ( "EncStaff" ) ) or isObjectInACLGroup ("user."..accName, aclGetGroup ( "SuperModerador" ) ) or isObjectInACLGroup ("user."..accName, aclGetGroup ( "SuperModerador" ) ) or isObjectInACLGroup ("user."..accName, aclGetGroup ( "Moderador" ) ) or isObjectInACLGroup ("user."..accName, aclGetGroup ( "EncFacciones" ) ) or isObjectInACLGroup ("user."..accName, aclGetGroup ( "EncAyudas" ) ) or isObjectInACLGroup ("user."..accName, aclGetGroup ( "EncFamilias" ) ) or isObjectInACLGroup ("user."..accName, aclGetGroup ( "Desarrollador" ) ) or isObjectInACLGroup ("user."..accName, aclGetGroup ( "Administrador.General" )  ) or isObjectInACLGroup ("user."..accName, aclGetGroup ( "Ayudante" ) ) or isObjectInACLGroup ("user."..accName, aclGetGroup ( "Moderador A Pruebas" ) )   then
			if permisos[getACLFromPlayer(v)] == true then
			v:outputChat(msg, r, g, b, val)
		end
	end
	return false
end

function math.round(num, idp)
	local mult = 10^(idp or 0)
	return math.floor(num * mult + 0.5) / mult
end