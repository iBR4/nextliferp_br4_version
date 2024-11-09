local PlayerJoin = {}
addEventHandler("onPlayerJoin", getRootElement(), function()
	table.insert(PlayerJoin, {source:getName(), source:getSerial()})
end)
addEventHandler("onPlayerLogin", getRootElement(), function()
	if isPlayerExists358(PlayerJoin, source) then
		for i, v in ipairs(Element.getAllByType("player")) do
			local accName = getAccountName ( getPlayerAccount ( v ) )
			if isObjectInACLGroup ("user."..accName, aclGetGroup ( "Admin" ) ) then
				for _, id in ipairs(PlayerJoin) do
					if id[2] == source:getSerial() then
					end
				end
			end
		end
	end
end)
addEventHandler("onPlayerQuit", getRootElement(), function()
	if isPlayerExists358(PlayerJoin, source) then
		for _, v in ipairs(PlayerJoin) do
			if v[2] == source:getSerial() then
				table.remove(PlayerJoin, _, source:getSerial())
			end
		end
	end
end)
function isPlayerExists358(tabla, player)
	for _, v in ipairs (tabla) do
		if v[2] == player:getSerial() then
			return true
		end
	end
	return false
end