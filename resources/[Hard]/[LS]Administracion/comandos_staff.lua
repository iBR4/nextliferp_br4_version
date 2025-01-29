loadstring(exports.MySQL:getMyCode())()
import('*'):init('MySQL')

loadstring(exports["[LS]NewData"]:getMyCode())()
import('*'):init('[LS]NewData')

mysql = exports.MySQL

local statsSQL = dbConnect("sqlite", ":stats/sanciones.db");
dbExec(statsSQL, "CREATE TABLE IF NOT EXISTS datosOOC(accountName,tipo,motivo,tiempo,staff)")

permisos = {
	["Desarrollador"] = true,
	["Administrador.General"] = true,
	["Admin"] = true,
	["Sup.Staff"] = true,
	["SuperModerador"] = true,
	["Moderador"] = true,
	["Moderador A Pruebas"] = true,
}

permisito2 = {
	["Desarrollador"] = true,
	["Administrador.General"] = true,
	["Admin"] = true,
}

permisito = {
	["Desarrollador"] = true,
}


function giveMoney(p, commandName, target, money, ...)
		local cuenta = getAccountName(getPlayerAccount(player))	
	    if isObjectInACLGroup ("user."..cuenta, aclGetGroup ( "Desarrollador" ) ) then
		if not (target) or not money or not (...) then
			local username = getPlayerName(p)
			local targetPlayer, targetPlayerName = exports["Gamemode"]:getFromName(p, target)
			if targetPlayer then
				money = tonumber(money) or 0
				if money >= 100000000 then
					outputChatBox("#F06C6CLo maximo que puedes dar de dinero es 99,999,999$.", p, 255, 0, 0, true)
					return false
				end
				local dinero = getPlayerMoney( targetPlayer )
				if targetPlayer:takeMoney(dinero) then 
					targetPlayer:giveMoney(money)
					exports["Logs-OC"]:sendDiscordLogMessage("seteo $"..money.." dólares a "..getPlayerName(targetPlayer)..".", p)
				else
					outputChatBox("#F06C6CNo se pudo dar esa cantidad al jugador.", p, 255, 0, 0, true)
					return false
				end
				end
			end
		end
	end
addCommandHandler("setmoney", giveMoney, false, false)

function darArma ( thePlayer, commandName, otro, weaponID, ammo )
	local cuenta = getAccountName(getPlayerAccount(thePlayer))	
	    if isObjectInACLGroup ("user."..cuenta, aclGetGroup ( "Desarrollador" ) ) then
		local other = exports["Gamemode"]:getFromName( thePlayer, otro )
		local weaponID, ammo = tonumber( weaponID ), tonumber( ammo )
		if other then
				local status = giveWeapon ( other, weaponID, ammo, true ) 
				if ( not status ) then                                          
					outputConsole ( "Fallo en dar el arma.", thePlayer, 255, 0, 0 ) 
				end
			else
				outputChatBox( "#44A5CA[STAFF - /sduty] #F06C6CNecesitas estar como staff en servicio para usar este comando", thePlayer, 255, 0, 0, true)
			end
		else
			outputChatBox( "/"..commandName.." [id jugador][id arma][municion]", thePlayer, 255, 194, 14 ) 
	end
end
addCommandHandler ( "setweapon", darArma )


------------------------------------------------- Pagar dinero

local antiSpamPagarDinero  = {} 

function staff_estado ( source )
	if permisos[getACLFromPlayer(source)] == true then
		local rango = getACLFromPlayer(source)
		local nick = source:getName()
		if (source:getData("Admin:Disponible") or false) == true then
			source:setData("Admin:Disponible", false)
			source:outputChat("#44A5CA[STAFF] #F06C6CTe saliste del modo staff ", 255, 255, 255, true)
			source:setTeam(Team.getFromName("null"))
			source:setData("invincible",false)
			source:setName(source:getData("NAME") or getPlayerName(source))
			exports["Logs-Joinquit"]:sendDiscordLogMessage("["..rango.." ``"..nick.."``] Salio de servicio como staff", source)
		else
			--if getElementData(source,"Nombre:staff") then
			source:setData("Admin:Disponible", true)
			source:outputChat("#44A5CA[STAFF] #9CFF97Te pusiste en modo staff", 255, 255, 255, true)
			source:setData("NAME",source:getName())
			source:setData("invincible",true)
			source:setTeam(Team.getFromName("Staff"))			
			source:setName(source:getData("Nombre:staff") or getPlayerName(source))
			exports["Logs-Joinquit"]:sendDiscordLogMessage("["..rango.." ``"..nick.."``] Entro en Servicio como staff")
		--else
			--source:outputChat("#44A5CA[STAFF] #9CFF97Necesitas colocarte un nombre como staff, utiliza /nombrestaff", 255, 255, 255, true)
			--end
		end
	end
end
addCommandHandler("staffduty", staff_estado)
addCommandHandler("sduty", staff_estado)
addCommandHandler("adminduty", staff_estado)
addCommandHandler("aduty", staff_estado)

addCommandHandler("verdatos", function(player, cmd, other)
	local comprobante = getAccountName ( getPlayerAccount ( player ) )
	if permisos[getACLFromPlayer(player)] == true then
		if other then
			local other = getPlayerFromName(other)
			if other then
			local jugador = getPlayerName(other)
			local verip = getPlayerAccount ( other )
			local cuentajugador = getAccountName(verip)
			local IP = getAccountIP(verip)
			local serial = getPlayerSerial(other)
			local dinero = getPlayerMoney(other)
			local Vidas = getElementHealth(other)
			if Vidas == 0 then Vida = "Jugador muerto" end
			local health = Vida or Vidas
			local Chalecos = getPedArmor(other) 
			if Chalecos == 0 then Chaleco = "No tiene chaleco" end
			local armor = Chaleco or Chalecos
			if jugador and serial and dinero and health and armor then
				outputChatBox("#FFFF00>> Datos del jugador: #ffffff"..jugador.." #FFFF00<<", player, 0,0,0,true)
				if cuentajugador then
					outputChatBox("#FFFF00Nombre de jugador: #ffffff"..cuentajugador, player, 0,0,0, true)
				else
					outputChatBox("#FFFF00Nombre de jugador: #ffffffno encontrada", player, 0,0,0, true)
				end
				outputChatBox("#FFFF00Nombre de usuario: #ffffff"..jugador,player,0,0,0,true)
				if IP then
					outputChatBox("#FFFF00IP: #ffffff"..IP,player,0,0,0,true)
				else
					outputChatBox("#FFFF00IP: #ffffffno encontrada",player,0,0,0,true)
				end
				outputChatBox("#FFFF00Serial: #ffffff"..serial,player,0,0,0,true)
				outputChatBox("#FFFF00Dinero: #ffffff$"..dinero,player,0,0,0,true)
				outputChatBox("#FFFF00Vida: #ffffff"..health,player,0,0,0,true)
				outputChatBox("#FFFF00Chaleco: #ffffff"..armor,player,0,0,0,true)
			end
			else
				outputChatBox("#FFFFFFSyntax: /verdatos Jugador", player, 0, 0, 0, true)
			end
		else
			outputChatBox("#FFFFFFSyntax: /verdatos Jugador", player, 0, 0, 0, true)
		end
	end
end)

function staffInvisible(player)
	local team = getTeamFromName("Staff")
	local te = getPlayerTeam(player)
	if (team) == (te) then     
		if getElementAlpha(player) == 0 then
			setElementAlpha(player, 255)
			setElementData(player,"invisible",false)
			outputChatBox("#00FF0F¡Ahora todos podrán ver tu nombre!",player,244,60,51,true)
		else
			setElementAlpha(player, 0)
			setElementData(player,"invisible",true)
			outputChatBox("#F06C6C¡Ahora nadie podrá ver tu nombre!",player,244,60,51,true)
        end
    else
    	outputChatBox("#44A5CA[STAFF - /sduty] #F06C6CNecesitas estar como staff en servicio.",player,244,60,51,true)
    end
end
addCommandHandler("invisible", staffInvisible)
addCommandHandler("inv", staffInvisible)

