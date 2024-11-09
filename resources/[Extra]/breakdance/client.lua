local ifp = engineLoadIFP( "breakdance.ifp", "breakdance" )

addEvent( "breakdance", true )
addEventHandler( "breakdance", root,
	function(enable)
		if (enable) then setPedAnimation(source, "breakdance", "WEAPON_crouch", -1, true, false)
		else setPedAnimation(source)
		end		
	end
)

addEventHandler("onClientResourceStart", resourceRoot,
    function()
        triggerServerEvent("onClientSync", resourceRoot)
	end
)

addEventHandler("onClientResourceStop", resourceRoot,
	function()
		if ifp then
			for _,player in ipairs(getElementsByType("player")) do
				local _, breakdance = getPedAnimation(player)
				if (breakdance == "WEAPON_crouch") then
					setPedAnimation(player)
				end
			end
			destroyElement(ifp)
		end
	end
)


-- SparroW MTA : https://sparrow-mta.blogspot.com
-- Facebook : https://www.facebook.com/sparrowgta/
-- İnstagram : https://www.instagram.com/sparrowmta/
-- Discord : https://discord.gg/DzgEcvy

-- Yeni YouTube Kanalımız : https://www.youtube.com/@TurkishSparroW/