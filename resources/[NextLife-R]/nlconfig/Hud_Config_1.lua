
local sx_, sy_ = guiGetScreenSize()

local sx, sy = sx_/1360, sy_/768

local hudPlayer = false

local loadingSprint = false

local screenW,screenH = guiGetScreenSize()

local resW, resH = 1280, 720

local x, y =  (screenW/resW), (screenH/resH)

local function dxDrawBorderedText( text, x, y, w, h, color, scale, font, alignX, alignY, clip, wordBreak, postGUI )
	dxDrawText ( text, x - 1, y - 1, w - 1, h - 1, tocolor ( 0, 0, 0, 155 ), scale, font, alignX, alignY, clip, wordBreak, false ) -- black
	dxDrawText ( text, x + 1, y - 1, w + 1, h - 1, tocolor ( 0, 0, 0, 155 ), scale, font, alignX, alignY, clip, wordBreak, false )
	dxDrawText ( text, x - 1, y + 1, w - 1, h + 1, tocolor ( 0, 0, 0, 155 ), scale, font, alignX, alignY, clip, wordBreak, false )
	dxDrawText ( text, x + 1, y + 1, w + 1, h + 1, tocolor ( 0, 0, 0, 155 ), scale, font, alignX, alignY, clip, wordBreak, false )
	dxDrawText ( text, x - 1, y, w - 1, h, tocolor ( 0, 0, 0, 155 ), scale, font, alignX, alignY, clip, wordBreak, false )
	dxDrawText ( text, x + 1, y, w + 1, h, tocolor ( 0, 0, 0, 155 ), scale, font, alignX, alignY, clip, wordBreak, false )
	dxDrawText ( text, x, y - 1, w, h - 1, tocolor ( 0, 0, 0, 155 ), scale, font, alignX, alignY, clip, wordBreak, false )
	dxDrawText ( text, x, y + 1, w, h + 1, tocolor ( 0, 0, 0, 155 ), scale, font, alignX, alignY, clip, wordBreak, false )
	dxDrawText ( text, x, y, w, h, color, scale, font, alignX, alignY, clip, wordBreak, postGUI )
end

local function dxDrawBorderedText2( text, x, y, w, h, color, scale, font, alignX, alignY, clip, wordBreak, postGUI )
	dxDrawText ( text:gsub('#%x%x%x%x%x%x', ''), x - 3, y - 3, w - 3, h - 3, tocolor ( 0, 0, 0, 225 ), scale, font, alignX, alignY, clip, wordBreak, false )
	dxDrawText ( text:gsub('#%x%x%x%x%x%x', ''), x + 3, y - 3, w + 3, h - 3, tocolor ( 0, 0, 0, 225 ), scale, font, alignX, alignY, clip, wordBreak, false )
	dxDrawText ( text:gsub('#%x%x%x%x%x%x', ''), x - 3, y + 2, w - 3, h + 3, tocolor ( 0, 0, 0, 225 ), scale, font, alignX, alignY, clip, wordBreak, false )
	dxDrawText ( text:gsub('#%x%x%x%x%x%x', ''), x + 3, y + 3, w +3, h + 3, tocolor ( 0, 0, 0, 225 ), scale, font, alignX, alignY, clip, wordBreak, false )
	dxDrawText ( text:gsub('#%x%x%x%x%x%x', ''), x - 3, y, w - 3, h, tocolor ( 0, 0, 0, 225 ), scale, font, alignX, alignY, clip, wordBreak, false )
	dxDrawText ( text:gsub('#%x%x%x%x%x%x', ''), x + 3, y, w + 3, h, tocolor ( 0, 0, 0, 225 ), scale, font, alignX, alignY, clip, wordBreak, false )
	dxDrawText ( text:gsub('#%x%x%x%x%x%x', ''), x, y - 3, w, h - 3, tocolor ( 0, 0, 0, 225 ), scale, font, alignX, alignY, clip, wordBreak, false )
	dxDrawText ( text:gsub('#%x%x%x%x%x%x', ''), x, y + 3, w, h + 3, tocolor ( 0, 0, 0, 225 ), scale, font, alignX, alignY, clip, wordBreak, false )
	dxDrawText ( text, x, y, w, h, color, scale, font, alignX, alignY, clip, wordBreak, postGUI, true )
