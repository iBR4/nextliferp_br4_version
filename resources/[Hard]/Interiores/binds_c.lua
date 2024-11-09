addEvent( "mensajeImportante", true )
addEventHandler( "mensajeImportante", getRootElement( ),
	function( )
		setWindowFlashing( true, 5 )
	end
)
function playPmSounda()
local pmsounda = playSound("puerta.ogg",false)
setSoundVolume(pmsounda, 0.90)
end
addEvent("puerta",true)
addEventHandler("puerta",getRootElement(),playPmSounda)
--[[
function playVideo (posX, posY, width, height, url, duration, canClose, postGUI)
	if not posX or not posY or not width or not height or not url then
		return false
	end
	local webBrowser = false
	closeButton = guiCreateButton (0.97, 0, 0.03, 0.03, "X", true)
	guiSetAlpha (closeButton, 0.5)
	guiSetVisible (closeButton, false)
	if not isElement (webBrowser) then
		webBrowser = createBrowser (width, height, false, false)
		function createVideoPlayer ()
			function webBrowserRender ()
				dxDrawImage (posX, posY, width, height, webBrowser, 0, 0, 0, tocolor(255,255,255,255), postGUI)
			end
			loadBrowserURL (webBrowser, url)
			
			setTimer (function()
				addEventHandler ("onClientRender", getRootElement(), webBrowserRender)
				showChat (false)
				if canClose then
					guiSetVisible (closeButton, true)
					showCursor (true)
				end
			end, 500, 1)
			setElementFrozen (localPlayer, true)
			if duration then
				videoTimer = setTimer (function()
					removeEventHandler ("onClientRender", getRootElement(), webBrowserRender)
					setElementFrozen (localPlayer, false)
					guiSetVisible (closeButton, false)
					showCursor (false)
					showChat (true)
					destroyElement (webBrowser)
				end, duration, 1)
			end
			
			addEventHandler ("onClientGUIClick", closeButton, function (button, state)
				if button == "left" then
					if isTimer (videoTimer) then
						killTimer (videoTimer)
						videoTimer = nil
						removeEventHandler ("onClientRender", getRootElement(), webBrowserRender)
						setElementFrozen (localPlayer, false)
						guiSetVisible (closeButton, false)
						showCursor (false)
						showChat (true)
						destroyElement (webBrowser)
					end
				end
			end, false)
		end
		setTimer (createVideoPlayer, 500, 1)
	end
end
-- <iframe width="922" height="519" src="https://www.youtube.com/embed/dAwocGl8QRc" title="se te acabó, Dama G." frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture; web-share" allowfullscreen></iframe>
-- "https://www.youtube.com/embed/NbGZeMFmcGc?autoplay=1&showinfo=0&rel=0&controls=0&disablekb=1"
--<iframe width="1397" height="795" src="https://www.youtube.com/embed/NbGZeMFmcGc" title="carga" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture; web-share" allowfullscreen></iframe>
-- /mods/deathmatch/resources/[Hard]/Interiores
-- <iframe width="1397" height="795" src="https://www.youtube.com/embed/1WdF_OjGajk" title="El día que John Cena DESTRUYÓ mentalmente a The Rock con tan solo UNA promo" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture; web-share" allowfullscreen></iframe>
local x, y = guiGetScreenSize()
function defaultFunction ()
	playVideo (0, 0, x, y, "https://www.youtube.com/embed/WuEXmwek-y4?autoplay=1&showinfo=0&rel=0&controls=0&disablekb=1&color=white", 12500, true, true)
end
addCommandHandler ("intro", defaultFunction)
]]