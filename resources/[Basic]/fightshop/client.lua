

---------------</Resolucion>

local screenW, screenH = guiGetScreenSize()

local x, y = (screenW/1366), (screenH/768)

------------------</Fontes>

local font1 = dxCreateFont("gfx/font.ttf", 15)

local font2 = dxCreateFont("gfx/font.ttf", 14)

local font3 = dxCreateFont("gfx/font2.ttf", 10)

---------------</Função>

luta = false

function fight()

--------------</Ismousepostion>------------------

		color1 = tocolor(1, 131, 241, 170)

		color2 = tocolor(1, 131, 241, 170)

		color3 = tocolor(1, 131, 241, 170)

		color4 = tocolor(1, 131, 241, 170)

		color5 = tocolor(1, 131, 241, 170)

		color6 = tocolor(1, 131, 241, 170)			

        if ismouseinposition (x*510,y*417,x*115,y*39) then color1 = tocolor(1, 131, 241, 255) end

        if ismouseinposition (x*510,y*480,x*115,y*39) then color2 = tocolor(1, 131, 241, 255) end

        if ismouseinposition (x*652,y*417,x*115,y*39) then color3 = tocolor(1, 131, 241, 255) end

        if ismouseinposition (x*652,y*480,x*115,y*39) then color4 = tocolor(1, 131, 241, 255) end

        if ismouseinposition (x*788,y*417,x*115,y*39) then color5 = tocolor(1, 131, 241, 255) end

        if ismouseinposition (x*788,y*480,x*115,y*39) then color6 = tocolor(1, 131, 241, 255) end

	    dxDrawBorder(x*510,y*417,x*115,y*39,tocolor(0,0,0,215),2)

	    dxDrawBorder(x*510,y*480,x*115,y*39,tocolor(0,0,0,215),2)

	    dxDrawBorder(x*652,y*417,x*115,y*39,tocolor(0,0,0,215),2)

	    dxDrawBorder(x*652,y*480,x*115,y*39,tocolor(0,0,0,215),2)

	    dxDrawBorder(x*788,y*417,x*115,y*39,tocolor(0,0,0,215),2)

	    dxDrawBorder(x*788,y*480,x*115,y*39,tocolor(0,0,0,215),2)

        dxDrawRectangle(x*510,y*417,x*115,y*39,color1, true) --luta1

        dxDrawRectangle(x*510,y*480,x*115,y*39,color2, true)---luta2

        dxDrawRectangle(x*652,y*417,x*115,y*39,color3, true)---luta3

        dxDrawRectangle(x*652,y*480,x*115,y*39,color4, true)--luta4

        dxDrawRectangle(x*788,y*417,x*115,y*39,color5, true)--luta5

        dxDrawRectangle(x*788,y*480,x*115,y*39,color6, true)---luta6

        ---------------------------------<end>------------------------------------

        dxDrawRectangle(x*487,y*220,x*422,y*357, tocolor(0, 0, 0, 135), false)

	    dxDrawBorder(x*487,y*220,x*422,y*357,tocolor(0,0,0,215),2)

        dxDrawRectangle(x*487,y*186,x*422,y*34, tocolor(1, 131, 241, 170), false)

	    dxDrawBorder(x*487,y*186,x*422,y*34,tocolor(0,0,0,215),2)

        dxDrawImage(x*625,y*236,x*168,y*171, "gfx/icon1.png", 0, 0, 0, tocolor(255, 255, 255, 255), false)

        dxDrawText("Estilos de Pelea",x*656,y*190,x*760,y*216, tocolor(255, 255, 255, 255), 1.00,font1, "left", "top", false, false, true, false, false)

        dxDrawText("Normal",x*533,y*427,x*602,y*446, tocolor(255, 255, 255, 255), 1.00, font2, "left", "top", false, false, true, false, false)

        dxDrawText("Boxing",x*538,y*490,x*597,y*514, tocolor(255, 255, 255, 255), 1.00,font2, "left", "top", false, false, true, false, false)

        dxDrawText("Kung-Fu",x*672,y*427,x*749,y*446, tocolor(255, 255, 255, 255), 1.00,font2, "left", "top", false, false, true, false, false)

        dxDrawText("Rodillazo",x*662,y*490,x*739,y*509, tocolor(255, 255, 255, 255), 1.00,font2, "left", "top", false, false, true, false, false)

        dxDrawText("Patada",x*802,y*427,x*893,y*450, tocolor(255, 255, 255, 255), 1.00,font2, "left", "top",false, false, true, false, false)

        dxDrawText("Codazo",x*812,y*490,x*879,y*509, tocolor(255, 255, 255, 255), 1.00,font2, "left", "top",false, false, true, false, false)

        dxDrawText("x",x*888,y*191,x*903,y*210, tocolor(255, 255, 255, 255), 1.00,font2, "left", "top",false, false, true, false, false)

  --------------------------------<Preços>---------------------------------------------

        dxDrawText("$ : 100",x*538,y*456,x*607,y*475, tocolor(255, 255, 255, 255), 1.00,font3, "left", "top", false, false, true, false, false)

        dxDrawText("$ : 600",x*538,y*519,x*607,y*538, tocolor(255, 255, 255, 255), 1.00,font3, "left", "top", false, false, true, false, false)

        dxDrawText("$ : 800",x*680,y*456,x*749,y*475, tocolor(255, 255, 255, 255), 1.00,font3, "left", "top", false, false, true, false, false)

        dxDrawText("$ : 300",x*680,y*524,x*749,y*543, tocolor(255, 255, 255, 255), 1.00,font3, "left", "top", false, false, true, false, false)

        dxDrawText("$ : 200",x*824,y*456,x*893,y*475, tocolor(255, 255, 255, 255), 1.00,font3, "left", "top", false, false, true, false, false)

        dxDrawText("$ : 150",x*824,y*524,x*893,y*543, tocolor(255, 255, 255, 255), 1.00,font3, "left", "top", false, false, true, false, false)

