--[[**********************************
*
*	Multi Theft Auto - Admin Panel
*
*	gui\admin_ban.lua
*
*	Original File by lil_Toady
*
*   Traducido al español por Zelev
*
**************************************]]

aBanForm = nil

local clipContent = nil

function aBanDetails ( ip )
	if ( aBanForm == nil ) then
		local x, y = guiGetScreenSize()
		aBanForm		= guiCreateWindow ( x / 2 - 185, y / 2 - 150, 330, 370, "Detalles", false )
		aBanIP			= guiCreateLabel ( 0.03, 0.10, 0.80, 0.09, "", true, aBanForm )
		aBanNick		= guiCreateLabel ( 0.03, 0.20, 0.80, 0.09, "", true, aBanForm )
		aBanDate		= guiCreateLabel ( 0.03, 0.30, 0.80, 0.09, "", true, aBanForm )
		aBanTime		= guiCreateLabel ( 0.03, 0.40, 0.80, 0.09, "", true, aBanForm )
		aBanBanner		= guiCreateLabel ( 0.03, 0.50, 0.80, 0.09, "", true, aBanForm )
		aBanUnban		= guiCreateLabel ( 0.03, 0.60, 0.80, 0.09, "", true, aBanForm )
		aBanCopy		= guiCreateButton ( 0.03, 0.88, 0.30, 0.08, "", true, aBanForm )
		aBanClose		= guiCreateButton ( 0.80, 0.88, 0.17, 0.08, "Cerrar", true, aBanForm )

		guiSetVisible ( aBanForm, false )
		addEventHandler ( "onClientGUIClick", aBanForm, aClientBanClick )
		addEventHandler ( "onClientGUISize", aBanForm, aBanDetailsWindowResize, false )

		--Register With Admin Form
		aRegister ( "BanDetails", aBanForm, aBanDetails, aBanDetailsClose )
	end
	if ( aBans["IP"][ip] ) then
		clipContent = { "Dirección IP", ip }
		guiSetText ( aBanIP, "IP: "..ip )
		guiSetText ( aBanNick, "Nombre: "..iif ( aBans["IP"][ip]["nick"], aBans["IP"][ip]["nick"], "desconocido" ) )
		guiSetText ( aBanDate, "Fecha: "..iif ( aBans["IP"][ip]["date"], aBans["IP"][ip]["date"], "desconocida" ) )
		guiSetText ( aBanTime, "Hora: "..iif ( aBans["IP"][ip]["time"], aBans["IP"][ip]["time"], "desconocida" ) )
		guiSetText ( aBanBanner, "Baneado por: "..iif ( aBans["IP"][ip]["banner"], aBans["IP"][ip]["banner"], "desconocido" ) )
		guiSetText ( aBanCopy, "Copiar IP" )
		local unban = tostring(aBans["IP"][ip]["unban"])
		if not unban or unban == "0" then
			guiSetText ( aBanUnban, "Desban: Permanente", unban)
		else
			guiSetText ( aBanUnban, "Desban: "..FormatDate("d/m/y h:i:s", "'", unban) )
		end
		if ( aBanReason ) then destroyElement ( aBanReason ) end
		aBanReason = guiCreateLabel ( 0.03, 0.70, 0.80, 0.30, "Razón: "..iif ( aBans["IP"][ip]["reason"], aBans["IP"][ip]["reason"], "desconocida" ), true, aBanForm )
		guiLabelSetHorizontalAlign ( aBanReason, "left", true )
		guiSetVisible ( aBanForm, true )
		guiBringToFront ( aBanForm )
		guiBringToFront ( aBanCopy )
	elseif ( aBans["Serial"][ip] ) then
		clipContent = { "serial", ip }
		guiSetText ( aBanIP, "Serial: "..ip )
		guiSetText ( aBanNick, "Nombre: "..iif ( aBans["Serial"][ip]["nick"], aBans["Serial"][ip]["nick"], "desconocido" ) )
		guiSetText ( aBanDate, "Fecha: "..iif ( aBans["Serial"][ip]["date"], aBans["Serial"][ip]["date"], "desconocida" ) )
		guiSetText ( aBanTime, "Hora: "..iif ( aBans["Serial"][ip]["time"], aBans["Serial"][ip]["time"], "desconocida" ) )
		guiSetText ( aBanBanner, "Baneado por: "..iif ( aBans["Serial"][ip]["banner"], aBans["Serial"][ip]["banner"], "desconocido" ) )
		guiSetText ( aBanCopy, "Copiar serial" )
		local unban = tostring(aBans["Serial"][ip]["unban"])
		if not unban or unban == "0" then
			guiSetText ( aBanUnban, "Desban: Permanent", unban)
		else
			guiSetText ( aBanUnban, "Desban: "..FormatDate("d/m/y h:i:s", "'", unban) )
		end
		if ( aBanReason ) then destroyElement ( aBanReason ) end
		aBanReason = guiCreateLabel ( 0.03, 0.70, 0.80, 0.30, "Razón: "..iif ( aBans["Serial"][ip]["reason"], aBans["Serial"][ip]["reason"], "desconocida" ), true, aBanForm )
		guiLabelSetHorizontalAlign ( aBanReason, "left", true )
		guiSetVisible ( aBanForm, true )
		guiBringToFront ( aBanForm )
		guiBringToFront ( aBanCopy )
	end
end

function aBanDetailsClose ( destroy )
	if ( ( destroy ) or ( guiCheckBoxGetSelected ( aPerformanceBan ) ) ) then
		if ( aBanForm ) then
			removeEventHandler ( "onClientGUIClick", aBanForm, aClientBanClick )
			destroyElement ( aBanForm )
			aBanForm = nil
			clipContent = nil
		end
	else
		guiSetVisible ( aBanForm, false )
	end
end

function aClientBanClick ( button )
	if ( button == "left" ) then
		if ( source == aBanClose ) then
			aBanDetailsClose ( false )
		elseif ( source == aBanUnban ) then
			triggerEvent ( "onClientGUIClick", aTab4.BansUnban, "left" )
		elseif ( source == aBanCopy ) then
			setClipboard( clipContent[2] )
			outputChatBox( "Con éxito se ha copiado " .. clipContent[1] .. " al portapapeles.", 255, 100, 70 )
		end
	end
end

-- BUGFIX: Buttons stop working on ban details window resize.
-- MTA seems not to update GUI position on resize but does move the clickable area.
-- Could also be a problem deeper in the admin code
-- Workaround is just to setPosition and setSize to update it.
function aBanDetailsWindowResize ()
	guiSetSize( aBanCopy, 0.30, 0.08, true )
	guiSetSize( aBanClose, 0.17, 0.08, true )
	guiSetPosition( aBanCopy, 0.03, 0.88, true )
	guiSetPosition( aBanClose, 0.80, 0.88, true )
end