end

components_1 = { "clock", "money", "wanted", "area_name", "vehicle_name", "breath", "clock", "armour" }
--local hudTable = { "ammo", "armour", "health", "money", "weapon", "wanted", "breath", "clock" }

local tamanoletras = (sx/sy)*2.45

local screenW, screenH = guiGetScreenSize()

-- local fuente = dxCreateFont( ":Gamemode/fonts/hint-text.ttf", 9 )


if screenW <= 1366 and screenH <= 768 then
	tamanoletras = (sx/sy)*1.90
end

local sx,sy = guiGetScreenSize()

local px,py = 1600,900

local x,y =  (sx/px), (sy/py)	


addEventHandler("onClientRender", getRootElement(), function()
	local loginstate = exports.nlogin:getStateLogin()
	if loginstate ~= false then return end
	if Save.HudBase ~= "Si" then return end
	if not isPlayerMapVisible() then

		

		local screenX, screenY = guiGetScreenSize( )

		dxSetAspectRatioAdjustmentEnabled( true )

        for _, component in ipairs( components_1 ) do
            setPlayerHudComponentVisible( component, false )
        end

        setPlayerHudComponentVisible( "ammo", true )
        setPlayerHudComponentVisible( "health", true )
        setPlayerHudComponentVisible( "weapon", true )
        --setPlayerHudComponentVisible( "wanted", true )

		local sx,sy = guiGetScreenSize()
		local px,py = 1600,900
		local x,y =  (sx/px), (sy/py)	
		local money = ("%08d"):format(getPlayerMoney())
		if money <= "0" then
			dxDrawBorderedText2("$"..money.."", 1090*x, 130*y, 430*x + 1090*x, 90*y + 130*y, tocolor(150, 0, 0, 255), tamanoletras, "pricedown", "right", "center", false, false, false, false, false)
		else
			dxDrawBorderedText2("$"..money.."", 1090*x, 130*y, 430*x + 1090*x, 90*y + 130*y, tocolor(14,105,0,255), tamanoletras, "pricedown", "right", "center", false, false, false, false, false)
		end

		

		local x, y, z = getElementPosition(localPlayer)

		local screenW, screenH = guiGetScreenSize()

		if getZoneName(x, y, z) == "Unknown" then
			zone = "En Interior"
		else
			zone = getZoneName(x, y, z)
		end

		dxDrawBorderedText("Ubicacion: "..(zone or "En Interior"),  screenW * 0.7800, screenH * 0.0130, screenW * 0.8258, screenH * 0.0273, tocolor(255, 255, 255, 255), 1.50, "default-bold", "left", "top", false, false, false, false, false)

		local state = getPedMoveState(localPlayer)

		if ( state == "sprint" or state == "jump" or loadingSprint == true ) then

			local sx,sy = guiGetScreenSize()

			local px,py = 1600,900

			local x,y =  (sx/px), (sy/py)	

			local stamina = localPlayer:getData("Roleplay:stamina") or 100

			if stamina then

				dxDrawRectangle(x*1366, y*85, x*154, y*16, tocolor(0, 0, 0, 255), false)--fundo preto

				dxDrawRectangle(x*1372, y*88, x*144, y*10, tocolor(7, 95, 0 ,255), false)--fundo

				dxDrawRectangle(x*1372, y*88, x*144*(stamina/100), y*10, tocolor(13, 183, 0, 255), false)

			end

		end

			local sx,sy = guiGetScreenSize()

			local px,py = 1600,900

			local x,y =  (sx/px), (sy/py)

			local armad = localPlayer:getArmor()

			if armad  > 0 then
				dxDrawRectangle(x*1366, y*110, x*154, y*16, tocolor(0, 0, 0, 255), false)--fundo preto
				dxDrawRectangle(x*1372, y*113, x*144, y*10, tocolor(176, 176, 176 ,255), false)--fundo
				dxDrawRectangle(x*1372, y*113, x*144*(armad/100), y*9, tocolor(255, 255, 255, 255), false)
			end	

			local sx,sy = guiGetScreenSize()

			local px,py = 1600,900

			local x,y =  (sx/px), (sy/py)	

			local bankmoney = ("%08d"):format((localPlayer:getData("Roleplay:bank_balance") or 0))
			--local bankmoney = getElementData(localPlayer,"bank.balance")
			if bankmoney <= "0" then
				dxDrawBorderedText2("$"..bankmoney, 1090*x, 160*y, 430*x + 1090*x, 95*y + 170*y, tocolor(95,146,84,255), tamanoletras, "pricedown", "right", "center", false, false, false, false, false)
			else
				dxDrawBorderedText2("$"..bankmoney, 1090*x, 160*y, 430*x + 1090*x, 95*y + 170*y, tocolor(95,146,84,255), tamanoletras, "pricedown", "right", "center", false, false, false, false, false)
			end	


	end
end)




