local fps = false

function getCurrentFPS() --Función útil ( https://wiki.multitheftauto.com/wiki/GetCurrentFPS )
    return fps
end

local function updateFPS(msSinceLastFrame)
    fps = (1 / msSinceLastFrame) * 1000
end
addEventHandler("onClientPreRender", root, updateFPS)

addEventHandler ( "onClientResourceStart", root,
function ( )
	local objects = getElementsByType( 'object' ) 
	for i=1, #objects do
		local v = objects[ i ]
		local model = getElementModel( v )
		--engineSetModelLODDistance ( v, 220 )
		--setFarClipDistance( 4000 )
		setOcclusionsEnabled ( false )
	end
end)

local time = getRealTime ()
local FPSLimit, lastTick, framesRendered, FPS = 150, getTickCount(), 0, 0
local sx_, sy_ = guiGetScreenSize()
local sx, sy = sx_/1360, sy_/768
local hudPlayer = false
local loadingSprint = false
local screenW,screenH = guiGetScreenSize()
local resW, resH = 1280, 720
local x, y =  (screenW/resW), (screenH/resH)

function addhudPlayer()
	if hudPlayer == false then
		hudPlayer = true
	end
end
addEvent("addhudPlayer", true)
addEventHandler("addhudPlayer", root, addhudPlayer)

function removeHudPlayer()
	if hudPlayer == true then
		hudPlayer = false
	end
end
addEvent("removeHudPlayer", true)
addEventHandler("removeHudPlayer", root, removeHudPlayer)

meses = {
	[1] = {"1"},
	[2] = {"2"},
	[3] = {"3"},
	[4] = {"4"},
	[5] = {"5"},
	[6] = {"6"},
	[7] = {"7"},
	[8] = {"8"},
	[9] = {"9"},
	[10] = {"10"},
	[11] = {"11"},
	[12] = {"12"},
}

--local components = { "ammo", "health", "weapon" , "money", "wanted", "area_name", "vehicle_name", "breath", "clock", "armour" }
--local hudTable = { "ammo", "armour", "health", "money", "weapon", "wanted", "breath", "clock" }

tamanoletras = (sx/sy)*2.45

local screenW, screenH = guiGetScreenSize()
local fuente = dxCreateFont( "fonts/hint-text.ttf", 9 )

if screenW <= 1366 and screenH <= 768 then
	tamanoletras = (sx/sy)*1.90
end

local sx,sy = guiGetScreenSize()
local px,py = 1600,900
local x,y =  (sx/px), (sy/py)	

local noreloadweapons = {}
noreloadweapons[17] = false
noreloadweapons[19] = true
noreloadweapons[39] = false
noreloadweapons[41] = true
noreloadweapons[42] = false

local meleespecialweapons = {}
meleespecialweapons[0] = true
meleespecialweapons[1] = true
meleespecialweapons[2] = true
meleespecialweapons[3] = true
meleespecialweapons[4] = true
meleespecialweapons[5] = true
meleespecialweapons[6] = true
meleespecialweapons[7] = true
meleespecialweapons[8] = true
meleespecialweapons[9] = true
meleespecialweapons[10] = true
meleespecialweapons[11] = true
meleespecialweapons[12] = true
meleespecialweapons[13] = true
meleespecialweapons[14] = true
meleespecialweapons[15] = true
meleespecialweapons[40] = true
meleespecialweapons[43] = true
meleespecialweapons[44] = true
meleespecialweapons[45] = true
meleespecialweapons[46] = true	

addEventHandler("onClientPreRender", root, function(time)
	if hudPlayer == true then
		local stamina = localPlayer:getData("Roleplay:stamina") or 100
		local state = getPedMoveState(localPlayer)
		if stamina >= 100 then
			loadingSprint = false
		end
		if ( state == "sprint" ) then
			if ( stamina >= 0 ) then
				stamina = stamina-(0.002*time)
			end
		else
			if ( stamina <= 100 ) then
				if ( state == "stand" ) then -- si el jugador esta quieto aumenta un poco mas rapido
					stamina = stamina+(0.002*time)
					loadingSprint = true
				else
					stamina = stamina+(0.0013*time)
					loadingSprint = true
				end
			end
		end
		if ( state == "jump" ) then
			if ( stamina >= 0 ) then
				stamina = stamina-(0.008*time)
			end
		end
		if ( stamina <= 5 ) then
			toggleControl( "sprint", false )
			toggleControl( "jump", false )
		end
		if ( stamina >= 50 ) then
			toggleControl( "sprint", true )
			toggleControl( "jump", true )
		end
		localPlayer:setData("Roleplay:stamina", stamina)
	end
end)

addEventHandler("onClientRender", getRootElement(), function()
	if not getResourceFromName("nlogin") then return end
	if not isPlayerMapVisible() then
		local currentTick = getTickCount()
		local elapsedTime = currentTick - lastTick
		if elapsedTime >= 1000 then
			FPS = framesRendered
			lastTick = currentTick
			framesRendered = 0
		else
			framesRendered = framesRendered + 1
		end
		localPlayer:setData("FPS", ""..tonumber(FPS).." FPS")
		if hudPlayer == true then
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
			local screenX, screenY = guiGetScreenSize( )
			--dxDrawText("/yo : ["..(localPlayer:getData("yo")[1]).."]", 10*sx, 730*sy, 0*sx, 314*sy, tocolor(195, 234, 255, 200), 1.00, "default", "left", "top", false, false, false, false, false)
			if getElementData(localPlayer,"yo") then
 				dxDrawText ( "Tu /yo: "..(localPlayer:getData("yo")[1]), 99999999999999, screenY - 99999999999999, screenX+1, screenY+1, tocolor ( 0, 0, 0, 220 ), 1, fuente )
 			end
			--dxDrawText ( "Tu /yo: "..(localPlayer:getData("yo")[1]), 43, screenY - 35, screenX, screenY, tocolor ( 255, 255, 255, 255 ), 1, fuente )
			dxDrawText(""..dia.."/".. meses[(mes+1)][1].."/"..ano.." - "..hora..":"..minutos.." (GMT-03) - "..localPlayer:getPing().."ms - "..(localPlayer:getData("FPS") or 0).." - "..localPlayer:getName().." [ ID: "..(localPlayer:getData("ID") or 0).." ] ", 10, screenY - 20, screenX+1, screenY+1, tocolor(247, 246, 150, 255), 1, "default", "left", "top", false, false, false, false, false)
			dxDrawText("Next Life RP 1.5", 10, screenY - 30, screenX-4, screenY+1, tocolor(255, 255, 255, 120), 1.00, "default", "right", "top", false, false, false, false, false)
			--for _, component in ipairs( components ) do
			--	setPlayerHudComponentVisible( component, false )
			--end
			local component3 = {"area_name", "vehicle_name"}
			for _, component3 in ipairs( component3 ) do 
				setPlayerHudComponentVisible( component3, false )
			end
			dxSetAspectRatioAdjustmentEnabled( true )
		    local loginstate = exports.nlogin:getStateLogin()
	    	if loginstate ~= false then return end
--[[
			local sx,sy = guiGetScreenSize()
			local px,py = 1600,900
			local x,y =  (sx/px), (sy/py)	
			local money = ("%08d"):format(getPlayerMoney())
			if money <= "0" then
				dxDrawBorderedText2("$"..money.."", 1090*x, 130*y, 430*x + 1090*x, 90*y + 130*y, tocolor(150, 0, 0, 255), tamanoletras, "pricedown", "right", "center", false, false, false, false, false)
			else
				dxDrawBorderedText2("$"..money.."", 1090*x, 130*y, 430*x + 1090*x, 90*y + 130*y, tocolor(14,105,0,255), tamanoletras, "pricedown", "right", "center", false, false, false, false, false)
				--dxDrawText("$00000000", 1063, 171, 1291, 210, tocolor(5, 56, 1, 255), 2.00, "pricedown", "left", "top", false, false, false, false, false)
				--dxDrawText("$00000000", 1063, 210, 1291, 249, tocolor(146, 246, 148, 255), 2.00, "pricedown", "left", "top", false, false, false, false, false)
			end
]]
		end
		
--[[
		local x, y, z = getElementPosition(localPlayer)
		local screenW, screenH = guiGetScreenSize()
		if getZoneName(x, y, z) == "Unknown" then
			zone = "En Interior"
		else
			zone = getZoneName(x, y, z)
		end
]]
		--dxDrawBorderedText(""..(zone or "En Interior"),x*1365, y*040, x*1358, y*40,tocolor(255,255,255,215),1.0,"pricedown","left","top",false,false,false)
		---
		
		-- dxDrawBorderedText("Ubicacion: "..(zone or "En Interior"),  screenW * 0.7800, screenH * 0.0130, screenW * 0.8258, screenH * 0.0273, tocolor(255, 255, 255, 255), 1.50, "default-bold", "left", "top", false, false, false, false, false)
		
		--
   		--dxDrawText(""..(zone or "En Interior"), (screenW * 0.4300) - 1, (screenH * 0.9800) - 1, (screenW * 0.6025) - 1, (screenH * 1) - 1, tocolor(0, 0, 0, 255), 1.50, "default-bold", "left", "top", false, false, false, false, false)
    	--dxDrawText(""..(zone or "En Interior"), (screenW * 0.4300) + 1, (screenH * 0.9800) - 1, (screenW * 0.6025) + 1, (screenH * 1) - 1, tocolor(0, 0, 0, 255), 1.50, "default-bold", "left", "top", false, false, false, false, false)
    	--dxDrawText(""..(zone or "En Interior"), (screenW * 0.4300) - 1, (screenH * 0.9800) + 1, (screenW * 0.6025) - 1, (screenH * 1) + 1, tocolor(0, 0, 0, 255), 1.50, "default-bold", "left", "top", false, false, false, false, false)
		--dxDrawText(""..(zone or "En Interior"), (screenW * 0.4300) + 1, (screenH * 0.9800) + 1, (screenW * 0.6025) + 1, (screenH * 1) + 1, tocolor(0, 0, 0, 255), 1.50, "default-bold", "left", "top", false, false, false, false, false)
	    --dxDrawText(""..(zone or "En Interior"), screenW * 0.4300, screenH * 0.9800, screenW * 0.6025, screenH * 1, tocolor(255, 255, 255, 255), 1.50, "default-bold", "left", "top", false, false, false, false, false)
--[[
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
]]
	end
end)

addEventHandler("onClientResourceStart",root,function()   hudPlayer = true  end)

bindKey("f2", "down", function() if hudPlayer == true then showCursor( not isCursorShowing() ) end end)

function dxDrawBorderedText2( text, x, y, w, h, color, scale, font, alignX, alignY, clip, wordBreak, postGUI )
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

function dxDrawBorderedText( text, x, y, w, h, color, scale, font, alignX, alignY, clip, wordBreak, postGUI )
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

addEventHandler("onClientResourceStart", getRootElement(), function()
	setAmbientSoundEnabled( "general", false )
	setAmbientSoundEnabled( "gunfire", false )
end)
