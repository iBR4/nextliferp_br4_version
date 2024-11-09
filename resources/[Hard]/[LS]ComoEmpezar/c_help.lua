myWindow = nil
pressed = false
function bindKeys()
	addCommandHandler ( "comoempezar", F1RPhelp )
	addCommandHandler ( "cerrarpanel", F1RPhelp )
end
addEventHandler("onClientResourceStart", getRootElement(), bindKeys)
function resetState()
	pressed = false
end
function F1RPhelp( key, keyState )
	if not (pressed) then
		pressed = true
		setTimer(resetState, 200, 1)
		if ( myWindow == nil ) then		
			local xmlServerRules = xmlLoadFile( "serverrules.xml" )
			local xmlOverview = xmlLoadFile( "overview.xml" )
			
			myWindow = guiCreateWindow ( 0.25, 0.25, 0.5, 0.5, "Panel De ayuda ( Para cerrar este panel /cerrarpanel)", true )
			local tabPanel = guiCreateTabPanel ( 0, 0.1, 1, 1, true, myWindow )
			
			local tabRules = guiCreateTab( "Como empezar en el servidor", tabPanel )
			local memoRules = guiCreateMemo ( 0, 0.1, 1, 1, xmlNodeGetValue( xmlServerRules ), true, tabRules )
			guiMemoSetReadOnly(memoRules, true)
			
			
	        local tabOverview = guiCreateTab( "Reglas Basicas", tabPanel )
			local memoOverview = guiCreateMemo ( 0, 0.1, 1, 1, xmlNodeGetValue( xmlOverview ), true, tabOverview )
			guiMemoSetReadOnly(memoOverview, true)
			
			showCursor( true )
			
			xmlUnloadFile( xmlServerRules )
			xmlUnloadFile( xmlOverview )
			xmlUnloadFile( xmlServer )
		else
			destroyElement(myWindow)
			myWindow = nil
			showCursor(false)
		end
	end
end