--[[

local screenWidth, screenHeight = guiGetScreenSize()
local root = getRootElement()
local wanted = getPlayerWantedLevel(localPlayer)
local now = getTickCount( )
local start = getTickCount( )

local screenW, screenH = guiGetScreenSize()
local sx, sy = screenW/1920, screenH/1080

-- 'round value'

function roundValue(value)
    local var = math.floor((value) + 0.5)
    return var
end

local function dxDrawBorderedText( text, x, y, w, h, color, scale, font, alignX, alignY, clip, wordBreak, postGUI )
trans = 155
	dxDrawText ( text, x - 1, y - 1, w - 1, h - 1, tocolor ( 0, 0, 0, trans ), scale, font, alignX, alignY, clip, wordBreak, false )
	dxDrawText ( text, x + 1, y - 1, w + 1, h - 1, tocolor ( 0, 0, 0, trans ), scale, font, alignX, alignY, clip, wordBreak, false )
	dxDrawText ( text, x - 1, y + 1, w - 1, h + 1, tocolor ( 0, 0, 0, trans ), scale, font, alignX, alignY, clip, wordBreak, false )
	dxDrawText ( text, x + 1, y + 1, w + 1, h + 1, tocolor ( 0, 0, 0, trans ), scale, font, alignX, alignY, clip, wordBreak, false )
	dxDrawText ( text, x - 1, y, w - 1, h, tocolor ( 0, 0, 0, trans ), scale, font, alignX, alignY, clip, wordBreak, false )
	dxDrawText ( text, x + 1, y, w + 1, h, tocolor ( 0, 0, 0, trans ), scale, font, alignX, alignY, clip, wordBreak, false )
	dxDrawText ( text, x, y - 1, w, h - 1, tocolor ( 0, 0, 0, trans ), scale, font, alignX, alignY, clip, wordBreak, false )
	dxDrawText ( text, x, y + 1, w, h + 1, tocolor ( 0, 0, 0, trans ), scale, font, alignX, alignY, clip, wordBreak, false )
	dxDrawText ( text, x, y, w, h, color, scale, font, alignX, alignY, clip, wordBreak, postGUI )
end



local function dxDrawBorderedText2( text, x, y, w, h, color, scale, font, alignX, alignY, clip, wordBreak, postGUI )
trans = 50
	dxDrawText ( text, x - 1, y - 1, w - 1, h - 1, tocolor ( 0, 0, 0, trans ), scale, font, alignX, alignY, clip, wordBreak, false )
	dxDrawText ( text, x + 1, y - 1, w + 1, h - 1, tocolor ( 0, 0, 0, trans ), scale, font, alignX, alignY, clip, wordBreak, false )
	dxDrawText ( text, x - 1, y + 1, w - 1, h + 1, tocolor ( 0, 0, 0, trans ), scale, font, alignX, alignY, clip, wordBreak, false )
	dxDrawText ( text, x + 1, y + 1, w + 1, h + 1, tocolor ( 0, 0, 0, trans ), scale, font, alignX, alignY, clip, wordBreak, false )
	dxDrawText ( text, x - 1, y, w - 1, h, tocolor ( 0, 0, 0, trans ), scale, font, alignX, alignY, clip, wordBreak, false )
	dxDrawText ( text, x + 1, y, w + 1, h, tocolor ( 0, 0, 0, trans ), scale, font, alignX, alignY, clip, wordBreak, false )
	dxDrawText ( text, x, y - 1, w, h - 1, tocolor ( 0, 0, 0, trans ), scale, font, alignX, alignY, clip, wordBreak, false )
	dxDrawText ( text, x, y + 1, w, h + 1, tocolor ( 0, 0, 0, trans ), scale, font, alignX, alignY, clip, wordBreak, false )
	dxDrawText ( text, x, y, w, h, color, scale, font, alignX, alignY, clip, wordBreak, postGUI )
end


function LibertyCityStories() --======== RENDER ==========--
local loginstate = exports.nlogin:getStateLogin()
if loginstate ~= false then return end
if Save.HudBase ~= "Si" then return end

local now = getTickCount()

-- oxygenio
	local oxigenio = getPedOxygenLevel ( getLocalPlayer() )
	if isElementInWater (getLocalPlayer()) then
	dxDrawRectangle(1747*sx, 100*sy, 66*sx, 16*sy, tocolor(255, 255, 255, 100), false)
	dxDrawRectangle(1747*sx, 100*sy, (66/1000*oxigenio)*sx, 16*sy, tocolor(255, 255, 255, 255), false)
	dxDrawImage(1745*sx, 98*sy, 70*sx, 20*sy, "files/img/bar.png", 0, 0, 0, tocolor(255, 255, 255 , 255), true)
	end
	
-- Colete

	local armour = getPedArmor ( getLocalPlayer() )
	if armour>0 then
		dxDrawRectangle(1747*sx, 45, 66*sx, 16, tocolor(74, 198, 206, 100), false)
		dxDrawRectangle(1747*sx, 45, (66/100*armour)*sx, 16, tocolor(74, 198, 206, 255), false)
		dxDrawImage(1745*sx, 43, 70*sx, 20, "files/img/bar.png", 0, 0, 0, tocolor(255, 255, 255 , 255), true)
	end
	
-- Vida
	local health = math.floor( getElementHealth( getLocalPlayer() ))
	dxDrawRectangle(1747*sx, 72, 66*sx, 17, tocolor(189, 115, 140, 100), false)
	
	local stat = getPedStat ( getLocalPlayer(), 24 )
		if stat < 1000 then
			dxDrawRectangle(1747*sx, 72*sy, (66/100*health)*sx, 16*sy, tocolor(189, 115, 140, 255), false)
		else
			dxDrawRectangle(1747*sx, 72*sy, (66/200*health)*sx, 16*sy, tocolor(189, 115, 140, 255), false)
		end
	dxDrawImage(1745*sx, 70*sy, 70*sx, 20*sy, "files/img/bar.png", 0, 0, 0, tocolor(255, 255, 255 , 255), true)
	
	if stat < 1000 then
	else
	dxDrawImage(1745*sx, 72*sy, 12*sx, 12*sy, "files/img/+.png", 0, 0, 0, tocolor(255, 255, 255 , 255), true)
	end

-- nivel de procurado
local wantedL = getPlayerWantedLevel(localPlayer)
if isElementInWater (getLocalPlayer()) then
	if wanted ~= wantedL then start = getTickCount( ) wanted = wantedL end
		if wantedL ~= 0 then
			for k=1,6 do
			dxDrawImage(roundValue(screenWidth - 230+(k*30)), 150*sy, 27*sx, 23*sy, "files/img/star2.png", 0, 0, 0, tocolor(255, 255, 255 , 255), false)
		end
		for k=1,wantedL do
			dxDrawImage(roundValue(screenWidth - 230+(k*30)), 150*sy, 27*sx, 23*sy, "files/img/star1.png", 0, 0, 0, tocolor(255 , 255, 255, now >= start+1500 and 255 or math.abs(math.sin(now/100)*255)), false)
		end
	end
else
if wanted ~= wantedL then start = getTickCount( ) wanted = wantedL end
		if wantedL ~= 0 then
			for k=1,6 do
			dxDrawImage((roundValue(screenWidth - 230+(k*30)))*sx, 130*sy, 27*sx, 23*sy, "files/img/star2.png", 0, 0, 0, tocolor(255, 255, 255 , 255), false)
		end
		for k=1,wantedL do
			dxDrawImage((roundValue(screenWidth - 230+(k*30)))*sx, 130*sy, 27*sx, 23*sy, "files/img/star1.png", 0, 0, 0, tocolor(255 , 255, 255, now >= start+1500 and 255 or math.abs(math.sin(now/100)*255)), false)
		end
	end
end

	
-- Armas
	dxDrawImage((roundValue(screenWidth - 100))*sx, 15*sy, 70*sx, 70*sy, "files/img/"..getPedWeapon(getLocalPlayer())..".png", 0, 0, 0, tocolor(255, 255, 255 , 255), true)

	
-- contagem de munição	
	local showammo1 = getPedAmmoInClip (localPlayer,getPedWeaponSlot(localPlayer))
	local showammo2 = getPedTotalAmmo(localPlayer)-getPedAmmoInClip(localPlayer)
local weapon = getPedWeapon(getLocalPlayer())

if ( weapon == 0 ) or ( weapon == 1 ) or ( weapon == 2 ) or ( weapon == 3 ) or ( weapon == 4 ) or ( weapon == 5 ) or ( weapon == 6 ) or ( weapon == 7 ) or ( weapon == 8 ) or ( weapon == 9 ) or ( weapon == 10 ) or ( weapon == 11 ) or ( weapon == 12 ) or ( weapon == 14 ) or ( weapon == 15 ) or ( weapon == 40 ) or ( weapon == 44 ) or ( weapon == 45 ) or ( weapon == 46 ) then
else
	if showammo2 < 999  then
		dxDrawBorderedText2(showammo1.."-"..showammo2, (screenWidth - 0)*sx, 85*sy, (screenWidth - 130)*sx, (screenHeight - 700)*sy, tocolor(255, 255, 255, 200), 1.0, "default-bold", "center", "top", false, false, true)
	end
end


-- tempo
	local hour, mins = getTime ()
	local Time = hour .. ":" .. (((mins < 10) and "0"..mins) or mins)
	if armour>0 then
		dxDrawBorderedText(Time, (screenWidth - 115)*sx, 10*sy, (screenWidth - 160)*sx, (screenHeight - 700)*sy, tocolor(156, 123, 90, 255), 1.0, "pricedown", "center", "top", false, false, true)
	else
		dxDrawBorderedText(Time, (screenWidth - 115)*sx, 30*sy, (screenWidth - 160)*sx, (screenHeight - 700)*sy, tocolor(156, 123, 90, 255), 1.0, "pricedown", "center", "top", false, false, true)
	end

-- Dinheiro
	local money = string.format("%08d", getPlayerMoney(getLocalPlayer()))
	if isElementInWater (getLocalPlayer()) then
		dxDrawBorderedText("$", (screenWidth - 0)*sx, 120*sy, (screenWidth - 328)*sx, (screenHeight - 700)*sy, tocolor(74, 115, 66, 255), 1.0, "pricedown", "center", "top", false, false, true)
		for i=1,9 do
			dxDrawBorderedText(string.char(string.byte(money, i,i)), (screenWidth - 0)*sx, 120*sy, screenWidth - 325+i*30, (screenHeight - 700)*sy, tocolor(74, 115, 66, 255), 1.0, "pricedown", "center", "top", false, false, true)
		end
	else
		dxDrawBorderedText("$", (screenWidth - 0)*sx, 100, (screenWidth - 328)*sx, (screenHeight - 700)*sy, tocolor(74, 115, 66, 255), 1.0, "pricedown", "center", "top", false, false, true)
		for i=1,9 do
			dxDrawBorderedText(string.char(string.byte(money, i,i)), (screenWidth - 0)*sx, 100*sy, (screenWidth - 325+i*30)*sx, (screenHeight - 700)*sy, tocolor(74, 115, 66, 255), 1.0, "pricedown", "center", "top", false, false, true)
		end
	end

	
	
end
addEventHandler("onClientRender", root, LibertyCityStories)

]]



--[[
local hudTable = { "ammo", "armour", "health", "money", "weapon", "wanted", "breath", "clock" }
addEventHandler("onClientResourceStart", resourceRoot,
    function()
		for id, hudComponents in ipairs(hudTable) do
			showPlayerHudComponent(hudComponents, false)
		end
    end)

addEventHandler("onClientResourceStop", resourceRoot,
    function()
		for id, hudComponents in ipairs(hudTable) do
			showPlayerHudComponent(hudComponents, true)
		end
    end)


]]
