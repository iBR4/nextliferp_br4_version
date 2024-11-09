
--[[


    ███╗░░██╗███████╗██╗░░██╗████████╗  ██╗░░░░░██╗███████╗███████╗
    ████╗░██║██╔════╝╚██╗██╔╝╚══██╔══╝  ██║░░░░░██║██╔════╝██╔════╝
    ██╔██╗██║█████╗░░░╚███╔╝░░░░██║░░░  ██║░░░░░██║█████╗░░█████╗░░
    ██║╚████║██╔══╝░░░██╔██╗░░░░██║░░░  ██║░░░░░██║██╔══╝░░██╔══╝░░
    ██║░╚███║███████╗██╔╝╚██╗░░░██║░░░  ███████╗██║██║░░░░░███████╗
    ╚═╝░░╚══╝╚══════╝╚═╝░░╚═╝░░░╚═╝░░░  ╚══════╝╚═╝╚═╝░░░░░╚══════╝ Client.lua

]]

-- Configurables

-- Configurable Personajes

LimitePersonajes = 3 -- Limite de creación maximos
pRespawnx,pRespawnY,pRespawnZ = 1743.095703125, -1861.3359375, 13.577640533447 -- Posicion Respawn Nuevos
pRotX,pRotY,pRotZ = 0, 0, 358.47012329102 -- Rotacion Respawn Nuevos
pInt,pDim = 0,0 -- Interior/Dimension Nuevos
pMoneyNew = 1500000 -- Dinero Nuevos
pVida,pChaleco = 100,0 -- Basicos


--

function dataFecha()
    local time = getRealTime() 
    local Dia,Mes,Siclo,Hora,Min = time.monthday,time.month,time.year +1900,time.hour,time.minute
    
    if #tostring(Dia) == 1 then
        Dia = "0"..Dia
    end
    if #tostring(Mes) == 1 then
        Mes = "0"..Mes
    end
    
    local Fecha = Dia.."/"..Mes.."/"..Siclo..""
    return Fecha
end


local allowed = { { 48, 57 }, { 65, 90 }, { 97, 122 } } -- numbers/lowercase chars/uppercase chars

function generateString ( len )
    
    if tonumber ( len ) then
        math.randomseed ( getTickCount () )

        local str = ""
        for i = 1, len do
            local charlist = allowed[math.random ( 1, 3 )]
            str = str .. string.char ( math.random ( charlist[1], charlist[2] ) )
        end

        return str
    end
    
    return false
    
end

if localPlayer then

function importarObjetos()
    txd = engineLoadTXD("files/models/PenthouseLS.txd")
    col = engineLoadCOL("files/models/PenthouseLS.col")
    dff = engineLoadDFF("files/models/PenthouseLS.dff")
    idObjeto = engineRequestModel("object")
    engineImportTXD(txd, idObjeto)
    engineReplaceCOL(col, idObjeto)
    engineReplaceModel(dff, idObjeto)
    engineSetModelLODDistance(idObjeto, 2000)
end
addEventHandler("onClientResourceStart", getResourceRootElement(getThisResource()), importarObjetos)

--[[
ObjetoTest = createObject(idObjeto, 1692.73828125, -1420.396484375, 91.529800415039)
setElementDimension( ObjetoTest, 0 )
setElementInterior( ObjetoTest, 0 )
setElementRotation( ObjetoTest, 0, 0, 90)
local Posicion_SpawnTest = {1700.994140625, -1428.6181640625, 87.232925415039, 0, 0, 47.074371337891} -- x,y,z rotX,rotY,rotZ
local RatioData = {dim = 0, int = 0} -- Dimension,Interior
PedTest = createPed( 0, Posicion_SpawnTest[1],Posicion_SpawnTest[2],Posicion_SpawnTest[3])
setElementDimension( PedTest, 0 )
setElementInterior( PedTest, 0 )
setElementRotation( PedTest, Posicion_SpawnTest[4],Posicion_SpawnTest[5],Posicion_SpawnTest[6])
]]
-------------------------------------------------------------------------------------------------------------------------------------

------------------------------------------- Notificaciones System -------------------------------------------------------------------

function sendMessage(text,r,g,b)
    triggerEvent("addTextMessage3D",localPlayer,text,r,g,b)
end

local screenW, screenH = guiGetScreenSize()
local sx, sy = screenW/1360, screenH/768
local sX,sY = guiGetScreenSize()

local DXSystem = {}

local desplazo = 3700

