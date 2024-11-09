local animEnable = {}
local syncPlayers = {}

addCommandHandler("breakdance",
	function(player)
		if (not animEnable[player]) then
			animEnable[player] = true
			triggerClientEvent(syncPlayers, "breakdance", player, true)
		else
			animEnable[player] = false
			triggerClientEvent(syncPlayers, "breakdance", player, false)
		end
	end
)

addEvent("onClientSync", true )
addEventHandler("onClientSync", resourceRoot,
    function()
        table.insert(syncPlayers, client)
		for player, enable in ipairs(animEnable) do
			if (enable) then
				triggerClientEvent(client, "breakdance", player, true)
			end
		end
    end 
)

addEventHandler("onPlayerQuit", root,
    function()
        for i, player in ipairs(syncPlayers) do
            if source == player then 
                table.remove(syncPlayers, i)
                break
            end 
        end
        if (animEnable[source] == true or animEnable[source] == false) then animEnable[source] = nil end
    end
)


-- SparroW MTA : https://sparrow-mta.blogspot.com
-- Facebook : https://www.facebook.com/sparrowgta/
-- İnstagram : https://www.instagram.com/sparrowmta/
-- Discord : https://discord.gg/DzgEcvy

-- Yeni YouTube Kanalımız : https://www.youtube.com/@TurkishSparroW/