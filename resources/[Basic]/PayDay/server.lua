loadstring(exports.MySQL:getMyCode())()
import('*'):init('MySQL')
--- setTimers
local globalMoney = 38
local enTrabajoMoney = 70
local faccionMoney = 2350
local rangosMoney = {
["Policia"]={
["Jefe de Policia"]=50000,
["Jefe Adjunto"]=30000,
["Comandante"]=20000,
["Capitan"]=18000,
["Teniente"]=18000,
["Sargento"]=13000,
["Detective II"]=7850,
["Detective I"]=6000,
["Oficial III+"]=6000,
["Oficial III"]=3350,
["Oficial II"]=2250,
["Oficial I"]=1500,
["Cadete"]=1000,
},
--
["Medico"]={
["Director General"]=18000,
["Director"]=14200,
["Sargento"]=10550,
["Rescatista"]=7500,
["Medico"]=4000,
["Paramedico"]=2000,
["Aspirante"]=1020,
},
["Bomberos"]={
["Jefe de Bomberos"]=18000,
["Vicejefe de bomberos"]=14200,
["Jefe adjunto"]=10550,
["Capitán"]=7500,
["Teniente"]=4000,
["Bombero III"]=2000,
["Bombero I"]=1020,
["Candidato"]=1000,
},
--
["Mecanico"]={
["Empresario"]=15000,
["Sub Empresario"]=12000,
["Mecanico Experto"]=10000,
["Mecanico"]=8000,
["Junior"]=3000,
["Aprendiz"]=1000,
},
["Gobierno"]={
["Magistrado"]=25000,
["Juez General"]=20000,
["Juez"]=15000,
["Fiscal"]=12000,
["Abogado"]=10000,
["Asistente Legal"]=7000,
["Estudiante"]=5000,
["Seguridad"]=3000,
},
}
--
Levels = {
	{1, 1},
	{2, 2},
	{3, 3},
	{4, 4},
	{5, 5},
	{6, 6},
	{7, 7},
	{8, 8},
	{9, 9},
	{10, 10},
	{11, 11},
	{12, 12},
	{13, 13},
	{14, 14},
	{15, 15},
	{16, 16},
	{17, 17},
	{18, 18},
	{19, 19},
	{20, 20},
}
function payday()
	for index, player in ipairs(Element.getAllByType("player")) do
		if not notIsGuest( player ) then
			if player:getData("AFK") == false then
				local vehs = exports["VehPriv"]:getLastID(player) or 0
				local name = getPlayerName(player)
				local vehs = vehs - 1
				local paga = 100 + 50 * vehs
				dinero = "200"
				if getPlayerVIP(player) == "VIP" then
					paga = 125 + 35 * vehs
					dinero = "125"
				elseif getPlayerVIP(player) == "VIP+" then
					paga = 125 + 35 * vehs
					dinero = "125"
				end
				local faccion = player:getData("Roleplay:faccion") or ""
				local rango = player:getData("Roleplay:faccion_rango") or ""
				outputDebugString("El Administrador "..name.. " Acaba de Lanzar el Payday")
				player:outputChat("#909090== #FDF200Dia de Paga #909090 ==", 255, 255, 255, true)
				player:outputChat("\n#FFFFFFGobierno: #0B7702+"..dinero, 255, 255, 255, true)
				playSoundFrontEnd(player, 7)
				if player:getData("Roleplay:faccion") ~="" then
					player:outputChat("#FFFFFFFacción: #0B7702+"..rangosMoney[tostring(faccion)][tostring(rango)], 255, 255, 255, true)
				end
				player:outputChat("\n#FFFFFFVehiculos: #FF0000-" .. convertNumber(math.round(vehs * 50)) .. " dólares\n#FFFFFFCasas: #FF0000-0 dólares \n", 255, 255, 255, true)
				if player:getData("Roleplay:faccion") ~="" then
					player:outputChat("#FEFA9ETotal ganado: $"..convertNumber(50 + rangosMoney[tostring(faccion)][tostring(rango)] - (vehs * 30) ), 255, 255, 255, true)
					--if player:getData("Roleplay:tarjeta_credito") == true then
					--	player:setData("Roleplay:bank_balance", player:getData("Roleplay:bank_balance") + tonumber(math.ceil( rangosMoney[tostring(faccion)][tostring(rango)] + paga)))
					--else
						player:setMoney(player:getMoney() + rangosMoney[tostring(faccion)][tostring(rango)] + paga )
					--end
				else
					player:outputChat("#11FF00Total: #0BBA00$"..convertNumber( paga ), 255, 255, 255, true)
					if player:getData("Roleplay:tarjeta_credito") == true then
						player:setData("Roleplay:bank_balance", player:getData("Roleplay:bank_balance") + tonumber(paga))
					else
						player:setMoney(player:getMoney() + paga)
					end
				end
				setNivel(player)
			end
		end
	end
