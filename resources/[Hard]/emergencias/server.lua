local zonadeltorax = createColSphere (2041.3333740234, -1430.818359375, 17.1640625, 5 )
local zonadeltorax2 = createColSphere (1172.0767822266, -1321.44140625, 15.39880657196, 5 )

function emergencias(player)
	if getElementHealth(player) <= 50 then
		if getPlayerMoney(player) >= 150 then
			if isElementWithinColShape(player, zonadeltorax) then
				fadeCamera( player, false )
				setElementPosition( player, 441.83657836914, 137.69717407227, 1017.85546875 )
				setElementInterior( player, 3)
				setElementDimension( player, 0)
				outputChatBox("Estás siendo atentido en la sala de emergencias...", player, 0,255,0, true)
					---
					setTimer( function()
						setElementHealth (player, 100)
						takePlayerMoney(player, 150)
						fadeCamera(player,true)
						outputChatBox("Has sido atendido con éxito, el hospital te cobra $150 pesos.", player, 0,255,0, true)
			    	end, 6000, 1, player )
			    	---
			elseif isElementWithinColShape(player, zonadeltorax2) then
				fadeCamera( player, false )
				setElementPosition( player, -1260.6672363281, -280.76754760742, 14.883911132812 )
				outputChatBox("Estás siendo atentido en la sala de emergencias...", player, 0,255,0, true)
					---
					setTimer( function(player)
						setElementHealth (player, 100)
						takePlayerMoney(player, 150)
						fadeCamera(player,true)
						outputChatBox("Has sido atendido con éxito, el hospital te cobra $150 pesos.", player, 0,255,0, true)
			    	end, 6000, 1, player )
			    	---
			else
				outputChatBox("Debes estar en el hospital para entrar a emergencias.", player, 255,0,0, true)
			end
		else
			outputChatBox("No tienes el dinero suficiente.", player, 255,0,0,true)
		end
	else
		outputChatBox("Debes tener menos del 50% de vida.", player, 255,0,0,true)
	end
end
addCommandHandler("emergencias", emergencias)