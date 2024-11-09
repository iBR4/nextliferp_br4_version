local screenX, screenY = guiGetScreenSize()
local panelVisible = false
local lastVersionShown = "0.0"
local configFilename = "config.xml"
local cornerRadius = 10

function drawRoundedRectangle(x, y, width, height, radius, color)
    dxDrawRectangle(x + radius, y, width - 2 * radius, height, color)
    dxDrawRectangle(x, y + radius, radius, height - 2 * radius, color)
    dxDrawRectangle(x + width - radius, y + radius, radius, height - 2 * radius, color)

    dxDrawCircle(x + radius, y + radius, radius, 180, 270, color, color, 20)
    dxDrawCircle(x + width - radius, y + radius, radius, 270, 360, color, color, 20)
    dxDrawCircle(x + radius, y + height - radius, radius, 90, 180, color, color, 20)
    dxDrawCircle(x + width - radius, y + height - radius, radius, 0, 90, color, color, 20)
end

function drawPanel(version)
    local panelColor = tocolor(52, 73, 94, 220)
    local textColor = tocolor(255, 255, 255, 255)
    local buttonColor = tocolor(231, 76, 60, 220)

    drawRoundedRectangle(screenX/2 - 150, screenY/2 - 75, 300, 150, cornerRadius, panelColor)
    dxDrawText("¡Nueva actualización!", screenX/2 - 145, screenY/2 - 70, screenX/2 + 145, screenY/2 - 40, textColor, 1.8, "default-bold", "center", "center")
    dxDrawText("Versión " .. version, screenX/2 - 145, screenY/2 - 35, screenX/2 + 145, screenY/2, textColor, 1.2, "default", "center", "center")
    drawRoundedRectangle(screenX/2 - 50, screenY/2 + 30, 100, 30, cornerRadius - 3, buttonColor)
    dxDrawText("Cerrar", screenX/2 - 50, screenY/2 + 30, screenX/2 + 50, screenY/2 + 60, textColor, 1, "default-bold", "center", "center")
end

function onClick(button, state)
    if button == "left" and state == "down" and panelVisible then
        local cursorX, cursorY = getCursorPosition()
        cursorX, cursorY = cursorX * screenX, cursorY * screenY

        if cursorX > screenX/2 - 50 and cursorX < screenX/2 + 50 and cursorY > screenY/2 + 30 and cursorY < screenY/2 + 60 then
            panelVisible = false
            showCursor(false)

            drawPanel(lastVersionShown)

            local configFile = xmlLoadFile(configFilename)
            if not configFile then
                configFile = xmlCreateFile(configFilename, "version")
            end
            xmlNodeSetAttribute(configFile, "version", lastVersionShown)
            xmlSaveFile(configFile)
            xmlUnloadFile(configFile)
        end
    end
end

function showPanel(version)
    panelVisible = true
    showCursor(true)
    lastVersionShown = version
end

local nuevaVersion = "0.1"

local configFile = xmlLoadFile(configFilename)
if configFile then
    lastVersionShown = xmlNodeGetAttribute(configFile, "version")
    xmlUnloadFile(configFile)
end

addEventHandler("onClientRender", root, function()
    if panelVisible then
        drawPanel(lastVersionShown)
    end
end)

addEventHandler("onClientClick", root, onClick)

addEventHandler("onClientPlayerSpawn", localPlayer, function()
    if not panelVisible and lastVersionShown ~= nuevaVersion then
        showPanel(nuevaVersion)
    end
end)
