mysql = exports.MySQL

function openPanelCoins(player)
	if player:getData("Comida") then
		if exports.nlogin:getCharacterData(player,"Monedas") ~= false then
			triggerClientEvent(player,"NL:ShowCoins",player,player,tonumber(exports.nlogin:getCharacterData(player,"Monedas")))
		else
			triggerClientEvent(player,"NL:ShowCoins",player,player,0)
		end
	end
end
--[[
addEventHandler("onPlayerResourceStart",root,function(startedResource)
	if not startedResource == resource then
		return false
	end
	unbindKey(source,"f6","down", openPanelCoins)
	bindKey(source,"f6","down", openPanelCoins)
end)
--]]
addEventHandler ( "onResourceStart", getResourceRootElement(getThisResource()),
function ()
	for i,source in pairs ( getElementsByType ( 'player' ) ) do
		if source and getElementData(source,'ID') then
			unbindKey(source,"f6","down", openPanelCoins)
			bindKey(source,"f6","down", openPanelCoins)
    	end
    end 
end)

addEventHandler("onPlayerJoin",root,function()
	unbindKey(source,"f6","down", openPanelCoins)
	bindKey(source,"f6","down", openPanelCoins)
end)

function isOccupedNick(nick)
	local save = mysql:query("SELECT * From save_system WHERE Cuenta = '"..nick.."'")
	if ( type ( save ) == "table" and #save == 0 ) or not save then
		return false
	else
		return true
	end
end

function bCoins(player,plan,days,coins)
	if source == player then
		if isElement(player) then
			if exports.nlogin:getCharacterData(player,"Monedas") ~= false then
				if exports.nlogin:getCharacterData(player,"Monedas") > 0 then
					if exports.nlogin:getCharacterData(player,"Monedas") >= coins then
						if plan == "Paquetes VIP" or plan == "Paquetes VIP+" then
							local data = {mysql:AccountName(player),days,plan,player,coins}
							exports["[LS]Donadores"]:addVipPlayer(data)
						elseif plan == "CambioNick" then
							if isOccupedNick(tostring(days)) == false then
								if getPlayerTeam(getPlayerTeam(player)) ~= getTeamFromName("Staff") then
									local nickcompleto = tostring(days)
									local old = getPlayerName(player)
									exports.nlogin:setCharacterData(player,"Monedas",exports.nlogin:getCharacterData(player,"Monedas") - coins )
									mysql:update("UPDATE Datos_Personajes SET Nick = ?  WHERE Cuenta = ?", nickcompleto, mysql:AccountName(player))
									mysql:update("UPDATE save_system SET Nick = ?  WHERE Cuenta = ?", nickcompleto, mysql:AccountName(player))
									setPlayerName(player, nickcompleto)
									outputChatBox("#FFFF00"..old.."#FFFFFF ahora es conocido como #FFFF00"..nickcompleto.."#FFFFFF.",root,255,255,255,true)
									outputChatBox("Cambiaste tu nombre completo con exito, Felicidades!",player,0,255,0,true)
									exports.Texts:output("*NLCoins Se a cambiado de nombre '"..old.."' a '"..nickcompleto.."' exitosamente!", vars[4], 0, 255, 150, true)
									outputDebugString("*NLCoins Se a cambiado de nombre '"..old.."' a '"..nickcompleto.."' exitosamente!")
									triggerClientEvent(player,"NL:ShowCoins",player,player,tonumber(exports.nlogin:getCharacterData(player,"Monedas")))
								else
									outputChatBox("Tienes que estar fuera del equipo staff /sduty!",player,255,255,0,true)
								end
							else
								outputChatBox("Este nombre esta ocupado, usa otro!",player,255,0,0,true)
							end
						end
					else
						outputChatBox("Tus NLCoins son insuficientes!",player,255,0,0,true)
					end
				else
					outputChatBox("Tus NLCoins son insuficientes!",player,255,0,0,true)
				end
			else
				outputChatBox("Tus NLCoins son insuficientes!",player,255,0,0,true)
			end
		end
	end
end
addEvent("NL:BuyItemsCoins",true)
addEventHandler("NL:BuyItemsCoins",root,bCoins)