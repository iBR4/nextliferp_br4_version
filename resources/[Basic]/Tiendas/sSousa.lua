local jblmao = { }
local jblchao = { }
local tempCol = { }
function jbl(thePlayer)
    if getPlayerItem(thePlayer,"Parlante") == 1 then
    if jbl then
    if getElementData(thePlayer, "rocketz:jbl") == "chao" then 
        message(thePlayer, "Pusiste un enlace en el parlante.", "error")
    else
    if not getElementData(thePlayer, "rocketz:jbl") then
            if getElementData(thePlayer, "rocketz:flood") ~= true then
            dimensao = getElementDimension(thePlayer)
            interior = getElementInterior(thePlayer)
            jblmao[thePlayer] = createObject(2102,0,0,0) 
            setElementDimension(jblmao[thePlayer], dimensao)
            setElementInterior(jblmao[thePlayer], interior )
            setElementData(thePlayer, "rocketz:jbl", true)
            setObjectScale ( jblmao[thePlayer], 1.00)
            exports.bone_attach:attachElementToBone(jblmao[thePlayer],thePlayer,12,0,0,0.4,0,180,0)
            setElementDimension(jblmao[thePlayer], dimensao)
            setElementInterior(jblmao[thePlayer], interior )
            setElementData(thePlayer, "rocketz:flood", true)
            message(thePlayer, "Tomaste el parlante.", "success")
            setTimer(function ()
                setElementData(thePlayer, "rocketz:flood", nil)
            end, 2000, 1)
        else
            message(thePlayer, "Aguarde un poco.", "error")
        end
    else
        if getElementData(thePlayer, "rocketz:flood") ~= true then
            setElementData(thePlayer, "rocketz:jbl", nil)
            destroyElement(jblmao[thePlayer])
            local jblmao = jblmao[thePlayer]
            triggerClientEvent(root, "pararmsc", root, thePlayer, jblmao)
            setElementData(thePlayer, "rocketz:flood", true)
            setTimer(function ()
                setElementData(thePlayer, "rocketz:flood", nil)
            end, 2000, 1)
        else
            message(thePlayer, "Aguarde un poco.", "error")
                    end
                end
            end
        end
        else
        outputChatBox("No tienes un parlante, compralo en un 24/7", thePlayer, 255, 255, 255, true)
    end
end
addCommandHandler(configjbl, jbl)
function soltarjbl(thePlayer, x, y, z)
    local x, y, z = getElementPosition(thePlayer)
    local rx, ry, rz = getElementRotation(thePlayer)
    if getElementData(thePlayer, "rocketz:jbl") == true then
        if getElementData(thePlayer, "rocketz:flood") == true then
            message(thePlayer, "Aguarde un poco.", "error")
        else
            setElementData(thePlayer, "rocketz:jbl", "chao")
            setPedAnimation(thePlayer, "bomber", "BOM_Plant_Loop", -1, true, false, false)
            setElementData(thePlayer, "rocketz:flood", true)
            setTimer(function ()
            setPedAnimation(thePlayer)
            exports.bone_attach:detachElementFromBone(jblmao[thePlayer], thePlayer)
            moveObject(jblmao[thePlayer], 0,x, y, z-1)
            tempCol[thePlayer] = createColSphere (x, y, z, 2)
            message(thePlayer, "Soltaste el Parlante.", "success")
            setTimer(function ()
                setElementData(thePlayer, "rocketz:flood", nil)
            end, 2000, 1)
        end, 500, 1)
    end
    else
        message(thePlayer, "No tenes un parlante en la mano.", "error")
    end
