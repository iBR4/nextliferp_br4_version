
loadstring(exports.MySQL:getMyCode())()
import('*'):init('MySQL')

_addCommandHandler = addCommandHandler

function addCommandHandler(comando, func)
    if type(comando) == 'table' then
        for i,v in ipairs(comando) do
            _addCommandHandler(v, func)
        end
    else
        return _addCommandHandler(comando, func)
    end
end

addEventHandler("onPlayerJoin", getRootElement(), function ( )
	if isElement(source) then
		source:setTeam(Team.getFromName("Sin logear"))
		setPlayerHudComponentVisible ( source, "area_name", false )  
	end
end)

addEventHandler("onPlayerLogin", getRootElement(), function ( )
	if isElement(source) then
		source:setTeam(nil)
	end
end)

function removeColorCoding( name )
    return type(name)=='string' and string.gsub ( name, '#%x%x%x%x%x%x', '' ) or name
end

teams = {
{"Jail OOC", 15, 15, 15},
{"Staff", 174, 0, 255},
{"Sin logear", 255, 255, 255},
{"AFK", 213, 197, 156},
}

addEventHandler("onResourceStart", resourceRoot, function ( )
	for i, v in ipairs(teams) do
		Team.create(v[1], v[2], v[3], v[4])
	end
	
	setMinuteDuration(10000)
	setMapName("Los Santos")
	setGameType("Roleplay")
	for i=0,49 do
		setGarageOpen( i, true )
	end
	for index, players in ipairs(Element.getAllByType("player")) do
		if not notIsGuest(players) then
			removeColorCoding(players:getName())
		end
	end
end)

function actiskils()
	local skills = {69,70,71,72,73,74,75,76,77,78,79,80,81}
	for i, source in ipairs( getElementsByType( "player" ) ) do
		for index,stat in ipairs(skills) do
			if stat == 71 or stat == 72 or stat == 76 or stat == 77 or stat == 78 then
				setPedStat( source, stat, 1000 )
			else
				setPedStat( source, stat, 800 )
			end
		end
	end
end
addEventHandler( "onResourceStart", resourceRoot,actiskils)
addEventHandler( "onPlayerJoin", root,actiskils)

--sitema de IDS
local ids = { }
addEventHandler( "onPlayerJoin", root,
	function( )
		for i = 1, getMaxPlayers( ) do
			if not ids[ i ] then
				ids[ i ] = source
				setElementData( source, "ID", i )	
				break
			end
		end
	end
)

addEventHandler( "onResourceStart", resourceRoot,
	function( )
		for i, source in ipairs( getElementsByType( "player" ) ) do
			ids[ i ] = source
			setElementData( source, "ID", i )
		end
	end
)

addEventHandler( "onPlayerQuit", root,
	function( type, reason, responsible )
		for i = 1, getMaxPlayers( ) do
			if ids[ i ] == source then
				ids[ i ] = nil
				
				if reason then
					type = type .. " - " .. reason
					if isElement( responsible ) and getElementType( responsible ) == "player" then
						type = type .. " - " .. getPlayerName( responsible )
					end
				end				
				break
			end
		end
	end
)