end

---------------</Função de Luta >



function fechar(_,state)

if luta then

if state == "down" then

if isCursorOnElement (x*888,y*191,x*903,y*210) then

showCursor(false)

setCameraTarget(g_localPlayer, g_localPlayer)

removeEventHandler("onClientRender", root,fight)

luta = false

showChat(true)

end

end

end

end

addEventHandler ("onClientClick", root, fechar)



function luta1(_,state)

if luta then

if state == "down" then

if isCursorOnElement (x*510,y*417,x*115,y*39) then

triggerServerEvent ("luta1", getLocalPlayer())

end

end

end

end

addEventHandler ("onClientClick", root, luta1)



function luta2(_,state)

if luta then

if state == "down" then

if isCursorOnElement (x*510,y*480,x*115,y*39) then

triggerServerEvent ("luta2", getLocalPlayer())

end

end

end

end

addEventHandler ("onClientClick", root, luta2)



function luta3(_,state)

if luta then

if state == "down" then

if isCursorOnElement (x*652,y*417,x*115,y*39) then

triggerServerEvent ("luta3", getLocalPlayer())

end

end

end

end

addEventHandler ("onClientClick", root, luta3)



function luta4(_,state)

if luta then

if state == "down" then

if isCursorOnElement (x*652,y*480,x*115,y*39) then

triggerServerEvent ("luta4", getLocalPlayer())

end

end

end

end

addEventHandler ("onClientClick", root, luta4)



function luta5(_,state)

if luta then

if state == "down" then

if isCursorOnElement (x*788,y*417,x*115,y*39) then

triggerServerEvent ("luta5", getLocalPlayer())

end

end

end

end

addEventHandler ("onClientClick", root, luta5)



function luta6(_,state)

if luta then

if state == "down" then

if isCursorOnElement (x*788,y*480,x*115,y*39) then

triggerServerEvent ("luta6", getLocalPlayer())

end

end

end

end

addEventHandler ("onClientClick", root, luta6)



function abrir (_,state)

if luta == false then

showCursor(true)

addEventHandler("onClientRender", root,fight)

luta = true

end

end

addEvent ("abrir",true)

addEventHandler ("abrir", root, abrir)



---------------</Função Is mouse Mudar cor do Butão>

function ismouseinposition ( x, y, width, height )

    if ( not isCursorShowing ( ) ) then

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



function cursorPosition(x, y, w, h)

	if (not isCursorShowing()) then

		return false

	end

	local mx, my = getCursorPosition()

	local fullx, fully = guiGetScreenSize()

	cursorx, cursory = mx*fullx, my*fully

	if cursorx > x and cursorx < x + w and cursory > y and cursory < y + h then

		return true

	else

		return false

	end

end



local x,y = guiGetScreenSize()



function isCursorOnElement(x,y,w,h)

	local mx,my = getCursorPosition ()

	local fullx,fully = guiGetScreenSize()

	cursorx,cursory = mx*fullx,my*fully

	if cursorx > x and cursorx < x + w and cursory > y and cursory < y + h then

		return true

	else

		return false

	end

end



function dxDrawBorder(posX, posY,posW,posH,color,scale)

    dxDrawLine(posX, posY, posX+posW, posY, color, scale,false)

    dxDrawLine(posX, posY, posX, posY+posH, color, scale,false)

    dxDrawLine(posX, posY+posH, posX+posW, posY+posH, color, scale,false)

    dxDrawLine(posX+posW, posY, posX+posW, posY+posH, color, scale,false)

end

