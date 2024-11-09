
mysql = exports.MySQL

function openPanelConfig(player)
	if player:getData("Comida") then
		triggerClientEvent(player,"NextLife:ShowConfig",player,player)
	else
		outputChatBox( "Aparece Primero!", player, 255, 0, 0, true )
	end
end

addEventHandler ( "onResourceStart", getResourceRootElement(getThisResource()),
function ()
	for i,source in pairs ( getElementsByType ( 'player' ) ) do
		if source and getElementData(source,'ID') then
			unbindKey(source,"f10","down", openPanelConfig)
			bindKey(source,"f10","down", openPanelConfig)
    	end
    end 
end)

addEventHandler("onPlayerJoin",root,function()
	unbindKey(source,"f10","down", openPanelConfig)
	bindKey(source,"f10","down", openPanelConfig)
end)
