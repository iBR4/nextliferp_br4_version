local sx, sy = guiGetScreenSize()
local scaleX, scaleY = sx / 1366, sy / 768

local carga = 0
local cargaMaxima = 100
local mostrarRectangles = false
local tiempoDeRelleno = 1500

local inicioRelleno = 0
local bloquearDisparo = false

addEventHandler("onClientRender", root,
    function()
        if mostrarRectangles then
            local width = 70 * scaleX
            local height = 5 * scaleY

            local x = (sx - width) / 2
            local y = (sy - height) / 1.2

            dxDrawRectangle(x, y, width, height, tocolor(0, 0, 0, 141), false)

            local tiempoTranscurrido = getTickCount() - inicioRelleno
            local cargaWidth = (tiempoTranscurrido / tiempoDeRelleno) * width

            cargaWidth = math.min(cargaWidth, width)

            dxDrawRectangle(x, y, cargaWidth, height, tocolor(254, 254, 254, 141), false)

            if cargaWidth >= width then
                mostrarRectangles = false
                bloquearDisparo = false
            end
        end
    end
)

addEventHandler("onClientPlayerWeaponSwitch", root,
    function(prevSlot, newSlot)
        if newSlot ~= 0 then
            mostrarRectangles = true
            bloquearDisparo = true

            inicioRelleno = getTickCount()
        else
            mostrarRectangles = false
            bloquearDisparo = false
        end
    end
)

addEventHandler("onClientKey", root,
    function(key, state)
        if mostrarRectangles and bloquearDisparo and key == "mouse1" and state then
            cancelEvent()
        end
    end
)
