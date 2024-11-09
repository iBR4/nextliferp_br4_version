marker_100 = createMarker(2104.5451660156, -1808.2277832031, 12.5,"cylinder",1.0, 255, 9, 0, 100)--Pizzeria
marker_101 = createMarker(2046.4508056641, -1910.6734619141, 12.5,"cylinder",1.0, 255, 9, 0, 100)--Licencias
marker_102 = createMarker(1832.2204589844, -1844.9476318359, 12.5,"cylinder",1.0, 255, 9, 0, 100)--Unity
marker_103 = createMarker(1419.6940917969, -1620.6721191406, 12.5,"cylinder",1.0, 255, 9, 0, 100)--Anuncios
marker_104 = createMarker(2479.9826660156, -1756.9849853516, 12.5,"cylinder",1.0, 255, 9, 0, 100)--Conce motos
marker_105 = createMarker(2115.5876464844, -1117.1667480469, 24.3,"cylinder",1.0, 255, 9, 0, 100)--Conce jefferson
marker_106 = createMarker(1034.9536132812, -982.80639648438, 41.6,"cylinder",1.0, 255, 9, 0, 100)--Temple
marker_107 = createMarker(594.62689208984, -1245.7709960938, 17,"cylinder",1.0, 255, 9, 0, 100)--Conce autos caros
marker_108 = createMarker(360.34307861328, -1753.1081542969, 4.6,"cylinder",1.0, 255, 9, 0, 100)--Playa
marker_109 = createMarker(1072.3005371094, -1860.9221191406, 12.5,"cylinder",1.0, 255, 9, 0, 100)--Verona
marker_109 = createMarker(1104.873046875, -1370.8922119141, 13,"cylinder",1.0, 255, 9, 0, 100)--Conce Camioneta
marker_110 = createMarker(459.04180908203, -91.134963989258, 998.6,"cylinder",1.0, 255, 9, 0, 100)--Conce Camioneta
setElementInterior( marker_110, 4) -- Coloca el numero de interior
setElementDimension( marker_110, 0 ) -- Coloca el numero de dimension
createBlip(1072.1343994141, -1860.7145996094, 13, 12, 2, 255, 0, 0, 255, 0, 200, getRootElement() )--Verona
createBlip(360.34307861328, -1753.1081542969, 13, 12, 2, 255, 0, 0, 255, 0, 200, getRootElement() )--Playa
createBlip(1034.9536132812, -982.80639648438, 13, 12, 2, 255, 0, 0, 255, 0, 200, getRootElement() )--Temple
    function createBankWindow()
    	local tempLbl
        BankWdw = guiCreateWindow(10, 250, 250, 250, "Banco de los santos", false)
		tempLbl = guiCreateLabel( 0.08, 0.12, 1, 1, "Nombre de cuenta: "..getPlayerName(localPlayer), true, BankWdw )
		guiSetFont( tempLbl, "default-bold-small" )
		tempLblll = guiCreateLabel( 0.08, 0.24, 1, 1,"Dinero en banco: $"..tostring(getElementData(localPlayer,"Roleplay:bank_balance")), true, BankWdw )
		guiSetFont( tempLblll, "default-bold-small" )
		tempLbll = guiCreateLabel( .06, .89, .5, .1, "version: 1.0", true, BankWdw )
		guiSetFont( tempLbll, "default-bold-small" )
        Tapanel = guiCreateTabPanel(0, 0.4, 1, 0.46, true, BankWdw)
        WithTap = guiCreateTab("Retiros", Tapanel)
        cantidad = guiCreateLabel( 0.03, 0.09, 1, 1, "Cantidad:", true, WithTap )
		guiSetFont( cantidad, "default-bold-small" )
        withdraw = guiCreateEdit(0.28, 0.05, 0.7, 0.25, "", true, WithTap)
        guiSetFont( withdraw, "default-bold-small" )
		guiEditSetMaxLength( withdraw, 8 )
        withbtn = guiCreateButton(0.018, 0.71, 0.45, 0.25, "Retirar dinero", true, WithTap)
        guiSetProperty( withbtn, "HoverTextColour", "FFFFFF00" )
        guiSetFont( withbtn, "default-bold-small" )
        withallbtn = guiCreateButton(0.498, 0.71, 0.48, 0.25, "Retirar todo", true, WithTap)
        guiSetFont( withallbtn, "default-bold-small" )
		guiSetProperty( withallbtn, "HoverTextColour", "FFFFFF00" )
        DepTap = guiCreateTab("Depositos", Tapanel)
        Deposi = guiCreateLabel( 0.03, 0.09, 1, 1, "Cantidad:", true, DepTap )
		guiSetFont( Deposi, "default-bold-small" )
        depositedit = guiCreateEdit(0.28, 0.05, 0.7, 0.25, "", true, DepTap)
        guiSetFont( depositedit, "default-bold-small" )
		guiEditSetMaxLength( depositedit, 8 )
        depositbtn = guiCreateButton(0.018, 0.71, 0.45, 0.25, "Depositar dinero", true, DepTap)
        guiSetFont( depositbtn, "default-bold-small" )
        guiSetProperty( depositbtn, "HoverTextColour", "FF00FF00" )
        depositallbtn = guiCreateButton(0.498, 0.71, 0.48, 0.25, "Depositar todo", true, DepTap)
        guiSetFont( depositallbtn, "default-bold-small" )
		guiSetProperty( depositallbtn, "HoverTextColour", "FF00FF00" )