end
addCommandHandler(configsoltarjbl, soltarjbl)
function pegarjblchao(thePlayer)
    if getElementData(thePlayer, "rocketz:jbl") == "chao" then
        if isElementWithinColShape(thePlayer, tempCol[thePlayer]) then
            if getElementData(thePlayer, "rocketz:flood") == true then
                message(thePlayer, "Espere um pouco!", "error")
            else
                setPedAnimation(thePlayer, "bomber", "BOM_Plant_Loop", -1, true, false, false)
                setElementData(thePlayer, "rocketz:flood", true)
                setTimer(function ()
                    setPedAnimation(thePlayer)
                    setElementData(thePlayer, "rocketz:jbl", true)
                    exports.bone_attach:attachElementToBone(jblmao[thePlayer],thePlayer,12,0,0,0.4,0,180,0)
                    destroyElement(tempCol[thePlayer])
                    message(thePlayer, "Tiraste el parlante.", "success")
                setTimer(function ()
                    setElementData(thePlayer, "rocketz:flood", nil)
                end, 2000, 1)
                end, 500, 1)
            end
        end
    end
end
addCommandHandler(configpegarjbl , pegarjblchao)
    
function setmusica(thePlayer, command, url)
    if getElementData(thePlayer, "rocketz:jbl") == true then
        if not url then
            message(thePlayer, "usa /musica [URL]", "error")
        else
        local x, y, z = getElementPosition(jblmao[thePlayer])
        local jblmao = jblmao[thePlayer]
        message(thePlayer, "Você colocou uma música na sua JBL.", "success")
        triggerClientEvent(root, "tocarmsc", thePlayer, thePlayer, url, x, y , z, jblmao)
        end
    end
end
addCommandHandler(configsetmusica, setmusica)
function setTex(thePlayer, command, texture)
    if getElementData(thePlayer, "rocketz:flood") == true then
        message(thePlayer, "Aguarde um pouco.", "error")
    else
        if getElementData(thePlayer, "rocketz:jbl") == true then
            if not texture then
                message(thePlayer, "Use /cambiarparlante [textura]", "error")
            else
                local jblmao = jblmao[thePlayer]
                setElementData(thePlayer, "rocketz:flood", true)
                triggerEvent("server->applyTextureJBL", thePlayer, jblmao, texture)
                message(thePlayer, "Textura cambiada!", "success")
                setTimer(function ()
                    setElementData(thePlayer, "rocketz:flood", nil)
                end, 2000, 1)
            end
        else
            message(thePlayer, "No tiene un parlante en la mano!", "error")
        end
    end
end
addCommandHandler(configsettextura, setTex)
function stopmusica(thePlayer)
    local jblmao = jblmao[thePlayer]
    triggerClientEvent(root, "pararmsc", root, thePlayer, jblmao)
    message(thePlayer, "Tiraste tu Parlante.", "success")
end
addCommandHandler(configpararmusica, stopmusica)
function stopScript()
    for k, v in ipairs(getElementsByType("player")) do 
        setElementData(v, "rocketz:jbl", nil)
        setElementData(v, "rocketz:flood", nil)
    end
end
addEventHandler("onResourceStop", getResourceRootElement(getThisResource()), stopScript)
function startScript()
    for k, v in ipairs(getElementsByType("player")) do 
        setElementData(v, "rocketz:jbl", nil)
        setElementData(v, "rocketz:flood", nil)
    end
end
addEventHandler("onResourceStart", getResourceRootElement(getThisResource()), startScript)
function quitPlayer()
    local jblValue = getElementData(source, "rocketz:jbl")
    if jblValue == true or jblValue == "chao" then
        if jblmao[source] and isElement(jblmao[source]) then
            exports.bone_attach:detachElementFromBone(jblmao[source], source)
            moveObject(jblmao[source], 1000, 0, 0, 0) -- Cambiado el tiempo para que el objeto se mueva durante 1 segundo (1000 milisegundos)
            destroyElement(jblmao[source])
            triggerClientEvent(root, "pararmsc", root, source, jblmao[source])
        end
        if tempCol[source] and isElement(tempCol[source]) then
            destroyElement(tempCol[source])
        end
    end
end
addEventHandler("onPlayerQuit", root, quitPlayer)
function message(player, message, type)
    triggerClientEvent(player, "N3xT.dxNotification", resourceRoot, message, type)
end