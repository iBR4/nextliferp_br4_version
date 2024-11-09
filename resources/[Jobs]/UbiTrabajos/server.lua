local tablae = {}

addEventHandler("onResourceStart", resourceRoot, function()
	for i, v in pairs(piktrabajo) do
		tablae[i] = Marker(v[1], v[2], v[3]-1, "cylinder", 1.5, 255, 255, 255, 0)
		tablae[i]:setInterior(v.int)
		tablae[i]:setDimension(v.dim)
	end
end)

addCommandHandler("trabajos", function(p)
	if not notIsGuest then
		if not p:isInVehicle() then
			for i, v in ipairs(tablae) do
				if p:isWithinMarker(v) then
					p:triggerEvent("setPanelTrabajos", p)
				end
			end
		end
	end
end)

local Pickup = Pickup(-2032.8400878906, -117.32215881348, 1035.171875, 3, 1239,0,0,0)
setElementInterior(Pickup, 3)
setElementDimension(Pickup, 90)