-- save system in data account
function saveAllDatas( p, t, a )
	if not notIsGuest( source ) then
		local puntorol = t:getData("Roleplay:rol")
		if ( puntorol ) then
			local puntorol2 = t:getData ("Roleplay:rol")
			source:setData("Roleplay:rol", puntorol2)
		end
	end
end
addEventHandler("onPlayerLogin", getRootElement(), saveAllDatas)
function quitDatas( q, r, e )
	if not notIsGuest( source ) then
		local account = source:getAccount()
		if ( account ) then
			local puntorol = source:getData("Roleplay:rol")
			account:setData("Roleplay:rol", puntorol)
		end
	end--
end
addEvent("onPlayerSaveQuit", true)
addEventHandler("onPlayerQuit", getRootElement(), quitDatas)
addEventHandler("onPlayerSaveQuit", getRootElement(), quitDatas)
--- onResourceStop
function stopDatas( )
	for i, v in ipairs( Element.getAllByType("player") ) do
		if not notIsGuest( v ) then
			triggerEvent("onPlayerSaveQuit", v)
		end
	end
end
addEventHandler("onResourceStop", resourceRoot, stopDatas)