local pickupwe = Pickup(450.29095458984, -80.836807250977, 999.5546875, 3, 1275)
setElementInterior( pickupwe, 4) -- Coloca el numero de interior
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
  dxDrawTextOnElement(pickupwe,"/mesero",0,20,255,255,255,255,2,"default")
end)
local praca = createMarker(450.29095458984, -80.836807250977, 999.5546875, "cylinder", 1.5, 255, 255, 0, 0 )
setElementDimension(praca,0)
setElementInterior(praca,4)
--local blip = createBlip(810.48486, -1616.12024, 13.54688, 14)              
local mesas = {
    {435.21343994141, -85.635757446289, 999.5546875},
    {439.33508300781, -85.606407165527, 999.5546875},
    {441.31323242188, -87.154174804688, 999.5546875},
    {444.97985839844, -87.148330688477, 999.5546875},
    {449.91436767578, -87.254920959473, 999.5546875},
    {451.54318237305, -89.499908447266, 999.5546875},
    {448.21899414062, -89.376266479492, 999.5546875},
    {444.54043579102, -89.290718078613, 999.5546875},
    {440.78829956055, -89.325149536133, 999.5546875},
    {437.29086303711, -89.277542114258, 999.5546875},
    {433.86813354492, -89.356231689453, 999.5546875},
    {456.72033691406, -83.736106872559, 999.5546875},
    {457.7258605957, -83.945495605469, 999.5546875},
}
addEventHandler("onClientMarkerHit", praca, function(el, md)
    if not md or getElementType(el) ~= "player" then return end
    if el ~= localPlayer then return end
    outputChatBox("#B200FF[MESERO] #ffffffBienvenido a la cocina escribe #FFF700/mesero #ffffffpara recibir la comida a entregar!",0,0,0,true)
end)
addCommandHandler("mesero", function()
    if localPlayer:getData("Roleplay:trabajo") == "Mesero" or localPlayer:getData("Roleplay:trabajoVIP") == "Mesero" then
    if not isElementWithinMarker(localPlayer, praca) then return end
    if not getElementData(localPlayer, "gracz_praca") then
                mesita = math.random(1, 10)
                setElementFrozen(el, true)
                outputChatBox("> Toma la bandeja",240, 0, 240,true)
                outputChatBox("#B200FF[MESERO] #ffffffTomaste la bandeja, ve a entregarla a la mesa numero #FFF700"..mesita..".",0,0,0,true)
            setTimer(function()
                setElementFrozen(el, false)
            end, 3600, 1)
        local losuj = math.random(2, #mesas)
        setElementData(localPlayer, "gracz_praca", true)
        setPedAnimation ( localPlayer, "CARRY", "crry_prtial", 1,true )
        toggleControl("sprint", false)
        local skrzynia = createObject(2814, 0, 0, 0, 0, 0, 0)
        attachElements ( skrzynia, localPlayer, 0, 0.5, 0.3)
        setElementDimension(skrzynia,0)
        setElementInterior(skrzynia,4)
        
        local cel = createMarker(mesas[losuj][1], mesas[losuj][2], mesas[losuj][3]-1.0, "checkpoint", 1.0, 255, 0, 0)
        
        setElementDimension(cel,0)
        setElementInterior(cel,4)
        local blip = createBlipAttachedTo(cel, 41)
        addEventHandler("onClientMarkerHit", cel, function(el, md)
            if not md or getElementType(el) ~= "player" then return end
            if el ~= localPlayer then return end
            if getPedOccupiedVehicle(el) then
            outputChatBox("")
                return
            end
            destroyElement(blip)
            setElementFrozen(el, true)
            outputChatBox("> Coloca la comida en la mesa",240, 0, 240,true)
            outputChatBox("#B200FF[MESERO] #ffffffEspera unos segundos mientras colocas la comida en la misma.",0,0,0,true)
            setTimer(function()
                setElementFrozen(el, false)
                outputChatBox("#B200FF[MESERO] #ffffffTe pagaron el plato de comida y tambien te dieron#ffffff propina.",0,0,0,true)
                outputChatBox("> Toma el dinero y lo guarda en su bolsillo.",240, 0, 240,true)
                outputChatBox("#B200FF[MESERO] #ffffffPuedes volver a tomar comida detras del mostrador.",0,0,0,true)
                destroyElement(skrzynia)
                destroyElement(cel)
                setPedAnimation(localPlayer, false)
                setElementData(el, "gracz_praca", false)
                toggleControl("sprint", true)
                triggerServerEvent("givePlayerMoney", el, 125 ,0)
                setElementData(el, "trabajo2", true)
            end, 3600, 1)
        end)
    else
        outputChatBox("")
    end
else
    outputChatBox("#ffffffSal de la cocina, tu no eres un mesero.",0,0,0,true)
end
end)
