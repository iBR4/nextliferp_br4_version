
local screenW, screenH = guiGetScreenSize()
--RadarBloods = createRadarArea( 2226.3254394531, -1767.6697998047, 200, -70, 200, 53, 53, 53)
--[[function entrandoAlBarrioBloods()
    dxDrawImage(screenW * 0.7701, screenH * 0.3802, screenW * 0.1413, screenH * 0.2305, ":familias/gui/images/BloodsLogo.png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
    dxDrawText("Barrio controlado por: Nadie", (screenW * 0.7353) - 1, (screenH * 0.7148) - 1, (screenW * 0.9441) - 1, (screenH * 0.8073) - 1, tocolor(0, 0, 0, 255), 1.00, "default-bold", "center", "top", false, false, false, false, false)
    dxDrawText("Barrio controlado por: Nadie", (screenW * 0.7353) + 1, (screenH * 0.7148) - 1, (screenW * 0.9441) + 1, (screenH * 0.8073) - 1, tocolor(0, 0, 0, 255), 1.00, "default-bold", "center", "top", false, false, false, false, false)
    dxDrawText("Barrio controlado por: Nadie", (screenW * 0.7353) - 1, (screenH * 0.7148) + 1, (screenW * 0.9441) - 1, (screenH * 0.8073) + 1, tocolor(0, 0, 0, 255), 1.00, "default-bold", "center", "top", false, false, false, false, false)
    dxDrawText("Barrio controlado por: Nadie", (screenW * 0.7353) + 1, (screenH * 0.7148) + 1, (screenW * 0.9441) + 1, (screenH * 0.8073) + 1, tocolor(0, 0, 0, 255), 1.00, "default-bold", "center", "top", false, false, false, false, false)
    dxDrawText("Barrio controlado por: Nadie", screenW * 0.7353, screenH * 0.7148, screenW * 0.9441, screenH * 0.8073, tocolor(182, 176, 176, 255), 1.00, "default-bold", "center", "top", false, false, false, false, false)
end
addEvent("BarrioBloodOn", true)
function onBlood()
	addEventHandler("onClientRender", getRootElement(), entrandoAlBarrioBloods)
end
addEventHandler("BarrioBloodOn", getRootElement(), onBlood)
addEvent("BarrioBloodOff", true)
function offBlood()
	removeEventHandler("onClientRender", getRootElement(), entrandoAlBarrioBloods)
end
addEventHandler("BarrioBloodOff", getRootElement(), offBlood)]]--
addEventHandler("onClientRender", getRootElement(), function()
local playerX2, playerY2, playerZ2 = getElementPosition ( localPlayer )
    for k, v in pairs(getJobsLadron()) do
        local playerX, playerY, playerZ = v[1], v[2], v[3]
        local sx, sy = getScreenFromWorldPosition(playerX, playerY, playerZ + 0.5)
        if sx and sy then
            local cx, cy, cz = getCameraMatrix()
            local distance = getDistanceBetweenPoints3D(playerX2, playerY2, playerZ2, playerX, playerY, playerZ + 0.5)
            if distance < 10 then
                dxDrawBorderedText3 ( v[4], sx, sy, sx, sy ,tocolor (255, 52, 52, 255 ),1, "default-bold","center", "center" ) 
            end
        end
    end
    local playerX1, playerY1, playerZ1 = 1295.0397949219, -981.95129394531, 32.6953125
    local sx1, sy1 = getScreenFromWorldPosition(playerX1, playerY1, playerZ1 + 0.5)
    if sx1 and sy1 then
        local cx, cy, cz = getCameraMatrix()
        local distance = getDistanceBetweenPoints3D(playerX2, playerY2, playerZ2, playerX1, playerY1, playerZ1 + 0.5)
        if distance < 10 then
            dxDrawBorderedText3 ( "", sx1, sy1, sx1, sy1 , tocolor (255, 255, 255, 255 ),1, "default-bold","center", "center" ) 
        end
    end
    local playerX12, playerY12, playerZ12 = 1295.0397949219, -981.95129394531, 32.6953125
    local sx2, sy2 = getScreenFromWorldPosition(playerX12, playerY12, playerZ12 + 0.5)
    if sx2 and sy2 then
        local cx, cy, cz = getCameraMatrix()
        local distance = getDistanceBetweenPoints3D(playerX2, playerY2, playerZ2, playerX12, playerY12, playerZ12 + 0.5)
        if distance < 10 then
            dxDrawBorderedText3 ( "", sx2, sy2, sx2, sy2 , tocolor (255, 255, 255, 255 ),1, "default-bold","center", "center" ) 
        end
    end
end) 
local jobLadronM = createPickup( 2324.955078125, -1175.1456298828, 1027.9765625, 3, 2061, 0)
setElementDimension(jobLadronM,0)
setElementInterior(jobLadronM,5)
function dxDrawBorderedText3( text, x, y, w, h, color, scale, font, alignX, alignY, clip, wordBreak, postGUI )
    dxDrawText(text:gsub('#%x%x%x%x%x%x', ''), (x) + 1, (y) + 1, (w) + 1, (h) + 1, tocolor ( 0, 0, 0, 255 ), scale, font, alignX, alignY, clip, wordBreak, postGUI, true)
    dxDrawText(text:gsub('#%x%x%x%x%x%x', ''), (x) - 1, (y) - 1, (w) - 1, (h) - 1, tocolor ( 0, 0, 0, 255 ), scale, font, alignX, alignY, clip, wordBreak, postGUI, true)
    dxDrawText(text, x, y, w, h, color, scale, font, alignX, alignY, clip, wordBreak, postGUI, true)
end
-------------------------------------
addEventHandler("onClientRender", getRootElement(), 
function()
end)
zonaComprarMascara = createColSphere( 1286.89, -979.3, 32.75, 3 )
function dxDrawTextOnElement(TheElement,text,height,distance,R,G,B,alpha,size,font,...)
    local x, y, z = getElementPosition(TheElement)
    local x2, y2, z2 = getCameraMatrix()
    local distance = distance or 20
    local height = height or 1
    if (isLineOfSightClear(x, y, z+2, x2, y2, z2, ...)) then
        local sx, sy = getScreenFromWorldPosition(x, y, z+height)
        if(sx) and (sy) then
            local distanceBetweenPoints = getDistanceBetweenPoints3D(x, y, z, x2, y2, z2)
            if(distanceBetweenPoints < distance) then
                dxDrawText(text, sx, sy, sx, sy, tocolor(R or 255, G or 255, B or 255, alpha or 255), (size or 1)-(distanceBetweenPoints / distance), font or "arial", "center", "center")
            end
        end
    end
end