function getFromName( player, targetName, ignoreLoggedOut )
	if targetName then
		targetName = tostring( targetName )
		
		local match = { }
		if targetName == "*" then
			match = { player }
		elseif tonumber( targetName ) then
			match = { ids[ tonumber( targetName ) ] }
		elseif ( getPlayerFromName ( targetName ) ) then
			match = { getPlayerFromName ( targetName ) }
		else	
			for key, value in ipairs ( getElementsByType ( "player" ) ) do
				if getPlayerName ( value ):lower():find( targetName:lower() ) then
					match[ #match + 1 ] = value
				end
			end
		end
		
		if #match == 1 then
			if notIsGuest( match[ 1 ] ) or not notIsGuest( player ) then
				return match[ 1 ], getPlayerName( match[ 1 ] ):gsub( "_", " " ), getElementData( match[ 1 ], "ID" )
			else
				if player then
					outputChatBox( getPlayerName( match[ 1 ] ):gsub( "_", " " ) .. " no esta logueado.", player, 255, 0, 0 )
				end
				return nil -- not logged in error
			end
		elseif #match == 0 then
			if player then
				outputChatBox( "No se encuentra al jugador.", player, 255, 0, 0 )
			end
			return nil -- no player
		elseif #match > 10 then
			if player then
				outputChatBox( #match .. " jugadores encontrados.", player, 255, 204, 0 )
			end
			return nil -- not like we want to show him that many players
		else
			if player then
				outputChatBox ( "Jugadores encontrados: ", player, 255, 204, 0 )
				for key, value in ipairs( match ) do
					outputChatBox( "  (" .. getElementData( value, "ID" ) .. ") " .. getPlayerName( value ):gsub ( "_", " " ), player, 255, 255, 0 )
				end
			end
			return nil -- more than one player. We list the player names + id.
		end
	end
end

addCommandHandler( "id",
	function( player, commandName, target )
		if not notIsGuest( player ) then
			local target, targetName, id = getFromName( player, target )
			if target then
				outputChatBox( "La ID de " .. targetName .. " es " .. id .. ".", player, 255, 204, 0 )
			end
		end
	end
)

function checkAFKPlayers() 
    for index, thePlayer in ipairs(getElementsByType("player")) do
    	local accName = getAccountName(getPlayerAccount(thePlayer))
    	local staffCreador = isObjectInACLGroup("user."..accName, aclGetGroup("Desarrollador"))
    	if staffCreador or getElementData(thePlayer, "afk:state") or getElementData(thePlayer, "Jaileado") or getElementData(thePlayer, "Muerto") then
    		--
    	else
        	if (getPlayerIdleTime(thePlayer) > 540000) then
        	    outputChatBox("\n#44A5CA[ANTI-AFK]#F1B96B Si no te mueves serás kickeado en 1 minuto.", thePlayer, 0,0,0, true)
        	    outputChatBox("#44A5CA[ANTI-AFK]#F1B96B Si no te mueves serás kickeado en 1 minuto.", thePlayer, 0,0,0, true)
        	    outputChatBox("#44A5CA[ANTI-AFK]#F1B96B Si no te mueves serás kickeado en 1 minuto.", thePlayer, 0,0,0, true)
        	    outputChatBox("#44A5CA[ANTI-AFK]#F1B96B Si no te mueves serás kickeado en 1 minuto.\n", thePlayer, 0,0,0, true)
        	end
        	if (getPlayerIdleTime(thePlayer) > 600000) then
        	    kickPlayer(thePlayer, "ANTI AFK - Duraste mas de 10 minutos sin moverte.")
        	end
        end
    end
end
setTimer(checkAFKPlayers, 30000, 0)

function setAFK(player)
		local cuenta = getAccountName(getPlayerAccount(player))
		if isObjectInACLGroup ("user."..cuenta, aclGetGroup ( "VIP" ) ) or isObjectInACLGroup ("user."..cuenta, aclGetGroup ( "VIP+" ) ) or isObjectInACLGroup ("user."..cuenta, aclGetGroup ( "Donador" ) ) then
			if getElementData(player, "afk:state") then
				setElementDimension(player, 0)
				setElementFrozen(player, false)
				player:setTeam(Team.getFromName("null"))
				removeElementData(player, "afk:state")
				for k, v in ipairs(getElementsByType("player")) do
					local x, y, z = getElementPosition( player )
					if getDistanceBetweenPoints3D( x, y, z, unpack( {getElementPosition( v )} ) ) < 15 then
						outputChatBox("#44A5CA[AFK] #FFFFFFEl jugador #FFFF00"..getPlayerName(player).."#FFFFFF ha salido del modo AFK.", v, 0,0,0, true)
					end
				end
			else
				if getElementInterior(player) == 0 then
					setElementData(player, "afk:state", true)
					setElementFrozen(player, true)
					setElementDimension(player, 660)
					player:setTeam(Team.getFromName("AFK"))	
					for k, v in ipairs(getElementsByType("player")) do
						local x, y, z = getElementPosition( player )
						if getDistanceBetweenPoints3D( x, y, z, unpack( {getElementPosition( v )} ) ) < 15 then
							outputChatBox("#44A5CA[AFK] #FFFFFFEl jugador #FFFF00"..getPlayerName(player).."#FFFFFF ha entrado en modo AFK.", v, 0,0,0, true)
					end
				end
			end
		end
	end
end
addCommandHandler("afk", setAFK)

------------Quitado de Luz nocturnas de Edificios ------------------------------------------------------------
removeWorldModel(4212,10000,0,0,0)
removeWorldModel(4213,10000,0,0,0)
removeWorldModel(4214,10000,0,0,0)
removeWorldModel(4215,10000,0,0,0)
removeWorldModel(4216,10000,0,0,0)
removeWorldModel(4217,10000,0,0,0)
removeWorldModel(4218,10000,0,0,0)
removeWorldModel(4219,10000,0,0,0)
removeWorldModel(4220,10000,0,0,0)
removeWorldModel(4221,10000,0,0,0)
removeWorldModel(4222,10000,0,0,0)
removeWorldModel(4715,10000,0,0,0)
removeWorldModel(4716,10000,0,0,0)
removeWorldModel(4717,10000,0,0,0)
removeWorldModel(4720,10000,0,0,0)
removeWorldModel(4721,10000,0,0,0)
removeWorldModel(4722,10000,0,0,0)
removeWorldModel(4723,10000,0,0,0)
removeWorldModel(4725,10000,0,0,0)
removeWorldModel(4739,10000,0,0,0)
removeWorldModel(4740,10000,0,0,0)
removeWorldModel(4741,10000,0,0,0)
removeWorldModel(4742,10000,0,0,0)
removeWorldModel(4743,10000,0,0,0)
removeWorldModel(4744,10000,0,0,0)
removeWorldModel(4745,10000,0,0,0)
removeWorldModel(4746,10000,0,0,0)
removeWorldModel(4747,10000,0,0,0)
removeWorldModel(4748,10000,0,0,0)
removeWorldModel(4749,10000,0,0,0)
removeWorldModel(4750,10000,0,0,0)
removeWorldModel(4751,10000,0,0,0)
removeWorldModel(4752,10000,0,0,0)
removeWorldModel(5057,10000,0,0,0)
removeWorldModel(5058,10000,0,0,0)
removeWorldModel(5059,10000,0,0,0)
removeWorldModel(5661,10000,0,0,0)
removeWorldModel(5662,10000,0,0,0)
removeWorldModel(5665,10000,0,0,0)
removeWorldModel(5990,10000,0,0,0)
removeWorldModel(5991,10000,0,0,0)
removeWorldModel(5992,10000,0,0,0)
removeWorldModel(6192,10000,0,0,0)
removeWorldModel(6193,10000,0,0,0)
removeWorldModel(6194,10000,0,0,0)
removeWorldModel(6195,10000,0,0,0)
removeWorldModel(6196,10000,0,0,0)
removeWorldModel(7072,10000,0,0,0)
removeWorldModel(7097,10000,0,0,0)
removeWorldModel(7206,10000,0,0,0)
removeWorldModel(7207,10000,0,0,0)
removeWorldModel(7208,10000,0,0,0)
removeWorldModel(7221,10000,0,0,0)
removeWorldModel(7222,10000,0,0,0)
removeWorldModel(7226,10000,0,0,0)
removeWorldModel(7280,10000,0,0,0)
removeWorldModel(7331,10000,0,0,0)
removeWorldModel(7332,10000,0,0,0)
removeWorldModel(7333,10000,0,0,0)
removeWorldModel(7892,10000,0,0,0)
removeWorldModel(7942,10000,0,0,0)
removeWorldModel(7943,10000,0,0,0)
removeWorldModel(7944,10000,0,0,0)
removeWorldModel(8372,10000,0,0,0)
removeWorldModel(9088,10000,0,0,0)
removeWorldModel(9089,10000,0,0,0)
removeWorldModel(9121,10000,0,0,0)
removeWorldModel(9122,10000,0,0,0)
removeWorldModel(9123,10000,0,0,0)
removeWorldModel(9124,10000,0,0,0)
removeWorldModel(9125,10000,0,0,0)
removeWorldModel(9126,10000,0,0,0)
removeWorldModel(9127,10000,0,0,0)
removeWorldModel(9128,10000,0,0,0)
removeWorldModel(9129,10000,0,0,0)
removeWorldModel(9154,10000,0,0,0)
removeWorldModel(9159,10000,0,0,0)
removeWorldModel(9277,10000,0,0,0)
removeWorldModel(9278,10000,0,0,0)
removeWorldModel(9279,10000,0,0,0)
removeWorldModel(9280,10000,0,0,0)
removeWorldModel(9281,10000,0,0,0)
removeWorldModel(9282,10000,0,0,0)
removeWorldModel(9283,10000,0,0,0)
removeWorldModel(9885,10000,0,0,0)
removeWorldModel(9886,10000,0,0,0)
removeWorldModel(9932,10000,0,0,0)
removeWorldModel(9933,10000,0,0,0)
removeWorldModel(9934,10000,0,0,0)
removeWorldModel(10057,10000,0,0,0)
removeWorldModel(10058,10000,0,0,0)
removeWorldModel(10146,10000,0,0,0)
removeWorldModel(10147,10000,0,0,0)
removeWorldModel(11410,10000,0,0,0)
removeWorldModel(11411,10000,0,0,0)
removeWorldModel(11412,10000,0,0,0)
removeWorldModel(13009,10000,0,0,0)
removeWorldModel(13461,10000,0,0,0)
removeWorldModel(13484,10000,0,0,0)
removeWorldModel(13485,10000,0,0,0)
removeWorldModel(13493,10000,0,0,0)
removeWorldModel(17954,10000,0,0,0)
removeWorldModel(17955,10000,0,0,0)
removeWorldModel(17956,10000,0,0,0)
removeWorldModel(17957,10000,0,0,0)