end
addCommandHandler("darstatsalosusuariosmatherfukersxd",payday)
setTimer(function()
	payday()
end, 1000*60*60,0)
function setNivel( player )
	if isElement(player) then
		local nivel = tonumber(exports.nlogin:getCharacterData(player,"Nivel")) or 1
		local actualExp = tonumber(exports.nlogin:getCharacterData(player,"XP"))  or 0
		if nivel == #Levels then
			exports['Notificaciones']:setTextNoti(player, '¡Estas en tu nivel maximo ', 0,255,0, true)
		elseif nivel < #Levels then
			local nuevaExp = 1
			if getPlayerVIP(player) == "VIP" then
				nuevaExp = 3
			elseif getPlayerVIP(player) == "VIP+" then
				nuevaExp = 6
			end
			if actualExp+nuevaExp >= Levels[nivel][1] then
				--player:setData("Nivel",nivel+1)
				--player:setData('PlayerExp',Levels[nivel][1]-(actualExp+nuevaExp))
				exports.nlogin:setCharacterData(player,"Nivel",nivel+1)
				exports.nlogin:setCharacterData(player,"XP",Levels[nivel][1]-(actualExp+nuevaExp))
				player:outputChat("¡Recibiste: #dd80ff +"..nuevaExp.." de exp #FFFFFFy subiste al #00FF00nivel "..(nivel+1).." #FFFFFFpor jugar en nuestro servidor!", 255, 255, 255, true)
				triggerClientEvent( root, "nuevonivel", root )
			elseif actualExp+nuevaExp < Levels[nivel][1] then
				--player:setData('PlayerExp', actualExp+nuevaExp)
				exports.nlogin:setCharacterData(player,"XP",actualExp+nuevaExp)
				player:outputChat("¡Recibiste: #dd80ff +"..nuevaExp.." de exp #FFFFFFpor jugar en nuestro servidor!", 255, 255, 255, true)
				triggerClientEvent( root, "nuevoxp", root )
			end
		end
	end
end
function getPlayerVIP(player)
	if isElement(player) then
		local accName = getAccountName ( getPlayerAccount ( player ) )
		if isObjectInACLGroup ("user."..accName, aclGetGroup ( "VIP+" ) ) then
			return "VIP+"
		elseif isObjectInACLGroup ("user."..accName, aclGetGroup ( "VIP" ) ) then
			return "VIP"
		else
			return false
		end
	end
	return false
end
function getExp( player )
	if isElement( player ) and player:getType() == "player" then
		return ( tonumber( exports.nlogin:getCharacterData(player,"XP") ) or 0 )
	else
		return false
	end
	return false
end
function getNivel( player )
	if isElement( player ) and player:getType() == "player" then
		return ( tonumber( exports.nlogin:getCharacterData(player,"Nivel") ) or 0 )
	else
		return false
	end
	return false
end
function math.round(num, idp)
  local mult = 10^(idp or 0)
  return math.floor(num * mult + 0.5) / mult
end