------------------------------------------------------------------------------------
        TransTap = guiCreateTab("Transferencias", Tapanel)
		guiSetEnabled(TransTap,true)
        useredit = guiCreateEdit( 0.28, 0.05, 0.70, 0.25, "", true, TransTap)
        guiSetFont( useredit, "default-bold-small" )
		guiEditSetMaxLength( useredit, 24 )
        transuser = guiCreateLabel(0.03, 0.09, 1, 1, "Enviar a:", true, TransTap)
        guiSetFont( transuser, "default-bold-small" )
        transamount = guiCreateLabel( 0.03, 0.41, 1, 1, "Cantidad:", true, TransTap)
        guiSetFont( transamount, "default-bold-small" )
        amountedit = guiCreateEdit(0.28, 0.37, 0.7, 0.25, "", true, TransTap)
        transbtn = guiCreateButton(0.018, 0.71, 0.45, 0.25, "Transferir", true, TransTap)
        guiSetFont( transbtn, "default-bold-small" )
        guiSetProperty( transbtn, "HoverTextColour", "FF00FFDD" )
-------------------------------------------------------------------------------------------------
        closeBtn = guiCreateButton(0.5, 0.87, 0.5, 0.2, "Cerrar", true, BankWdw)
       	guiSetProperty( closeBtn, "HoverTextColour", "FFFF0000" )
		guiSetFont( closeBtn, "default-bold-small" )
showCursor(true)
guiSetInputEnabled(not guiGetInputEnabled())
addEventHandler("onClientGUIClick",depositbtn,depoistMoney,false)		
addEventHandler("onClientGUIClick",withbtn,withdrawMoney,false)	
addEventHandler("onClientGUIClick",withallbtn,withdrawAllMoney,false)	
addEventHandler("onClientGUIClick",depositallbtn,depositAllMoney,false)		
addEventHandler("onClientGUIClick",transbtn,transferMoney,false)			
addEventHandler("onClientGUIClick",closeBtn,hide,false)		
    end