function addTextLogin(text,r,g,b)

    if (type(text) ~= "string" or type(r) ~= "number" or type(g) ~= "number" or type(b) ~= "number") then return outputConsole("[Noxium:MessagesConfigLogin] Datos incorrectos enviados intente nuevamente.", source) end

    for i,data in ipairs(DXSystem) do
        if data[1] == text then
            data[3] = data[3] + 1
            return
        end
    end

    if (#DXSystem > 1 ) then 
        table.remove(DXSystem, 1) 
    end
 
    local tick = getTickCount()+desplazo

    table.insert(DXSystem, {text,tick,0,r,g,b})

    if (#DXSystem == 1) then
        addEventHandler("onClientRender", root, DXMessageInfo)
    end

    return true
end
addEvent("addTextMessage3D", true)
addEventHandler("addTextMessage3D", root, addTextLogin)

dxfont4_ref =  dxCreateFont(":nlogin/files/fonts/chalet.ttf", 8*sy)

function DXMessageInfo()
 
    if (#DXSystem == 0) then
        removeEventHandler("onClientRender", root, DXMessageInfo)
    end
    
    local toRemove = 0

    for i,data in ipairs(DXSystem) do
        if (data[2] > getTickCount()) then

            if i == 1 then
                if data[3] == 0 then
                    dxDrawBourdeText(1.0,data[1],1140*sx, 302*sy, 1356*sx, 328*sy, tocolor(data[4], data[5], data[6], 230), tocolor(0, 0, 0, 209), 1.00, dxfont4_ref, "right", "center", false, false, false, true, false)
                else
                    dxDrawBourdeText(1.0,data[1].." ["..data[3].."]",1140*sx, 302*sy, 1356*sx, 328*sy, tocolor(data[4], data[5], data[6], 230), tocolor(0, 0, 0, 209), 1.00, dxfont4_ref, "right", "center", false, false, false, true, false)
                end
            elseif i == 2 then
                if data[3] == 0 then
                    dxDrawBourdeText(1.0,data[1],1140*sx, 342*sy, 1356*sx, 328*sy, tocolor(data[4], data[5], data[6], 230), tocolor(0, 0, 0, 209), 1.00, dxfont4_ref, "right", "center", false, false, false, true, false)
                else
                    dxDrawBourdeText(1.0,data[1].." ["..data[3].."]",1140*sx, 342*sy, 1356*sx, 328*sy, tocolor(data[4], data[5], data[6], 230), tocolor(0, 0, 0, 209), 1.00, dxfont4_ref, "right", "center", false, false, false, true, false)              
                end
            elseif i == 3 then
                if data[3] == 0 then
                    dxDrawBourdeText(1.0,data[1],1140*sx, 382*sy, 1356*sx, 328*sy, tocolor(data[4], data[5], data[6], 230), tocolor(0, 0, 0, 209), 1.00, dxfont4_ref, "right", "center", false, false, false, true, false)
                else
                    dxDrawBourdeText(1.0,data[1].." ["..data[3].."]",1140*sx, 382*sy, 1356*sx, 328*sy, tocolor(data[4], data[5], data[6], 230), tocolor(0, 0, 0, 209), 1.00, dxfont4_ref, "right", "center", false, false, false, true, false)              
                end
            end

        else
            toRemove = toRemove + 1
        end
    end
    if (toRemove > 0) then
        for i=1,toRemove do
            table.remove(DXSystem, 1)
        end
    end
    local i = #DXSystem-1
end


--------------------------
local sx, sy = guiGetScreenSize()
local EditBox = {}
local editSelected;

addEvent('onEditBoxEnter')

function dxDrawEditBox(key, text, x, y, w, h, font, masked, max, r, g, b, spaces, color2, alignX, caretVisible)

    if not EditBox[key] then
        EditBox[key] = {
            text = '',
            max = max or -1,
            spaces = spaces or false,
            over = false
        }
    end

    local font = font or 'default-bold'
    local color2 = color2 or tocolor(30,30,30,100)
    local v = EditBox[key]

    if (#v.text == 0) then
        dxDrawText(text, x + 5, y, x + w - 10, y + h, color2, 1, font, (alignX or "center"), "center", true, false, false)
    end
    
    if (dxGetTextWidth(masked and string.gsub(v.text, ".", "•") or v.text, 1, font) <= w - 10) then
        dxDrawText(masked and string.gsub(v.text, ".", "•") or v.text, x + 5, y, x + w - 10, y + h, tocolor(r, g, b, 255), 1, font, "left", "center", true, false, false)
    else
        dxDrawText(masked and string.gsub(v.text, ".", "•") or v.text, x + 5, y, x + w - 10, y + h, tocolor(r, g, b, 255), 1, font, "right", "center", true, false, false)
    end
    
    if editSelected and editSelected == key and (caretVisible == nil or caretVisible == true) then
        if (dxGetTextWidth(masked and string.gsub(v.text, ".", "•") or v.text, 1, font) <= w - 10) then
            dxDrawLine(x + 5 + dxGetTextWidth(masked and string.gsub(v.text, ".", "•") or v.text, 1, font), y + 5, x + 5 + dxGetTextWidth(masked and string.gsub(v.text, ".", "•") or v.text, 1, font), y + h - 5, tocolor(r, g, b, math.abs(math.sin(getTickCount() / 255) * 255)), 1, false)
        else
            dxDrawLine(x + w - 10, y + 5, x + w - 10, y + h - 5, tocolor(r, g, b, math.abs(math.sin(getTickCount() / 255) * 255)), 1, false)
        end
    end
    
    if isCursorShowing() then
        local cx, cy = getCursorPosition()
        local cx, cy =(cx*sx),(cy*sy)
        v.over = (cx >= x and cx <= x + w) and (cy >= y and cy <= y + h)
    else
        v.over = false
    end

    if editSelected and editSelected == key then
        if getKeyState( 'backspace' ) then

            if not tickDelete or getTickCount(  ) - tickDelete >= 90 then

                if #v.text > 0 then
                    EditBox[key].text = EditBox[key].text:sub(1, #EditBox[key].text-1)
                end
                tickDelete = getTickCount(  )

            end
        else
            if tickDelete then
                tickDelete = nil
            end
        end
    end

    return EditBox[key].text
end
 

function editSetText(key, txt)
    if EditBox[key] then
        EditBox[key].text = txt
        return true
    end
    return false
end

function editGetText(key)
    return EditBox[key] and EditBox[key].text or false
end


function activeInputEditBox(key)
    editSelected = key
    if editSelected then
        guiSetInputEnabled( true )
        showCursor( true )
    else
        guiSetInputEnabled( false )
        showCursor( false )
    end
end

addEventHandler("onClientClick", getRootElement(),
    function(button, state, cx, cy)
        if (button == "left") and (state == "down") then

            local key
            for k, v in pairs(EditBox) do
                if v.over then
                    key = k
                    break
                end
            end

            if key and EditBox[key] then
                --guiSetInputMode("no_binds")
                guiSetInputEnabled( true )
                --showCursor( true )
                editSelected = key
            else
                --guiSetInputMode("allow_binds")
                if editSelected then
                    guiSetInputEnabled( false )
                    --showCursor( false )
                    editSelected = nil
                end
            end

        end
    end
)

addEventHandler("onClientCharacter", getRootElement(),
    function(c)
        if (isChatBoxInputActive()) or (isConsoleActive()) or (isMainMenuActive()) then
            return
        end

        for k, v in pairs(EditBox) do
            if v.over then
                key = k
                break
            end
        end

        local key = editSelected
        if key and EditBox[key] then
            if (EditBox[key].max == -1) or (#EditBox[key].text < EditBox[key].max) then
                if EditBox[key].spaces then
                    EditBox[key].text = EditBox[key].text..c
                else
                    if c ~= " " then
                        EditBox[key].text = EditBox[key].text..c
                    end
                end
            end
        end
    end
)

addEventHandler("onClientKey", getRootElement(),
    function(button, press)
        if (isChatBoxInputActive()) or (isConsoleActive()) or (isMainMenuActive()) then
            return
        end

        local key = editSelected
        if key and EditBox[key] then
            if (press) then
                if (button == "enter") then
                    triggerEvent('onEditBoxEnter', root, key, EditBox[key].text)
                end
            end
        end
    end
)

addEventHandler("onClientPaste", root, function(text2)
    local key = editSelected
    if key and EditBox[key] then
        EditBox[key].text = (EditBox[key].text or '') .. text2
    end
end)

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

function dxDrawBourdeText(lines, text, x, y, sx, sy, color, color2, size, font, alignX, alignY,clip, wordBreak, postGUI, colorCoded, subPixelPositioning, fRotation, fRotationCenterX, fRotationCenterY)
    local lines = lines or 2
    for i= -lines, lines, lines do
        for j= -lines, lines, lines do
            dxDrawText( text:gsub('#%x%x%x%x%x%x',''), x + i, y + j, sx + i, sy + j, color2, size, font, alignX, alignY, clip, wordBreak, postGUI, colorCoded, subPixelPositioning, fRotation, fRotationCenterX, fRotationCenterY)
        end
    end
    dxDrawText( text, x, y, sx, sy, color, size, font, alignX, alignY, clip, wordBreak, postGUI, colorCoded, subPixelPositioning, fRotation, fRotationCenterX, fRotationCenterY)
end

function math.cero(numero)
    if numero < 10 then return "0"..numero end
    return math.ceil(numero)
end

function convertNumber ( number )   
    local formatted = number   
    while true do   
    formatted, k = string.gsub(formatted, "^(-?%d+)(%d%d%d)", '%1,%2') 
        if ( k==0 ) then   
            break
        end   
    end   
    return formatted 
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

else


end