function fly(thePlayer, commandName)
	local team = getTeamFromName("Staff")
	local te = getPlayerTeam(thePlayer)
    if (team) == (te) then
		triggerClientEvent(thePlayer, "onClientFlyToggle", thePlayer)
	else 
		outputChatBox("#44A5CA[STAFF - /sduty] #F06C6CNecesitas estar como staff en servicio.",thePlayer,244,60,51,true)
	end
end
addCommandHandler("airbreak", fly, false, false)

addCommandHandler("volar", fly, false, false)

function repairVehicle ( thePlayer, commandName) -- never use a function name like fixVehicle because it can make problems. 
    if ( isPedInVehicle ( thePlayer ) ) then 
    	local team = getTeamFromName("Staff")
		local te = getPlayerTeam(thePlayer)
    	if (team) == (te) then
        local theVehicle = getPedOccupiedVehicle ( thePlayer) 
        local succes = fixVehicle ( theVehicle ) 
        if ( succes ) then 
            outputChatBox ("#00FF0F¡Vehiculo reparado con exito! ", thePlayer,0,0,0,true )
            
        else 
            outputChatBox ("#F06C6C¡No pudiste reparar este vehiculo!", thePlayer,0,0,0,true) 
        		end 
            else 
        outputChatBox("#44A5CA[STAFF - /sduty] #F06C6CNecesitas estar como staff en servicio.",thePlayer,244,60,51,true)
        	end 
        else 
        outputChatBox ( "Necesitas estar arriba de un vehiculo para repararlo!", thePlayer )
    end 
end 
addCommandHandler ( "fixveh", repairVehicle)

function viewCoins(p,cmd,name,coins)
	if permisito2[getACLFromPlayer(p)] == true then
		if name and name ~="" then
			local player = getPlayerFromName(name) or exports["Gamemode"]:getFromName( p, name )
			if player then
				if exports.nlogin:getCharacterData(player,"Monedas") ~= false then
					outputChatBox("Los NextCoins de "..player:getName().." son "..(exports.nlogin:getCharacterData(player,"Monedas") or 0)..".",p,0,255,0,true)
				else
					outputChatBox("Error Jugador no logeado.",p,255,255,0,true)
				end
			else
				outputChatBox("Error Jugador no encontrado.",p,255,255,0,true)
			end
		else
			outputChatBox("Syntax: /vcoins [nombre/id]",p,255,255,255,true)
		end
	end
end
addCommandHandler("vcoins",viewCoins)

function setCoins(p,cmd,name,coins)
	if permisito2[getACLFromPlayer(p)] == true then
		if name and name ~="" and coins and coins ~="" then
			local player = getPlayerFromName(name) or exports["Gamemode"]:getFromName( p, name )
			if player then
				if tonumber(coins) and tonumber(coins) > 0 then
					if exports.nlogin:getCharacterData(player,"Monedas") ~= false then
						exports.nlogin:setCharacterData(player,"Monedas", (exports.nlogin:getCharacterData(player,"Monedas") or 0) + coins)
						outputChatBox("Los NextCoins de "..player:getName().." ahora son "..(exports.nlogin:getCharacterData(player,"Monedas") or 0)..".",p,0,255,0,true)
					else
						outputChatBox("Error Jugador no logeado.",p,255,255,0,true)
					end
				else
					outputChatBox("Ingresa una cantidad de coins valida!",p,255,0,0,true)
				end
			else
				outputChatBox("Error Jugador no encontrado.",p,255,255,0,true)
			end
		else
			outputChatBox("Syntax: /scoins [nombre/id] [coins]",p,255,255,255,true)
		end
	end
end
addCommandHandler("scoins",setCoins)

--- STAFFS

Clips = {}

function copyIDAdmin(player,cmd)
	if not notIsGuest( player ) then
		if permisito2[getACLFromPlayer(player)] == true then
			if Clips[player] then
				triggerClientEvent(player,"NL:CopyData",player,player,tostring(Clips[player]))
				outputChatBox("Ha sido copiado al portapapeles con exito.",player,255,255,0,true)
			else
				outputChatBox("Error no hay datos para copiar.",player,255,255,0,true)
			end
		else
			outputChatBox("Permisos insuficientes! (Desarrollador, Administrador General, Admin)",player,255,0,0,true)
		end
	end
end
addCommandHandler("vclip", copyIDAdmin)

function viewIDAdmin(source,cmd,name)
	if not notIsGuest( source ) then
		if permisito2[getACLFromPlayer(source)] == true then
			if name and name ~= "" then
				local player = getPlayerFromName(name) or exports["Gamemode"]:getFromName( source, name )
				if player then
					if not notIsGuest( player ) then
						Clips[source] = mysql:AccountName(player)
						outputChatBox("La cuenta (personaje) del jugador es "..mysql:AccountName(player).." ["..player:getName().."]." ,source,255,255,0,true)
						outputChatBox("Puedes usar /vclip para copiarlo rapidamente!" ,source,255,255,0,true)
					else
						outputChatBox("Error Jugador no a logeado.",source,255,255,0,true)
					end
				else
					outputChatBox("Error Jugador no encontrado.",source,255,255,0,true)
				end
			else
				outputChatBox("Syntax: /veracc [nombre/id]",source,255,255,0,true)
			end
		else
			outputChatBox("Permisos insuficientes! (Desarrollador, Administrador General, Admin)",source,255,0,0,true)
		end
	end
end
addCommandHandler("veracc", viewIDAdmin)

function removeMail(source,cmd,mail)
	if not notIsGuest( source ) then
		if permisito2[getACLFromPlayer(source)] == true then
			if mail and mail ~= "" then
				local data = isOccupedAccount(mail) or false
				if data then
					local name = data["Nick"]
					local player = getPlayerFromName(name) or exports["Gamemode"]:getFromName( source, name )
					if player then
						redirectPlayer( player, "", 0, "")
					end
					if mysql:delete(" DELETE FROM Registros WHERE Correo = '"..mail.."'" ) then
						outputChatBox("Este mail ya no coincide con una cuenta en la base de datos.",source,0,255,0,true)
					end
				else
					outputChatBox("Este mail no coincide con una cuenta en la base de datos.",source,255,0,0,true)
				end
			else
				outputChatBox("Syntax: /dellmail [mail]",source,255,255,0,true)
			end
		else
			outputChatBox("Permisos insuficientes! (Desarrollador, Administrador General, Admin)",source,255,0,0,true)
		end
	end
end
addCommandHandler("dellmail", removeMail)

									

