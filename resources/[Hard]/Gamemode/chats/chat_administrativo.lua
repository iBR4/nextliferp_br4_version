local antiSpamAdmin = {}
local Administradores ={
["Desarrollador"]=true,
["Administrador.General"]=true,
["Admin"]=true,
["Sup.Staff"]=true,
["SuperModerador"]=true,
["Moderador"]=true,
["Moderador A Pruebas"]=true,
}
function chatAdministrativo(player, cmd, ...)
	if not notIsGuest(player) then
		if Administradores[getACLFromPlayer(player)] == true then
			local tick = getTickCount()
			if (Administradores[player] and Administradores[player][1] and tick - Administradores[player][1] < 500) then
				return
			end
			local msg = table.concat({...}, " ")
			if msg ~="" and msg ~=" " then
				local nick = _getPlayerNameR(player)
				local MyACL = getACLFromPlayer(player)
				for i, v in ipairs(Element.getAllByType("player")) do
					if Administradores[getACLFromPlayer(v)] == true then
						v:outputChat("#0098E3[#0098E3"..MyACL.." - /a] "..player:getData("Nombre:staff")..": #FFFFFF" .. msg, 0, 122, 183, true)
					end
				end
				if (not Administradores[player]) then
					Administradores[player] = {}
				end
				Administradores[player][1] = getTickCount()
			end
		end
	end
end
addCommandHandler("a", chatAdministrativo)
