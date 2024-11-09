loadstring(exports.MySQL:getMyCode())()
import('*'):init('MySQL')
function agenda_open( source )
	if not notIsGuest( source ) then
		if source:getData("Roleplay:Agenda") == "Si" then
			local texto = source:getData("Roleplay:AgendaTexto") or ""
			source:triggerEvent("abrir_window", source, texto)
		else
			source:outputChat("* No tienes una agenda.", 150, 0, 0, ture)
		end
	end
end
addCommandHandler("agenda", agenda_open)
addEvent("enviar_element", true)
addEventHandler("enviar_element", root, function( text )
	local account = source:getAccount()
	if account then
		source:setData("Roleplay:AgendaTexto", text)
		account:setData("Roleplay:AgendaTexto", text)
		
		source:outputChat("* Acabas de guardar lo que escribiste en tu agenda..", 0, 150, 0, true)
	end
end)
local accounts = {["Antonio_Marin"] = true, [""] =true, [""]=true},
addEvent("afkKicker",true)
addEventHandler("afkKicker",root,
function (player)
	if accounts[AccountName(player)] then return end
	--kickPlayer(player,"Te has quedado AFK, Reconecta")
	player:setData("AFK", true)
end)
function getPlayer( ... )
	if ( ... ) then
		
		local elements = {};
		for _, string in ipairs( { ... } ) do
			for _, element in ipairs( getElementsByType( 'player' ) ) do
				if ( string.find( string:lower(), getPlayerName(element):lower(), 1, true ) ) then
					table.insert( elements, element );
				end
			end
		end
		
		return elements;
	end
	
	return false
end
addCommandHandler( 'broadcast', 
	function( player, command, target, target_ )
		if ( target and target_ ) then
			target, target_ = getPlayer( target, target_ );
			if ( target ) then
				setPlayerVoiceBroadcastTo( target, target_ );
			--	print(target_.." "..target)
			else
				outputChatBox( not target and "Target 1 not found!" or not target_ and "Target 2 not found!", root, 255, 0, 0, false );
			end
		end
	end
)
function pene(player)
outputChatBox ("Servicios públicos de la ciudad:", player,255, 255, 255, true)
outputChatBox ("Policía: #0013FF911", player,255, 255, 255, true)
outputChatBox ("Médicos: #FF0000512", player,255, 255, 255, true)
outputChatBox ("Mecánicos: #E8FF00311", player,255, 255, 255, true)
outputChatBox ("Taxistas: #FF4900555", player,255, 255, 255, true)
end
addCommandHandler ("servicios", pene)