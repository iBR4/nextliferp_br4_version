-- SAVE LICENSES
addEventHandler("onPlayerLogin", getRootElement(), function(p, t, a)
		--conducir
		local conducir = t:getData("Roleplay:ExpJobCarpintero")
		if (conducir) then
			local va = t:getData("Roleplay:ExpJobCarpintero")
			source:setData("Roleplay:ExpJobCarpintero", va)
		else
			source:setData("Roleplay:ExpJobCarpintero", 1)
		end
end)
function quitBasurero(q, r, e)
		local account = source:getAccount()
		if (account) then
			local va = source:getData("Roleplay:ExpJobCarpintero")
			account:setData("Roleplay:ExpJobCarpintero", va)
		end
end
addEvent("onStopResource", true)
addEventHandler("onPlayerQuit", getRootElement(), quitBasurero)
addEventHandler("onStopResource", getRootElement(), quitBasurero)
function stopBasurero( )
	for i, v in ipairs( Element.getAllByType("player") ) do
			triggerEvent("onStopResource", v)
	end
end
addEventHandler("onResourceStop", resourceRoot, stopBasurero)