local antiSpamYO = {}
local antiSpamGuardarYO = {}
local valoresYo = {}
function describir_personaje( source, cmd, ... )
	if not source:getAccount():isGuest () then
		local tick = getTickCount()
		if (antiSpamYO[source] and antiSpamYO[source][1] and tick - antiSpamYO[source][1] < 2000) then
			source:outputChat("#4169E1[YO] #ffffffEspera 2 segundos para volver utilizar el comando ", 150, 0, 0,true)
			return
		end
		local message = table.concat({...}, " ")
		if message ~= "" and message ~= " " and message:len() >= 1 then
			source:setData("yo", {message, 150, 0, 0})
			source:outputChat("#4169E1[YO] #ffffffColocaste tu /yo con exito: #4169E1" ..message, 150, 0, 0,true)
			if (not antiSpamYO[source]) then
				antiSpamYO[source] = {}
			end
			antiSpamYO[source][1] = getTickCount()
			if isElement( chatCol ) then
				destroyElement( chatCol )
			end
		else
			source:outputChat("#4169E1[YO] #ffffffBorraste tu /yo perfectamente.", 150, 0, 0,true)
			source:setData("yo", {"", 150, 0, 0})
		end
	end
end
addCommandHandler("yo", describir_personaje)
addEventHandler("onPlayerLogin", getRootElement(), function(p, t, a)
	local va = t:getData("yo") or ""
	source:setData("yo", {va, 150, 0, 0})
end)
function quitYo(p,t,a)
	local account = source:getAccount()
	if (account) then
		local va = source:getData("yo") or ""
		account:setData("yo", va[1])
	end
end
addEvent("onStopResource", true)
addEventHandler("onPlayerQuit", getRootElement(), quitYo)
addEventHandler("onStopResource", getRootElement(), quitYo)
function stopYo( )
	for i, v in ipairs( Element.getAllByType("player") ) do
		if not notIsGuest( v ) then
			triggerEvent("onStopResource", v)
		end
	end
end
addEventHandler("onResourceStop", resourceRoot, stopYo)