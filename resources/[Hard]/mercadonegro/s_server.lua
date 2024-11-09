
local Marcador = Marker(1295.0397949219, -989.25329589844, 31.8, "cylinder", 1.5, 100, 100, 100, 50)
local Marcador1 = Marker(1295.0397949219, -981.95129394531, 31.8, "cylinder", 1.5, 100, 100, 100, 50)
addCommandHandler("tienda", function(player, cmd)
	if isElement(player) then
		if isElementWithinMarker(player,Marcador) then
			player:triggerEvent("vertienda", player)
		end
	end
end)
function msg_emprego(source)
	if isElementWithinMarker(source, Marcador) then
		outputChatBox("#F7FF00Un sujeto te dice: #ffffff'Todo lo que ves esta para la venta'",source,255,255,255,true)
		outputChatBox("#ffffffUsa #00FF04/tienda #ffffffpara ver que puedes comprar",source,255,255,255,true)
	end
end
addEventHandler("onMarkerHit", Marcador, msg_emprego)
function msg_emprego1(source)
	if isElementWithinMarker(source, Marcador1) then
		outputChatBox("#F7FF00Un sujeto te dice: #ffffff'¿Quieres una mascara para tapar tu rostro?'",source,255,255,255,true)
		outputChatBox("#ffffffUsa #00FF04/comprar mascara #ffffffpara comprar una mascara, recuerda que solo podras usarla si perteneces a una #00FF04familia ilegal",source,255,255,255,true)
	end
end
addEventHandler("onMarkerHit", Marcador1, msg_emprego1)
function giveClientWeapon(id, ammo, cost)
	if source:getMoney() >= cost then
		print("mercado: "..id.." $"..cost)
		source:outputChat("Has comprado un arma por $"..cost,0,255,0,true)
		giveWeapon(source, id, ammo )
		--setPedArmor(source,100)
		takePlayerMoney( source, cost )
	else
		source:outputChat("No tienes dinero suficiente",255,0,0,true)
	end
end
addEvent( "buyarma2", true )
addEventHandler("buyarma2", root, giveClientWeapon)
