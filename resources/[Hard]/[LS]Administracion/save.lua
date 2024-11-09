-- loadstring(exports.MySQL:getMyCode())()
-- import('*'):init('MySQL')

-- save system in data account
function saveAllDatas( p, t, a )
	if not notIsGuest( source ) then
		local nombrestaff = t:getData("Nombre:staff")
		if ( nombrestaff ) then
			local nombrestaff2 = t:getData ("Nombre:staff")
			source:setData("Nombre:staff", nombrestaff2)
		end
	end
end
addEventHandler("onPlayerLogin", getRootElement(), saveAllDatas)
function quitDatas( q, r, e )
	if not notIsGuest( source ) then
		local account = source:getAccount()
		if ( account ) then
			local nombrestaff = source:getData("Nombre:staff")
			account:setData("Nombre:staff", nombrestaff)
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