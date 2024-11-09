
local screenW, screenH = guiGetScreenSize()
local sx, sy = screenW/1920, screenH/1080

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

function roundValue(value)
    local var = math.floor((value) + 0.5)
    return var
end

local components1 = { "ammo", "health", "weapon" , "money", "wanted", "area_name", "vehicle_name", "breath", "clock", "armour" }

addEventHandler("onClientRender", root,
    function()

        local loginstate = exports.nlogin:getStateLogin()
        if loginstate ~= false then return end
        if Save.HudBase ~= "No" then return end
        if not getElementData(localPlayer,"Comida") then return end
        if not getElementData(localPlayer,"Agua") then return end

        for _, component in ipairs( components1 ) do
            setPlayerHudComponentVisible( component, false )
        end

        local ammo = getPedTotalAmmo (getLocalPlayer()) - getPedAmmoInClip (getLocalPlayer()) or 0
        local Balas = getPedAmmoInClip (getLocalPlayer()).."/"..ammo

        time = getRealTime ()
        day = time.monthday
        mes = time.month    
        ano = time.year + 1900
        hour = time.hour
        mins = time.minute

        if day <= 9 then
            dia = "0"..day..""
        else
            dia = day
        end

        if mes <= 9 then
            mes = "0"..mes..""
        else
            mes = mes
        end

        if hour <= 9 then
            hora = "0"..hour..""
        else
            hora = hour
        end

        if mins <= 9 then
            minutos = "0"..mins..""
        else
            minutos = mins
        end

        --local money = ("%08d"):format(getPlayerMoney())
        local money = getPlayerMoney()


        if getPedStat (localPlayer, 24) == 1000 then
            saludBarra = (174)*(getElementHealth(localPlayer)/200)
        else
            saludBarra = (174)*(getElementHealth(localPlayer)/100)
        end

        --print(roundValue(getElementData(localPlayer,"Roleplay:stamina")))
       

        local chalecoBarra = (174)*(getPedArmor(localPlayer)/100)
        if roundValue(getElementData(localPlayer,"Roleplay:stamina")) > 100 then
            sprintBarra = (174)*((roundValue(getElementData(localPlayer,"Roleplay:stamina")) or 100)/106)
        else
            sprintBarra = (174)*((roundValue(getElementData(localPlayer,"Roleplay:stamina")) or 100)/100)
        end

        local x,y,z = getElementPosition(localPlayer)
        local zona = getZoneName( x,y,z, false )
        local ciudad = getZoneName( x,y,z, true )
        local bankmoney = (localPlayer:getData("Roleplay:bank_balance") or 0) -- ("%08d"):format((localPlayer:getData("Roleplay:bank_balance") or 0))

        dxDrawImage(1344*sx, 52*sy, 120*sx, 120*sy, ":Gamemode/img/"..getPedWeapon(getLocalPlayer())..".png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
        -- Vida
        dxDrawRectangle(1474*sx, 128*sy, 184*sx, 16*sy, tocolor(3, 0, 0, 207), false)
        dxDrawRectangle(1480*sx, 132*sy, 174*sx, 8*sy, tocolor(199, 0, 0, 193), false)
        dxDrawRectangle(1480*sx, 132*sy, saludBarra*sx, 8*sy, tocolor(199, 0, 0, 193), false)
        --
        --dxDrawText("   [    ]", 1466*sx, 62*sy, 1668*sx, 118*sy, tocolor(3, 0, 0, 207), 4.00, "default", "left", "center", false, false, false, false, false)
        dxDrawText("[", 1506*sx, 62*sy, 1668*sx, 118*sy, tocolor(3, 0, 0, 207), 4.00*sy, "default", "left", "center", false, false, false, false, false)
        dxDrawText("]", 1606*sx, 62*sy, 1668*sx, 118*sy, tocolor(3, 0, 0, 207), 4.00*sy, "default", "left", "center", false, false, false, false, false)
        dxDrawImage(1840*sx, 88*sy, 45*sx, 45*sy, ":nlconfig/files/extra/b1.png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
        dxDrawImage(1842*sx, 52*sy, 45*sx, 45*sy, ":nlconfig/files/extra/b2.png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
        dxDrawText(getElementData(localPlayer,"Comida").."%", (1850 - 1)*sx, (55 - 1)*sy, (1844 - 1)*sx, (93 - 1)*sy, tocolor(0, 0, 0, 255), 1.00*sy, "pricedown", "right", "center", false, false, false, false, false)
        dxDrawText(getElementData(localPlayer,"Comida").."%", (1850 + 1)*sx, (55 - 1)*sy, (1844 + 1)*sx, (93 - 1)*sy, tocolor(0, 0, 0, 255), 1.00*sy, "pricedown", "right", "center", false, false, false, false, false)
        dxDrawText(getElementData(localPlayer,"Comida").."%", (1850 - 1)*sx, (55 + 1)*sy, (1844 - 1)*sx, (93 + 1)*sy, tocolor(0, 0, 0, 255), 1.00*sy, "pricedown", "right", "center", false, false, false, false, false)
        dxDrawText(getElementData(localPlayer,"Comida").."%", (1850 + 1)*sx, (55 + 1)*sy, (1844 + 1)*sx, (93 + 1)*sy, tocolor(0, 0, 0, 255), 1.00*sy, "pricedown", "right", "center", false, false, false, false, false)
        dxDrawText(getElementData(localPlayer,"Comida").."%", 1850*sx, 55*sy, 1844*sx, 93*sy, tocolor(196, 189, 13, 254), 1.00*sy, "pricedown", "right", "center", false, false, false, false, false)
        dxDrawText(getElementData(localPlayer,"Agua").."%", (1850 - 1)*sx,( 94 - 1 )*sy, (1844 - 1)*sx, ( 132 - 1 )*sy, tocolor(0, 0, 0, 255), 1.00*sy, "pricedown", "right", "center", false, false, false, false, false)
        dxDrawText(getElementData(localPlayer,"Agua").."%", (1850 + 1)*sx,( 94 - 1 )*sy, (1844 + 1)*sx, ( 132 - 1 )*sy, tocolor(0, 0, 0, 255), 1.00*sy, "pricedown", "right", "center", false, false, false, false, false)
        dxDrawText(getElementData(localPlayer,"Agua").."%", (1850 - 1)*sx,( 94 + 1 )*sy, (1844 - 1)*sx, ( 132 + 1 )*sy, tocolor(0, 0, 0, 255), 1.00*sy, "pricedown", "right", "center", false, false, false, false, false)
        dxDrawText(getElementData(localPlayer,"Agua").."%", (1850 + 1)*sx,( 94 + 1 )*sy, (1844 + 1)*sx, ( 132 + 1 )*sy, tocolor(0, 0, 0, 255), 1.00*sy, "pricedown", "right", "center", false, false, false, false, false)
        dxDrawText(getElementData(localPlayer,"Agua").."%", 1850*sx, 94*sy, 1844*sx, 132*sy, tocolor(252, 74, 115, 254), 1.00*sy, "pricedown", "right", "center", false, false, false, false, false)
        dxDrawText(""..hora..":"..minutos.."", (1484 - 1)*sx, (68 - 1)*sy , (1644 - 1)*sx, (108 - 1)*sy , tocolor(0, 0, 0, 255), 1.00*sy, "pricedown", "center", "center", false, false, false, false, false)
        dxDrawText(""..hora..":"..minutos.."", (1484 + 1)*sx, (68 - 1)*sy , (1644 + 1)*sx, (108 - 1)*sy , tocolor(0, 0, 0, 255), 1.00*sy, "pricedown", "center", "center", false, false, false, false, false)
        dxDrawText(""..hora..":"..minutos.."", (1484 - 1)*sx, (68 + 1)*sy , (1644 - 1)*sx, (108 + 1)*sy , tocolor(0, 0, 0, 255), 1.00*sy, "pricedown", "center", "center", false, false, false, false, false)
        dxDrawText(""..hora..":"..minutos.."", (1484 + 1)*sx, (68 + 1)*sy , (1644 + 1)*sx, (108 + 1)*sy , tocolor(0, 0, 0, 255), 1.00*sy, "pricedown", "center", "center", false, false, false, false, false)
        dxDrawText(""..hora..":"..minutos.."", 1484*sx, 68*sy, 1644*sx, 108*sy, tocolor(255, 255, 255, 255), 1.00*sy, "pricedown", "center", "center", false, false, false, false, false)
        dxDrawText(""..dia.."/"..mes.."/"..ano, (1484 - 1)*sx , (78 - 1)*sy, (1644 - 1)*sx, (118 - 1)*sy, tocolor(0, 0, 0, 255), 1.00*sy, "default-bold", "center", "bottom", false, false, false, false, false)
        dxDrawText(""..dia.."/"..mes.."/"..ano, (1484 + 1)*sx , (78 - 1)*sy, (1644 + 1)*sx, (118 - 1)*sy, tocolor(0, 0, 0, 255), 1.00*sy, "default-bold", "center", "bottom", false, false, false, false, false)
        dxDrawText(""..dia.."/"..mes.."/"..ano, (1484 - 1)*sx , (78 + 1)*sy, (1644 - 1)*sx, (118 + 1)*sy, tocolor(0, 0, 0, 255), 1.00*sy, "default-bold", "center", "bottom", false, false, false, false, false)
        dxDrawText(""..dia.."/"..mes.."/"..ano, (1484 + 1)*sx , (78 + 1)*sy, (1644 + 1)*sx, (118 + 1)*sy, tocolor(0, 0, 0, 255), 1.00*sy, "default-bold", "center", "bottom", false, false, false, false, false)
        dxDrawText(""..dia.."/"..mes.."/"..ano, 1484*sx, 78*sy, 1644*sx, 118*sy, tocolor(255, 255, 255, 255), 1.00*sy, "default-bold", "center", "bottom", false, false, false, false, false)

        if getZoneName(x, y, z) == "Unknown" then
            zona = ""
            ciudad = ": En Interior"
        else
            ciudad = "\n"..getZoneName(x, y, z, true)
            zona = "("..getZoneName(x, y, z, false)..")"
        end
        --
        dxDrawText("Ubicacion "..ciudad.." "..zona, (1484 - 1)*sx, (10 - 1)*sy, (1644 - 1)*sx, (50 - 1)*sy, tocolor(0, 0, 0, 255), 1.00*sy, "default-bold", "center", "bottom", false, false, false, false, false)
        dxDrawText("Ubicacion "..ciudad.." "..zona, (1484 + 1)*sx, (10 - 1)*sy, (1644 + 1)*sx, (50 - 1)*sy, tocolor(0, 0, 0, 255), 1.00*sy, "default-bold", "center", "bottom", false, false, false, false, false)
        dxDrawText("Ubicacion "..ciudad.." "..zona, (1484 - 1)*sx, (10 + 1)*sy, (1644 - 1)*sx, (50 + 1)*sy, tocolor(0, 0, 0, 255), 1.00*sy, "default-bold", "center", "bottom", false, false, false, false, false)
        dxDrawText("Ubicacion "..ciudad.." "..zona, (1484 + 1)*sx, (10 + 1)*sy, (1644 + 1)*sx, (50 + 1)*sy, tocolor(0, 0, 0, 255), 1.00*sy, "default-bold", "center", "bottom", false, false, false, false, false)
        dxDrawText("Ubicacion "..ciudad.." "..zona, 1484*sx, 10*sy, 1644*sx, 50*sy, tocolor(255, 255, 255, 255), 1.00*sy, "default-bold", "center", "bottom", false, false, false, false, false)
        
        if isPedInWater(localPlayer) then
            local oxigenoBarra = (122)*((getPedOxygenLevel (localPlayer) or 0)/1002)
            -- Agua
            dxDrawRectangle(1664*sx, 128*sy, 129*sx, 16*sy, tocolor(3, 0, 0, 207), false)
            dxDrawRectangle(1668*sx, 132*sy, 122*sx, 8*sy, tocolor(27, 209, 168, 193), false)
            dxDrawRectangle(1668*sx, 132*sy, oxigenoBarra*sx, 8*sy, tocolor(27, 209, 168, 193), false)
            --
        end

        if chalecoBarra > 0 then
            -- Sprint
            dxDrawRectangle(1474*sx, 146*sy, 184*sx, 16*sy, tocolor(3, 0, 0, 207), false)
            dxDrawRectangle(1480*sx, 150*sy, 174*sx, 8*sy, tocolor(254, 254, 254, 193), false)
            dxDrawRectangle(1480*sx, 150*sy, chalecoBarra*sx, 8*sy, tocolor(254, 254, 254, 193), false)
            -- Chaleco
            dxDrawRectangle(1474*sx, 164*sy, 184*sx, 16*sy, tocolor(3, 0, 0, 207), false)
            dxDrawRectangle(1480*sx, 168*sy, 174*sx, 8*sy, tocolor(255,69,0, 193), false)
            dxDrawRectangle(1480*sx, 168*sy, sprintBarra*sx, 8*sy, tocolor(255,69,0, 193), false)
            --
        else
            -- Sprint
            dxDrawRectangle(1474*sx, 146*sy, 184*sx, 16*sy, tocolor(3, 0, 0, 207), false)
            dxDrawRectangle(1480*sx, 150*sy, 174*sx, 8*sy, tocolor(255,69,0, 193), false)
            dxDrawRectangle(1480*sx, 150*sy, sprintBarra*sx, 8*sy, tocolor(255,69,0, 193), false)
        end

        dxDrawText("$"..bankmoney, (1802 - 1)*sx, (144 - 1)*sy, (1876 - 1)*sx, (182 - 1)*sy, tocolor(0, 0, 0, 255), 1.00*sy, "pricedown", "right", "center", false, false, false, false, false)
        dxDrawText("$"..bankmoney, (1802 + 1)*sx, (144 - 1)*sy, (1876 + 1)*sx, (182 - 1)*sy, tocolor(0, 0, 0, 255), 1.00*sy, "pricedown", "right", "center", false, false, false, false, false)
        dxDrawText("$"..bankmoney, (1802 - 1)*sx, (144 + 1)*sy, (1876 - 1)*sx, (182 + 1)*sy, tocolor(0, 0, 0, 255), 1.00*sy, "pricedown", "right", "center", false, false, false, false, false)
        dxDrawText("$"..bankmoney, (1802 + 1)*sx, (144 + 1)*sy, (1876 + 1)*sx, (182 + 1)*sy, tocolor(0, 0, 0, 255), 1.00*sy, "pricedown", "right", "center", false, false, false, false, false)
        dxDrawText("$"..bankmoney, 1802*sx, 144*sy, 1876*sx, 182*sy, tocolor(254, 254, 254, 193), 1.00*sy, "pricedown", "right", "center", false, false, false, false, false)

        dxDrawText(Balas, (1422 - 1)*sx, (144 - 1)*sy, (1876 - 1)*sx, (182 - 1)*sy, tocolor(0, 0, 0, 255), 1.00*sy, "default-bold", "left", "center", false, false, false, false, false)
        dxDrawText(Balas, (1422 + 1)*sx, (144 - 1)*sy, (1876 + 1)*sx, (182 - 1)*sy, tocolor(0, 0, 0, 255), 1.00*sy, "default-bold", "left", "center", false, false, false, false, false)
        dxDrawText(Balas, (1422 - 1)*sx, (144 + 1)*sy, (1876 - 1)*sx, (182 + 1)*sy, tocolor(0, 0, 0, 255), 1.00*sy, "default-bold", "left", "center", false, false, false, false, false)
        dxDrawText(Balas, (1422 + 1)*sx, (144 + 1)*sy, (1876 + 1)*sx, (182 + 1)*sy, tocolor(0, 0, 0, 255), 1.00*sy, "default-bold", "left", "center", false, false, false, false, false)
        dxDrawText(Balas, 1422*sx, 144*sy, 1876*sx, 182*sy, tocolor(255, 255, 255, 193), 1.00*sy, "default-bold", "left", "center", false, false, false, false, false)

        dxDrawText("$"..convertNumber (money), (1802 - 1)*sx, (172 - 1)*sy , (1876 - 1)*sx, (210 - 1)*sy , tocolor(0, 0, 0, 255), 1.00*sy, "pricedown", "right", "center", false, false, false, false, false)
        dxDrawText("$"..convertNumber (money), (1802 + 1)*sx, (172 - 1)*sy , (1876 + 1)*sx, (210 - 1)*sy , tocolor(0, 0, 0, 255), 1.00*sy, "pricedown", "right", "center", false, false, false, false, false)
        dxDrawText("$"..convertNumber (money), (1802 - 1)*sx, (172 + 1)*sy , (1876 - 1)*sx, (210 + 1)*sy , tocolor(0, 0, 0, 255), 1.00*sy, "pricedown", "right", "center", false, false, false, false, false)
        dxDrawText("$"..convertNumber (money), (1802 + 1)*sx, (172 + 1)*sy , (1876 + 1)*sx, (210 + 1)*sy , tocolor(0, 0, 0, 255), 1.00*sy, "pricedown", "right", "center", false, false, false, false, false)
        dxDrawText("$"..convertNumber (money), 1802*sx, 172*sy, 1876*sx, 210*sy, tocolor(20, 196, 16, 193), 1.00*sy, "pricedown", "right", "center", false, false, false, false, false)

        local LvE = getPlayerWantedLevel(localPlayer) or 0

        if LvE == 6 then
            dxDrawImage(0, 482*sy, 42*sx, 42*sy,":Gamemode/img/star.png", 0, 0, 0, tocolor(255, 255, 255, 255), false) -- 6
            dxDrawImage(0, 522*sy, 42*sx, 42*sy,":Gamemode/img/star.png", 0, 0, 0, tocolor(255, 255, 255, 255), false) -- 5
            dxDrawImage(0, 562*sy, 42*sx, 42*sy,":Gamemode/img/star.png", 0, 0, 0, tocolor(255, 255, 255, 255), false) -- 4
            dxDrawImage(0, 602*sy, 42*sx, 42*sy,":Gamemode/img/star.png", 0, 0, 0, tocolor(255, 255, 255, 255), false) -- 3
            dxDrawImage(0, 642*sy, 42*sx, 42*sy,":Gamemode/img/star.png", 0, 0, 0, tocolor(255, 255, 255, 255), false) -- 2
            dxDrawImage(0, 682*sy, 42*sx, 42*sy,":Gamemode/img/star.png", 0, 0, 0, tocolor(255, 255, 255, 255), false) -- 1
        end

        if LvE == 5 then
            dxDrawImage(0, 522*sy, 42*sx, 42*sy,":Gamemode/img/star.png", 0, 0, 0, tocolor(255, 255, 255, 255), false) -- 5
            dxDrawImage(0, 562*sy, 42*sx, 42*sy,":Gamemode/img/star.png", 0, 0, 0, tocolor(255, 255, 255, 255), false) -- 4
            dxDrawImage(0, 602*sy, 42*sx, 42*sy,":Gamemode/img/star.png", 0, 0, 0, tocolor(255, 255, 255, 255), false) -- 3
            dxDrawImage(0, 642*sy, 42*sx, 42*sy,":Gamemode/img/star.png", 0, 0, 0, tocolor(255, 255, 255, 255), false) -- 2
            dxDrawImage(0, 682*sy, 42*sx, 42*sy,":Gamemode/img/star.png", 0, 0, 0, tocolor(255, 255, 255, 255), false) -- 1
        end

        if LvE == 4 then
            dxDrawImage(0, 562*sy, 42*sx, 42*sy,":Gamemode/img/star.png", 0, 0, 0, tocolor(255, 255, 255, 255), false) -- 4
            dxDrawImage(0, 602*sy, 42*sx, 42*sy,":Gamemode/img/star.png", 0, 0, 0, tocolor(255, 255, 255, 255), false) -- 3
            dxDrawImage(0, 642*sy, 42*sx, 42*sy,":Gamemode/img/star.png", 0, 0, 0, tocolor(255, 255, 255, 255), false) -- 2
            dxDrawImage(0, 682*sy, 42*sx, 42*sy,":Gamemode/img/star.png", 0, 0, 0, tocolor(255, 255, 255, 255), false) -- 1
        end

        if LvE == 3 then
            dxDrawImage(0, 602*sy, 42*sx, 42*sy,":Gamemode/img/star.png", 0, 0, 0, tocolor(255, 255, 255, 255), false) -- 3
            dxDrawImage(0, 642*sy, 42*sx, 42*sy,":Gamemode/img/star.png", 0, 0, 0, tocolor(255, 255, 255, 255), false) -- 2
            dxDrawImage(0, 682*sy, 42*sx, 42*sy,":Gamemode/img/star.png", 0, 0, 0, tocolor(255, 255, 255, 255), false) -- 1
        end

        if LvE == 2 then
            dxDrawImage(0, 642*sy, 42*sx, 42*sy,":Gamemode/img/star.png", 0, 0, 0, tocolor(255, 255, 255, 255), false) -- 2
            dxDrawImage(0, 682*sy, 42*sx, 42*sy,":Gamemode/img/star.png", 0, 0, 0, tocolor(255, 255, 255, 255), false) -- 1
        end

        if LvE == 1 then
            dxDrawImage(0, 682*sy, 42*sx, 42*sy,":Gamemode/img/star.png", 0, 0, 0, tocolor(255, 255, 255, 255), false) -- 1
        end

    end
)
