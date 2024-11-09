
-- Costos

CNick = {450} -- Cambio Nick (Coins)

VIP1 = {15,200} -- VIP Comun (Dias/Coins)
VIP2 = {30,350} -- VIP Comun (Dias/Coins)
VIP3 = {60,550} -- VIP Comun (Dias/Coins)

VIPC1 = {15,380} -- VIP + (Dias/Coins)
VIPC2 = {30,750} -- VIP + (Dias/Coins)
VIPC3 = {60,1000} -- VIP + (Dias/Coins)

--

local screenW, screenH = guiGetScreenSize()

local sx,sy = screenW/1920, screenH/1080

local dxFuenteCoins = dxCreateFont("files/CollegeSans.ttf", 10*sy)

local img = dxCreateTexture("files/cambioNombrenextlife.png", "dxt5", true, "clamp")

local DatoCoins_,Ventana_,InCoins = 0,"Paquetes VIP",false

-- No Tocar (Anti-Spam)

local tick_antes, tick = nil, nil
local AntiSpamSkin = false

--


addEventHandler("onClientRender", root,
    function()
        if InCoins ~= false then
            if Ventana_ == "Paquetes VIP" then
                dxDrawRectangle(560*sx, 290*sy, 800*sx, 500*sy, tocolor(0, 0, 0, 220), false)
                dxDrawRectangle(570*sx, 342*sy, 576*sx, 420*sy, tocolor(213, 96, 0, 200), false)
                dxDrawRectangle(570*sx, 318*sy, 126*sx, 24*sy, tocolor(189, 85, 0, 220), false)
                dxDrawRectangle(700*sx, 318*sy, 126*sx, 24*sy, tocolor(189, 85, 0, 220), false)
                dxDrawRectangle(830*sx, 318*sy, 126*sx, 24*sy, tocolor(189, 85, 0, 220), false)
                dxDrawText("Paquetes VIP", 572*sx, 320*sy, 692*sx, 338*sy, tocolor(255, 255, 255, 255), 1.00, dxFuenteCoins, "center", "center", false, false, false, false, false)
                dxDrawImage(1230*sx, 352*sy, 44*sx, 42*sy, ":nlcoins/files/Next_life_logo.png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
                dxDrawText("NLCoins: "..DatoCoins_, 1156*sx, 398*sy, 1348*sx, 422*sy, tocolor(255, 255, 255, 255), 1.00, dxFuenteCoins, "center", "center", false, false, false, false, false)
                dxDrawText("Paquetes VIP+", 702*sx, 320*sy, 822*sx, 338*sy, tocolor(255, 255, 255, 255), 1.00, dxFuenteCoins, "center", "center", false, false, false, false, false)
                dxDrawText("Cambios", 832*sx, 320*sy, 952*sx, 338*sy, tocolor(255, 255, 255, 255), 1.00, dxFuenteCoins, "center", "center", false, false, false, false, false)
                dxDrawImage(610*sx, 432*sy, 138*sx, 144*sy, ":nlcoins/files/nextcoinspsd.png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
                dxDrawText("VIP "..VIP1[1].." Dias", 593*sx, 390*sy, 757*sx, 426*sy, tocolor(255, 255, 255, 255), 1.00, dxFuenteCoins, "center", "center", false, false, false, false, false)
                dxDrawText("[ "..VIP1[2].." Coins ]", 594*sx, 582*sy, 757*sx, 618*sy, tocolor(255, 255, 255, 255), 1.00, dxFuenteCoins, "center", "center", false, false, false, false, false)
                dxDrawText("[ "..VIP2[2].." Coins ]", 780*sx, 582*sy, 944*sx, 618*sy, tocolor(255, 255, 255, 255), 1.00, dxFuenteCoins, "center", "center", false, false, false, false, false)
                dxDrawImage(796*sx, 432*sy, 138*sx, 144*sy, ":nlcoins/files/nextcoinspsd.png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
                dxDrawText("VIP "..VIP2[1].." Dias", 780*sx, 390, 944*sx, 426, tocolor(255, 255, 255, 255), 1.00, dxFuenteCoins, "center", "center", false, false, false, false, false)
                dxDrawImage(974*sx, 432*sy, 138*sx, 144*sy, ":nlcoins/files/nextcoinspsd.png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
                dxDrawText("VIP "..VIP3[1].." Dias", 958*sx, 390*sy, 1122*sx, 426*sy, tocolor(255, 255, 255, 255), 1.00, dxFuenteCoins, "center", "center", false, false, false, false, false)
                dxDrawText("[ "..VIP3[2].." Coins ]", 958*sx, 582*sy, 1122*sx, 618*sy, tocolor(255, 255, 255, 255), 1.00, dxFuenteCoins, "center", "center", false, false, false, false, false)
                dxDrawRectangle(626*sx, 634*sy, 98*sx, 24*sy, tocolor(189, 85, 0, 220), false)
                dxDrawRectangle(812*sx, 634*sy, 98*sx, 24*sy, tocolor(189, 85, 0, 220), false)
                dxDrawRectangle(990*sx, 634*sy, 98*sx, 24*sy, tocolor(189, 85, 0, 220), false)
                dxDrawText("Comprar", 594*sx, 628*sy, 757*sx, 664*sy, tocolor(255, 255, 255, 255), 1.00, dxFuenteCoins, "center", "center", false, false, false, false, false)
                dxDrawText("Comprar", 780*sx, 628*sy, 944*sx, 664*sy, tocolor(255, 255, 255, 255), 1.00, dxFuenteCoins, "center", "center", false, false, false, false, false)
                dxDrawText("Comprar", 958*sx, 628*sy, 1122*sx, 664*sy, tocolor(255, 255, 255, 255), 1.00, dxFuenteCoins, "center", "center", false, false, false, false, false)
                dxDrawText("¡Recuerda que no hay vuelta atras!", 570*sx, 698*sy, 1146*sx, 738*sy, tocolor(255, 255, 255, 255), 1.00, dxFuenteCoins, "center", "center", false, false, false, false, false)
                dxDrawText("¡Bienvenido a la Store!", 1156*sx, 698*sy, 1349*sx, 696*sy, tocolor(255, 255, 255, 255), 1.00, dxFuenteCoins, "center", "center", false, false, false, false, false)
            elseif Ventana_ == "Paquetes VIP+" then
                dxDrawRectangle(560*sx, 290*sy, 800*sx, 500*sy, tocolor(0, 0, 0, 220), false)
                dxDrawRectangle(570*sx, 342*sy, 576*sx, 420*sy, tocolor(213, 96, 0, 200), false)
                dxDrawRectangle(570*sx, 318*sy, 126*sx, 24*sy, tocolor(189, 85, 0, 220), false)
                dxDrawRectangle(700*sx, 318*sy, 126*sx, 24*sy, tocolor(189, 85, 0, 220), false)
                dxDrawRectangle(830*sx, 318*sy, 126*sx, 24*sy, tocolor(189, 85, 0, 220), false)
                dxDrawText("Paquetes VIP", 572*sx, 320*sy, 692*sx, 338*sy, tocolor(255, 255, 255, 255), 1.00, dxFuenteCoins, "center", "center", false, false, false, false, false)
                dxDrawImage(1230*sx, 352*sy, 44*sx, 42*sy, ":nlcoins/files/Next_life_logo.png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
                dxDrawText("NLCoins: "..DatoCoins_, 1156*sx, 398*sy, 1348*sx, 422*sy, tocolor(255, 255, 255, 255), 1.00, dxFuenteCoins, "center", "center", false, false, false, false, false)
                dxDrawText("Paquetes VIP+", 702*sx, 320*sy, 822*sx, 338*sy, tocolor(255, 255, 255, 255), 1.00, dxFuenteCoins, "center", "center", false, false, false, false, false)
                dxDrawText("Cambios", 832*sx, 320*sy, 952*sx, 338*sy, tocolor(255, 255, 255, 255), 1.00, dxFuenteCoins, "center", "center", false, false, false, false, false)
                dxDrawImage(610*sx, 432*sy, 138*sx, 144*sy, ":nlcoins/files/nextcoincolor.png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
                dxDrawText("VIP+ "..VIPC1[1].." Dias", 593*sx, 390*sy, 757*sx, 426*sy, tocolor(255, 255, 255, 255), 1.00, dxFuenteCoins, "center", "center", false, false, false, false, false)
                dxDrawText("[ "..VIPC1[2].." Coins ]", 594*sx, 582*sy, 757*sx, 618*sy, tocolor(255, 255, 255, 255), 1.00, dxFuenteCoins, "center", "center", false, false, false, false, false)
                dxDrawText("[ "..VIPC2[2].." Coins ]", 780*sx, 582*sy, 944*sx, 618*sy, tocolor(255, 255, 255, 255), 1.00, dxFuenteCoins, "center", "center", false, false, false, false, false)
                dxDrawImage(796*sx, 432*sy, 138*sx, 144*sy, ":nlcoins/files/nextcoincolor.png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
                dxDrawText("VIP+ "..VIPC2[1].." Dias", 780*sx, 390*sy, 944*sx, 426*sy, tocolor(255, 255, 255, 255), 1.00, dxFuenteCoins, "center", "center", false, false, false, false, false)
                dxDrawImage(974*sx, 432*sy, 138*sx, 144*sy, ":nlcoins/files/nextcoincolor.png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
                dxDrawText("VIP+ "..VIPC3[1].." Dias", 958*sx, 390*sy, 1122*sx, 426*sy, tocolor(255, 255, 255, 255), 1.00, dxFuenteCoins, "center", "center", false, false, false, false, false)
                dxDrawText("[ "..VIPC3[2].." Coins ]", 958*sx, 582*sy, 1122*sx, 618*sy, tocolor(255, 255, 255, 255), 1.00, dxFuenteCoins, "center", "center", false, false, false, false, false)
                dxDrawRectangle(626*sx, 634*sy, 98*sx, 24*sy, tocolor(189, 85, 0, 220), false)
                dxDrawRectangle(812*sx, 634*sy, 98*sx, 24*sy, tocolor(189, 85, 0, 220), false)
                dxDrawRectangle(990*sx, 634*sy, 98*sx, 24*sy, tocolor(189, 85, 0, 220), false)
                dxDrawText("Comprar", 594*sx, 628*sy, 757*sx, 664*sy, tocolor(255, 255, 255, 255), 1.00, dxFuenteCoins, "center", "center", false, false, false, false, false)
                dxDrawText("Comprar", 780*sx, 628*sy, 944*sx, 664*sy, tocolor(255, 255, 255, 255), 1.00, dxFuenteCoins, "center", "center", false, false, false, false, false)
                dxDrawText("Comprar", 958*sx, 628*sy, 1122*sx, 664*sy, tocolor(255, 255, 255, 255), 1.00, dxFuenteCoins, "center", "center", false, false, false, false, false)
                dxDrawText("¡Recuerda que no hay vuelta atras!", 570*sx, 698*sy, 1146*sx, 738*sy, tocolor(255, 255, 255, 255), 1.00, dxFuenteCoins, "center", "center", false, false, false, false, false)
                dxDrawText("¡Bienvenido a la Store!", 1156*sx, 698*sy, 1349*sx, 696*sy, tocolor(255, 255, 255, 255), 1.00, dxFuenteCoins, "center", "center", false, false, false, false, false)          
            elseif Ventana_ == "Cambios" then
                dxDrawRectangle(560*sx, 290*sy, 800*sx, 500*sy, tocolor(0, 0, 0, 220), false)
                dxDrawRectangle(1156*sx, 698*sy, 192*sx, 26*sy, tocolor(191, 86, 0, 240), false)
                dxDrawRectangle(570*sx, 342*sy, 576*sx, 420*sy, tocolor(213, 96, 0, 200), false)
                dxDrawRectangle(570*sx, 318*sy, 126*sx, 24*sy, tocolor(189, 85, 0, 220), false)
                dxDrawRectangle(700*sx, 318*sy, 126*sx, 24*sy, tocolor(189, 85, 0, 220), false)
                dxDrawRectangle(830*sx, 318*sy, 126*sx, 24*sy, tocolor(189, 85, 0, 220), false)
                dxDrawText("Paquetes VIP", 572*sx, 320*sy, 692*sx, 338*sy, tocolor(255, 255, 255, 255), 1.00, dxFuenteCoins, "center", "center", false, false, false, false, false)
                dxDrawImage(1230*sx, 352*sy, 44*sx, 42*sy, ":nlcoins/files/Next_life_logo.png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
                dxDrawText("NLCoins: "..DatoCoins_, 1156*sx, 398*sy, 1348*sx, 422*sy, tocolor(255, 255, 255, 255), 1.00, dxFuenteCoins, "center", "center", false, false, false, false, false)
                dxDrawText("Paquetes VIP+", 702*sx, 320*sy, 822*sx, 338*sy, tocolor(255, 255, 255, 255), 1.00, dxFuenteCoins, "center", "center", false, false, false, false, false)
                dxDrawText("Cambios", 832*sx, 320*sy, 952*sx, 338*sy, tocolor(255, 255, 255, 255), 1.00, dxFuenteCoins, "center", "center", false, false, false, false, false)
                dxDrawImage(610*sx, 432*sy, 138*sx, 144*sy, ":nlcoins/files/cambioNombrenextlife.png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
                dxDrawText("Cambio de\nNombre/Apellido", 593*sx, 390*sy, 757*sx, 426*sy, tocolor(255, 255, 255, 255), 1.00, dxFuenteCoins, "center", "center", false, false, false, false, false)
                dxDrawText("[ 450 Coins ]", 594*sx, 582*sy, 757*sx, 618*sy, tocolor(255, 255, 255, 255), 1.00, dxFuenteCoins, "center", "center", false, false, false, false, false)

                dxDrawRectangle(626*sx, 634*sy, 98*sx, 24*sy, tocolor(189, 85, 0, 220), false)
                dxDrawText("Comprar", 594*sx, 628*sy, 757*sx, 664*sy, tocolor(255, 255, 255, 255), 1.00, dxFuenteCoins, "center", "center", false, false, false, false, false)
                dxDrawText("¡Recuerda que no hay vuelta atras!", 570*sx, 698*sy, 1146*sx, 738*sy, tocolor(255, 255, 255, 255), 1.00, dxFuenteCoins, "center", "center", false, false, false, false, false)
                dxDrawText("¡Cambia tu nombre Aqui!", 1156*sx, 664*sy, 1349*sx, 696*sy, tocolor(255, 255, 255, 255), 1.00, dxFuenteCoins, "center", "center", false, false, false, false, false)
                --dxDrawRectangle(1156*sx, 732*sy, 192*sx, 26*sy, tocolor(213, 96, 0, 220), false)
                dxDrawEditBox("newnick", "* Nombre_Apellido", 1156*sx, 698*sy, 192*sx, 26*sy, dxFuenteCoins, false, 22, 255, 255, 255, tocolor(240,240,240,190), "left", true)
                --dxDrawText("Min:8 | Max:22\n", 1156*sx, 730*sy, 1348*sx, 760*sy, tocolor(255, 255, 255, 255), 1.00, dxFuenteCoins, "center", "center", false, false, false, false, false)      
            end
        end
    end
)


addEventHandler ( "onClientClick", root,
function (button, state, absoluteX, absoluteY, worldX, worldY, worldZ, clickedElement)
    if (state == "down") and (button == "left") then 
        if InCoins ~= false then 
            if isMouseInPosition ( 570*sx, 318*sy, 126*sx, 24*sy ) then -- Ventanas
                if Ventana_ ~= "Paquetes VIP" then
                    Ventana_ = "Paquetes VIP"
                end
            end
            if isMouseInPosition ( 700*sx, 318*sy, 126*sx, 24*sy ) then -- Ventanas
                if Ventana_ ~= "Paquetes VIP+" then
                    Ventana_ = "Paquetes VIP+"
                end
            end
            if isMouseInPosition( 830*sx, 318*sy, 126*sx, 24*sy ) then -- Ventanas
                if Ventana_ ~= "Cambios" then
                    Ventana_ = "Cambios"
                end
            end
            if not tick_antes or ( getTickCount() - tick_antes ) > 5000 then
                if Ventana_ == "Paquetes VIP" then
                    if isMouseInPosition( 626*sx, 634*sy, 98*sx, 24*sy ) then -- Cambios 1
                        tick_antes = getTickCount()
                        triggerServerEvent("NL:BuyItemsCoins",localPlayer,localPlayer,"Paquetes VIP",VIP1[1],VIP1[2])
                    end
                    if isMouseInPosition( 812*sx, 634*sy, 98*sx, 24*sy ) then -- Cambios 2 
                        tick_antes = getTickCount()
                        triggerServerEvent("NL:BuyItemsCoins",localPlayer,localPlayer,"Paquetes VIP",VIP2[1],VIP2[2])
                    end 
                    if isMouseInPosition( 990*sx, 634*sy, 98*sx, 24*sy ) then -- Cambios 3 
                        tick_antes = getTickCount()
                        triggerServerEvent("NL:BuyItemsCoins",localPlayer,localPlayer,"Paquetes VIP",VIP3[1],VIP3[2])
                    end    
                end
                if Ventana_ == "Paquetes VIP+" then
                    if isMouseInPosition( 626*sx, 634*sy, 98*sx, 24*sy ) then -- Cambios 1
                        tick_antes = getTickCount()
                        triggerServerEvent("NL:BuyItemsCoins",localPlayer,localPlayer,"Paquetes VIP+",15,380)
                    end
                    if isMouseInPosition( 812*sx, 634*sy, 98*sx, 24*sy ) then -- Cambios 2 
                        tick_antes = getTickCount()
                        triggerServerEvent("NL:BuyItemsCoins",localPlayer,localPlayer,"Paquetes VIP+",30,750)
                    end 
                    if isMouseInPosition( 990*sx, 634*sy, 98*sx, 24*sy ) then -- Cambios 3 
                        tick_antes = getTickCount()
                        triggerServerEvent("NL:BuyItemsCoins",localPlayer,localPlayer,"Paquetes VIP+",60,1000)
                    end    
                end
                if Ventana_ == "Cambios" then
                    if isMouseInPosition( 626*sx, 634*sy, 98*sx, 24*sy ) then -- Cambios 1
                        local nombre = editGetText("newnick")
                        if (nombre) and nombre ~= "" then
                            if string.find(nombre,"_") then
                                if #nombre >= 8 and #nombre <= 22 then
                                    if nombre ~= "Nombre_Apellido" then
                                        tick_antes = getTickCount()
                                        triggerServerEvent("NL:BuyItemsCoins",localPlayer,localPlayer,"CambioNick",tostring(nombre),CNick[1])
                                    else
                                        triggerEvent("addTextMessage3D",localPlayer,"Ingresa un nombre #F58A02Valido #ffffff!",255,255,255)
                                        setSound(3)
                                    end
                                else
                                    triggerEvent("addTextMessage3D",localPlayer,"Ingresa un #F58A02Nombre Valido Con (Min:8/Max:22) Caracteres#ffffff!",255,255,255)
                                    setSound(3)                                    
                                end
                            else
                                triggerEvent("addTextMessage3D",localPlayer,"Ingresa un nombre correctamente #F58A02[Nombre_Apellido] #ffffff!",255,255,255)
                                setSound(3)
                            end
                        else
                            triggerEvent("addTextMessage3D",localPlayer,"Ingresa un #F58A02Nombre Valido#ffffff!",255,255,255)
                            setSound(3)
                        end
                    end
                    --[[
                    if isMouseInPosition( 812*sx, 634*sy, 98*sx, 24*sy ) then -- Cambios 2 
                        tick_antes = getTickCount()
                    end 
                    if isMouseInPosition( 990*sx, 634*sy, 98*sx, 24*sy ) then -- Cambios 3 
                        tick_antes = getTickCount()
                    end    
                    ]]
                end
            else
                outputChatBox( "Espera un momento, Compra con calma !!", 255, 0, 0, true )
            end
        end
    end
end)


function gCoins(player,coins)
    if isElement(player) then
        if source == player then
            DatoCoins_ = tonumber(coins)
            if InCoins == false then
                InCoins = true
                showCursor(true)
            else
                InCoins = false
                showCursor(false)
            end
        end
    end
end
addEvent("NL:ShowCoins",true)
addEventHandler("NL:ShowCoins",root,gCoins)

function setSound(t)
    if t == 1 then
        sound = playSound(":nlogin/files/sounds/enter.mp3")
        setSoundVolume(sound, 0.8)
    elseif t == 2 then
        sound = playSound(":nlogin/files/sounds/back.wav")
        setSoundVolume(sound, 0.8)
    elseif t == 3 then
        sound = playSound(":nlogin/files/sounds/notification.mp3")
        setSoundVolume(sound, 0.8)
    end
end

function dxDrawRectangleBorde(left, top, width, height, color, postgui)
    if not postgui then
        postgui = false;
    end
    left, top = left + 2, top + 2;
    width, height = width - 2, height - 2;
    dxDrawRectangle(left - 2, top, 2, height, color, postgui);
    dxDrawRectangle(left + width, top, 2, height, color, postgui);
    dxDrawRectangle(left, top - 2, width, 2, color, postgui);
    dxDrawRectangle(left, top + height, width, 2, color, postgui);
    dxDrawRectangle(left - 1, top - 1, 1, 1, color, postgui);
    dxDrawRectangle(left + width, top - 1, 1, 1, color, postgui);
    dxDrawRectangle(left - 1, top + height, 1, 1, color, postgui);
    dxDrawRectangle(left + width, top + height, 1, 1, color, postgui);
    dxDrawRectangle(left, top, width, height, color, postgui);
end

function isMouseInPosition ( x, y, width, height )
    if ( not isCursorShowing( ) ) then
        return false
    end
    local sx, sy = guiGetScreenSize ( )
    local cx, cy = getCursorPosition ( )
    local cx, cy = ( cx * sx ), ( cy * sy )
    if ( cx >= x and cx <= x + width ) and ( cy >= y and cy <= y + height ) then
        return true
    else
        return false
    end
end

function isEventHandlerAdded( sEventName, pElementAttachedTo, func )
    if type( sEventName ) == 'string' and isElement( pElementAttachedTo ) and type( func ) == 'function' then
        local aAttachedFunctions = getEventHandlers( sEventName, pElementAttachedTo )
        if type( aAttachedFunctions ) == 'table' and #aAttachedFunctions > 0 then
            for i, v in ipairs( aAttachedFunctions ) do
                if v == func then
                    return true
                end
            end
        end
    end
    return false
end
