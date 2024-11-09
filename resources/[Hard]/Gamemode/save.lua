-- SAVE LICENSES

addEventHandler("onPlayerLogin", getRootElement(), function(p, t, a)
	local conducir = t:getData("Agua")
	if (conducir) then
		local va = t:getData("Agua")
		source:setData("Agua", va)
	else
		source:setData("Agua", 1)
	end
	local nivel = t:getData("Comida")
	if nivel then
		source:setData("Comida", nivel)
	else
		source:setData("Comida", 1)
	end
end)

function quitPizzero(q, r, e)
	local account = source:getAccount()
	if (account) then
		local va = source:getData("Agua")
		account:setData("Agua", va)
		local va2 = source:getData("Comida")
		account:setData("Comida",va2)
	end
end
addEvent("onStopResource", true)
addEventHandler("onPlayerQuit", getRootElement(), quitPizzero)
addEventHandler("onStopResource", getRootElement(), quitPizzero)

function stopPizzero( )
	for i, v in ipairs( Element.getAllByType("player") ) do
		if not notIsGuest( v ) then
			triggerEvent("onStopResource", v)
		end
	end
end
addEventHandler("onResourceStop", resourceRoot, stopPizzero)