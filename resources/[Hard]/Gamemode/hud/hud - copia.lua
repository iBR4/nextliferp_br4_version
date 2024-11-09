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



end



)



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



[1]={"1"},



[2]={"2"},



[3]={"3"},



[4]={"4"},



[5]={"5"},



[6]={"6"},



[7]={"7"},



[8]={"8"},



[9]={"9"},



[10]={"10"},



[11]={"11"},



[12]={"12"},



}







local components = {"money", "area_name", "radio", "vehicle_name", "clock","armour"}








tamanoletras = (sx/sy)*2.45



local screenW, screenH = guiGetScreenSize()

local fuente = dxCreateFont( "fonts/hint-text.ttf", 9 )



if screenW <= 1366 and screenH <= 768 then



	tamanoletras = (sx/sy)*1.90



end




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



		dxDrawText("Los Santos Carmona [ALPHA 0.1.0]", 395*sx, 741*sy, 1358*sx, 314*sy, tocolor(255, 255, 255, 120), 1.00, "default", "right", "top", false, false, false, false, false)



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

			dxDrawText ( "Tu /yo: "..(localPlayer:getData("yo")[1]), 43, screenY - 34, screenX+1, screenY+1, tocolor ( 0, 0, 0, 220 ), 1, fuente )
			dxDrawText ( "Tu /yo: "..(localPlayer:getData("yo")[1]), 43, screenY - 35, screenX, screenY, tocolor ( 255, 255, 255, 255 ), 1, fuente )



			--dxDrawText(""..dia.."/".. meses[(mes+1)][1].."/"..ano.." "..hora..":"..minutos.." - "..(localPlayer:getData("FPS") or 0).." - "..localPlayer:getName().." [ ID: "..(localPlayer:getData("ID") or 0).." ] ", 10*sx, 750*sy, 0*sx, 314*sy, tocolor(195, 234, 255, 200), 1, fuente, "left", "top", false, false, false, false, false)



		



			for _, component in ipairs( components ) do



				setPlayerHudComponentVisible( component, false )



			end

			local component2 = {"crosshair","weapon","ammo","health","radar"}

			for _, component2 in ipairs( component2 ) do 

				setPlayerHudComponentVisible( component2, true )

			end
			
			local component3 = {"area_name", "vehicle_name"}

			for _, component3 in ipairs( component3 ) do 

				setPlayerHudComponentVisible( component3, false )

			end

			dxSetAspectRatioAdjustmentEnabled( true )



			local money = ("%08d"):format(getPlayerMoney())
			



			if money <= "0" then



				--dxDrawBorderedText("$"..money.."", 1090*sx, 130*sy, 200*sx + 1090*sx, 90*sy + 130*sy, tocolor(150, 0, 0, 255), tamanoletras, "pricedown", "right", "center", false, false, false, false, false)
				dxDrawBorderedText("$"..money, x*999, y*120, x*1061, y*190, tocolor(0, 125, 0, 255), 1.80, "pricedown", "left", "top", false, false, false, false, false)



			else



				--dxDrawBorderedText("$"..money.."", 1090*sx, 130*sy, 200*sx + 1090*sx, 90*sy + 130*sy, tocolor(14,105,0,255), tamanoletras, "pricedown", "right", "center", false, false, false, false, false)
				dxDrawBorderedText("$"..money, x*999, y*120, x*1061, y*190, tocolor(0, 125, 0, 255), 1.80, "pricedown", "left", "top", false, false, false, false, false)


			end
		end
			
			local x, y, z = getElementPosition(localPlayer)
			local screenW, screenH = guiGetScreenSize()



			if getZoneName(x, y, z) == "Unknown" then



				zone = "En Interior"



			else



				zone = getZoneName(x, y, z)



			
		end


       		dxDrawText(""..(zone or "En Interior"), (screenW * 0.4766) - 1, (screenH * 0.9800) - 1, (screenW * 0.6025) - 1, (screenH * 1) - 1, tocolor(0, 0, 0, 255), 1.50, "default-bold", "left", "top", false, false, false, false, false)
        	dxDrawText(""..(zone or "En Interior"), (screenW * 0.4766) + 1, (screenH * 0.9800) - 1, (screenW * 0.6025) + 1, (screenH * 1) - 1, tocolor(0, 0, 0, 255), 1.50, "default-bold", "left", "top", false, false, false, false, false)
        	dxDrawText(""..(zone or "En Interior"), (screenW * 0.4766) - 1, (screenH * 0.9800) + 1, (screenW * 0.6025) - 1, (screenH * 1) + 1, tocolor(0, 0, 0, 255), 1.50, "default-bold", "left", "top", false, false, false, false, false)
    		dxDrawText(""..(zone or "En Interior"), (screenW * 0.4766) + 1, (screenH * 0.9800) + 1, (screenW * 0.6025) + 1, (screenH * 1) + 1, tocolor(0, 0, 0, 255), 1.50, "default-bold", "left", "top", false, false, false, false, false)
    	    dxDrawText(""..(zone or "En Interior"), screenW * 0.4766, screenH * 0.9800, screenW * 0.6025, screenH * 1, tocolor(255, 255, 255, 255), 1.50, "default-bold", "left", "top", false, false, false, false, false)



			local state = getPedMoveState(localPlayer)


			if ( state == "sprint" or state == "jump" or loadingSprint == true ) then



				local stamina = localPlayer:getData("Roleplay:stamina") or 100



				if stamina then





					dxDrawRectangle( 1160*sx, 60*sy, 130*sx, 15*sy, tocolor(0, 0, 0, 255), false )



					dxDrawRectangle( 1164*sx, 62*sy, 123*sx, 10*sy, tocolor(14, 150, 1, 100), false )



					dxDrawRectangle( 1164*sx, 62*sy, 122*sx*(stamina/100), 10*sy, tocolor(22, 255, 0, 255), false )


				end



			end

			--Chaleco 

				local armad = localPlayer:getArmor()

				if armad  > 0 then

					dxDrawRectangle( 1161*sx, 97*sy, 131*sx, 15*sy, tocolor(0, 0, 0, 255), false )



					dxDrawRectangle( 1165*sx, 100*sy, 123*sx, 9*sy, tocolor(255, 255, 255, 100), false )



					dxDrawRectangle( 1165*sx, 100*sy, 122*sx*(armad/100), 9*sy, tocolor(255, 255, 255, 255), false )

				end

			--Agua

				--[[local water = localPlayer:getData("Agua") or 100

				dxDrawRectangle( 1161*sx, 77*sy, 131*sx, 15*sy, tocolor(0, 0, 0, 255), false )


				dxDrawRectangle( 1165*sx, 80*sy, 123*sx, 9*sy, tocolor(0, 100, 255, 100), false )


				dxDrawRectangle( 1165*sx, 80*sy, 122*sx*(water/100), 9*sy, tocolor(0, 100, 255, 255), false )

			--Comida

				local eat = localPlayer:getData("Comida") or 100

				dxDrawRectangle( 1161*sx, 57*sy, 131*sx, 15*sy, tocolor(0, 0, 0, 255), false )


				dxDrawRectangle( 1165*sx, 60*sy, 123*sx, 9*sy, tocolor(255, 107, 0, 100), false )


				dxDrawRectangle( 1165*sx, 60*sy, 122*sx*(eat/100), 9*sy, tocolor(255, 107, 0, 255), false )--]]

			-- Dinero en Banco



			local bankmoney = ("%08d"):format((localPlayer:getData("Roleplay:bank_balance") or 0))



			if bankmoney <= "0" then



				--dxDrawBorderedText("$"..bankmoney, 1090*sx, 140*sy, 200*sx + 1090*sx, 95*sy + 170*sy, tocolor(95,146,84,255), tamanoletras, "pricedown", "right", "center", false, false, false, false, false)



			else



				--dxDrawBorderedText("$"..bankmoney, 1090*sx, 140*sy, 200*sx + 1090*sx, 95*sy + 170*sy, tocolor(95,146,84,255), tamanoletras, "pricedown", "right", "center", false, false, false, false, false)



			end



		end



