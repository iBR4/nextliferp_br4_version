local panel  -- Variable para almacenar el elemento del panel

function mostrarPanelComprarCoins()
    showCursor(true)  -- Mostrar el mouse
    guiSetInputMode("no_binds_when_editing")  -- Desactivar la edición del panel

    local screenWidth, screenHeight = guiGetScreenSize()
    local panelWidth = screenWidth * 0.6
    local panelHeight = screenHeight * 0.4
    local panelX = (screenWidth - panelWidth) / 2
    local panelY = (screenHeight - panelHeight) / 2

    panel = guiCreateWindow(panelX, panelY, panelWidth, panelHeight, "Comprar Monedas", false)
    guiWindowSetSizable(panel, false)  -- Desactivar la capacidad de cambiar el tamaño del panel
    local label = guiCreateLabel(0.1, 0.1, 0.8, 0.6, "¡Bienvenido a la tienda de New Horizon!", true, panel)
    guiLabelSetHorizontalAlign(label, "center", true)

    local imageWidth = panelWidth * 0.5
    local imageHeight = panelHeight * 0.8
    local imageX = (panelWidth - imageWidth) / 2
    local imageY = 30
    local image = guiCreateStaticImage(imageX, imageY, imageWidth, imageHeight, "imagenes/coins.png", false, panel)
    -- Reemplaza "ruta/imagen.png" con la ruta y nombre de tu imagen

    local comprarButton = guiCreateButton(0.4, 0.8, 0.2, 0.1, "Comprar coins", true, panel)
    addEventHandler("onClientGUIClick", comprarButton, mostrarURLCompra, false)

    local closeButton = guiCreateButton(0.9, 0.9, 0.1, 0.1, "Cerrar", true, panel)
    addEventHandler("onClientGUIClick", closeButton, cerrarPanelComprarCoins, false)

    guiSetVisible(panel, true)
end

function mostrarURLCompra()
    outputChatBox("#FF9B13[#FFFFFFNext Life#FF9B13] #FFFFFFPara comprar #FF9B13Nextcoins #FFFFFFvisita nuestro #FF9B13Discord #FFFFFFen la categoria de #FF9B13Tiendas.", 255, 255,255, true)  -- Reemplaza con la URL del sitio web de compra de monedas
end

function cerrarPanelComprarCoins()
    showCursor(false)  -- Ocultar el mouse
    guiSetInputMode("allow_binds")  -- Restaurar la edición normal

    if isElement(panel) then
        destroyElement(panel)
    end
end

function iniciarPanelComprarCoins()
    addCommandHandler("comprarcoins", mostrarPanelComprarCoins)
end
addEventHandler("onClientResourceStart", resourceRoot, iniciarPanelComprarCoins)

