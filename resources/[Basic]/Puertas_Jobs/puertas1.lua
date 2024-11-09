Porton = createObject( 1494, 1574.1456298828, -1677, 15.2, 0, 0, 270)
setElementData(Porton, "estadoPuerta", "cerrada")
setElementFrozen(Porton, true)
PortonA = createColSphere( 1574.1456298828, -1677, 16.3, 2)

function abrirU()
	if getElementData(Porton, "estadoPuerta") == "abierta" then
		moveObject( Porton, 1500, 1574.1456298828, -1677, 15.2,0,0,-130)
		setElementData( Porton, "estadoPuerta", "cerrada" )
	elseif getElementData(Porton, "estadoPuerta") == "cerrada" then
		moveObject( Porton, 1500, 1574.1456298828, -1677, 15.2,0,0,130)
		setElementData( Porton, "estadoPuerta", "abierta" )
		setTimer( function()
			moveObject( Porton, 1500, 1574.1456298828, -1677, 15.2,0,0,-130)
			setElementData( Porton, "estadoPuerta", "cerrada" )
		end, 3000, 1)
	end
end

addEventHandler( "onColShapeHit", getRootElement(), function(player) 
	if getElementType(player) == "player" then
		if player:getData('Roleplay:faccion') == 'Policia' then
			if source == PortonA then
				bindKey ( player, "f", "down", abrirU)
			end
		end
	end
end)

addEventHandler( "onColShapeLeave", getRootElement(), function(player)  
	if getElementType(player) == "player" then
		if player:getData('Roleplay:faccion') == 'Policia' then
			if source == PortonA then
				unbindKey ( player, "f", "down", abrirU)
			end
		end
	end
end)

---------------------------------------------------------------------------


Puerta = createObject( 1494, 1571.3, -1680.8,15.2, 0, 0, 270)
setElementData(Puerta, "estadoPuerta1", "cerrada1")
setElementFrozen(Puerta, true)
PuertaA = createColSphere( 1571.3, -1680.8, 16.3, 2)

function PuertaAbrir()
	if getElementData(Puerta, "estadoPuerta1") == "abierta1" then
		moveObject(Puerta, 1500, 1571.3, -1680.8, 15.2,0,0,-130)
		setElementData( Puerta, "estadoPuerta1", "cerrad1a" )
	elseif getElementData(Puerta, "estadoPuerta1") == "cerrada1" then
		moveObject(Puerta, 1500, 1571.3, -1680.8, 15.2,0,0,130)
		setElementData(Puerta, "estadoPuerta1", "abierta1" )
		setTimer( function()
			moveObject(Puerta, 1500, 1571.3, -1680.8, 15.2,0,0,-130)
			setElementData(Puerta, "estadoPuerta1", "cerrada1" )
		end, 3000, 1)
	end
end

addEventHandler( "onColShapeHit", getRootElement(), function(thePlayer) 
	if getElementType(thePlayer) == "player" then
		if thePlayer:getData('Roleplay:faccion') == 'Policia' then
			if source == PuertaA then
				bindKey ( thePlayer, "f", "down", PuertaAbrir)
			end
		end
	end
end)

addEventHandler( "onColShapeLeave", getRootElement(), function(thePlayer)  
	if getElementType(thePlayer) == "player" then
		if thePlayer:getData('Roleplay:faccion') == 'Policia' then
			if source == PuertaA then
				unbindKey ( thePlayer, "f", "down", PuertaAbrir)
			end
		end
	end
end)


---------------------------------------------------------------------------



addCommandHandler( "agreaaaaaaaaaaaaaaaaa", 
	function( thePlayer, commandName, otherPlayer, amount )
		local amount = tonumber(amount)
		if otherPlayer and amount and math.ceil( amount ) == amount and amount > 0 then	        
			if exports.players:isLoggedIn( thePlayer ) then
				if exports.factions:isPlayerInFaction( thePlayer, 1 ) then
					local other, name = exports.players:getFromName( player, otherPlayer )
					if other then
				        if player ~= other then
							if exports.players:takeMoney( other, amount ) then
						    	exports.players:giveMoney( thePlayer, amount )
								exports.chat:me( thePlayer, "sacaria una libreta de su bolsillo izquierdo y redactaria una multa" )
   	     		        		outputChatBox( "(( " .. name .. " Fuiste multado por $" .. amount .. ". ))",other, 200,50,50  )
							end
						end
					end
				end
			end
		else
			outputChatBox( "#44A5CASyntax:#FFFFFF /multar ID cantidad",thePlayer, 220, 220, 220, true)
		end
	end
)