end)

addEventHandler("onClientResourceStart",root,function()   hudPlayer = true  end)




bindKey("f2", "down", function() if hudPlayer == true then showCursor( not isCursorShowing() ) end end)



function dxDrawBorderedText2( text, x, y, w, h, color, scale, font, alignX, alignY, clip, wordBreak, postGUI )
dxDrawText ( text:gsub('#%x%x%x%x%x%x', ''), x - 2, y - 2, w - 2, h - 2, tocolor ( 0, 0, 0, 225 ), scale, font, alignX, alignY, clip, wordBreak, false )
dxDrawText ( text:gsub('#%x%x%x%x%x%x', ''), x + 2, y - 2, w + 2, h - 2, tocolor ( 0, 0, 0, 225 ), scale, font, alignX, alignY, clip, wordBreak, false )
dxDrawText ( text:gsub('#%x%x%x%x%x%x', ''), x - 2, y + 2, w - 2, h + 2, tocolor ( 0, 0, 0, 225 ), scale, font, alignX, alignY, clip, wordBreak, false )
dxDrawText ( text:gsub('#%x%x%x%x%x%x', ''), x + 2, y + 2, w + 2, h + 2, tocolor ( 0, 0, 0, 225 ), scale, font, alignX, alignY, clip, wordBreak, false )
dxDrawText ( text:gsub('#%x%x%x%x%x%x', ''), x - 2, y, w - 2, h, tocolor ( 0, 0, 0, 225 ), scale, font, alignX, alignY, clip, wordBreak, false )
dxDrawText ( text:gsub('#%x%x%x%x%x%x', ''), x + 2, y, w + 2, h, tocolor ( 0, 0, 0, 225 ), scale, font, alignX, alignY, clip, wordBreak, false )
dxDrawText ( text:gsub('#%x%x%x%x%x%x', ''), x, y - 2, w, h - 2, tocolor ( 0, 0, 0, 225 ), scale, font, alignX, alignY, clip, wordBreak, false )
dxDrawText ( text:gsub('#%x%x%x%x%x%x', ''), x, y + 2, w, h + 2, tocolor ( 0, 0, 0, 225 ), scale, font, alignX, alignY, clip, wordBreak, false )
dxDrawText ( text, x, y, w, h, color, scale, font, alignX, alignY, clip, wordBreak, postGUI, true )
end


