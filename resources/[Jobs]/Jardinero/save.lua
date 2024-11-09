--[[
-- SAVE LICENSES
addEventHandler("onPlayerLogin", getRootElement(), function(p, t, a)
		--conducir
		local conducir = t:getData("Roleplay:ExpJobJardinero")
		if (conducir) then
			local va = t:getData("Roleplay:ExpJobJardinero")
			source:setData("Roleplay:ExpJobJardinero", va)
		else
			source:setData("Roleplay:ExpJobJardinero", 1)
	
	end
end)
function quitJardinero(q, r, e)
		local account = source:getAccount()
		if (account) then
			local va = source:getData("Roleplay:ExpJobJardinero")
			account:setData("Roleplay:ExpJobJardinero", va)
	
	end
end
addEvent("onStopResource", true)
addEventHandler("onPlayerQuit", getRootElement(), quitJardinero)
addEventHandler("onStopResource", getRootElement(), quitJardinero)
function stopJardinero( )
	for i, v in ipairs( Element.getAllByType("player") ) do
	
			triggerEvent("onStopResource", v)
	end
end
addEventHandler("onResourceStop", resourceRoot, stopJardinero)
]]