addEvent("createBankWindow", true)
addEventHandler("createBankWindow", getLocalPlayer(), createBankWindow)
function showGUI(hitElement)
triggerEvent("createBankWindow",hitElement)
end
addEventHandler("onClientMarkerHit", marker_100,showGUI)
addEventHandler("onClientMarkerHit", marker_101,showGUI)
addEventHandler("onClientMarkerHit", marker_102,showGUI)
addEventHandler("onClientMarkerHit", marker_103,showGUI)
addEventHandler("onClientMarkerHit", marker_104,showGUI)
addEventHandler("onClientMarkerHit", marker_105,showGUI)
addEventHandler("onClientMarkerHit", marker_106,showGUI)
addEventHandler("onClientMarkerHit", marker_107,showGUI)
addEventHandler("onClientMarkerHit", marker_108,showGUI)
addEventHandler("onClientMarkerHit", marker_109,showGUI)
addEventHandler("onClientMarkerHit", marker_110,showGUI)
-- addEventHandler("onClientMarkerHit", marker_111,showGUI)
-- addEventHandler("onClientMarkerHit", marker_112,showGUI)
function hide()
guiSetVisible(BankWdw,false)
guiSetInputEnabled(not guiGetInputEnabled())
showCursor(false)
end
function setZero()
if getElementData(localPlayer,"Roleplay:bank_balance") == false or getElementData(localPlayer,"Roleplay:bank_balance") == nil then
setElementData(localPlayer,"Roleplay:bank_balance",0)
end
end
addEventHandler("onClientRender",root,setZero)
function depoistMoney()
local text = guiGetText(depositedit)
local curr = getElementData(localPlayer,"Roleplay:bank_balance")
if tonumber(text) and getPlayerMoney(localPlayer) >= tonumber(text) and tonumber(text) >= 0 then
triggerServerEvent("onDepositHit",localPlayer,text)
setElementData(localPlayer,"Roleplay:bank_balance",tonumber(text + curr))
outputChatBox("#FFFFFF [#0076FF Banco #FFFFFF] Has depositado exitosamente #02BF09$"..tonumber(text)..".", 255, 255, 255, true)
dxDrawRectangle(717, 352, 168, 42, tocolor(0, 255, 0, 255), false)
elseif getPlayerMoney(localPlayer) < tonumber(text) then
outputChatBox("#FFFFFF [#0076FF Banco #FFFFFF] No tienes tanto dinero.", 255, 255, 255, true)
dxDrawRectangle(717, 352, 168, 42, tocolor(0, 255, 0, 255), false)
elseif tonumber(text) < 0 then
outputChatBox("#FFFFFF [#0076FF Banco #FFFFFF] No puedes depositar numeros negativos.", 255, 255, 255, true)
dxDrawRectangle(717, 352, 168, 42, tocolor(0, 255, 0, 255), false)
end
end
function withdrawMoney()
    -- Obtiene el texto de algún elemento de la interfaz de usuario
    local text = guiGetText(withdraw)
    
    -- Obtiene el saldo bancario del jugador
    local curr = getElementData(localPlayer, "Roleplay:bank_balance")
    
    -- Comprueba si el texto ingresado es un número válido y si el saldo es suficiente
    if tonumber(curr) >= tonumber(text) and tonumber(text) > 0 then
        -- Envía un evento al servidor para manejar la retirada de dinero
        triggerServerEvent("onWithdrawHit", localPlayer, text)
        
        -- Actualiza el saldo del jugador después de la retirada
        setElementData(localPlayer, "Roleplay:bank_balance", tonumber(curr) - tonumber(text))
        
        -- Muestra un mensaje en el chat indicando la cantidad retirada
        outputChatBox("#FFFFFF [#0076FF Banco #FFFFFF] Has retirado del banco #02BF09$" .. tonumber(text) .. ".", 255, 255, 255, true)
        
        -- Intento de dibujar un rectángulo en la pantalla (se debe llamar en un contexto de renderizado)
        dxDrawRectangle(717, 308, 168, 42, tocolor(0, 255, 0, 255), false)
    elseif tonumber(curr) < tonumber(text) then
        -- Si el saldo es insuficiente, muestra un mensaje en el chat
        outputChatBox("#FFFFFF [#0076FF Banco #FFFFFF] No tienes tanto dinero.", 255, 255, 255, true)
        
        -- Intento de dibujar un rectángulo en la pantalla (se debe llamar en un contexto de renderizado)
        dxDrawRectangle(717, 308, 168, 42, tocolor(0, 255, 0, 255), false)
    elseif tonumber(text) < 0 then
        -- Si se ingresa una cantidad negativa, muestra un mensaje en el chat
        outputChatBox("#FFFFFF [#0076FF Banco #FFFFFF] No puedes retirar números negativos.", 255, 255, 255, true)
        
        -- Intento de dibujar un rectángulo en la pantalla (se debe llamar en un contexto de renderizado)
        dxDrawRectangle(717, 308, 168, 42, tocolor(0, 255, 0, 255), false)
    end
end
function withdrawAllMoney()
local curr = getElementData(localPlayer,"Roleplay:bank_balance")
triggerServerEvent("onWithdrawAllHit",localPlayer,curr)
setElementData(localPlayer,"Roleplay:bank_balance",0)
outputChatBox("#FFFFFF [#0076FF Banco #FFFFFF] Ha retirado con éxito todo el dinero de la cuenta bancaria.", 255, 255, 255, true)
dxDrawRectangle(381, 420, 168, 42, tocolor(0, 255, 0, 255), false)
end
function depositAllMoney()
    -- Obtiene el dinero del jugador
    local money = getPlayerMoney(localPlayer)
    
    -- Obtiene el saldo bancario del jugador
    local curr = getElementData(localPlayer, "Roleplay:bank_balance")
    
    -- Suma el dinero del jugador al saldo bancario
    setElementData(localPlayer, "Roleplay:bank_balance", tonumber(money) + tonumber(curr))
    
    -- Envía un evento al servidor para manejar el depósito de todo el dinero
    triggerServerEvent("onDepositAllHit", localPlayer, money)
    outputChatBox("#FFFFFF [#0076FF Banco #FFFFFF] Ha depositado exitosamente todo su dinero en su cuenta bancaria.", 255, 255, 255, true)
    
    -- Intento de dibujar un rectángulo en la pantalla (se debe llamar en un contexto de renderizado)
    dxDrawRectangle(717, 420, 168, 42, tocolor(0, 255, 0, 255), false)
end
function transferMoney()
local money = tonumber(guiGetText(amountedit))
local sourceMoney = getElementData(getLocalPlayer(),"Roleplay:bank_balance")
local name = guiGetText(useredit)
local receiver = getPlayerFromName(name)
local receiverMoney = getElementData(receiver,"Roleplay:bank_balance")
if receiver ~= localPlayer and sourceMoney >= money and money >= 0 then
local revMoney  = getElementData(receiver,"Roleplay:bank_balance")
local sorMoney = getElementData(getLocalPlayer(),"Roleplay:bank_balance")
setTimer(setElementData,1000,1,receiver,"Roleplay:bank_balance",revMoney + money)
setElementData(localPlayer,"Roleplay:bank_balance",sorMoney - money)
end
end