--
-- s_sPanel.lua
--

function onEventStart()
	if getElementType ( source ) == "player" then
		local account = getPlayerAccount ( source )
		if account and not isGuestAccount ( account ) then
			if getAccountData ( account, "spl.on" ) then
				setElementData ( source, "spl_logged", true )
				l_water = getAccountData ( account, "spl.water" ) 
				l_carpaint = getAccountData ( account, "spl.carpaint" ) 
				l_bloom = getAccountData ( account, "spl.bloom" )
				l_blur = getAccountData ( account, "spl.blur" ) 
				l_detail = getAccountData ( account, "spl.detail" ) 
				l_palette = getAccountData ( account, "spl.palette" ) 
	            triggerClientEvent (source, "onLogged",getRootElement(),true,l_water,l_carpaint,l_bloom,l_blur,l_palette,l_detail)
			end
		end
	end
end

function splsave ( water, carpaint, bloom, blur, palette,detail )
	local account = getPlayerAccount ( source )
	if account and not isGuestAccount ( account ) then
	    setAccountData ( account, "spl.on",true )
		setAccountData ( account, "spl.water", water )
		setAccountData ( account, "spl.carpaint", carpaint )
		setAccountData ( account, "spl.bloom", bloom )
		setAccountData ( account, "spl.blur", blur )
		setAccountData ( account, "spl.detail", detail )
		setAccountData ( account, "spl.palette", palette )
		outputChatBox ( "SP: Your graphics settings have been saved!", source )
		else
	outputChatBox ( "SP: Login to save graphics settings !", source )
	end
end

addEvent ( "splSave", true )
addEventHandler ( "splSave", root, splsave )
addEventHandler ( "onPlayerLogin", root, onEventStart )