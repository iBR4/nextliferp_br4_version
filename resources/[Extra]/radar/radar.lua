--Features
local enableBlips = true
local renderNorthBlip = true
local alwaysRenderMap = false
local alwaysRenderOxygen = false
local disableGTASAhealth = false
local disableGTASAarmor = false
local disableGTASAoxygen = false

--Dimensions & Sizes
local worldW, worldH = 1596, 1600
local blip = 15

local sx, sy = guiGetScreenSize()
local rt = dxCreateRenderTarget(290, 175)
local xFactor, yFactor = sx/1366, sy/768
local yFactor = xFactor

-- Useful functions --
function findRotation(x1, y1, x2, y2)
    local t = -math.deg(math.atan2(x2 - x1, y2 - y1))
    if t < 0 then t = t + 360 end
    return t
end

function getPointFromDistanceRotation(x, y, dist, angle)
    local a = math.rad(90 - angle)
    local dx = math.cos(a) * dist
    local dy = math.sin(a) * dist
    return x + dx, y + dy
end

function drawRadar()
    setPlayerHudComponentVisible("radar", false)
    if disableGTASAhealth then setPlayerHudComponentVisible("health", false) end
    if disableGTASAarmor then setPlayerHudComponentVisible("armour", false) end
    if disableGTASAoxygen then setPlayerHudComponentVisible("breath", false) end
    if not isPlayerMapVisible() then
        local mW, mH = dxGetMaterialSize(rt)
        local x, y = getElementPosition(localPlayer)
        local X, Y = mW / 2 - (x / (6000 / worldW)), mH / 2 + (y / (6000 / worldH))
        local camX, camY, camZ = getElementRotation(getCamera())
        dxSetRenderTarget(rt, true)
        if alwaysRenderMap or getElementInterior(localPlayer) == 0 then
            dxDrawRectangle(0, 0, mW, mH, 0xFF7CA7D1)
            dxDrawImage(X - worldW / 2, mH / 5 + (Y - worldH / 2), worldW, worldH, "image/world.png", camZ, (x / (6000 / worldW)), -(y / (6000 / worldH)), tocolor(255, 255, 255, 255))
        end
        dxSetRenderTarget()
        dxDrawRectangle((10) * xFactor, sy - ((200 + 10)) * yFactor, (300) * xFactor, (186) * yFactor, tocolor(0, 0, 0))
        dxDrawImage((10 + 5) * xFactor, sy - ((200 + 5)) * yFactor, (300 - 10) * xFactor, (175) * yFactor, rt, 0, 0, 0, tocolor(255, 255, 255, 150))
        local health = math.max(math.min(getElementHealth(localPlayer) / (0.232018558500192 * getPedStat(localPlayer, 24) - 32.018558511152), 1), 0)
        local armor = math.max(math.min(getPedArmor(localPlayer) / 100, 1), 0)
        local oxygen = math.max(math.min(getPedOxygenLevel(localPlayer) / (1.5 * getPedStat(localPlayer, 225) + 1000), 1), 0)
        local r, g, b
        
        local healthBadR, healthBadG, healthBadB = 255, 0, 0 -- Red
        local healthOkayR, healthOkayG, healthOkayB = 255, 255, 0 -- Yellow
        local healthCriticalR, healthCriticalG, healthCriticalB = 0, 255, 0 -- Green

        if health >= 0.25 then
            r, g, b = interpolateBetween(healthBadR, healthBadG, healthBadB, healthOkayR, healthOkayG, healthOkayB, math.floor(health * 20) / 10, "InOutQuad")
        else
            r, g, b = interpolateBetween(healthCriticalR, healthCriticalG, healthCriticalB, healthBadR, healthBadG, healthBadB, math.floor(health * 20) / 10, "InOutQuad")
        end
        local col = tocolor(r, g, b, 190)
        local bg = tocolor(r, g, b, 100)
		
		if alwaysRenderOxygen or (oxygen < 1 or isElementInWater(localPlayer)) then
		end
		local rx, ry, rz = getElementRotation(localPlayer)
		local lB = (15)*xFactor
		local rB = (15+290)*xFactor
		local tB = sy-(205)*yFactor
		local bB = tB + (175)*yFactor
		local cX, cY = (rB+lB)/2, (tB+bB)/2 +(35)*yFactor
		local toLeft, toTop, toRight, toBottom = cX-lB, cY-tB, rB-cX, bB-cY
		for k, v in ipairs(getElementsByType("blip")) do
			local bx, by = getElementPosition(v)
			local actualDist = getDistanceBetweenPoints2D(x, y, bx, by)
			local maxDist = getBlipVisibleDistance(v)
			if actualDist <= maxDist and getElementDimension(v)==getElementDimension(localPlayer) and getElementInterior(v)==getElementInterior(localPlayer) then
				local dist = actualDist/(6000/((worldW+worldH)/2))
				local rot = findRotation(bx, by, x, y)-camZ
				local bpx, bpy = getPointFromDistanceRotation(cX, cY, math.min(dist, math.sqrt(toTop^2 + toRight^2)), rot)
				local bpx = math.max(lB, math.min(rB, bpx))
				local bpy = math.max(tB, math.min(bB, bpy))
				local bid = getElementData(v, "customIcon") or getBlipIcon(v)
				local _, _, _, bcA = getBlipColor(v)
				local bcR, bcG, bcB = 255, 255, 255
				if getBlipIcon(v) == 0 then
					bcR, bcG, bcB = getBlipColor(v)
				end
				local bS = getBlipSize(v)
				dxDrawImage(bpx -(blip*bS)*xFactor/2, bpy -(blip*bS)*yFactor/2, (blip*bS)*xFactor, (blip*bS)*yFactor, "image/blip/"..bid..".png", 0, 0, 0, tocolor(bcR, bcG, bcB, bcA))
			end
		end
		if renderNorthBlip then
			local rot = -camZ+180
			local bpx, bpy = getPointFromDistanceRotation(cX, cY, math.sqrt(toTop^2 + toRight^2), rot) --get position
			local bpx = math.max(lB, math.min(rB, bpx))
			local bpy = math.max(tB, math.min(bB, bpy)) --cap position to screen
			local dist = getDistanceBetweenPoints2D(cX, cY, bpx, bpy) --get distance to the capped position
			local bpx, bpy = getPointFromDistanceRotation(cX, cY, dist, rot) --re-calculate position based on new distance
			if bpx and bpy then --if position was obtained successfully
				local bpx = math.max(lB, math.min(rB, bpx))
				local bpy = math.max(tB, math.min(bB, bpy)) --cap position just in case
				dxDrawImage(bpx -(blip*2)/2, bpy -(blip*2)/2, blip*2, blip*2, "image/blip/4.png", 0, 0, 0) --draw north (4) blip
			end
		end
		dxDrawImage(cX -(blip*2)*xFactor/2, cY -(blip*2)*yFactor/2, (blip*2)*xFactor, (blip*2)*yFactor, "image/player.png", camZ-rz, 0, 0)
	end
end
addEventHandler("onClientRender", root, drawRadar)

addEventHandler("onClientResourceStop", resourceRoot, function()
	setPlayerHudComponentVisible("radar", true)
	if disableGTASAhealth then setPlayerHudComponentVisible("health", false) end
	if disableGTASAarmor then setPlayerHudComponentVisible("armour", false) end
	if disableGTASAoxygen then setPlayerHudComponentVisible("breath", false) end
end)