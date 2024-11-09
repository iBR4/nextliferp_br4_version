--[[
-- SAVE LICENSES
addEventHandler("onPlayerLogin", getRootElement(), function(p, t, a)
	local conducir = t:getData("Pizzero:Exp")
	if (conducir) then
		local va = t:getData("Pizzero:Exp")
		source:setData("Pizzero:Exp", va)
	else
		source:setData("Pizzero:Exp", 1)
	end
	local nivel = t:getData("Pizzero:Nivel")
	if nivel then
		source:setData("Pizzero:Nivel", nivel)
	else
		source:setData("Pizzero:Nivel", 1)
	end
end)
function quitPizzero(q, r, e)
	local account = source:getAccount()
	if (account) then
		local va = source:getData("Pizzero:Exp")
		account:setData("Pizzero:Exp", va)
		local va2 = source:getData("Pizzero:Nivel")
		account:setData("Pizzero:Nivel",va2)
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
]]