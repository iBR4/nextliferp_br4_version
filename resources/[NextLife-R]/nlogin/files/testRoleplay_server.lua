addEvent("PasoElRol", true)

addEventHandler("PasoElRol", root, function(player)
	if source == player then
		triggerEvent("Roleplay:RecoverLoginPlayer",player,player)
	end
end)



addEvent("kickedPlayer", true)

addEventHandler("kickedPlayer", root, function()

	source:outputChat("REPROBASTE EL TEST DE ROL, VUELVE A HACERLO", 150, 50, 50, true)

	setTimer(kickPlayer, 3000, 1, source, "Console", "REPROBASTE EL TEST DE ROL, VUELVE A HACERLO")

end)