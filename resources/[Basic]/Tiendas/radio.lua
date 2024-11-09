
function frecuencia(thePlayer, cmd, frecuencia)
    if getPlayerItem(thePlayer,"Radio") == 1 then
        if frecuencia then
            local frecuenciaB = tonumber(frecuencia)
            if frecuenciaB then
                if (frecuencia:len() == 4) then
                    setElementData(thePlayer, "frecuencia", frecuencia)
                    setAccountData(getPlayerAccount(thePlayer), "frecuencia", frecuencia)
                    outputChatBox("#0065BF[Radio] #FFFFFFTu frecuencia fue cambiada a: #00FF00"..tostring(frecuencia).."Hz", thePlayer, 0, 255, 0, true)
                else
                    outputChatBox("#0065BF[Radio] #FFFFFFLa frecuencia debe tener un total de 4 numeros, nada mas ni nada menos.", thePlayer, 0, 255, 0, true)
                end
            else
                outputChatBox("#0065BF[Radio] #FFFFFFLa frecuencia debe ser de numeros, no letras.", thePlayer, 0, 255, 0, true)
            end
        else
            outputChatBox("/"..cmd.." <numero>", thePlayer, 255, 0, 0, true)
        end
    else
     outputChatBox("No tienes un radio comprala en un 24/7", thePlayer, 255, 255, 255, true)
    end
end
addCommandHandler("frecuencia", frecuencia)
addCommandHandler("hz", frecuencia)
function radio( player, cmd, ... )
    if player:getData("Muerto") == true then
        outputChatBox("No puedes usar este comando mientras estás muerto.", player, 255, 0, 0, true)
        return
    end
    
    local msg = table.concat( { ... }, ' ' )
    local a = _getPlayerNameR( player )
    
    if msg then
        if getPlayerItem(player,"Radio") == 1 then
            if tonumber(player:getData("frecuencia")) then
                local myhz = getElementData( player, 'frecuencia' )
                outputDebugString("#0065BF[Radio #"..myhz.."Hz] #FFFCD1[ING] "..a.." dice: #FFFFFF"..msg, 0, 38, 232, 34)
                for _, p in pairs( getElementsByType( 'player' ) ) do
                     local youhz = getElementData( p, 'frecuencia' ) or 0
                    if youhz == myhz then
                        outputChatBox("#0065BF[Radio #"..myhz.."Hz] #FFFCD1[ING] "..a.." dice: #FFFFFF"..msg, p, 255, 255, 255, true)
                        player:setData("TextInfo", {"> Habla por la radio",178, 140, 214})
                        setTimer(function(p)
                            if isElement(p) then
                                p:setData("TextInfo", {"",178, 140, 214})
                            end
                        end, 4000, 1, player)
                    end          
                end
            else
                player:outputChat("Primero selecciona una frecuencia antes",255,0,0,true)
            end
        else
            outputChatBox("No tienes un radio, cómpralo en un 24/7.", player, 255, 255, 255, true)
        end
    else
        outputChatBox("No puedes hablar por la radio si no proporcionas un mensaje.", player, 255, 255, 255, true)
    end
end
addCommandHandler("radio", radio)
addCommandHandler("r", radio)
