--[[
-- SAVE LICENSES
addEventHandler("onPlayerLogin", getRootElement(), function(p, t, a)
	local conducir = t:getData("Camionero:Exp")
	if (conducir) then
		local va = t:getData("Camionero:Exp")
		source:setData("Camionero:Exp", va)
	else
		source:setData("Camionero:Exp", 1)
	end
	local nivel = t:getData("Camionero:Nivel")
	if nivel then
		source:setData("Camionero:Nivel", nivel)
	else
		source:setData("Camionero:Nivel", 1)
	end
end)
function quitPizzero(q, r, e)
	local account = source:getAccount()
	if (account) then
		local va = source:getData("Camionero:Exp")
		account:setData("Camionero:Exp", va)
		local va2 = source:getData("Camionero:Nivel")
		account:setData("Camionero:Nivel",va2)
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