function dxDrawBorderedText( text, x, y, w, h, color, scale, font, alignX, alignY, clip, wordBreak, postGUI )
dxDrawText ( text:gsub('#%x%x%x%x%x%x', ''), x - 4, y - 4, w - 4, h - 4, tocolor ( 0, 0, 0, 225 ), scale, font, alignX, alignY, clip, wordBreak, false )
dxDrawText ( text:gsub('#%x%x%x%x%x%x', ''), x + 4, y - 4, w + 4, h - 4, tocolor ( 0, 0, 0, 225 ), scale, font, alignX, alignY, clip, wordBreak, false )
dxDrawText ( text:gsub('#%x%x%x%x%x%x', ''), x - 4, y + 4, w - 4, h + 4, tocolor ( 0, 0, 0, 225 ), scale, font, alignX, alignY, clip, wordBreak, false )
dxDrawText ( text:gsub('#%x%x%x%x%x%x', ''), x + 4, y + 4, w + 4, h + 4, tocolor ( 0, 0, 0, 225 ), scale, font, alignX, alignY, clip, wordBreak, false )
dxDrawText ( text:gsub('#%x%x%x%x%x%x', ''), x - 4, y, w - 4, h, tocolor ( 0, 0, 0, 225 ), scale, font, alignX, alignY, clip, wordBreak, false )
dxDrawText ( text:gsub('#%x%x%x%x%x%x', ''), x + 4, y, w + 4, h, tocolor ( 0, 0, 0, 225 ), scale, font, alignX, alignY, clip, wordBreak, false )
dxDrawText ( text:gsub('#%x%x%x%x%x%x', ''), x, y - 4, w, h - 4, tocolor ( 0, 0, 0, 225 ), scale, font, alignX, alignY, clip, wordBreak, false )
dxDrawText ( text:gsub('#%x%x%x%x%x%x', ''), x, y + 4, w, h + 4, tocolor ( 0, 0, 0, 225 ), scale, font, alignX, alignY, clip, wordBreak, false )
dxDrawText ( text, x, y, w, h, color, scale, font, alignX, alignY, clip, wordBreak, postGUI, true )
end






addEventHandler("onClientResourceStart", getRootElement(), function()
setAmbientSoundEnabled( "general", false )
setAmbientSoundEnabled( "gunfire", false )
end)

