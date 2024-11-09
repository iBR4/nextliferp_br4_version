function onPreFunction( sourceResource, functionName, isAllowedByACL, luaFilename, luaLineNumber, ... )
    local args = { ... }
    local resname = sourceResource and getResourceName(sourceResource)
    if sourceResource ~= getThisResource(  ) then
    	if availables[getElementType(args[1])] then
    		if getBaseFromID[tonumber(args[2])] then
                --if not isLoaded[args[1]] or isLoaded[args[1]] ~= getBaseFromID[tonumber(args[2])] then
                    setElementModel(args[1], getBaseFromID[tonumber(args[2])])
                   -- isLoaded[args[1]] = getBaseFromID[tonumber(args[2])]
               -- end
    			setElementData(args[1], 'ModelCustomID', tonumber(args[2]))
    		end
    	end
    else
    	
    end
end
addDebugHook( "postFunction", onPreFunction, {"setElementModel"} )

addEventHandler( "onResourceStart", resourceRoot,
    function()
        for type in pairs(availables) do
            for i, v in ipairs(getElementsByType(type)) do
                local customID = getElementData(v, 'ModelCustomID')
                if tonumber(customID) then
                    --setElementData(v, 'ModelCustomID', nil)
                    setElementModel(v, getBaseFromID[customID])
                   -- setTimer(setElementData, 100, 1, v, 'ModelCustomID', customID)
                end
            end
        end
    end
)
addEventHandler( "onPlayerSpawn", getRootElement(),
    function()
        local customID = getElementData(source, 'ModelCustomID')
        if tonumber(customID) then
            triggerClientEvent('Custom:applyModel', source, customID)
        end
    end
)
--[[
_createVehicle = createVehicle
function createVehicle(model, ...)
    local model = tonumber(model)
    local check = exports.newmodels:isCustomModel(model)
    if check then
        local veh = _createVehicle(check.base_id, ...)
        setTimer(setElementModel, 2000, 1, veh, model)
        return veh
    else
        return _createVehicle(model, ...)
    end
end]]