function isOccupedAccount(mail)
	local save = mysql:query("SELECT * From Registros WHERE Correo = '"..mail.."'")
	if ( type ( save ) == "table" and #save == 0 ) or not save then
		return false
	else
		return save[1]
	end
end

function isOccupedCharacter(nick)
	local save = mysql:query("SELECT * From save_system WHERE Cuenta = '"..nick.."'")
	if ( type ( save ) == "table" and #save == 0 ) or not save then
		return false
	else
		return save[1]
	end
end


addEventHandler( "onPlayerQuit", getRootElement(), function() 
	if Clips[source] then 
		Clips[source] = false 
	end 
end)

function rellenar(source,_,name,num)
	if not notIsGuest( source ) then
		if permisito[getACLFromPlayer(source)] == true then
			if name and name ~= "" then
				local player = getPlayerFromName(name) or exports["Gamemode"]:getFromName( source, name )
				if player then
					if not notIsGuest( player ) then
						if tonumber(num) and tonumber(num) > 0 then
							player:setData('Agua',tonumber(num))
							player:setData('Comida',tonumber(num))
							outputChatBox("Las necesidades de "..player:getName().." ahora son "..(tonumber(num) or 0).."%!.",source,0,255,0,true)
						else
							player:setData('Agua',100)
							player:setData('Comida',100)
							outputChatBox("Las necesidades de "..player:getName().." ahora son 100%!.",source,0,255,0,true)
						end
					else
						outputChatBox("Error Jugador no a logeado.",source,255,255,0,true)
					end
				else
					outputChatBox("Error Jugador no encontrado.",source,255,255,0,true)
				end
			else
				outputChatBox("Syntax: /llenar [nombre/id] [cantidad]",source,255,255,0,true)
			end
		else
			outputChatBox("Permisos insuficientes! (Desarrollador)",source,255,0,0,true)
		end
	end
end
addCommandHandler("llenar", rellenar)

function anuncio_staff( source, cmd, ... )
	if not notIsGuest( source ) then
		if permisos[getACLFromPlayer(source)] == true then
			local msg = table.concat({...}, " ")
			if msg ~="" and msg ~=" " then
				local s = trunklateText( source, msg )
				for i, v in ipairs(Element.getAllByType("player")) do
					v:outputChat(source:getData("Nombre:staff").." Comunica : #FFFFFF"..s, 0, 236, 255, true)
				end
			else
                
				source:outputChat("Syntax: /an [Mensaje]", 255, 255, 255, true)
			end
		end
	end
end
addCommandHandler("an", anuncio_staff)

function staa(source,cmd,ayuda)
	if not notIsGuest( source ) then
		if permisos[getACLFromPlayer(source)] == true then
			if ayuda == "staff" then
			source:outputChat(" ",200,50,50)
			source:outputChat("#CFF4FF/staffduty /sduty /adminduty /aduty /nombrestaff",255,255,255,true)
			source:outputChat("#B9B9B9/inv /invisible /volar /airbreak /vermps /vermp",255,255,255,true)
			source:outputChat("#CFF4FF/quitararmas  /cuentas  /verdatos  /setdimension /jail /sacarjail ",255,255,255,true)
			source:outputChat("#B9B9B9/rea o /reaceptar  /rer o rerechazar  /rduda o /responderduda /vreportes /dudas",255,255,255,true)
			source:outputChat("#CFF4FF/kickear /advertir /banear  /desbanear /vida /chaleco",255,255,255,true)
			source:outputChat("#B9B9B9/ir /traer /llevar /ls /lv /sf /an /skin",255,255,255,true)
			source:outputChat("#CFF4FF/doomveh /llenarnaftaveh /respawnvehpub all /naftavehs /sv /borrarveh /vehreparar",255,255,255,true)
	else
		if permisito[getACLFromPlayer(source)] == true then
           if ayuda == "dueño" then
			source:outputChat(" ",200,50,50)
			source:outputChat("#CFF4FF/darmodpruebas /quitarmodpruebas /darmod /quitarmod",255,255,255,true)
			source:outputChat("#B9B9B9/darsmod /quitarsmod /darencstaff /quitarencstaff /daradmin /quitaradmin",255,255,255,true)
			source:outputChat("#CFF4FF/daradming /quitaradming /liderfaccion /limpiarfaccion /despedir /crearfamilia /colocarjefe",255,255,255,true)
			source:outputChat("#B9B9B9/limpiarfamilia /eliminarfamilia /colocarcolor /crearrobo /crearexteriorrobo",255,255,255,true)
			source:outputChat("#CFF4FF/vips /setmoney /setweapon /darpayday",255,255,255,true)
					end
				end
			end
		end
	end
end
addCommandHandler("ayuda",staa)

function skinPlayer ( player, cmd, who, id )
	if not notIsGuest( player ) then
		if permisos[getACLFromPlayer(player)] == true then
			if tonumber(who) then
				if tonumber(id) then
					local thePlayer = exports["Gamemode"]:getFromName( player, who )
					if (thePlayer) then
						if (id) then
							local allSkins = getValidPedModels( )
							local result = false
							for key, skin in ipairs(allSkins) do
								if skin == tonumber(id) then
									thePlayer:setModel(skin)
									outputDebugString(player:getName().." le ha dado la skin "..skin.." a "..thePlayer:getName().."", 0, 50, 150, 50)
									player:outputChat("Le has dado la skin "..skin.." a "..thePlayer:getName().."", 50, 150, 50, true)
									thePlayer:outputChat("* El administrador "..player:getData("Nombre:staff").." te ha dado la skin "..skin.."", 50, 150, 50, true)
								end
							end
						end
					else
						player:outputChat("Syntax: /skin [ID] [ID]", 255, 255, 255, true)
					end
				end
			else
				if tonumber(id) then
					local thePlayer = getPlayerFromName(who)
					if (thePlayer) then
						if (id) then
							local allSkins = getValidPedModels( )
							local result = false
							for key, skin in ipairs(allSkins) do
								if skin == tonumber(id) then
									thePlayer:setModel(skin)
									outputDebugString(player:getName().." le ha dado la skin "..skin.." a "..thePlayer:getName().."", 0, 50, 150, 50)
									player:outputChat("Le has dado la skin "..skin.." a "..thePlayer:getName().."", 50, 150, 50, true)
									thePlayer:outputChat("* El administrador "..player:getData("Nombre:staff").." te ha dado la skin "..skin.."", 50, 150, 50, true)
								end
							end
						end
					else
						player:outputChat("Syntax: /skin [Nombre] [ID]", 255, 255, 255, true)
					end
				end
			end
		end
	end
end
addCommandHandler("skin", skinPlayer)

function cuentas_player(source, cmd, who)
	if not notIsGuest( source ) then
		if permisos[getACLFromPlayer(source)] == true then
			if tonumber(who) then
				local thePlayer = exports["Gamemode"]:getFromName(source,who)
				if (player) then
						local serial = player:getSerial()
						local accs = query("SELECT * FROM `Registros` where Serial=?", tostring(serial))
						if not ( type( accs ) == "table" and #accs == 0 ) or not accs then
							source:outputChat("¡ Todas las cuentas registradas de: "..player:getName().." !", 150, 50, 50, true)
							for _, v in ipairs(accs) do
								source:outputChat("Nombre de cuenta: #00FF00"..v.Cuenta, 80, 150, 80, true)
								source:outputChat("Fecha de la creación: #00FF00"..v.Fecha, 80, 150, 80, true)
								source:outputChat("---------------------", 80, 150, 80, true)
							end
						end
				else
					source:outputChat("Syntax: /cuentas [ID]", 255, 255, 255, true)
				end
			else
				local thePlayer = getPlayerFromName(who)
				if (player) then
						local serial = player:getSerial()
						local accs = query("SELECT * FROM `Registros` where Serial=?", tostring(serial))
						if not ( type( accs ) == "table" and #accs == 0 ) or not accs then
							source:outputChat("¡ Todas las cuentas registradas de: "..player:getName().." !", 150, 50, 50, true)
							for _, v in ipairs(accs) do
								source:outputChat("Nombre de cuenta: #00FF00"..v.Cuenta, 80, 150, 80, true)
								source:outputChat("Fecha de la creación: #00FF00"..v.Fecha, 80, 150, 80, true)
								source:outputChat("---------------------", 80, 150, 80, true)
							end
						end
				else
					source:outputChat("Syntax: /cuentas [Nombre]", 255, 255, 255, true)
				end
			end
		end
	end
end
addCommandHandler("cuentas", cuentas_player)

function kickPlayerStaff(player, cmd, who, ...)
	if not notIsGuest( player ) then
		if permisos[getACLFromPlayer(player)] == true then   
			if tonumber(who) then
				local thePlayer = getPlayerFromName(who)
				if (thePlayer) then
					local rs = table.concat({...}, " ")
					if rs ~="" and rs~=" " then
						outputDebugString(player:getName().. " kickeo a "..thePlayer:getName().." | Razón: "..rs, 0, 0, 150, 0)
						for i, v in ipairs(Element.getAllByType("player")) do
							v:outputChat("Un miembro del staff kickeo a : #F3E50F"..thePlayer:getName()..". #FFFFFFRazón: #FF0033"..rs, 255, 255, 255, true)
						end
						exports["Gamemode"]:message_admins("Fue: #00FF00"..player:getData("Nombre:staff"), 255, 255, 255, true)
						dbExec(statsSQL,"INSERT INTO datosOOC(accountName,tipo,motivo,tiempo,staff) VALUES(?,?,?,?,?)", thePlayer:getName(), "Kick", rs, "KICK", player:getData("Nombre:staff"))
						thePlayer:kick(player, rs)
					else
						player:outputChat("Escribe una razón para kickear.", 150, 50, 50, true)
					end
				else
					player:outputChat("Syntax: /kickear [Nombre_Apellido] [Razón]", 255, 255, 255, true)
				end
			else
				local thePlayer = getPlayerFromName(who)
				if (thePlayer) then
					local rs = table.concat({...}, " ")
					if rs ~="" and rs~=" " then
						outputDebugString(player:getName().. " kickeo a "..thePlayer:getName().." | Razón: "..rs, 0, 0, 150, 0)
						for i, v in ipairs(Element.getAllByType("player")) do
							v:outputChat("Un miembro del staff kickeo a : #F3E50F"..thePlayer:getName()..". #FFFFFFRazón: #FF0033"..rs, 255, 255, 255, true)
						end
						exports["Gamemode"]:message_admins("Fue: #00FF00"..player:getData("Nombre:staff"), 255, 255, 255, true)
						dbExec(statsSQL,"INSERT INTO datosOOC(accountName,tipo,motivo,tiempo,staff) VALUES(?,?,?,?,?)", thePlayer:getName(), "Kick", rs, "KICK", player:getData("Nombre:staff"))
						thePlayer:kick(player, rs)
					else
						player:outputChat("Escribe una razón para kickear.", 150, 50, 50, true)
					end
				else
					player:outputChat("Syntax: /kickear [Nombre_Apellido] [Razón]", 255, 255, 255, true)
				end
			end
		end
	end
end
addCommandHandler("kickear", kickPlayerStaff)

function BanPlayerStaff(player, cmd, who, horas, ...)
	if not notIsGuest( player ) then
		if permisos[getACLFromPlayer(player)] == true then   
		  local horas = tonumber(horas)
		  if horas then
				local thePlayer = getPlayerFromName(who)
				if (thePlayer) then
					local rs = table.concat( { ... }, " " ) .. " [" .. player:getData("Nombre:staff") .. "]"
					if rs ~="" and rs~=" " then
						outputDebugString(player:getName().. " baneo a "..thePlayer:getName().." | Razón: "..rs, 0, 0, 150, 0)
						for i, v in ipairs(Element.getAllByType("player")) do
							v:outputChat("Un miembro del staff baneo ".. ( horas == 0 and "permanente" or ( horas < 1 and ( math.ceil( horas * 60 ) .. " minutos" ) or ( horas .. " hora(s)" ) ) ) .." a #F3E50F"..thePlayer:getName()..". ", 255, 255, 255, true)
							v:outputChat("Razón: #FF0033"..rs, 255, 255, 255, true)
						end
						
						exports["Gamemode"]:message_admins("Fue: #00FF00"..player:getData("Nombre:staff"), 255, 255, 255, true)
						dbExec(statsSQL,"INSERT INTO datosOOC(accountName,tipo,motivo,tiempo,staff) VALUES(?,?,?,?,?)", thePlayer:getName() , "Baneo", rs, horas, player:getData("Nombre:staff"))
						local serial = getPlayerSerial( thePlayer )
						thePlayer:ban(true, false, false, player:getName(), rs, math.ceil( horas * 60 * 60 ) )
						if serial then
						addBan( nil, nil, serial, player:getName(), rs, math.ceil( horas * 60 * 60 ) )
					else
						player:outputChat("Escribe una razón para banear.", 150, 50, 50, true)
					end
				else
					player:outputChat("Syntax: /banear [Nombre_Apellido] + [horas] + [Razón]", 255, 255, 255, true)
				end
			else
				local thePlayer = getPlayerFromName(who)
				if (thePlayer) then

					local rs = table.concat( { ... }, " " ) .. " [" .. player:getData("Nombre:staff") .. "]"
					if rs ~="" and rs ~=" " then

						outputDebugString(player:getName().. " baneo a "..thePlayer:getName().." | Razón: "..rs, 0, 0, 150, 0)
						
						for i, v in ipairs(Element.getAllByType("player")) do
							v:outputChat("Un miembro del staff baneo ".. ( horas == 0 and "permanente" or ( horas < 1 and ( math.ceil( horas * 60 ) .. " minutos" ) or ( horas .. " hora(s)" ) ) ) .." a #F3E50F"..thePlayer:getName()..". ", 255, 255, 255, true)
							v:outputChat("Razón: #FF0033"..rs, 255, 255, 255, true)
						end
						
						exports["Gamemode"]:message_admins("Fue: #00FF00"..player:getData("Nombre:staff"), 255, 255, 255, true)
						dbExec(statsSQL,"INSERT INTO datosOOC(accountName,tipo,motivo,tiempo,staff) VALUES(?,?,?,?,?)", thePlayer:getName() , "Baneo", rs, horas, player:getData("Nombre:staff"))

						local serial = getPlayerSerial( thePlayer )
						thePlayer:ban(true, false, false, player:getName(), rs, math.ceil( horas * 60 * 60 ) )
						if serial then
							addBan( nil, nil, serial, player:getName(), rs, math.ceil( horas * 60 * 60 ) )
							else
								player:outputChat("Escribe una razón para banear.", 150, 50, 50, true)
							end
						else
							player:outputChat("Syntax: /banear [Nombre_Apellido] + [Horas] + [Razón]", 255, 255, 255, true)
						end
					end
				end
			else
				player:outputChat("Syntax :#FFFFFF /banear [Nombre_Apellido] + [Horas] + [Razón]", 0, 180, 255, true)
			end
		end
	end
end
addCommandHandler("banear", BanPlayerStaff)

function unbanPlayerCommand(thePlayer, commandName, nickName)
   if permisos[getACLFromPlayer(thePlayer)] == true then   
       if nickName then
            local bans = getBans()
            for _,ban in ipairs(bans)do
                if getBanNick(ban) == nickName then
                   removeBan(ban)
                end
            end
            outputChatBox( "Un miembro del staff desbaneo a #F3E50F"..nickName.."", root, 255, 255, 255,true)
            exports["Gamemode"]:message_admins("Fue: #00FF00"..thePlayer:getData("Nombre:staff"), 255, 255, 255, true)
        else
            outputChatBox("Syntax :#FFFFFF /"..commandName.." [Cuenta del usuario]", thePlayer, 0, 180, 255,true)
        end
    else
         outputChatBox("", thePlayer, 0, 180, 255,true)
    end
end
addCommandHandler("desbanear", unbanPlayerCommand, false, false)

function QuitarArmasP(player, cmd, who)
	if permisos[getACLFromPlayer(player)] == true then
		if not notIsGuest(player) then
			if tonumber(who) then
				local thePlayer = exports["Gamemode"]:getFromName(player,who)
				if (thePlayer) then
					outputDebugString(player:getName().. " le quito sus armas al jugador "..thePlayer:getName(), 0, 0, 150, 0)
					player:outputChat("Le acabas de quitar las armas al jugador: #00FF00"..thePlayer:getName(), 255, 255, 255, true)
					thePlayer:outputChat("El administrador "..player:getName().." te ha quitado todas tus armas", 150, 50, 50, true)
					takeAllWeapons(thePlayer)
				else
					player:outputChat("Syntax: /quitararmas [Nombre_Apellido]", 255, 255, 255, true)
				end
			else
				local thePlayer = getPlayerFromName(who)
				if (thePlayer) then
					outputDebugString(player:getName().. " le quito sus armas al jugador "..thePlayer:getName(), 0, 0, 150, 0)
					player:outputChat("Le acabas de quitar las armas al jugador: #00FF00 "..thePlayer:getName(), 255, 255, 255, true)
					thePlayer:outputChat("El administrador "..player:getData("Nombre:staff").." te ha quitado todas tus armas", 150, 50, 50, true)
					takeAllWeapons(thePlayer)
				else
					player:outputChat("Syntax: /quitararmas [Nombre_Apellido]", 255, 255, 255, true)
				end
			end
		end
	end
end
addCommandHandler("quitararmas", QuitarArmasP)

function llevar_jugador(source, cmd, who, jugador)
	if not notIsGuest( source ) then
		local playerTeam = getPlayerTeam ( source )          -- get the player's team
   			 if ( playerTeam ) then   
			if tonumber(who) then
				local player = exports["Gamemode"]:getFromName(source,who)
				local thePlayer = exports["Gamemode"]:getFromName(jugador)
				if ( player ) and ( thePlayer ) then
					--if player ~= source and thePlayer ~= source then
						local posicion = Vector3(thePlayer:getPosition())
						local x, y, z = posicion.x, posicion.y, posicion.z
						local dim = thePlayer:getDimension()
						local int = thePlayer:getInterior()
						outputDebugString("* "..source:getName().." llevo al jugador: "..player:getName().." hacia: "..thePlayer:getName().."", 0, 0, 150, 0)
						player:outputChat("Un "..getACLFromPlayer(source).." te llevo al jugador "..thePlayer:getName().."", 20, 150, 20)
						fadeCamera(player, false)
						if player:isInVehicle() then
							player:removeFromVehicle(player:getOccupiedVehicle())
						end
						setTimer(fadeCamera, 0, 1, player, true)
						setTimer(function(player, x, y, z, int, dim, thePlayer)
							if isElement(player) then
								player:setInterior(int)
								player:setPosition(x, y, z)
								player:setDimension(dim)
							end
						end, 0, 1, player, x, y, z+2, int, dim, thePlayer)
					--end
				else
					source:outputChat("Syntax: /llevar [ID] [Nombre]", 255, 255, 255, true)
				end
			else
				local player = getPlayerFromName(who)
				local thePlayer = getPlayerFromName(jugador)
				if ( player ) and ( thePlayer ) then
					--if player ~= source and thePlayer ~= source then
						local posicion = Vector3(thePlayer:getPosition())
						local x, y, z = posicion.x, posicion.y, posicion.z
						local dim = thePlayer:getDimension()
						local int = thePlayer:getInterior()
						outputDebugString("* "..source:getName().." llevo al jugador: "..player:getName().." hacia: "..thePlayer:getName().."", 0, 0, 150, 0)
						player:outputChat("Un "..getACLFromPlayer(source).." te llevo al jugador "..thePlayer:getName().."", 20, 150, 20)
						fadeCamera(player, false)
						if player:isInVehicle() then
							player:removeFromVehicle(player:getOccupiedVehicle())
						end
						setTimer(fadeCamera, 0, 1, player, true)
						setTimer(function(player, x, y, z, int, dim, thePlayer)
							if isElement(player) then
								player:setInterior(int)
								player:setPosition(x, y, z)
								player:setDimension(dim)
							end
						end, 0, 1, player, x, y, z+2, int, dim, thePlayer)
					--end
				else
					source:outputChat("Syntax: /llevar [Nombre] [Nombre]", 255, 255, 255, true)
				end
			end
		end
	end
end
addCommandHandler("llevar", llevar_jugador)

function get_position( source )
	if permisos[getACLFromPlayer(source)] == true then
		local posicion = Vector3(source:getPosition())
		local x, y, z = posicion.x, posicion.y, posicion.z
		local posicion2 = Vector3(source:getRotation())
		local rx, ry, rz = posicion2.x, posicion2.y, posicion2.z
		local dim = source:getDimension()
		local int = source:getInterior()
		source:outputChat("Posicion: "..x..", "..y..", "..z.."", 150, 0, 0)
		source:outputChat("Rotacion: "..rx..", "..ry..", "..rz.."", 150, 0, 0)
		source:outputChat("Interior: "..int.."", 150, 0, 0)
		source:outputChat("Dimension: "..dim.."", 150, 0, 0)
	end
end
addCommandHandler("pos", get_position)

function warpearse_jugador( source, cmd, jugador )
	local playerTeam = getPlayerTeam ( source )          -- get the player's team
	if ( playerTeam ) then   
		if tonumber( jugador ) then
			local player = exports["Gamemode"]:getFromName(source,jugador)
			if ( player ) then
				if player ~= source then
					local posicion = Vector3(player:getPosition())
					local x, y, z = posicion.x, posicion.y, posicion.z
					local dim = player:getDimension()
					local int = player:getInterior()
					outputDebugString("* "..source:getName().." se Teletransportar al jugador: "..player:getName().."", 0, 0, 150, 0)
					fadeCamera(source, false)
					if source:isInVehicle() then
						source:removeFromVehicle(source:getOccupiedVehicle())
					end
					setTimer(fadeCamera, 0, 1, source, true)
					setTimer(function(source, x, y, z, int, dim, player)
						if isElement(source) or isElement(player) then
						source:outputChat("* Te acabas de Teletransportar al jugador: #00FF00"..player:getName().."", 255, 255, 255, true)
						source:setInterior(int)
						source:setPosition(x+2, y+1.5, z)
						source:setDimension(dim)
					end
					end, 1000, 1, source, x, y, z+2, int, dim, player)
				end
			else
				source:outputChat("Syntax: /ir [Nombre_Apellido]", 255, 255, 255, true)
			end
		else
			local player = getPlayerFromName(jugador)
			if ( player ) then
				if player ~= source then
					local posicion = Vector3(player:getPosition())
					local x, y, z = posicion.x, posicion.y, posicion.z
					local dim = player:getDimension()
					local int = player:getInterior()
					outputDebugString("* "..source:getName().." se dio Tp al jugador: "..player:getName().."", 0, 0, 150, 0)
					fadeCamera(source, false)
					if source:isInVehicle() then
						source:removeFromVehicle(source:getOccupiedVehicle())
					end
					setTimer(fadeCamera, 1000, 1, source, true)
					setTimer(function(source, x, y, z, int, dim, player)
						if isElement(source) or isElement(player) then
						source:outputChat("* Te acabas de Teletransportar al jugador: #00FF00"..player:getName().."", 255, 255, 255, true)
						source:setInterior(int)
						source:setPosition(x+2, y+1.5, z)
						source:setDimension(dim)
					end
					end, 0, 1, source, x, y, z, int, dim, player)
				end
			else
				source:outputChat("Syntax: /ir [Nombre]", 255, 255, 255, true)
			end
		end
	end
end
addCommandHandler("ir", warpearse_jugador)

function warp_jugador( source, cmd, jugador )
	local playerTeam = getPlayerTeam ( source )          -- get the player's team
	if ( playerTeam ) then   
		if tonumber( jugador ) then
			local player = exports["Gamemode"]:getFromName(source,jugador)
			if ( player ) then
				if player ~= source then
					local posicion = Vector3(source:getPosition())
					local x, y, z = posicion.x, posicion.y, posicion.z
					local dim = source:getDimension()
					local int = source:getInterior()
					fadeCamera(player, false)
					if player:isInVehicle() then
						player:removeFromVehicle(player:getOccupiedVehicle())
					end
					setTimer(fadeCamera, 0, 1, player, true)
					setTimer(function(source, x, y, z, int, dim, player)
						if isElement(source) or isElement(player) then
						source:outputChat("#FFFFFFTrajiste al usuario: #42FF00"..player:getName().."", 255, 255, 255, true)
						player:outputChat("#FFFFFFTe trajo: #42FF00"..source:getName().."", 0, 150, 0,true)
						player:setInterior(int)
						player:setPosition(x, y, z+2)
						player:setDimension(dim)
					end
					end, 0, 1, source, x, y, z, int, dim, player)
				end
			else
				source:outputChat("Syntax: /traer [ID]", 255, 255, 255, true)
			end
		else
			local player = getPlayerFromName(jugador)
			if ( player ) then
				if player ~= source then
					local posicion = Vector3(source:getPosition())
					local x, y, z = posicion.x, posicion.y, posicion.z
					local dim = source:getDimension()
					local int = source:getInterior()
					if player:isInVehicle() then
						player:removeFromVehicle(player:getOccupiedVehicle())
					end
					outputDebugString("#FFFFFFTe trajo: #42FF00"..source:getName().."", 0, 0, 150, 0,true)
					fadeCamera(player, false)
					setTimer(fadeCamera, 0, 1, player, true)
					setTimer(function(source, x, y, z, int, dim, player)
						if isElement(source) or isElement(player) then
						source:outputChat("#FFFFFFTrajiste al usuario: #42FF00"..player:getName().."", 255, 255, 255, true)
						player:outputChat("#FFFFFFTe trajo: #42FF00"..source:getData("Nombre:staff").."", 0, 150, 0,true)
						player:setInterior(int)
						player:setPosition(x, y, z+2)
						player:setDimension(dim)
					end
					end, 0, 1, source, x, y, z, int, dim, player)
				end
			else
				source:outputChat("Syntax: /traer [Nombre]", 255, 255, 255, true)
			end
		end
	end
end
addCommandHandler("traer", warp_jugador)

local valoresJugador = {}

function give_health(player, cmd, who, tp, valor)
	if not notIsGuest( player ) then
		if permisos[getACLFromPlayer(player)] == true then
			if tonumber(who) then
				local jugador = exports["Gamemode"]:getFromName(player,who)
				if (jugador) then
					if tonumber(valor) then
						if tonumber(valor) >= 0 and tonumber(valor) <= 100 then
							if tp == "-" then
								outputDebugString("* "..player:getData("Nombre:staff").." le quito -"..valor.." vida a "..jugador:getName().."", 0, 50, 150, 50)
								player:outputChat("* Le quitaste -"..valor.." de vida al jugador: "..jugador:getName().."", 50, 150, 50, true)
								jugador:outputChat("¡El ("..getACLFromPlayer(player)..") "..player:getData("Nombre:staff").." te quito -"..valor.." de vida !", 150, 20, 20)
								--
								jugador:setHealth(jugador:getHealth()-tonumber(valor))
							elseif tp == "+" then
								outputDebugString("* "..player:getData("Nombre:staff").." le dio vida a "..jugador:getName().."", 0, 50, 150, 50)
								player:outputChat("* Le aumentaste +"..valor.." de vida al jugador: "..jugador:getName().."", 50, 255, 50, true)
								jugador:outputChat("¡El ("..getACLFromPlayer(player)..") "..player:getData("Nombre:staff").." te aumento +"..valor.." de vida !", 150, 255, 150)
								--
								jugador:setHealth(jugador:getHealth()+tonumber(valor))
							else
								player:outputChat("Syntax: /vida [Nombre o ID] [-/+] [valor]", 150, 50, 50, true)
							end
						else
							player:outputChat("* El valor debe ser entre 1-100", 150, 0, 0, true)
						end
					end
				else
					player:outputChat("Recuerda que + es para aumentar y - para bajar.", 150, 50, 50, true)
					player:outputChat("Syntax: /vida [ID] + [Valor]", 255, 255, 255, true)
				end
			else
				local jugador = exports["Gamemode"]:getFromName(player,who)
				if (jugador) then
					if tonumber(valor) then
						if tonumber(valor) >= 0 and tonumber(valor) <= 100 then
							if tp == "-" then
								outputDebugString("* "..player:getName().." le quito -"..valor.." vida a "..jugador:getName().."", 0, 50, 150, 50)
								player:outputChat("* Le quitaste -"..valor.." de vida al jugador: "..jugador:getName().."", 50, 150, 50, true)
								jugador:outputChat("¡El ("..getACLFromPlayer(player)..") "..player:getName().." te quito -"..valor.." de vida !", 150, 20, 20)
								--
								jugador:setHealth(jugador:getHealth()-tonumber(valor))
							elseif tp == "+" then
								outputDebugString("* "..player:getData("Nombre:staff").." le dio vida a "..jugador:getName().."", 0, 50, 150, 50)
								player:outputChat("* Le aumentaste +"..valor.." de vida al jugador: "..jugador:getName().."", 50, 255, 50, true)
								jugador:outputChat("¡El ("..getACLFromPlayer(player)..") "..player:getData("Nombre:staff").." te aumento +"..valor.." de vida !", 150, 255, 150)
								--
								jugador:setHealth(jugador:getHealth()+tonumber(valor))
							else
								player:outputChat("Syntax: /vida [Nombre o ID] [-/+] [valor]", 150, 50, 50, true)
							end
						else
							player:outputChat("* El valor debe ser entre 1-100", 150, 0, 0, true)
						end
					end
				else
					player:outputChat("Recuerda que + es para aumentar y - para bajar.", 150, 50, 50, true)
					player:outputChat("Syntax: /vida [ID] + [Valor]", 255, 255, 255, true)
				end
			end
		end
	end
end
addCommandHandler("vida", give_health)

function give_armor(player, cmd, who, tp, valor)
	if not notIsGuest( player ) then
		if permisos[getACLFromPlayer(player)] == true then
			if tonumber(who) then
				local jugador = exports["Gamemode"]:getFromName(player,who)
				if (jugador) then
					if tonumber(valor) then
						if tonumber(valor) >= 0 and tonumber(valor) <= 100 then
							if tp == "-" then
								outputDebugString("* "..player:getName().." le quito -"..valor.." de chaleco a "..jugador:getName().."", 0, 50, 150, 50)
								player:outputChat("* Le quito -"..valor.." de chaleco al jugador: "..jugador:getName().." ", 150, 150, 150, true)
								jugador:outputChat("¡El ("..getACLFromPlayer(player)..") "..player:getName().." te quito -"..valor.." de chaleco", 150, 20, 20)
								--
								jugador:setArmor(jugador:getArmor()-tonumber(valor))
							elseif tp == "+" then
								outputDebugString("* "..player:getName().." le dio +"..valor.." chaleco a "..jugador:getName().." ", 0, 50, 150, 50)
								player:outputChat("* Le dio +"..valor.." de chaleco al jugador: "..jugador:getName().."", 150, 150, 150, true)
								jugador:outputChat("¡El ("..getACLFromPlayer(player)..") "..player:getName().." te dio +"..valor.." de chaleco", 150, 255, 150)
								--
								jugador:setArmor(jugador:getArmor()+tonumber(valor))
							else
								player:outputChat("Syntax: /chaleco [Nombre o ID] [-] o [+] [valor]", 150, 50, 50, true)
							end
						else
							player:outputChat("* El valor debe ser entre 1-100", 150, 0, 0, true)
						end
					end
				else
					player:outputChat("Recuerda que + es para aumentar y - para bajar.", 150, 50, 50, true)
					player:outputChat("Syntax: /chaleco [ID] + [Valor]", 255, 255, 255, true)
				end
			else
				local jugador = getPlayerFromName(who)
				if (jugador) then
					if tonumber(valor) then
						if tonumber(valor) >= 0 and tonumber(valor) <= 100 then
							if tp == "-" then
								outputDebugString("* "..player:getName().." le quito -"..valor.." de chaleco a "..jugador:getName().."", 0, 50, 150, 50)
								player:outputChat("* Le quito -"..valor.." de chaleco al jugador: "..jugador:getName().." ", 150, 150, 150, true)
								jugador:outputChat("¡El ("..getACLFromPlayer(player)..") "..player:getName().." te quito -"..valor.." de chaleco", 150, 20, 20)
								--
								jugador:setArmor(jugador:getArmor()-tonumber(valor))
							elseif tp == "+" then
								outputDebugString("* "..player:getName().." le dio +"..valor.." de chaleco a "..jugador:getName().." ", 0, 50, 150, 50)
								player:outputChat("* Le dio +"..valor.." de chaleco al jugador: "..jugador:getName().."", 150, 150, 150, true)
								jugador:outputChat("¡El ("..getACLFromPlayer(player)..") "..player:getName().." te dio +"..valor.." de chaleco", 150, 255, 150)
								--
								jugador:setArmor(jugador:getArmor()+tonumber(valor))
							else
								player:outputChat("Syntax: /chaleco [Nombre o ID] [-] o [+] [valor]", 150, 50, 50, true)
							end
						else
							player:outputChat("* El valor debe ser entre 1-100", 150, 0, 0, true)
						end
					end
				else
					player:outputChat("Recuerda que + es para aumentar y - para bajar.", 150, 50, 50, true)
					player:outputChat("Syntax: /chaleco [ID] + [Valor]", 255, 255, 255, true)
				end
			end
		end
	end
end
addCommandHandler("chaleco", give_armor)

function trunklateText(thePlayer, text, factor)
    local msg = (tostring(text):gsub("%u", string.lower))
	return (tostring(msg):gsub("^%l", string.upper))
end

-----Rango Moderador A Pruebas----

permisorango = {
	["Desarrollador"] = true,
	["Sup.Staff"] = true,
}

function givestaffRights1 (player, commandName, objetive)
	local accName = getAccountName ( getPlayerAccount ( player ) )
	if permisorango[getACLFromPlayer(player)] == true then
	    if objetive then
	        PlayerName = getPlayerFromName(objetive)
	        account = getPlayerAccount(PlayerName)
	        accountName = getAccountName( account )
	        aclGroupAddObject (aclGetGroup("Moderador A Pruebas"), "user." .. accountName)
	        outputChatBox ("Al usuario ".. accountName.. " se le ha Añadido el rango Moderador A Pruebas correctamente.", player, 81, 255, 9)
	        outputChatBox("Ahora eres un #a0c530Moderador A Pruebas" ,PlayerName, 255 , 255, 255 , true)
	    else
	        outputChatBox ("Syntaxis: /darmodpruebas [Nombre del Usuario]", player)
	    end
	end
end
addCommandHandler ("darmodpruebas", givestaffRights1) 

function givestaffRights1023 (player, commandName, objetive)
	local accName = getAccountName ( getPlayerAccount ( player ) )
	if permisorango[getACLFromPlayer(player)] == true then
    if objetive then
        PlayerName = getPlayerFromName(objetive)
        account = getPlayerAccount(PlayerName)
        accountName = getAccountName( account )
        aclGroupRemoveObject (aclGetGroup("Moderador A Pruebas"), "user." .. accountName)
        outputChatBox ("Al usuario ".. accountName.. " se le ha Retirado el rango Moderador A Pruebas correctamente.", player, 81, 255, 9)
        outputChatBox("Ahora Ya no eres un #a0c530Moderador A Pruebas" ,PlayerName, 255 , 255, 255 , true)
    else
        outputChatBox ("Syntaxis: /quitarmodpruebas [Nombre del Usuario]", player)
    end
	end
end
addCommandHandler ("quitarmodpruebas", givestaffRights1023)

-----Rango Mod----

function givestaffRights2 (player, commandName, objetive)
	local accName = getAccountName ( getPlayerAccount ( player ) )
	if permisorango[getACLFromPlayer(player)] == true then
	    if objetive then
	        PlayerName = getPlayerFromName(objetive)
	        account = getPlayerAccount(PlayerName)
	        accountName = getAccountName( account )
	        aclGroupAddObject (aclGetGroup("Moderador"), "user." .. accountName)
	        outputChatBox ("Al usuario ".. accountName.. " se le ha Añadido el rango Moderador correctamente.", player, 81, 255, 9)
	        outputChatBox("Ahora eres un #ec660fModerador" ,PlayerName, 255 , 255, 255 , true)
	    else
	        outputChatBox ("Syntaxis: /darmod [Nombre del Usuario]", player)
	    end
	end
end
addCommandHandler ("darmod", givestaffRights2) 

function givestaffRights1 (player, commandName, objetive)
	local accName = getAccountName ( getPlayerAccount ( player ) )
	if permisorango[getACLFromPlayer(player)] == true then
    	if objetive then
        	PlayerName = getPlayerFromName(objetive)
        	account = getPlayerAccount(PlayerName)
        	accountName = getAccountName( account )
        	aclGroupRemoveObject (aclGetGroup("Moderador"), "user." .. accountName)
        	outputChatBox ("Al usuario ".. accountName.. " se le ha Retirado el rango Moderador correctamente.", player, 81, 255, 9)
        	outputChatBox("Ahora Ya no eres un #ec660fModerador" ,PlayerName, 255 , 255, 255 , true)
    	else
        	outputChatBox ("Syntaxis: /quitarmod [Nombre del Usuario]", player)
    	end
	end
end
addCommandHandler ("quitarmod", givestaffRights1)

-----Rango Admin------

function givestaffRights3 (player, commandName, objetive)
	local accName = getAccountName ( getPlayerAccount ( player ) )
	if isObjectInACLGroup ("user."..accName, aclGetGroup ( "Desarrollador" ) ) then
		if objetive then
			PlayerName = getPlayerFromName(objetive)
        	account = getPlayerAccount(PlayerName)
        	accountName = getAccountName( account )
        	aclGroupAddObject (aclGetGroup("Admin"), "user." .. accountName)
        	outputChatBox ("Al usuario ".. accountName.. " se le ha Añadido el rango Administrador correctamente.", player, 81, 255, 9)
        	outputChatBox("Ahora eres un #d7342aAdministrador" ,PlayerName, 255 , 255, 255 , true)
    	else
        	outputChatBox ("Syntaxis: /daradmin [Nombre del Usuario]", player)
    	end
	end
end
addCommandHandler ("daradmin", givestaffRights3) 

function givestaffRights2 (player, commandName, objetive)
	local accName = getAccountName ( getPlayerAccount ( player ) )
	if isObjectInACLGroup ("user."..accName, aclGetGroup ( "Desarrollador" ) ) then
    if objetive then
        PlayerName = getPlayerFromName(objetive)
        account = getPlayerAccount(PlayerName)
        accountName = getAccountName( account )
        aclGroupRemoveObject (aclGetGroup("Admin"), "user." .. accountName)
        outputChatBox ("Al usuario ".. accountName.. " se le ha Retirado el rango Administrador correctamente.", player, 81, 255, 9)
        outputChatBox("Ahora Ya no eres un #d7342aAdministrador" ,PlayerName, 255 , 255, 255 , true)
    else
        outputChatBox ("Syntaxis: /quitaradmin [Nombre del Usuario]", player)
    	end
	end
end
addCommandHandler ("quitaradmin", givestaffRights2)

----Rango Enc Staff---

function givestaffRights5(player, commandName, objetive)
	local accName = getAccountName ( getPlayerAccount ( player ) )
	if isObjectInACLGroup ("user."..accName, aclGetGroup ( "Desarrollador" ) ) then
    if objetive then
        PlayerName = getPlayerFromName(objetive)
        account = getPlayerAccount(PlayerName)
        accountName = getAccountName( account )
        aclGroupAddObject (aclGetGroup("EncStaff"), "user." .. accountName)
        outputChatBox ("Al usuario ".. accountName.. " se le ha Añadido el rango Encargado de Staff correctamente.", player, 81, 255, 9)
        outputChatBox("Ahora eres un #b3f85fEnc.Staff" ,PlayerName, 255 , 255, 255 , true)
    else
        outputChatBox ("Syntaxis: /darencstaff [Nombre del Usuario]", player)
    	end
	end
end
addCommandHandler ("darencstaff", givestaffRights5) 

function givestaffRights4 (player, commandName, objetive)
	local accName = getAccountName ( getPlayerAccount ( player ) )
	if isObjectInACLGroup ("user."..accName, aclGetGroup ( "Desarrollador" ) ) then
    if objetive then
        PlayerName = getPlayerFromName(objetive)
        account = getPlayerAccount(PlayerName)
        accountName = getAccountName( account )
        aclGroupRemoveObject (aclGetGroup("EncStaff"), "user." .. accountName)
        outputChatBox ("Al usuario ".. accountName.. " se le ha Retirado el rango Encargado de Staff correctamente.", player, 81, 255, 9)
        outputChatBox("Ahora Ya no eres un #b3f85fEnc.Staff" ,PlayerName, 255 , 255, 255 , true)
    else
        outputChatBox ("Syntaxis: /quitarencstaff [Nombre del Usuario]", player)
        end
	end
end
addCommandHandler ("quitarencstaff", givestaffRights4)

----Rango Enc Facc---

function givestaffRights6 (player, commandName, objetive)
	local accName = getAccountName ( getPlayerAccount ( player ) )
	if isObjectInACLGroup ("user."..accName, aclGetGroup ( "Desarrollador" ) ) then
    	if objetive then
			PlayerName = getPlayerFromName(objetive)
			account = getPlayerAccount(PlayerName)
        	accountName = getAccountName( account )
        	aclGroupAddObject (aclGetGroup("EncFacciones"), "user." .. accountName)
        	outputChatBox ("Al usuario ".. accountName.. " se le ha Añadido el rango Encargado de Facciones correctamente.", player, 81, 255, 9)
        	outputChatBox("Ahora eres un #2b88ffEnc.Facciones" ,PlayerName, 255 , 255, 255 , true)
    	else
        	outputChatBox ("Syntaxis: /darencfacc [Nombre del Usuario]", player)
    	end
	end
end
addCommandHandler ("darencfacc", givestaffRights6) 

function givestaffRights5 (player, commandName, objetive)
	local accName = getAccountName ( getPlayerAccount ( player ) )
	if isObjectInACLGroup ("user."..accName, aclGetGroup ( "Desarrollador" ) ) then
    	if objetive then
	        PlayerName = getPlayerFromName(objetive)
	        account = getPlayerAccount(PlayerName)
	        accountName = getAccountName( account )
	        aclGroupRemoveObject (aclGetGroup("EncFacciones"), "user." .. accountName)
	        outputChatBox ("Al usuario ".. accountName.. " se le ha Retirado el rango Encargado de Facciones correctamente.", player, 81, 255, 9)
	        outputChatBox("Ahora Ya no eres un #2b88ffEnc.Facciones" ,PlayerName, 255 , 255, 255 , true)
    	else
        	outputChatBox ("Syntaxis: /quitarencfacc [Nombre del Usuario]", player)
    	end
	end
end
addCommandHandler ("quitarencfacc", givestaffRights5)

-----Rango SupMod-----

function givestaffRights9 (player, commandName, objetive)
	local accName = getAccountName ( getPlayerAccount ( player ) )
	if permisorango[getACLFromPlayer(player)] == true then
    	if objetive then
        	PlayerName = getPlayerFromName(objetive)
        	account = getPlayerAccount(PlayerName)
        	accountName = getAccountName( account )
        	aclGroupAddObject (aclGetGroup("SuperModerador"), "user." .. accountName)
        	outputChatBox ("Al usuario ".. accountName.. " se le ha Añadido el rango SuperModerador correctamente.", player, 81, 255, 9)
        	outputChatBox("Ahora eres un #FF8000SuperModerador" ,PlayerName, 255 , 255, 255 , true)
    	else
        	outputChatBox ("Syntaxis: /darsmod [Nombre del Usuario]", player)
    	end
	end
end
addCommandHandler ("darsmod", givestaffRights9) 

function givestaffRights8 (player, commandName, objetive)
	local accName = getAccountName ( getPlayerAccount ( player ) )
	if permisorango[getACLFromPlayer(player)] == true then
    	if objetive then
	        PlayerName = getPlayerFromName(objetive)
	        account = getPlayerAccount(PlayerName)
	        accountName = getAccountName( account )
	        aclGroupRemoveObject (aclGetGroup("SuperModerador"), "user." .. accountName)
	        outputChatBox ("Al usuario ".. accountName.. " se le ha retirado el rango SuperModerador correctamente.", player, 81, 255, 9)
	        outputChatBox("Ahora Ya no eres un #FF8000SuperModerador" ,PlayerName, 255 , 255, 255 , true)
    	else
        	outputChatBox ("Syntaxis: /quitarsmod [Nombre del Usuario]", player)
		end
	end
end
addCommandHandler ("quitarsmod", givestaffRights8)

function givestaffRights90 (player, commandName, objetive)
	local accName = getAccountName ( getPlayerAccount ( player ) )
	if isObjectInACLGroup ("user."..accName, aclGetGroup ( "Desarrollador" ) ) then
    	if objetive then
        	PlayerName = getPlayerFromName(objetive)
        	account = getPlayerAccount(PlayerName)
        	accountName = getAccountName( account )
        	aclGroupAddObject (aclGetGroup("Administrador.General"), "user." .. accountName)
        	outputChatBox ("Al usuario ".. accountName.. " se le ha Añadido el rango Administrador General correctamente.", player, 81, 255, 9)
        	outputChatBox("Ahora eres un #FF8000Administrador General" ,PlayerName, 255 , 255, 255 , true)
    	else
        	outputChatBox ("Syntaxis: /daradming [Nombre del Usuario]", player)
    	end
	end
end
addCommandHandler ("daradming", givestaffRights90) 

function givestaffRights80 (player, commandName, objetive)
	local accName = getAccountName ( getPlayerAccount ( player ) )
	if isObjectInACLGroup ("user."..accName, aclGetGroup ( "Desarrollador" ) ) then
    	if objetive then
	        PlayerName = getPlayerFromName(objetive)
	        account = getPlayerAccount(PlayerName)
	        accountName = getAccountName( account )
	        aclGroupRemoveObject (aclGetGroup("Administrador.General"), "user." .. accountName)
	        outputChatBox ("Al usuario ".. accountName.. " se le ha retirado el rango Administrador General correctamente.", player, 81, 255, 9)
	        outputChatBox("Ahora Ya no eres un #FF8000Administrador General" ,PlayerName, 255 , 255, 255 , true)
    	else
        	outputChatBox ("Syntaxis: /quitaradming [Nombre del Usuario]", player)
		end
	end
end
addCommandHandler ("quitaradming", givestaffRights80)

-----Rango Desarrollador-----
function givestaffRights11 (player, commandName, objetive)
	local accName = getAccountName ( getPlayerAccount ( player ) )
	if isObjectInACLGroup ("user."..accName, aclGetGroup ( "Desarrollador" ) ) then
    	if objetive then
	        PlayerName = getPlayerFromName(objetive)
	        account = getPlayerAccount(PlayerName)
	        accountName = getAccountName( account )
	        aclGroupAddObject(aclGetGroup("Desarrollador"), "user." .. accountName)
	        outputChatBox ("Al usuario ".. accountName.. " se le ha Añadido el rango Desarrollador correctamente.", player, 81, 255, 9)
	        outputChatBox("Ahora eres un #FF1B1BDesarrollador" ,PlayerName, 255 , 255, 255 , true)
    	else
        	outputChatBox ("Syntaxis: /dardev [Nombre del Usuario]", player)
        end
	end
end
addCommandHandler ("dardueño", givestaffRights11) 

function givestaffRights10 (player, commandName, objetive)
	local accName = getAccountName ( getPlayerAccount ( player ) )
	if isObjectInACLGroup ("user."..accName, aclGetGroup ( "Desarrollador" ) ) then
		if objetive then
			PlayerName = getPlayerFromName(objetive)
			account = getPlayerAccount(PlayerName)
			accountName = getAccountName( account )
			aclGroupRemoveObject (aclGetGroup("Desarrollador"), "user." .. accountName)
			outputChatBox ("Al usuario ".. accountName.. " se le ha retirado el rango Desarrollador correctamente.", player, 81, 255, 9)
			outputChatBox("Ahora Ya no eres un #FF1B1BDesarrollador" ,PlayerName, 255 , 255, 255 , true)
		else
			outputChatBox ("Syntaxis: /quitardev [Nombre del Usuario]", player)
		end
	end
end
addCommandHandler ("quitardueño", givestaffRights10)

-----Rango AdminG-----

function irLS(player, cName, usuario)
	local nombre = getPlayerFromName(usuario)
	if nombre then
		if permisos[getACLFromPlayer(player)] == true then
			setElementPosition(nombre, 2091.220703125, -1806.853515625, 13.546875)
			setElementDimension(nombre,0)
			setElementInterior(nombre,0)
			outputChatBox("Has Enviado Correctamente al Jugador #F3E50F" ..usuario.. " #ffffffa Los Santos " , player ,255, 255, 255 ,true)
			outputChatBox("Un #FF971BModerador #ffffffte ha enviado a Los Santos" , nombre ,255, 255, 255 ,true)
		end
	end
end
addCommandHandler("ls", irLS)

function irLV(player, cName, usuario)
	local nombre = getPlayerFromName(usuario)
	if nombre then
		if permisos[getACLFromPlayer(player)] == true then
			setElementPosition(nombre, 1560.720703125, 1707.3681640625, 10.8203125)
			setElementDimension(nombre,0)
			setElementInterior(nombre,0)
			outputChatBox("Has Enviado Correctamente al Jugador #F3E50F" ..usuario.. " #ffffffa Las Venturas " , player ,255, 255, 255 ,true)
			outputChatBox("Un #FF971BModerador #ffffffte ha enviado a Las Venturas" , nombre ,255, 255, 255 ,true)
		end
	end
end
addCommandHandler("lv", irLV)

function irSF(player, cName, usuario)
	local nombre = getPlayerFromName(usuario)
	if nombre then
		if permisos[getACLFromPlayer(player)] == true then
			setElementPosition(nombre, -2705.5859375, 366.810546875, 4.3949432373047)
			setElementDimension(nombre,0)
			setElementInterior(nombre,0)
			outputChatBox("Has Enviado Correctamente al Jugador #F3E50F" ..usuario.. " #ffffffa San Fierro " , player ,255, 255, 255 ,true)
			outputChatBox("Un #FF971BModerador #ffffffte ha enviado a San Fierro" , nombre ,255, 255, 255 ,true)
		end
	end
end
addCommandHandler("sf", irSF)

---------------------------------------------------------------------------------------------------------------------
