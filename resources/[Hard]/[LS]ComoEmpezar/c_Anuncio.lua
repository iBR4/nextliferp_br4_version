local screenW, screenH = guiGetScreenSize()
local costodeanuncio = 250 -- Acá escribe cuanto cuesta el anuncio
local pickupwe = createPickup(-180.85716247559, 1116.4703369141, 20.342189788818, 3, 1275, 0)
setElementInterior( pickupwe, 14) -- Coloca el numero de interior
setElementDimension( pickupwe, 0 ) -- Coloca el numero de dimension
function dxDrawTextOnElement(TheElement,text,height,distance,R,G,B,alpha,size,font,...)
    local x, y, z = getElementPosition(pickupwe)
    local x2, y2, z2 = getCameraMatrix()
    local distance = distance or 20
    local height = height or 1
    if (isLineOfSightClear(x, y, z+2, x2, y2, z2, ...)) then
        local sx, sy = getScreenFromWorldPosition(x, y, z+height)
        if(sx) and (sy) then
            local distanceBetweenPoints = getDistanceBetweenPoints3D(x, y, z, x2, y2, z2)
            if(distanceBetweenPoints < distance) then
                dxDrawText(text, sx+2, sy+2, sx, sy, tocolor(R or 255, G or 255, B or 255, alpha or 255), (size or 1)-(distanceBetweenPoints / distance), font or "arial", "center", "center")
            end
        end
    end
end
addEventHandler("onClientRender", getRootElement(), 
function ()
  dxDrawTextOnElement(pickupwe,"¿Eres nuevo?, Escribe /comoempezar",0,20,255,255,255,255,1.5,"default")
end)