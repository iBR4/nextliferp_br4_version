newID = {}
function onPreFunction( sourceResource, functionName, isAllowedByACL, luaFilename, luaLineNumber, ... )
    local args = { ... }
    local resname = sourceResource and getResourceName(sourceResource)
    if sourceResource ~= getThisResource(  ) then
    	if availables[getElementType(args[1])] then
    		if getBaseFromID[args[2]] then
               setElementModel(args[1], newID[args[2]])
    		end
    	end
    end
end
addDebugHook( "postFunction", onPreFunction, {"setElementModel"} )
addEventHandler( "onClientResourceStart", resourceRoot,
	function()
		for type in pairs(Modelos) do
			for i, v in ipairs(Modelos[type]) do
				local id = engineRequestModel(type, v.base_id)
				newID[v.id] = id
				if fileExists(v.path .. v.id .. ".txd") and fileExists(v.path .. v.id .. ".dff") then
				    txd = engineLoadTXD(v.path .. v.id .. ".txd")
				    engineImportTXD(txd, id)
				    dff = engineLoadDFF(v.path .. v.id .. ".dff")
				    engineReplaceModel(dff, id)
				end
			end
		end
		for type in pairs(availables) do
            for i, v in ipairs(getElementsByType(type)) do
                local customID = getElementData(v, 'ModelCustomID')
                if tonumber(customID) then
                    setElementModel(v, newID[customID])
                    
                end
            end
        end
	end
)
addEventHandler( "onClientElementDataChange", getRootElement(),
	function(key, old, new)
		if availables[getElementType(source)] then
			if key == 'ModelCustomID' then
				if tonumber(new) then
					
					--if not isLoaded[source] then
						setElementModel(source, getBaseFromID[new])
						setElementModel(source, newID[new])
						--isLoaded[source] = true
					--end
				end
			end
		end
	end
)
-- addEventHandler( "onClientElementStreamIn", getRootElement(),
-- 	function()
-- 		if availables[getElementType(source)] then
-- 			local customID = getElementData(source, 'ModelCustomID')
-- 			if tonumber(customID) then
-- 				if not isLoaded[source] then
-- 					setElementModel(source, getBaseFromID[customID])
-- 					setElementModel(source, newID[customID])
-- 					isLoaded[source] = true
-- 				end
-- 			end
-- 		end
-- 	end
-- )
addEvent('Custom:applyModel', true)
addEventHandler( "Custom:applyModel", getRootElement(),
	function(customID)
		setElementModel(source, getBaseFromID[customID])
		setElementModel(source, newID[customID])
					
	end
)
