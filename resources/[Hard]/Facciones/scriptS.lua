-- altalaban san mtahoz
local policeVehicles = {
	[427] = true,			-- Enforcer
	[490] = true,			-- FBI Rancher
	[497] = true,			-- 497poliheli
	[528] = true,			-- FBI Truck
	[491] = true,			-- Virgo
	[596] = true,			-- Police LS
	[598] = true,			-- Police LV
	[599] = true,			-- Police Ranger
	[523] = true,			-- HPV1000
	[426] = true,			-- Premier
	[546] = true,			-- Intruder
	[516] = true,			-- Nebula
	[492] = true,			-- Greenwood
	[20006] = true,         -- lancer
	
}
local binds = {}
local lightColor = {}
local lightStates = {}
local lightTimers = {}
function toggleSiren(p)
if p:getData("Roleplay:faccion") == "Policia" or p:getData("Roleplay:faccion") == "Medico" then
	if p.vehicle then
		local state = p.vehicle:getData('police:siren')
		if state then
			p.vehicle:setData('police:siren', false)
			resetLights(p.vehicle)
		else
			lightColor[p.vehicle] = {p.vehicle:getHeadLightColor()}
			lightStates[p.vehicle] = {}
			for i = 0, 3 do
				lightStates[p.vehicle][i] = p.vehicle:getLightState(i)
			end
			sirenTimer(p.vehicle)
			lightTimers[p.vehicle] = setTimer(sirenTimer, 200, 0, p.vehicle)
			p.vehicle:setData('police:siren', true)
		end
	end
end
end
addCommandHandler("strobos", toggleSiren, false)
function sirenTimer(veh)
	if veh:getData('police:siren:state') then
		veh:setLightState(0, 1)
		veh:setLightState(1, 0)
		veh:setLightState(2, 0)
		veh:setLightState(3, 1)
		veh:setHeadLightColor(255, 255, 255)
	else	
		veh:setLightState(0, 0)
		veh:setLightState(1, 1)
		veh:setLightState(2, 1)
		veh:setLightState(3, 0)
		veh:setHeadLightColor(255, 255, 255)
	end
	veh:setData('police:siren:state', not veh:getData('police:siren:state'))
end
function resetLights(veh)
	if lightTimers[veh] then lightTimers[veh]:destroy() lightTimers[veh] = nil end
	veh:setHeadLightColor(lightColor[veh][1], lightColor[veh][2], lightColor[veh][3])
	veh:setData('veh:light', 1)
	for i = 0, 3 do
		veh:setLightState(i, lightStates[veh][i])
	end
	lightColor[veh] = nil
	lightStates[veh] = nil
end
function onStart()
	for k, v in pairs(getElementsByType('player')) do
		if v.vehicle and policeVehicles[v.vehicle.model] then
		end
	end
end
addEventHandler('onResourceStart', getResourceRootElement(thisResource), onStart)
function onStop()
	for k, v in pairs(binds) do
		onExit(k)
	end
	for k, v in pairs(lightColor) do
		resetLights(k)
	end
end
addEventHandler('onResourceStop', getResourceRootElement(thisResource), onStop)
function onDestroy()
	if getElementType(source) == 'vehicle' then
		if lightColor[source] then
			resetLights(source)
		end
	end
end
addEventHandler('onElementDestroy', root, onDestroy)