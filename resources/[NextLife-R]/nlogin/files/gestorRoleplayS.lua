loadstring(exports.MySQL:getMyCode())()
import('*'):init('MySQL')

loadstring(exports["[LS]NewData"]:getMyCode())()
import('*'):init('[LS]NewData')

mysql = exports.MySQL

permisos = {
	["Desarrollador"] = true,
	["Administrador.General"] = true,
	["Admin"] = true,
	["Sup.Staff"] = true,
	["SuperModerador"] = true,
	["Moderador"] = true,
	["Moderador A Pruebas"] = true,
}

permisos_2 = {
	["Desarrollador"] = true,
	["Administrador.General"] = true,
	["Admin"] = true,
}

permisito_owner = {
	["Desarrollador"] = true,
}

function getOnlinePlayers()
	local tab = {}
	for i,players in pairs(getElementsByType('player')) do
		if not notIsGuest( players ) then
			table.insert(tab,{players,getGlobalCharacters(players)})
		end
	end
	return tab
end

function updateGridStaff()
	for i,players in pairs(getElementsByType('player')) do
		if not notIsGuest( players ) then
			if permisos_2[getACLFromPlayer(players)] then
				triggerClientEvent(players,'NL:ShowGestorUpdate',players,players,getCharactersAll())
			end
		end
	end
end

function sendTextStaff(name,text)
	for i,players in pairs(getElementsByType('player')) do
		if not notIsGuest( players ) then
			if permisos_2[getACLFromPlayer(players)] then
				outputChatBox(text, players, 255, 255, 0, true )
			end
		end
	end
	return true
end

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

function openPanelConfig(player)
	if player:getData("Comida") then
		if permisos_2[getACLFromPlayer(player)] then
			triggerClientEvent(player,"NL:ShowGestor",player,player,getOnlinePlayers(),getCharactersAll())
		end
	else
		outputChatBox( "Aparece Primero!", player, 255, 0, 0, true )
	end
end
-- triggerClientEvent(player,"NL:ShowGestorUpdate",player,player)
addEventHandler ( "onResourceStart", getResourceRootElement(getThisResource()),
function ()
	for i,source in pairs ( getElementsByType ( 'player' ) ) do
		if source and getElementData(source,'ID') then
			unbindKey(source,"f7","down", openPanelConfig)
			bindKey(source,"f7","down", openPanelConfig)
    	end
    end 
end)

addEventHandler("onPlayerJoin",root,function()
	unbindKey(source,"f7","down", openPanelConfig)
	bindKey(source,"f7","down", openPanelConfig)
end)

addEvent("NL:ShowGestorUpdate:Server",true)
addEventHandler("NL:ShowGestorUpdate:Server", getRootElement(),
function(player,action,mailSelected,accSelected,nameSelected,newMail)
	if source == player then
		if isElement(player) then
			if not notIsGuest( player ) then
				if permisos_2[getACLFromPlayer(player)] == true then
					if mailSelected ~= "" and accSelected ~= "" then
						local data = isOccupedAccount(mailSelected)
						if data then
							if action == 'update' then
								local dataNew = isOccupedAccount(newMail)  -- Nuevo
								if dataNew then
									local player_old = getPlayerFromName(nameSelected)
									if player_old and player ~= player_old then
										redirectPlayer( player_old, "", 0, "")
									end
									local upDatos = mysql:update("UPDATE Datos_Personajes SET Serial = ? WHERE Cuenta = ?", dataNew["Serial"], accSelected)
									local upRegistros = mysql:update("UPDATE Registros SET Serial = ? WHERE Cuenta = ?", dataNew["Serial"], accSelected)
									local upSaveSerial = mysql:update("UPDATE save_system SET Serial = ? WHERE Cuenta = ?", dataNew["Serial"], accSelected)
									local upSaveCorreo = mysql:update("UPDATE save_system SET Correo = ?  WHERE Cuenta = ?", newMail, accSelected)
									if (upRegistros) and (upDatos) and (upSaveCorreo and upSaveSerial) then
										local player2 = getPlayerFromName(nameSelected)
										if player2 and player ~= player2 then
											redirectPlayer( player2, "", 0, "")
										end
										if isElement(player) then
											outputChatBox("Este personaje ya no coincide con el anterior email designado correctamente.",player,0,255,0,true)
											outputChatBox("Ahora el personaje le pertenece a ("..newMail..")!.",player,0,255,0,true)
											sendTextStaff("[NL:GestorPers] El Jugador ("..player:getName()..") a cambiado el mail del personaje ("..nameSelected.."). ahora el nuevo mail es ("..newMail..") !")
										end
										updateGridStaff()
									else
										outputChatBox("No se a podido recargar los datos en la base de datos.",player,255,0,0,true)
									end
								else
									outputChatBox("Este nuevo mail no coincide con una cuenta en la base de datos.",player,255,0,0,true)
								end
							elseif action == 'delete' then
								local playerSelect = getPlayerFromName(nameSelected)
								if playerSelect and player ~= playerSelect then
									if not notIsGuest( playerSelect ) then
										redirectPlayer( playerSelect, "", 0, "")
									end
								end
								local delRegistros = mysql:delete(" DELETE FROM Registros WHERE Cuenta = '"..mail.."'" )
								local delSaveSystem = mysql:delete(" DELETE FROM save_system WHERE Cuenta = '"..mail.."'" )
								local delDatos = mysql:delete(" DELETE FROM Datos_Personajes WHERE Cuenta = '"..mail.."'" )
								local delAccount = removeAccount ( getAccount(accSelected) )
								if (delAccount) and (delRegistros and delSaveSystem and delDatos) then
									if isElement(player) then
										outputChatBox("Este personaje ya no existe y fue borrado correctamente ('"..nameSelected.."') !.",player,0,255,0,true)
										sendTextStaff("[NL:GestorPers] El Jugador ("..player:getName()..") a eliminado el personaje ("..nameSelected..") con exito !")
									end
									updateGridStaff()
								else
									outputChatBox("No se a podido modificar los datos en la base de datos, intentalo nuevamente mas tarde.",player,255,0,0,true)
								end
							end
						else
							outputChatBox("Este mail no coincide con una cuenta en la base de datos.",player,255,0,0,true)
						end
					else
						outputChatBox("Los datos no han sido enviados correctamente, intentalo denuevo.",player,255,0,0,true)
					end
				else
					outputChatBox("Permisos insuficientes! (Desarrollador, Administrador General, Admin)",player,255,0,0,true)
				end
			end
		end
	end
end)

