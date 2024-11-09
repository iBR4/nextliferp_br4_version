-- SAVE LICENSES
addEventHandler("onPlayerLogin", getRootElement(), function(p, t, a)
	local conducir = t:getData("Taxista:Exp")
	if (conducir) then
		local va = t:getData("Taxista:Exp")
		source:setData("Taxista:Exp", va)
	else
		source:setData("Taxista:Exp", 1)
	end
	local nivel = t:getData("Taxista:Nivel")
	if nivel then
		source:setData("Taxista:Nivel", nivel)
	else
		source:setData("Taxista:Nivel", 1)
	end
end)
function quitPizzero(q, r, e)
	local account = source:getAccount()
	if (account) then
		local va = source:getData("Taxista:Exp")
		account:setData("Taxista:Exp", va)
		local va2 = source:getData("Taxista:Nivel")
		account:setData("Taxista:Nivel",va2)
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