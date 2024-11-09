textsToDraw = {}
maxrange = 10

addEventHandler("onClientRender", root,
    function()
        local screenWidth, screenHeight = guiGetScreenSize()
        local playerX, playerY, playerZ = getElementPosition(localPlayer)
        
        for _, b in ipairs(textsToDraw) do
            local x, y, z = b[1], b[2], b[3]
            local scx, scy = getScreenFromWorldPosition(x, y, z + 1)

            local distance = getDistanceBetweenPoints3D(playerX, playerY, playerZ, x, y, z)
            if scx and scy and distance <= maxrange then
                dxDrawFramedText(b[4], scx, scy - 1, screenWidth, screenHeight, tocolor(b[5], b[6], b[7], 255), 1.3, "sans")
            end
        end
    end
)

function AgregarTextoMarcadores(x, y, z, text, r, g, b)
    table.insert(textsToDraw, {x, y, z, text, r, g, b})
end

function dxDrawFramedText(message, left, top, width, height, color, scale, font)
    local frameColor = tocolor(0, 0, 0, 255)

    dxDrawText(message, left + 1, top + 1, width + 1, height + 1, frameColor, scale, font, "left", "top", false, false, false, true)
end

AgregarTextoMarcadores(1294.861328125, -989.2109375, 32.6953125, "#FFFFFF[#FF0000OOC#FFFFFF] Utiliza #0BD000/tienda #FFFFFFpara comprar armas.", 255, 255, 255, true, true, true)

AgregarTextoMarcadores(1295.02734375, -981.9453125, 32.6953125, "#FFFFFF[#FF0000OOC#FFFFFF] Utiliza #0BD000/comprar mascara #FFFFFFpara comprar una mascara", 255, 255, 255, true, true, true)

--------------------------------------------------------------------------------------------------
