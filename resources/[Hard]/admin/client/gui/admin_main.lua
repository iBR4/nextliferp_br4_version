--[[**********************************
*
*	Multi Theft Auto - Admin Panel
*
*	gui\admin_main.lua
*
*	Original File by lil_Toady
*
*   Traducido al español por Zelev
*
**************************************]]

aAdminForm = nil
aLastCheck = 0
aCurrentVehicle = 429
aCurrentWeapon = 30
aCurrentAmmo = 90
aCurrentSlap = 20
aPlayers = {}
aBans = {}
aLastSync = 0
aResources = {}

function guiComboBoxAdjustHeight ( combobox, itemcount )
    if getElementType ( combobox ) ~= "gui-combobox" or type ( itemcount ) ~= "number" then error ( "Invalid arguments @ 'guiComboBoxAdjustHeight'", 2 ) end
    local width = guiGetSize ( combobox, false )
    return guiSetSize ( combobox, width, ( itemcount * 20 ) + 20, false )
end

function aAdminMenu ()
	if ( aAdminForm == nil ) then
		local x, y = guiGetScreenSize()
		aAdminForm			= guiCreateWindow ( x / 2 - 310, y / 2 - 260, 620, 520, "", false )
							guiWindowSetSizable ( aAdminForm, false )
						  guiSetText ( aAdminForm, "Panel de Admin   -   v".._version.."   [ESP]" )
						  guiCreateLabel ( 0.75, 0.05, 0.45, 0.04, "por lil_Toady", true, aAdminForm )
		aTabPanel			= guiCreateTabPanel ( 0.01, 0.05, 0.98, 0.95, true, aAdminForm )
		aTab1 = {}
		aTab1.Tab			= guiCreateTab ( "Jugador", aTabPanel, "players" )
		aTab1.Messages		= guiCreateButton ( 0.75, 0.02, 0.23, 0.04, "0/0 no leídos", true, aTab1.Tab )
		aTab1.ScreenShots		= guiCreateButton ( 0.75, 0.065, 0.23, 0.04, "capturas de pantalla", true, aTab1.Tab )
		aTab1.PlayerListSearch 	= guiCreateEdit ( 0.03, 0.05, 0.16, 0.04, "", true, aTab1.Tab )
						  guiCreateStaticImage ( 0.19, 0.05, 0.035, 0.04, "client\\images\\search.png", true, aTab1.Tab )
		aTab1.HideColorCodes= guiCreateCheckBox ( 0.037, 0.94, 0.20, 0.04, "Ocultar códigos", true, true, aTab1.Tab )
		aTab1.PlayerList		= guiCreateGridList ( 0.03, 0.10, 0.20, 0.83, true, aTab1.Tab )
						  guiGridListAddColumn( aTab1.PlayerList, "Nombre", 0.85 )
						  guiGridListSetSortingEnabled ( aTab1.PlayerList, false )
						  for id, player in ipairs ( getElementsByType ( "player" ) ) do guiGridListSetItemPlayerName ( aTab1.PlayerList, guiGridListAddRow ( aTab1.PlayerList ), 1, getPlayerName ( player ), false, false ) end
		aTab1.Kick			= guiCreateButton ( 0.71, 0.125, 0.13, 0.04, "Kickear", true, aTab1.Tab, "kick" )
		aTab1.Ban			= guiCreateButton ( 0.85, 0.125, 0.13, 0.04, "Banear", true, aTab1.Tab, "ban" )
		aTab1.Mute			= guiCreateButton ( 0.71, 0.170, 0.13, 0.04, "Mutear", true, aTab1.Tab, "mute" )
		aTab1.Freeze		= guiCreateButton ( 0.85, 0.170, 0.13, 0.04, "Congelar", true, aTab1.Tab, "freeze" )
		aTab1.Spectate		= guiCreateButton ( 0.71, 0.215, 0.13, 0.04, "Espectar", true, aTab1.Tab, "spectate" )
		aTab1.Slap			= guiCreateButton ( 0.85, 0.215, 0.13, 0.04, "¡Pegar! "..aCurrentSlap.." _", true, aTab1.Tab, "slap" )
		aTab1.SlapDropDown	= guiCreateStaticImage ( 0.95, 0.215, 0.03, 0.04, "client\\images\\dropdown.png", true, aTab1.Tab )
		aTab1.SlapOptions		= guiCreateGridList ( 0.85, 0.215, 0.13, 0.40, true, aTab1.Tab )
						  guiGridListSetSortingEnabled ( aTab1.SlapOptions, false )
						  guiGridListAddColumn( aTab1.SlapOptions, "", 0.85 )
						  guiSetVisible ( aTab1.SlapOptions, false )
						  for i = 0, 10 do guiGridListSetItemText ( aTab1.SlapOptions, guiGridListAddRow ( aTab1.SlapOptions ), 1, tostring ( i * 10 ), false, false ) end
		aTab1.Nick			= guiCreateButton ( 0.71, 0.260, 0.13, 0.04, "Nombre", true, aTab1.Tab )
		aTab1.Shout			= guiCreateButton ( 0.85, 0.260, 0.13, 0.04, "¡Gritar!", true, aTab1.Tab, "shout" )
		aTab1.Admin			= guiCreateButton ( 0.71, 0.305, 0.27, 0.04, "Dar derechos de admin", true, aTab1.Tab, "setgroup" )

		local y = 0.03		-- Start y coord
		local A = 0.045		-- Large line gap
		local B = 0.035		-- Small line gap

						     guiCreateHeader ( 0.25, y, 0.20, 0.04, "Jugador:", true, aTab1.Tab )
y=y+A   aTab1.Name			= guiCreateLabel ( 0.26, y, 0.30, 0.035, "Nombre: N/A", true, aTab1.Tab )
y=y+A   aTab1.IP			= guiCreateLabel ( 0.26, y, 0.30, 0.035, "IP: N/A", true, aTab1.Tab )
		aTab1.CountryCode	= guiCreateLabel ( 0.45, y, 0.04, 0.035, "", true, aTab1.Tab )
		aTab1.Flag	  = guiCreateStaticImage ( 0.40, y, 0.025806, 0.021154, "client\\images\\empty.png", true, aTab1.Tab )
y=y+A   aTab1.Serial		= guiCreateLabel ( 0.26, y, 0.435, 0.035, "Serial: N/A", true, aTab1.Tab )
		--aTab1.Username		= guiCreateLabel ( 0.26, 0.245, 0.435, 0.035, "Username: N/A", true, aTab1.Tab )
y=y+B   aTab1.Version		= guiCreateLabel ( 0.26, y, 0.435, 0.035, "Versión: N/A", true, aTab1.Tab )
y=y+B   aTab1.Accountname	= guiCreateLabel ( 0.26, y, 0.435, 0.035, "Nombre de cuenta: N/A", true, aTab1.Tab )
y=y+B   aTab1.Groups		= guiCreateLabel ( 0.26, y, 0.435, 0.035, "Grupos: N/A", true, aTab1.Tab )
y=y+A   aTab1.ACDetected	= guiCreateLabel ( 0.26, y, 0.30, 0.035, "AC detectado: N/A", true, aTab1.Tab )
y=y+B   aTab1.ACD3D			= guiCreateLabel ( 0.26, y, 0.30, 0.035, "D3D9.DLL: N/A", true, aTab1.Tab )
y=y+B   aTab1.ACModInfo		= guiCreateLabel ( 0.26, y, 0.20, 0.035, "IMG mods: N/A", true, aTab1.Tab )
		aTab1.ACModDetails = guiCreateButton ( 0.46, y, 0.13, 0.04, "Detalles", true, aTab1.Tab )


		B = 0.040
y=y+A  				         guiCreateHeader ( 0.25, y, 0.20, 0.04, "Juego:", true, aTab1.Tab )
y=y+A   aTab1.Health		= guiCreateLabel ( 0.26, y, 0.20, 0.04, "Salud: 0%", true, aTab1.Tab )
		aTab1.Armour		= guiCreateLabel ( 0.45, y, 0.20, 0.04, "Armadura: 0%", true, aTab1.Tab )
y=y+B   aTab1.Skin			= guiCreateLabel ( 0.26, y, 0.20, 0.04, "Skin: N/A", true, aTab1.Tab )
		aTab1.Team			= guiCreateLabel ( 0.45, y, 0.20, 0.04, "Team: ninguno", true, aTab1.Tab )
y=y+B   aTab1.Weapon		= guiCreateLabel ( 0.26, y, 0.35, 0.04, "Arma: N/A", true, aTab1.Tab )
y=y+B   aTab1.Ping			= guiCreateLabel ( 0.26, y, 0.20, 0.04, "Ping: 0", true, aTab1.Tab )
		aTab1.Money			= guiCreateLabel ( 0.45, y, 0.20, 0.04, "Dinero: 0", true, aTab1.Tab )
y=y+B   aTab1.Area			= guiCreateLabel ( 0.26, y, 0.44, 0.04, "Zona: desconocida", true, aTab1.Tab )
y=y+B   aTab1.PositionX		= guiCreateLabel ( 0.26, y, 0.30, 0.04, "X: 0", true, aTab1.Tab )
y=y+B   aTab1.PositionY		= guiCreateLabel ( 0.26, y, 0.30, 0.04, "Y: 0", true, aTab1.Tab )
y=y+B   aTab1.PositionZ		= guiCreateLabel ( 0.26, y, 0.30, 0.04, "Z: 0", true, aTab1.Tab )
y=y+B   aTab1.Dimension		= guiCreateLabel ( 0.26, y, 0.20, 0.04, "Dimensión: 0", true, aTab1.Tab )
		aTab1.Interior		= guiCreateLabel ( 0.45, y, 0.20, 0.04, "Interior: 0", true, aTab1.Tab )

y=y+A  				         guiCreateHeader ( 0.25, y, 0.20, 0.04, "Vehículo:", true, aTab1.Tab )
y=y+A  aTab1.Vehicle		= guiCreateLabel ( 0.26, y, 0.35, 0.04, "Vehículo: N/A", true, aTab1.Tab )
y=y+B  aTab1.VehicleHealth	= guiCreateLabel ( 0.26, y, 0.25, 0.04, "Estado del vehículo: 0%", true, aTab1.Tab )

		aTab1.SetHealth		= guiCreateButton ( 0.71, 0.395, 0.13, 0.04, "Salud", true, aTab1.Tab, "sethealth" )
		aTab1.SetArmour		= guiCreateButton ( 0.85, 0.395, 0.13, 0.04, "Armadura", true, aTab1.Tab, "setarmour" )
		aTab1.SetSkin		= guiCreateButton ( 0.71, 0.440, 0.13, 0.04, "Skin", true, aTab1.Tab, "setskin" )
		aTab1.SetTeam		= guiCreateButton ( 0.85, 0.440, 0.13, 0.04, "Team", true, aTab1.Tab, "setteam" )
		aTab1.SetDimension	= guiCreateButton ( 0.71, 0.755, 0.13, 0.04, "Dimensión", true, aTab1.Tab, "setdimension" )
		aTab1.SetInterior		= guiCreateButton ( 0.85, 0.755, 0.13, 0.04, "Interior", true, aTab1.Tab, "setinterior" )
		aTab1.GiveWeapon		= guiCreateButton ( 0.71, 0.485, 0.27, 0.04, "Dar: "..getWeaponNameFromID ( aCurrentWeapon ), true, aTab1.Tab, "giveweapon" )
		aTab1.WeaponDropDown	= guiCreateStaticImage ( 0.95, 0.485, 0.03, 0.04, "client\\images\\dropdown.png", true, aTab1.Tab )
		aTab1.WeaponOptions	= guiCreateGridList ( 0.71, 0.485, 0.27, 0.48, true, aTab1.Tab )
						  guiGridListAddColumn( aTab1.WeaponOptions, "", 0.85 )
						  guiSetVisible ( aTab1.WeaponOptions, false )
						  for i = 1, 46 do if ( getWeaponNameFromID ( i ) ~= false ) then guiGridListSetItemText ( aTab1.WeaponOptions, guiGridListAddRow ( aTab1.WeaponOptions ), 1, getWeaponNameFromID ( i ), false, false ) end end
		aTab1.SetMoney		= guiCreateButton ( 0.71, 0.530, 0.13, 0.04, "Dinero", true, aTab1.Tab, "setmoney" )
		aTab1.SetStats		= guiCreateButton ( 0.85, 0.530, 0.13, 0.04, "Stats", true, aTab1.Tab, "setstat" )
		aTab1.JetPack		= guiCreateButton ( 0.71, 0.575, 0.27, 0.04, "Otorgar JetPack", true, aTab1.Tab, "jetpack" )
		aTab1.Warp			= guiCreateButton ( 0.71, 0.620, 0.27, 0.04, "Teletransportarse", true, aTab1.Tab, "warp" )
		aTab1.WarpTo		= guiCreateButton ( 0.71, 0.665, 0.27, 0.04, "Teletransportar a...", true, aTab1.Tab, "warp" )
		aTab1.VehicleFix		= guiCreateButton ( 0.71, 0.84, 0.13, 0.04, "Reparar", true, aTab1.Tab, "repair" )
		aTab1.VehicleDestroy	= guiCreateButton ( 0.71, 0.89, 0.13, 0.04, "Destruir", true, aTab1.Tab, "destroyvehicle" )
		aTab1.VehicleBlow		= guiCreateButton ( 0.85, 0.84, 0.13, 0.04, "Explotar", true, aTab1.Tab, "blowvehicle" )
		aTab1.VehicleCustomize 	= guiCreateButton ( 0.85, 0.89, 0.13, 0.04, "Customizar", true, aTab1.Tab, "customize" )
		aTab1.AnonAdmin		  = guiCreateCheckBox (0.745, 0.942, 0.20, 0.04, "Admin anónimo", isAnonAdmin(), true, aTab1.Tab )
		aTab1.GiveVehicle		= guiCreateButton ( 0.71, 0.710, 0.27, 0.04, "Dar: "..getVehicleNameFromModel ( aCurrentVehicle ), true, aTab1.Tab, "givevehicle" )
		aTab1.VehicleDropDown 	= guiCreateStaticImage ( 0.95, 0.710, 0.03, 0.04, "client\\images\\dropdown.png", true, aTab1.Tab )
		local gx, gy 		= guiGetSize ( aTab1.GiveVehicle, false )
		aTab1.VehicleOptions	= guiCreateGridList ( 0, 0, gx, 200, false )
						  guiGridListAddColumn( aTab1.VehicleOptions, "", 0.85 )
						  guiSetAlpha ( aTab1.VehicleOptions, 0.80 )
						  guiSetVisible ( aTab1.VehicleOptions, false )
							local vehicleNames = {}
							for i = 400, 611 do
								if ( getVehicleNameFromModel ( i ) ~= "" ) then
									table.insert( vehicleNames, { model = i, name = getVehicleNameFromModel ( i ) } )
								end
							end
							table.sort( vehicleNames, function(a, b) return a.name < b.name end )
							for _,info in ipairs(vehicleNames) do
								local row = guiGridListAddRow ( aTab1.VehicleOptions )
								guiGridListSetItemText ( aTab1.VehicleOptions, row, 1, info.name, false, false )
								guiGridListSetItemData ( aTab1.VehicleOptions, row, 1, tostring ( info.model ) )
							end
		aTab2 = {}
		aTab2.Tab			= guiCreateTab ( "Resources", aTabPanel, "resources" )
		aTab2.ManageACL		= guiCreateButton ( 0.75, 0.02, 0.23, 0.04, "Administrar ACL", true, aTab2.Tab )
		aTab2.ResourceListSearch = guiCreateEdit ( 0.03, 0.05, 0.31, 0.04, "", true, aTab2.Tab )
						  guiCreateStaticImage ( 0.34, 0.05, 0.035, 0.04, "client\\images\\search.png", true, aTab2.Tab )
		aTab2.ResourceList	= guiCreateGridList ( 0.03, 0.10, 0.35, 0.80, true, aTab2.Tab )
						  guiGridListAddColumn( aTab2.ResourceList, "Resource", 0.55 )
						  guiGridListAddColumn( aTab2.ResourceList, "", 0.05 )
						  guiGridListAddColumn( aTab2.ResourceList, "Estado", 0.35 )
						  guiGridListAddColumn( aTab2.ResourceList, "Nombre completo", 0.6 )
						  guiGridListAddColumn( aTab2.ResourceList, "Autor", 0.4 )
						  guiGridListAddColumn( aTab2.ResourceList, "Versión", 0.2 )
		aTab2.ResourceInclMaps	= guiCreateCheckBox ( 0.03, 0.91, 0.15, 0.04, "Incluir mapas", false, true, aTab2.Tab )
		aTab2.ResourceRefresh	= guiCreateButton ( 0.20, 0.915, 0.18, 0.04, "Actualizar lista", true, aTab2.Tab, "listresources" )
		aTab2.ResourceSettings	= guiCreateButton ( 0.40, 0.05, 0.20, 0.04, "Ajustes", true, aTab2.Tab )
		aTab2.ResourceStart	= guiCreateButton ( 0.40, 0.10, 0.20, 0.04, "Iniciar", true, aTab2.Tab, "start" )
		aTab2.ResourceRestart	= guiCreateButton ( 0.40, 0.15, 0.20, 0.04, "Reiniciar", true, aTab2.Tab, "restart" )
		aTab2.ResourceStop	= guiCreateButton ( 0.40, 0.20, 0.20, 0.04, "Detener", true, aTab2.Tab, "stop" )
		aTab2.ResourceDelete	= guiCreateButton ( 0.40, 0.25, 0.20, 0.04, "Eliminar", true, aTab2.Tab, "delete" )
		aTab2.ResourcesStopAll	= guiCreateButton ( 0.63, 0.2, 0.20, 0.04, "DETENER TODO", true, aTab2.Tab, "stopall" )
		aTab2.ResourceFailture	= guiCreateButton ( 0.63, 0.10, 0.25, 0.04, "Ver fallo de carga", true, aTab2.Tab )
						 guiSetVisible ( aTab2.ResourceFailture, false )
		--aModules			= guiCreateTabPanel ( 0.40, 0.25, 0.57, 0.38, true, aTab2.Tab ) --What's that for?
							guiCreateHeader(0.40, 0.3, 0.3, 0.04, "Información del resource:", true, aTab2.Tab)
		aTab2.ResourceName			= guiCreateLabel ( 0.41, 0.35, 0.6, 0.03, "Nombre completo: ", true, aTab2.Tab )
		aTab2.ResourceAuthor		= guiCreateLabel ( 0.41, 0.4, 0.6, 0.03, "Autor: ", true, aTab2.Tab )
		aTab2.ResourceVersion		= guiCreateLabel ( 0.41, 0.45, 0.6, 0.03, "Versión: ", true, aTab2.Tab )
		aTab2.ResourceVersion		= guiCreateLabel ( 0.41, 0.45, 0.6, 0.03, "Versión: ", true, aTab2.Tab )
						  guiCreateLabel ( 0.40, 0.77, 0.20, 0.03, "Registro de cambios:", true, aTab2.Tab )
		aTab2.LogLine1		= guiCreateLabel ( 0.41, 0.81, 0.50, 0.03, "", true, aTab2.Tab )
		aTab2.LogLine2		= guiCreateLabel ( 0.41, 0.84, 0.50, 0.03, "", true, aTab2.Tab )
		aTab2.LogLine3		= guiCreateLabel ( 0.41, 0.87, 0.50, 0.03, "", true, aTab2.Tab )
		aTab2.LogLine4		= guiCreateLabel ( 0.41, 0.90, 0.50, 0.03, "", true, aTab2.Tab )
		aTab2.LogLine5		= guiCreateLabel ( 0.41, 0.93, 0.50, 0.03, "", true, aTab2.Tab )
						  guiCreateLabel ( 0.41, 0.65, 0.50, 0.04, "Ejecutar comando:", true, aTab2.Tab )
		aTab2.Command		= guiCreateEdit ( 0.41, 0.70, 0.40, 0.055, "", true, aTab2.Tab )
		aTab2.ExecuteClient	= guiCreateButton ( 0.82, 0.70, 0.16, 0.035, "Client", true, aTab2.Tab, "execute" )
		aTab2.ExecuteServer	= guiCreateButton ( 0.82, 0.736, 0.16, 0.035, "Server", true, aTab2.Tab, "execute" )
		aTab2.ExecuteAdvanced	= guiCreateLabel ( 0.45, 0.71, 0.50, 0.04, "Solo para usuarios avanzados.", true, aTab2.Tab )
						  guiLabelSetColor ( aTab2.ExecuteAdvanced, 255, 0, 0 )
		aLogLines = 1

		createMapTab()

		aTab3 = {}
		aTab3.Tab			= guiCreateTab ( "Server", aTabPanel, "server" )
		aTab3.Server		= guiCreateLabel ( 0.05, 0.05, 0.70, 0.05, "Servidor: desconocido", true, aTab3.Tab )
		aTab3.Password		= guiCreateLabel ( 0.05, 0.10, 0.40, 0.05, "Contraseña: ninguna", true, aTab3.Tab )
		aTab3.GameType		= guiCreateLabel ( 0.05, 0.15, 0.40, 0.05, "Tipo de juego: ninguno", true, aTab3.Tab )
		aTab3.MapName		= guiCreateLabel ( 0.05, 0.20, 0.40, 0.05, "Nombre del mapa: ninguno", true, aTab3.Tab )
		aTab3.Players		= guiCreateLabel ( 0.05, 0.25, 0.20, 0.05, "Jugadores: 0/0", true, aTab3.Tab )
		aTab3.SetPassword		= guiCreateButton ( 0.80, 0.05, 0.18, 0.04, "Contraseña", true, aTab3.Tab, "setpassword" )
		aTab3.ResetPassword	= guiCreateButton ( 0.80, 0.10, 0.18, 0.04, "Nueva contras.", true, aTab3.Tab, "setpassword" )
		aTab3.SetGameType		= guiCreateButton ( 0.80, 0.15, 0.18, 0.04, "Tipo de juego", true, aTab3.Tab, "setgame" )
		aTab3.SetMapName		= guiCreateButton ( 0.80, 0.20, 0.18, 0.04, "Nombre del mapa", true, aTab3.Tab, "setmap" )
		aTab3.SetWelcome		= guiCreateButton ( 0.80, 0.25, 0.18, 0.04, "Bienvenida", true, aTab3.Tab, "setwelcome" )
		aTab3.Shutdown		= guiCreateButton ( 0.80, 0.3, 0.18, 0.04, "Apagar", true, aTab3.Tab, "shutdown" )
						  guiCreateStaticImage ( 0.05, 0.32, 0.50, 0.0025, "client\\images\\dot.png", true, aTab3.Tab )
		aTab3.WeatherCurrent	= guiCreateLabel ( 0.05, 0.35, 0.45, 0.05, "Clima actual: "..getWeather().." ("..getWeatherNameFromID ( getWeather() )..")", true, aTab3.Tab )
		aTab3.WeatherDec		= guiCreateButton ( 0.05, 0.40, 0.035, 0.04, "<", true, aTab3.Tab )
		aTab3.Weather		= guiCreateEdit ( 0.095, 0.40, 0.35, 0.04, getWeather().." ("..getWeatherNameFromID ( getWeather() )..")", true, aTab3.Tab )
		aTab3.WeatherInc		= guiCreateButton ( 0.45, 0.40, 0.035, 0.04, ">", true, aTab3.Tab )
						  guiEditSetReadOnly ( aTab3.Weather, true )
		aTab3.WeatherSet		= guiCreateButton ( 0.50, 0.40, 0.10, 0.04, "Fijar", true, aTab3.Tab, "setweather" )
		aTab3.WeatherBlend	= guiCreateButton ( 0.61, 0.40, 0.15, 0.04, "Mezclar", true, aTab3.Tab, "blendweather" )

						  local th, tm = getTime()
		aTab3.TimeCurrent		= guiCreateLabel ( 0.05, 0.45, 0.25, 0.04, "Hora: "..th..":"..tm, true, aTab3.Tab )
		aTab3.TimeH			= guiCreateEdit ( 0.35, 0.45, 0.055, 0.04, "12", true, aTab3.Tab )
		aTab3.TimeM			= guiCreateEdit ( 0.425, 0.45, 0.055, 0.04, "00", true, aTab3.Tab )
						  guiCreateLabel ( 0.415, 0.45, 0.05, 0.04, ":", true, aTab3.Tab )
						  guiEditSetMaxLength ( aTab3.TimeH, 2 )
						  guiEditSetMaxLength ( aTab3.TimeM, 2 )
		aTab3.TimeSet		= guiCreateButton ( 0.50, 0.45, 0.10, 0.04, "Fijar", true, aTab3.Tab, "settime" )
						  guiCreateLabel ( 0.63, 0.45, 0.12, 0.04, "( 0-23:0-59 )", true, aTab3.Tab )

		aTab3.GravityCurrent	= guiCreateLabel ( 0.05, 0.50, 0.28, 0.04, "Gravedad: "..string.sub ( getGravity(), 0, 6 ), true, aTab3.Tab )
		aTab3.Gravity		= guiCreateEdit ( 0.35, 0.50, 0.135, 0.04, "0.008", true, aTab3.Tab )
		aTab3.GravitySet		= guiCreateButton ( 0.50, 0.50, 0.10, 0.04, "Fijar", true, aTab3.Tab, "setgravity" )

		aTab3.SpeedCurrent	= guiCreateLabel ( 0.05, 0.55, 0.30, 0.04, "Velocidad del juego: "..getGameSpeed(), true, aTab3.Tab )
		aTab3.Speed			= guiCreateEdit ( 0.35, 0.55, 0.135, 0.04, "1", true, aTab3.Tab )
		aTab3.SpeedSet		= guiCreateButton ( 0.50, 0.55, 0.10, 0.04, "Fijar", true, aTab3.Tab, "setgamespeed" )
						  guiCreateLabel ( 0.63, 0.55, 0.09, 0.04, "( 0-10 )", true, aTab3.Tab )

		aTab3.WavesCurrent	= guiCreateLabel ( 0.05, 0.60, 0.25, 0.04, "Altitud de olas: "..getWaveHeight(), true, aTab3.Tab )
		aTab3.Waves			= guiCreateEdit ( 0.35, 0.60, 0.135, 0.04, "0", true, aTab3.Tab )
		aTab3.WavesSet		= guiCreateButton ( 0.50, 0.60, 0.10, 0.04, "Fijar", true, aTab3.Tab, "setwaveheight" )
					 	 guiCreateLabel ( 0.63, 0.60, 0.09, 0.04, "( 0-100 )", true, aTab3.Tab )

		aTab3.FPSCurrent	= guiCreateLabel ( 0.05, 0.65, 0.25, 0.04, "Límite de FPS: 38", true, aTab3.Tab )
		aTab3.FPS			= guiCreateEdit ( 0.35, 0.65, 0.135, 0.04, "38", true, aTab3.Tab )
		aTab3.FPSSet		= guiCreateButton ( 0.50, 0.65, 0.10, 0.04, "Fijar", true, aTab3.Tab, "setfpslimit" )
					 	 guiCreateLabel ( 0.63, 0.65, 0.1, 0.04, "( 25-100 )", true, aTab3.Tab )


		aTab4 = {}
		aTab4.Tab			= guiCreateTab ( "Bans", aTabPanel, "bans" )
		aTab4.BansList		= guiCreateGridList ( 0.03, 0.12, 0.80, 0.8, true, aTab4.Tab )
		aTab4.EditBox		= guiCreateEdit ( 0.03, 0.05, 0.54, 0.05, "", true, aTab4.Tab )
		aTab4.ComboBox		= guiCreateComboBox ( 0.58, 0.05, 0.12, 0.05, "Elegir", true, aTab4.Tab )
		aTab4.Button		= guiCreateButton ( 0.71, 0.05, 0.12, 0.05, "Buscar...", true, aTab4.Tab )
		aTab4.ProgressBar		= guiCreateProgressBar ( 0.03, 0.88, 0.8, 0.05, true, aTab4.Tab )
						guiSetVisible (aTab4.ProgressBar,false)
						local ComboBoxItems = {"Serial","IP","Nombre","Admin","Razón"}
							for i,ComboBoxIndividualItems in ipairs (ComboBoxItems) do
								guiComboBoxAddItem (aTab4.ComboBox,ComboBoxIndividualItems)
							end
						guiComboBoxAdjustHeight (aTab4.ComboBox,#ComboBoxItems)
						ComboBoxItems = nil
						guiComboBoxSetSelected (aTab4.ComboBox,0)


				function searchBans()
				local searchText = guiGetText (aTab4.EditBox)
					if searchText == "" then
					triggerServerEvent ( "aSync", localPlayer, "bans" )
					else
					local itemBoxSelected = guiComboBoxGetSelected(aTab4.ComboBox)
					local text = guiComboBoxGetItemText(aTab4.ComboBox, itemBoxSelected)
					guiGridListClear (aTab4.BansList)
					triggerServerEvent ( "aSync", localPlayer, "bansearch",{text,searchText})
					end

				end
				addEventHandler("onClientGUIClick", aTab4.Button, searchBans,false)

						  guiGridListAddColumn( aTab4.BansList, "Nombre", 0.22 )
						  guiGridListAddColumn( aTab4.BansList, "IP", 0.22 )
						  guiGridListAddColumn( aTab4.BansList, "Serial", 0.22 )
						  guiGridListAddColumn( aTab4.BansList, "Admin", 0.22 )
						  guiGridListAddColumn( aTab4.BansList, "Fecha", 0.17 )
						  guiGridListAddColumn( aTab4.BansList, "Hora", 0.13 )
						  guiGridListAddColumn( aTab4.BansList, "Fecha de desbaneo", 0.25 )
						  guiGridListAddColumn( aTab4.BansList, "Razón", 0.8 )

						  guiGridListSetSortingEnabled( aTab4.BansList, false )
		aTab4.Details		= guiCreateButton ( 0.85, 0.10, 0.13, 0.04, "Detalles", true, aTab4.Tab )
		aTab4.Unban			= guiCreateButton ( 0.85, 0.20, 0.13, 0.04, "Desbanear", true, aTab4.Tab, "unban" )
		aTab4.UnbanIP		= guiCreateButton ( 0.85, 0.25, 0.13, 0.04, "Desb. IP", true, aTab4.Tab, "unbanip" )
		aTab4.UnbanSerial		= guiCreateButton ( 0.85, 0.30, 0.13, 0.04, "Desb. serial", true, aTab4.Tab, "unbanserial" )
		aTab4.BanIP			= guiCreateButton ( 0.85, 0.40, 0.13, 0.04, "Banear IP", true, aTab4.Tab, "banip" )
		aTab4.BanSerial		= guiCreateButton ( 0.85, 0.45, 0.13, 0.04, "Ban. serial", true, aTab4.Tab, "banserial" )
		aTab4.BansRefresh		= guiCreateButton ( 0.85, 0.85, 0.13, 0.04, "Refrescar", true, aTab4.Tab, "listbans" )
		aTab4.BansTotal		= guiCreateLabel ( 0.20, 0.94, 0.31, 0.04, "Mostrando  0 / 0  bans", true, aTab4.Tab )
		aTab4.BansMore		= guiCreateButton ( 0.50, 0.94, 0.13, 0.04, "Más...", true, aTab4.Tab, "listbans" )

		aTab5 = {}
		aTab5.Tab			= guiCreateTab ( "Admin chat", aTabPanel, "adminchat" )
		aTab5.AdminChat		= guiCreateMemo ( 0.03, 0.05, 0.75, 0.85, "", true, aTab5.Tab )
						  guiSetProperty ( aTab5.AdminChat, "ReadOnly", "true" )
		aTab5.AdminPlayers	= guiCreateGridList ( 0.79, 0.05, 0.18, 0.80, true, aTab5.Tab )
						  guiGridListAddColumn ( aTab5.AdminPlayers, "Admins", 0.90 )
		aTab5.AdminChatSound	= guiCreateCheckBox ( 0.79, 0.86, 0.18, 0.04, "Reprod. sonido", true, true, aTab5.Tab )
		aTab5.AdminText		= guiCreateEdit ( 0.03, 0.92, 0.80, 0.06, "", true, aTab5.Tab )
		aTab5.AdminSay		= guiCreateButton ( 0.85, 0.92, 0.08, 0.06, "Enviar", true, aTab5.Tab )
		aTab5.AdminChatHelp	= guiCreateButton ( 0.94, 0.92, 0.03, 0.06, "?", true, aTab5.Tab )

		aTab6 = {}
		aTab6.Tab			= guiCreateTab ( "Opciones", aTabPanel )
						  guiCreateHeader ( 0.03, 0.05, 0.10, 0.05, "Crucial:", true, aTab6.Tab )
		aTab6.OutputPlayer	= guiCreateCheckBox ( 0.05, 0.10, 0.47, 0.04, "Enviar información del jugador a la consola al", false, true, aTab6.Tab )
						  guiCreateLabel ( 0.08, 0.15, 0.40, 0.04, "seleccionar. (útil para copiar sus datos)", true, aTab6.Tab )
		aTab6.AdminChatOutput 	= guiCreateCheckBox ( 0.05, 0.20, 0.47, 0.04, "Ver el chat de admins en la caja de chat", false, true, aTab6.Tab )
						  guiCreateHeader (  0.03, 0.30, 0.47, 0.04, "Apariencia:", true, aTab6.Tab )
						  guiCreateHeader ( 0.63, 0.05, 0.10, 0.05, "Cuenta:", true, aTab6.Tab )
		aTab6.AutoLogin		= guiCreateCheckBox ( 0.65, 0.10, 0.47, 0.04, "Auto-login by serial", false, true, aTab6.Tab )
						  guiSetVisible ( aTab6.AutoLogin, false )	-- Not used
						  guiCreateHeader ( 0.63, 0.15, 0.25, 0.05, "Cambiar contraseña:", true, aTab6.Tab )
						  guiCreateLabel ( 0.65, 0.20, 0.15, 0.05, "Antigua:", true, aTab6.Tab )
						  guiCreateLabel ( 0.65, 0.25, 0.15, 0.05, "Nueva:", true, aTab6.Tab )
						  guiCreateLabel ( 0.65, 0.30, 0.15, 0.05, "Confirmar:", true, aTab6.Tab )
		aTab6.PasswordOld		= guiCreateEdit ( 0.80, 0.20, 0.15, 0.045, "", true, aTab6.Tab )
		aTab6.PasswordNew		= guiCreateEdit ( 0.80, 0.25, 0.15, 0.045, "", true, aTab6.Tab )
		aTab6.PasswordConfirm	= guiCreateEdit ( 0.80, 0.30, 0.15, 0.045, "", true, aTab6.Tab )
						  guiEditSetMasked ( aTab6.PasswordOld, true )
						  guiEditSetMasked ( aTab6.PasswordNew, true )
						  guiEditSetMasked ( aTab6.PasswordConfirm, true )
		aTab6.PasswordChange	= guiCreateButton ( 0.85, 0.35, 0.10, 0.04, "Aceptar", true, aTab6.Tab )
						  guiCreateHeader ( 0.03, 0.65, 0.20, 0.055, "Rendimiento:", true, aTab6.Tab )
						  guiCreateStaticImage ( 0.03, 0.69, 0.94, 0.0025, "client\\images\\dot.png", true, aTab6.Tab )
						  guiCreateLabel ( 0.05, 0.71, 0.20, 0.055, "Prioridad de rendim.:", true, aTab6.Tab )
						  guiCreateLabel ( 0.11, 0.76, 0.10, 0.05, "Memoria", true, aTab6.Tab )
						  guiCreateLabel ( 0.11, 0.81, 0.10, 0.05, "Auto", true, aTab6.Tab )
						  guiCreateLabel ( 0.11, 0.86, 0.10, 0.05, "Rapidez", true, aTab6.Tab )
		aTab6.PerformanceRAM	= guiCreateRadioButton ( 0.07, 0.75, 0.05, 0.055, "", true, aTab6.Tab )
		aTab6.PerformanceAuto	= guiCreateRadioButton ( 0.07, 0.80, 0.05, 0.055, "", true, aTab6.Tab )
		aTab6.PerformanceCPU	= guiCreateRadioButton ( 0.07, 0.85, 0.05, 0.055, "", true, aTab6.Tab )
						  if ( aGetSetting ( "performance" ) == "RAM" ) then guiRadioButtonSetSelected ( aTab6.PerformanceRAM, true )
						  elseif ( aGetSetting ( "performance" ) == "CPU" ) then guiRadioButtonSetSelected ( aTab6.PerformanceCPU, true )
						  else guiRadioButtonSetSelected ( aTab6.PerformanceAuto, true ) end
		aTab6.PerformanceAdvanced = guiCreateButton ( 0.05, 0.91, 0.11, 0.04, "Avanzado", true, aTab6.Tab )
		aPerformance()
					   	  guiCreateLabel ( 0.70, 0.90, 0.19, 0.055, "Retraso de act.(MS):", true, aTab6.Tab )
		aTab6.RefreshDelay	= guiCreateEdit ( 0.89, 0.90, 0.08, 0.045, "50", true, aTab6.Tab )

		if ( aGetSetting ( "outputPlayer" ) ) then guiCheckBoxSetSelected ( aTab6.OutputPlayer, true ) end
		if ( aGetSetting ( "adminChatOutput" ) ) then guiCheckBoxSetSelected ( aTab6.AdminChatOutput, true ) end
		if ( aGetSetting ( "adminChatSound" ) ) then guiCheckBoxSetSelected ( aTab5.AdminChatSound, true ) end
		--if ( tonumber ( aGetSetting ( "adminChatLines" ) ) ) then guiSetText ( aTab6.AdminChatLines, aGetSetting ( "adminChatLines" ) ) end
		if ( ( tonumber ( aGetSetting ( "refreshDelay" ) ) ) and ( tonumber ( aGetSetting ( "refreshDelay" ) ) >= 50 ) ) then guiSetText ( aTab6.RefreshDelay, aGetSetting ( "refreshDelay" ) ) end

		addEventHandler ( "aClientLog", _root, aClientLog )
		addEventHandler ( "aClientAdminChat", _root, aClientAdminChat )
		addEventHandler ( "aClientSync", _root, aClientSync )
		addEventHandler ( "aMessage", _root, aMessage )
		addEventHandler ( "aClientResourceStart", _root, aClientResourceStart )
		addEventHandler ( "aClientResourceStop", _root, aClientResourceStop )
		addEventHandler ( "aClientPlayerJoin", _root, aClientPlayerJoin )
		addEventHandler ( "onClientPlayerQuit", _root, aClientPlayerQuit )
		addEventHandler ( "onClientMouseEnter", _root, aClientMouseEnter )
		addEventHandler ( "onClientGUIClick", aAdminForm, aClientClick )
		addEventHandler ( "onClientGUIScroll", aAdminForm, aClientScroll )
		addEventHandler ( "onClientGUIDoubleClick", aAdminForm, aClientDoubleClick )
		addEventHandler ( "onClientGUIDoubleClick", aTab1.VehicleOptions, aClientDoubleClick )
		addEventHandler ( "onClientGUIAccepted", aAdminForm, aClientGUIAccepted )
		addEventHandler ( "onClientGUIChanged", aAdminForm, aClientGUIChanged )
		addEventHandler ( "onClientCursorMove", _root, aClientCursorMove )
		addEventHandler ( "onClientRender", _root, aClientRender )
		addEventHandler ( "onClientPlayerChangeNick", _root, aClientPlayerChangeNick )
		addEventHandler ( "onClientResourceStop", _root, aMainSaveSettings )
		addEventHandler ( "onClientGUITabSwitched", aTabPanel, aClientGUITabSwitched )

		bindKey ( "arrow_d", "down", aPlayerListScroll, 1 )
		bindKey ( "arrow_u", "down", aPlayerListScroll, -1 )

		triggerServerEvent ( "aSync", localPlayer, "players" )
		if ( hasPermissionTo ( "command.listmessages" ) ) then triggerServerEvent ( "aSync", localPlayer, "messages" ) end
		triggerServerEvent ( "aSync", localPlayer, "server" )
		triggerEvent ( "onAdminInitialize", resourceRoot )
		showCursor ( true )

		if getVersion().sortable and getVersion().sortable < "1.0.4-9.02436" then
			guiSetText ( aAdminForm, "Advertencia - Panel de admin incompatible con versión del servidor" )
			guiLabelSetHorizontalAlign ( guiCreateLabel ( 0.30, 0.11, 0.4, 0.04, "Actualizar servidor o desactualizar el panel", true, aAdminForm ), "center" )
		end
	end
	guiSetVisible ( aAdminForm, true )
	showCursor ( true )
	-- If the camera target was on another player, select him in the player list
	local element = getCameraTarget()
	if element and getElementType(element)=="vehicle" then
		element = getVehicleController(element)
	end
	if element and getElementType(element)=="player" and element ~= localPlayer then
		for row=0,guiGridListGetRowCount( aTab1.PlayerList )-1 do
			if ( guiGridListGetItemPlayerName ( aTab1.PlayerList, row, 1 ) == getPlayerName ( element ) ) then
				guiGridListSetSelectedItem ( aTab1.PlayerList, row, 1 )
				break
			end
		end
	end
    guiSetInputMode ( "no_binds_when_editing" )
end

function aAdminMenuClose ( destroy )
	if ( destroy ) then
		aMainSaveSettings ()
		aPlayers = {}
		aWeathers = {}
		aBans = {}
		removeEventHandler ( "aClientLog", _root, aClientLog )
		removeEventHandler ( "aClientAdminChat", _root, aClientAdminChat )
		removeEventHandler ( "aClientSync", _root, aClientSync )
		removeEventHandler ( "aMessage", _root, aMessage )
		removeEventHandler ( "aClientResourceStart", _root, aClientResourceStart )
		removeEventHandler ( "aClientResourceStop", _root, aClientResourceStop )
		removeEventHandler ( "aClientPlayerJoin", _root, aClientPlayerJoin )
		removeEventHandler ( "onClientPlayerQuit", _root, aClientPlayerQuit )
		removeEventHandler ( "onClientMouseEnter", _root, aClientMouseEnter )
		removeEventHandler ( "onClientGUIClick", aAdminForm, aClientClick )
		removeEventHandler ( "onClientGUIScroll", aAdminForm, aClientScroll )
		removeEventHandler ( "onClientGUIDoubleClick", aAdminForm, aClientDoubleClick )
		removeEventHandler ( "onClientGUIDoubleClick", aTab1.VehicleOptions, aClientDoubleClick )
		removeEventHandler ( "onClientGUIAccepted", aAdminForm, aClientGUIAccepted )
		removeEventHandler ( "onClientGUIChanged", aAdminForm, aClientGUIChanged )
		removeEventHandler ( "onClientCursorMove", _root, aClientCursorMove )
		removeEventHandler ( "onClientRender", _root, aClientRender )
		removeEventHandler ( "onClientPlayerChangeNick", _root, aClientPlayerChangeNick )
		removeEventHandler ( "onClientResourceStop", _root, aMainSaveSettings )
		unbindKey ( "arrow_d", "down", aPlayerListScroll )
		unbindKey ( "arrow_u", "down", aPlayerListScroll )
		destroyElement ( aTab1.VehicleOptions )
		destroyElement ( aAdminForm )
		aAdminForm = nil
	else
		guiSetVisible ( aTab1.VehicleOptions, false )
		guiSetVisible ( aAdminForm, false )
	end
	showCursor ( false )
    guiSetInputMode ( "allow_binds")
end

function aMainSaveSettings ()
	aSetSetting ( "outputPlayer", guiCheckBoxGetSelected ( aTab6.OutputPlayer ) )
	aSetSetting ( "adminChatOutput", guiCheckBoxGetSelected ( aTab6.AdminChatOutput ) )
	aSetSetting ( "adminChatSound", guiCheckBoxGetSelected ( aTab5.AdminChatSound ) )
	--aSetSetting ( "adminChatLines", guiGetText ( aTab6.AdminChatLines ) )
	aSetSetting ( "refreshDelay", guiGetText ( aTab6.RefreshDelay ) )
	aSetSetting ( "currentWeapon", aCurrentWeapon )
	aSetSetting ( "currentAmmo", aCurrentAmmo )
	aSetSetting ( "currentVehicle", aCurrentVehicle )
	aSetSetting ( "currentSlap", aCurrentSlap )
	if ( guiRadioButtonGetSelected ( aTab6.PerformanceRAM ) ) then aSetSetting ( "performance", "RAM" )
	elseif ( guiRadioButtonGetSelected ( aTab6.PerformanceCPU ) ) then aSetSetting ( "performance", "CPU" )
	else aSetSetting ( "performance", "Auto" ) end
end

function aAdminRefresh ()
	if ( guiGridListGetSelectedItem ( aTab1.PlayerList ) ~= -1 ) then
		local player = getPlayerFromName ( guiGridListGetItemPlayerName ( aTab1.PlayerList, guiGridListGetSelectedItem( aTab1.PlayerList ), 1 ) )
		if ( player and aPlayers[player] ) then
			guiSetText ( aTab1.Name, "Nombre: "..aPlayers[player]["name"] )
			guiSetText ( aTab1.Mute, iif ( aPlayers[player]["mute"], "Desmutear", "Mutear" ) )
			guiSetText ( aTab1.Freeze, iif ( aPlayers[player]["freeze"], "Descongelar", "Congelar" ) )
			--guiSetText ( aTab1.Username, "Community Username: "..( aPlayers[player]["username"] or "" ) )
			guiSetText ( aTab1.Version, "Versión: "..( aPlayers[player]["version"] or "" ) )
			guiSetText ( aTab1.Accountname, "Nombre de cuenta: "..( aPlayers[player]["accountname"] or "" ) )
			guiSetText ( aTab1.Groups, "Grupos: "..( aPlayers[player]["groups"] or "ninguno" ) )
			guiSetText ( aTab1.ACDetected, "AC detectado: "..( aPlayers[player]["acdetected"] or "" ) )
			guiSetText ( aTab1.ACD3D, "D3D9.DLL: "..( aPlayers[player]["d3d9dll"] or "" ) )
			guiSetText ( aTab1.ACModInfo, "IMG mods: "..( aPlayers[player]["imgmodsnum"] or "" ) )
			if ( isPedDead ( player ) ) then guiSetText ( aTab1.Health, "Salud: muerto" )
			else guiSetText ( aTab1.Health, "Salud: "..math.ceil ( getElementHealth ( player ) ).."%" ) end
			guiSetText ( aTab1.Armour, "Armadura: "..math.ceil ( getPedArmor ( player ) ).."%" )
			guiSetText ( aTab1.Skin, "Skin: "..iif ( getElementModel ( player ), getElementModel ( player ), "N/A" ) )
			if ( getPlayerTeam ( player ) ) then guiSetText ( aTab1.Team, "Team: "..getTeamName ( getPlayerTeam ( player ) ) )
			else guiSetText ( aTab1.Team, "Team: ninguno" ) end
			guiSetText ( aTab1.Ping, "Ping: "..getPlayerPing ( player ) )
			guiSetText ( aTab1.Money, "Dinero: "..( aPlayers[player]["money"] or 0 ) )
			if ( getElementDimension ( player ) ) then guiSetText ( aTab1.Dimension, "Dimensión: "..getElementDimension ( player ) ) end
			if ( getElementInterior ( player ) ) then guiSetText ( aTab1.Interior, "Interior: "..getElementInterior ( player ) ) end
			guiSetText ( aTab1.JetPack, iif ( doesPedHaveJetPack ( player ), "Sacar JetPack", "Otorgar JetPack" ) )
			if ( getPedWeapon ( player ) ) then guiSetText ( aTab1.Weapon, "Arma: "..getWeaponNameFromID ( getPedWeapon ( player ) ).." (ID: "..getPedWeapon ( player )..")" ) end
			local x, y, z = getElementPosition ( player )
			guiSetText ( aTab1.Area, "Zona: "..iif ( getZoneName ( x, y, z, false ) == getZoneName ( x, y, z, true ), getZoneName ( x, y, z, false ), getZoneName ( x, y, z, false ).." ("..getZoneName ( x, y, z, true )..")" ) )
			guiSetText ( aTab1.PositionX, "X: "..x )
			guiSetText ( aTab1.PositionY, "Y: "..y )
			guiSetText ( aTab1.PositionZ, "Z: "..z )
			local vehicle = getPedOccupiedVehicle ( player )
			if ( vehicle ) then
				guiSetText ( aTab1.Vehicle, "Vehículo: "..getVehicleName ( vehicle ).." (ID: "..getElementModel ( vehicle )..")" )
				guiSetText ( aTab1.VehicleHealth, "Estado del vehículo: "..math.ceil ( getElementHealth ( vehicle ) ).."%" )
			else
				guiSetText ( aTab1.Vehicle, "Vehículo: a pie" )
				guiSetText ( aTab1.VehicleHealth, "Estado del vehículo: 0%" )
			end
			if ( aPlayers[player]["admin"] ) then
				guiSetText(aTab1.Admin, "Anular derechos de admin")
			else
				guiSetText(aTab1.Admin, "Dar derechos de admin")
			end
			return player
		end
	end
end

function aClientSync ( type, table, data )
	if ( type == "player" and aPlayers[source] ) then
		for type, data in pairs ( table ) do
			aPlayers[source][type] = data
		end
	elseif ( type == "players" ) then
		aPlayers = table
	elseif ( type == "resources" ) then
		local bInclMaps = guiCheckBoxGetSelected ( aTab2.ResourceInclMaps )
		aResources = table
		for id, resource in ipairs(table) do
			if bInclMaps or resource["type"] ~= "map" then
				local row = guiGridListAddRow ( aTab2.ResourceList )
				guiGridListSetItemText ( aTab2.ResourceList, row, 1, resource["name"], false, false )
				guiGridListSetItemText ( aTab2.ResourceList, row, 2, resource["numsettings"] > 0 and tostring(resource["numsettings"]) or "", false, false )
				guiGridListSetItemText ( aTab2.ResourceList, row, 3, resource["state"], false, false )
				guiGridListSetItemText ( aTab2.ResourceList, row, 4, resource["fullName"], false, false )
				guiGridListSetItemText ( aTab2.ResourceList, row, 5, resource["author"], false, false )
				guiGridListSetItemText ( aTab2.ResourceList, row, 6, resource["version"], false, false )
			end
		end
	elseif ( type == "loggedout" ) then
		aAdminDestroy()
	elseif ( type == "admins" ) then
		--if ( guiGridListGetRowCount ( aTab5.AdminPlayers ) > 0 ) then guiGridListClear ( aTab5.AdminPlayers ) end
		for id, player in ipairs(getElementsByType("player")) do
			if ( table[player]["admin"] == false ) and ( player == localPlayer ) then
				aAdminDestroy()
				break
			elseif aPlayers[player] then
				aPlayers[player]["groups"] = table[player]["groups"]
				if ( table[player]["chat"] ) then
					local id = 0
					local exists = false
					while ( id <= guiGridListGetRowCount( aTab5.AdminPlayers ) ) do
						if ( guiGridListGetItemPlayerName ( aTab5.AdminPlayers, id, 1 ) == getPlayerName ( player ) ) then
							exists = true
						end
						id = id + 1
					end
					if ( exists == false ) then guiGridListSetItemPlayerName ( aTab5.AdminPlayers, guiGridListAddRow ( aTab5.AdminPlayers ), 1, getPlayerName ( player ), false, false ) end
				end
			end
		end
	elseif ( type == "server" ) then
		guiSetText ( aTab3.Server, "Server: "..table["name"] )
		guiSetText ( aTab3.Players, "Jugador: "..#getElementsByType ( "player" ).."/"..table["players"] )
		guiSetText ( aTab3.Password, "Contraseña: "..( table["password"] or "ninguna" ) )
		guiSetText ( aTab3.GameType, "Tipo de juego: "..( table["game"] or "ninguno" ) )
		guiSetText ( aTab3.MapName, "Nombre del mapa: "..( table["map"] or "ninguno" ) )
		guiSetText ( aTab3.FPSCurrent, "Límite de FPS: "..( table["fps"] or "N/A" ) )
		guiSetText ( aTab3.FPS, table["fps"] or "38" )
	elseif ( type == "bansdirty" ) then
		g_GotLatestBansList = false
		if aAdminForm and guiGetVisible ( aAdminForm ) and guiGetSelectedTab( aTabPanel ) == aTab4.Tab then
			-- Request full bans list if bans tab is displayed when 'bansdirty' is received
			triggerServerEvent ( "aSync", localPlayer, "bans" )
		end
	elseif ( type == "bans" or type == "bansmore" ) then
		if type == "bans" then
			g_GotLatestBansList = true
			guiGridListClear ( aTab4.BansList )
			aBans = {}
			aBans["Serial"] = {}
			aBans["IP"] = {}
		end
		local total = tonumber(table.total) or 0
		local amount = guiGridListGetRowCount( aTab4.BansList ) + #table
		guiSetText( aTab4.BansTotal, "Mostrando  " .. amount .. " / " .. total .. "  bans" )
		if g_GotLatestBansList then
			for i=1,#table do
				local ban = table[i]
				if ban.serial then
					aBans["Serial"][ban.serial] = ban
				end
				if ban.ip then
					aBans["IP"][ban.ip] = ban
				end
				local time, date = "-", "-"
				if ban.seconds then
					local realTime = getRealTime( ban.seconds )
					time = string.format("%02d:%02d", realTime.hour, realTime.minute )
					date = string.format("%04d-%02d-%02d", realTime.year + 1900, realTime.month + 1, realTime.monthday )
				end
				local reason = ban["reason"] and ban["reason"]~="nil" and ban["reason"] or ""
				local row = guiGridListAddRow ( aTab4.BansList )
				guiGridListSetItemText ( aTab4.BansList, row, 1, ban["nick"]	or "n/a", false, false )
				guiGridListSetItemText ( aTab4.BansList, row, 2, ban.ip			or "n/a", false, false )
				guiGridListSetItemText ( aTab4.BansList, row, 3, ban.serial		or "n/a", false, false )
				guiGridListSetItemText ( aTab4.BansList, row, 4, ban["banner"]	or "n/a", false, false )
				guiGridListSetItemText ( aTab4.BansList, row, 5, date,					false, false )
				guiGridListSetItemText ( aTab4.BansList, row, 6, time,					false, false )
				guiGridListSetItemText ( aTab4.BansList, row, 8, reason, false, false )
				local unban = "Permanent"
				if ban.unban and tonumber(ban.unban) ~= 0 then
					unban = FormatDate("d/m/y h:i:s", "'", tostring(ban.unban))
				end
				guiGridListSetItemText ( aTab4.BansList, row, 7, unban, false, false )
			end
		end
	elseif ( type == "messages" ) then
		local prev = tonumber ( string.sub ( guiGetText ( aTab1.Messages ), 1, 1 ) )
		if ( prev < table["unread"] ) then
			playSoundFrontEnd ( 18 )
		end
		guiSetText ( aTab1.Messages, table["unread"].."/"..table["total"].." no leídos" )


	elseif ( type == "bansearch" ) then
				g_GotLatestBansList = true
			guiGridListClear ( aTab4.BansList )
			aBans = {}
			aBans["Serial"] = {}
			aBans["IP"] = {}

		if g_GotLatestBansList then

			for i=1,#table do
				local ban = table[i]
				if ban.serial then
					aBans["Serial"][ban.serial] = ban
				end
				if ban.ip then
					aBans["IP"][ban.ip] = ban
				end
			local tType = getNeededTagType (data[1],ban)
			if tType and string.match (string.lower(tType),string.lower(data[2])) then

				local time, date = "-", "-"
				if ban.seconds then
					local realTime = getRealTime( ban.seconds )
					time = string.format("%02d:%02d", realTime.hour, realTime.minute )
					date = string.format("%04d-%02d-%02d", realTime.year + 1900, realTime.month + 1, realTime.monthday )
				end

				local reason = ban["reason"] and ban["reason"]~="nil" and ban["reason"] or ""
				local row = guiGridListAddRow ( aTab4.BansList )
					guiGridListSetItemText ( aTab4.BansList, row, 1, ban["nick"]	or "n/a", false, false )
					guiGridListSetItemText ( aTab4.BansList, row, 2, ban.ip			or "n/a", false, false )
					guiGridListSetItemText ( aTab4.BansList, row, 3, ban.serial		or "n/a", false, false )
					guiGridListSetItemText ( aTab4.BansList, row, 4, ban["banner"]	or "n/a", false, false )
					guiGridListSetItemText ( aTab4.BansList, row, 5, date,					false, false )
					guiGridListSetItemText ( aTab4.BansList, row, 6, time,					false, false )
					guiGridListSetItemText ( aTab4.BansList, row, 8, reason, false, false )
				local unban = "Permanent"

				if ban.unban and tonumber(ban.unban) ~= 0 then
					unban = FormatDate("d/m/y h:i:s", "'", tostring(ban.unban))
				end
				guiGridListSetItemText ( aTab4.BansList, row, 7, unban, false, false )
			end
			end
		end
			local total = tonumber(table.total) or 0
			local amount = guiGridListGetRowCount( aTab4.BansList )
			local w,h = guiGetSize (aTab4.BansList,true)
			guiSetSize (aTab4.BansList,w,0.75,true)
			if amount <total then
			guiProgressBarSetProgress (aTab4.ProgressBar,50+(amount))
			guiSetVisible (aTab4.ProgressBar,true)
			end
			guiSetText( aTab4.BansTotal, "Encontrados  " .. amount .. " / " .. total .. "  bans" )

		elseif ( type == "banlistend" ) then
		guiSetVisible (aTab4.ProgressBar,false)
		local w,h = guiGetSize (aTab4.BansList,true)
		guiSetSize (aTab4.BansList,w,0.8,true)

		elseif ( type == "message" ) then
			aMessageBox (data[1],data[2])
		guiSetVisible (aTab4.ProgressBar,false)
		local w,h = guiGetSize (aTab4.BansList,true)
		guiSetSize (aTab4.BansList,w,0.8,true)

	end
end

function getNeededTagType (tagType,ban)
if tagType=="IP" and ban.ip then return ban.ip end
if tagType=="Serial" and ban.serial then return ban.serial end
if tagType=="Nombre" and ban["nick"] then return ban["nick"] end
if tagType=="Admin" and ban["banner"] then return ban["banner"] end
if tagType=="Razón" and ban["reason"] then return ban["reason"] end
return false
end




function aClientGUITabSwitched( selectedTab )
	if getElementParent( selectedTab ) == aTabPanel then
		if selectedTab == aTab2.Tab then
			-- Handle initial update of resources list
			if guiGridListGetRowCount( aTab2.ResourceList ) == 0 then
				if ( hasPermissionTo ( "command.listresources" ) ) then
					triggerServerEvent ( "aSync", localPlayer, "resources" )
				end
			end
		elseif selectedTab == aTabMap.Tab then
			-- Handle initial update of map list
			if guiGridListGetRowCount( aTabMap.MapList ) == 0 then
				if ( hasPermissionTo ( "command.listresources" ) ) then
					triggerServerEvent ( "getMaps_s", localPlayer, localPlayer, true )
				end
			end
		elseif selectedTab == aTab4.Tab then
			if not g_GotLatestBansList then
				-- Request full bans list if bans tab is selected and current list is out of date
				triggerServerEvent ( "aSync", localPlayer, "bans" )
			end
		end
	end
end

function aMessage ( )

end

function aClientResourceStart ( resource )
	local id = 0
	while ( id <= guiGridListGetRowCount( aTab2.ResourceList ) ) do
		if ( guiGridListGetItemText ( aTab2.ResourceList, id, 1 ) == resource ) then
			guiGridListSetItemText ( aTab2.ResourceList, id, 3, "running", false, false )
		end
		id = id + 1
	end
end

function aClientResourceStop ( resource )
	local id = 0
	while ( id <= guiGridListGetRowCount( aTab2.ResourceList ) ) do
		if ( guiGridListGetItemText ( aTab2.ResourceList, id, 1 ) == resource ) then
			guiGridListSetItemText ( aTab2.ResourceList, id, 3, "loaded", false, false )
		end
		id = id + 1
	end
end

function aClientPlayerJoin ( ip, username, accountname, serial, admin, country )
	if ip == false and serial == false then
		-- Update country only
		if aPlayers[source] then
			aPlayers[source]["country"] = country
		end
		return
	end
	aPlayers[source] = {}
	aPlayers[source]["name"] = getPlayerName ( source )
	aPlayers[source]["IP"] = ip
	aPlayers[source]["username"] = username or "N/A"
	aPlayers[source]["accountname"] = accountname or "N/A"
	aPlayers[source]["serial"] = serial
	aPlayers[source]["admin"] = admin
	aPlayers[source]["country"] = country
	aPlayers[source]["acdetected"] = "..."
	aPlayers[source]["d3d9dll"] = ""
	aPlayers[source]["imgmodsnum"] = ""
	local row = guiGridListAddRow ( aTab1.PlayerList )
	guiGridListSetItemPlayerName ( aTab1.PlayerList, row, 1, getPlayerName ( source ), false, false )
	if ( admin ) then
		local row = guiGridListAddRow ( aTab5.AdminPlayers )
		guiGridListSetItemPlayerName ( aTab5.AdminPlayers, row, 1, getPlayerName ( source ), false, false )
	end
	if ( aSpectator.PlayerList ) then
		local row = guiGridListAddRow ( aSpectator.PlayerList )
		guiGridListSetItemPlayerName ( aSpectator.PlayerList, row, 1, getPlayerName ( source ), false, false )
	end
end

function aClientPlayerQuit ()
	local id = 0
	while ( id <= guiGridListGetRowCount( aTab1.PlayerList ) ) do
		if ( guiGridListGetItemPlayerName ( aTab1.PlayerList, id, 1 ) == getPlayerName ( source ) ) then
			guiGridListRemoveRow ( aTab1.PlayerList, id )
		end
		id = id + 1
	end
	if ( aPlayers[source] and aPlayers[source]["admin"] ) then
		local id = 0
		while ( id <= guiGridListGetRowCount( aTab5.AdminPlayers ) ) do
			if ( guiGridListGetItemPlayerName ( aTab5.AdminPlayers, id, 1 ) == getPlayerName ( source ) ) then
				guiGridListRemoveRow ( aTab5.AdminPlayers, id )
			end
			id = id + 1
		end
	end
	if ( aSpectator.PlayerList ) then
		local id = 0
		while ( id <= guiGridListGetRowCount( aSpectator.PlayerList ) ) do
			if ( guiGridListGetItemPlayerName ( aSpectator.PlayerList, id, 1 ) == getPlayerName ( source ) ) then
				guiGridListRemoveRow ( aSpectator.PlayerList, id )
			end
			id = id + 1
		end
	end
	aPlayers[source] = nil
end

function aPlayerListScroll ( key, state, inc )
	if ( not guiGetVisible ( aAdminForm ) ) then return end
	local max = guiGridListGetRowCount ( aTab1.PlayerList )
	if ( max <= 0 ) then return end
	local current = guiGridListGetSelectedItem ( aTab1.PlayerList )
	local next = current + inc
	max = max - 1
	if ( current == -1 ) then
		guiGridListSetSelectedItem ( aTab1.PlayerList, 0, 1 )
	elseif ( next > max ) then return
	elseif ( next < 0 ) then return
	else
		guiGridListSetSelectedItem ( aTab1.PlayerList, next, 1 )
	end
	local oldsource = source
	source = aTab1.PlayerList;
	aClientClick ( "left" )
	source = oldsource
end

function aClientPlayerChangeNick ( oldNick, newNick )
	local lists = { aTab1.PlayerList, aTab5.AdminPlayers, aSpectator.PlayerList }
	for _,gridlist in ipairs(lists) do
		for row=0,guiGridListGetRowCount(gridlist)-1 do
			if ( guiGridListGetItemPlayerName ( gridlist, row, 1 ) == oldNick ) then
				guiGridListSetItemPlayerName ( gridlist, row, 1, newNick, false, false )
				aPlayers[source]["name"] = newNick
			end
		end
	end
end

function aClientLog ( text )
	if text == "deleted" then
		guiGridListClear ( aTab2.ResourceList )
		triggerServerEvent ( "aSync", localPlayer, "resources" )
	end
	text = "#"..aLogLines..": "..text
	if ( guiGetText ( aTab2.LogLine1 ) == "" ) then guiSetText ( aTab2.LogLine1, text )
	elseif ( guiGetText ( aTab2.LogLine2 ) == "" ) then guiSetText ( aTab2.LogLine2, text )
	elseif ( guiGetText ( aTab2.LogLine3 ) == "" ) then guiSetText ( aTab2.LogLine3, text )
	elseif ( guiGetText ( aTab2.LogLine4 ) == "" ) then guiSetText ( aTab2.LogLine4, text )
	elseif ( guiGetText ( aTab2.LogLine5 ) == "" ) then guiSetText ( aTab2.LogLine5, text )
	else
		guiSetText ( aTab2.LogLine1, guiGetText ( aTab2.LogLine2 ) )
		guiSetText ( aTab2.LogLine2, guiGetText ( aTab2.LogLine3 ) )
		guiSetText ( aTab2.LogLine3, guiGetText ( aTab2.LogLine4 ) )
		guiSetText ( aTab2.LogLine4, guiGetText ( aTab2.LogLine5 ) )
		guiSetText ( aTab2.LogLine5, text )
	end

	aLogLines = aLogLines + 1
end

function aClientAdminChat ( message )
	guiSetText ( aTab5.AdminChat, guiGetText ( aTab5.AdminChat )..""..getPlayerName ( source )..": "..message )
	guiSetProperty ( aTab5.AdminChat, "CaratIndex", tostring ( string.len ( guiGetText ( aTab5.AdminChat ) ) ) )
	if ( guiCheckBoxGetSelected ( aTab6.AdminChatOutput ) ) then outputChatBox ( "ADMIN> "..getPlayerName ( source )..": "..message, 255, 0, 0 ) end
	if ( ( guiCheckBoxGetSelected ( aTab5.AdminChatSound ) ) and ( source ~= localPlayer ) ) then playSoundFrontEnd ( 13 ) end
end

function aSetCurrentAmmo ( ammo )
	ammo = tonumber ( ammo )
	if ( ( ammo ) and ( ammo > 0 ) and ( ammo < 10000 ) ) then
		aCurrentAmmo = ammo
		return
	end
	outputChatBox ( "Valor de munición inválido", 255, 0, 0 )
end

function aClientGUIAccepted ( element )
	if ( element == aTab5.AdminText ) then
		local message = guiGetText ( aTab5.AdminText )
		if ( ( message ) and ( message ~= "" ) ) then
			if ( gettok ( message, 1, 32 ) == "/clear" ) then guiSetText ( aTab5.AdminChat, "" )
			else triggerServerEvent ( "aAdminChat", localPlayer, message ) end
			guiSetText ( aTab5.AdminText, "" )
		end
	end
end

function aClientGUIChanged ()
	if ( source == aTab1.PlayerListSearch ) then
		guiGridListClear ( aTab1.PlayerList )
		local text = guiGetText ( source )
		if ( text == "" ) then
			for id, player in ipairs ( getElementsByType ( "player" ) ) do
				guiGridListSetItemPlayerName ( aTab1.PlayerList, guiGridListAddRow ( aTab1.PlayerList ), 1, getPlayerName ( player ), false, false )
			end
		else
			for id, player in ipairs ( getElementsByType ( "player" ) ) do
				if ( string.find ( string.upper ( getPlayerName ( player ) ), string.upper ( text ), 1, true ) ) then
					guiGridListSetItemPlayerName ( aTab1.PlayerList, guiGridListAddRow ( aTab1.PlayerList ), 1, getPlayerName ( player ), false, false )
				end
			end
		end
	elseif ( source == aTab2.ResourceListSearch ) then
		local bInclMaps = guiCheckBoxGetSelected ( aTab2.ResourceInclMaps )
		guiGridListClear ( aTab2.ResourceList )
		local text = string.lower(guiGetText(source))
		if ( text == "" ) then
			for id, resource in ipairs(aResources) do
				if bInclMaps or resource["type"] ~= "map" then
					local row = guiGridListAddRow ( aTab2.ResourceList )
					guiGridListSetItemText ( aTab2.ResourceList, row, 1, resource["name"], false, false )
					guiGridListSetItemText ( aTab2.ResourceList, row, 2, resource["numsettings"] > 0 and tostring(resource["numsettings"]) or "", false, false )
					guiGridListSetItemText ( aTab2.ResourceList, row, 3, resource["state"], false, false )
					guiGridListSetItemText ( aTab2.ResourceList, row, 4, resource["fullName"], false, false )
					guiGridListSetItemText ( aTab2.ResourceList, row, 5, resource["author"], false, false )
					guiGridListSetItemText ( aTab2.ResourceList, row, 6, resource["version"], false, false )
				end
			end
		else
			for id, resource in ipairs(aResources) do
				if bInclMaps or resource["type"] ~= "map" then
					if string.find(string.lower(resource.name), text, 1, true) then
						local row = guiGridListAddRow ( aTab2.ResourceList )
						guiGridListSetItemText ( aTab2.ResourceList, row, 1, resource["name"], false, false )
						guiGridListSetItemText ( aTab2.ResourceList, row, 2, resource["numsettings"] > 0 and tostring(resource["numsettings"]) or "", false, false )
						guiGridListSetItemText ( aTab2.ResourceList, row, 3, resource["state"], false, false )
						guiGridListSetItemText ( aTab2.ResourceList, row, 4, resource["fullName"], false, false )
						guiGridListSetItemText ( aTab2.ResourceList, row, 5, resource["author"], false, false )
						guiGridListSetItemText ( aTab2.ResourceList, row, 6, resource["version"], false, false )
					end
				end
			end
		end
	end
end

function aClientScroll ( element )
	if ( source == aTab6.MouseSense ) then
		guiSetText ( aTab6.MouseSenseCur, "Cursor sensivity: ("..string.sub ( guiScrollBarGetScrollPosition ( source ) / 50, 0, 4 )..")" )
	end
end

function aClientCursorMove ( rx, ry, x, y )

end

function aClientMouseEnter ( element )
	if ( getElementType ( source ) == "gui-button" ) then

	end
end

function aClientDoubleClick ( button )
	if ( source == aTab1.WeaponOptions ) then
		if ( guiGridListGetSelectedItem ( aTab1.WeaponOptions ) ~= -1 ) then
			aCurrentWeapon = getWeaponIDFromName ( guiGridListGetItemText ( aTab1.WeaponOptions, guiGridListGetSelectedItem ( aTab1.WeaponOptions ), 1 ) )
			local wep = guiGridListGetItemText ( aTab1.WeaponOptions, guiGridListGetSelectedItem ( aTab1.WeaponOptions ), 1 )
			wep = string.gsub ( wep, "Combat Shotgun", "Combat SG" )
			guiSetText ( aTab1.GiveWeapon, "Dar: "..wep.." " )
		end
		guiSetVisible ( aTab1.WeaponOptions, false )
	elseif ( source == aTab1.VehicleOptions ) then
		local item = guiGridListGetSelectedItem ( aTab1.VehicleOptions )
		if ( item ~= -1 ) then
			if ( guiGridListGetItemText ( aTab1.VehicleOptions, item, 1 ) ~= "" ) then
				aCurrentVehicle = tonumber ( guiGridListGetItemData ( aTab1.VehicleOptions, item, 1 ) )
				guiSetText ( aTab1.GiveVehicle, "Dar: "..guiGridListGetItemText ( aTab1.VehicleOptions, item, 1 ).." " )
			end
		end
		guiSetVisible ( aTab1.VehicleOptions, false )
	elseif ( source == aTab1.SlapOptions ) then
		if ( guiGridListGetSelectedItem ( aTab1.SlapOptions ) ~= -1 ) then
			aCurrentSlap = guiGridListGetItemText ( aTab1.SlapOptions, guiGridListGetSelectedItem ( aTab1.SlapOptions ), 1 )
			guiSetText ( aTab1.Slap, "¡Pegar! "..aCurrentSlap.." _" )
			if ( aSpecSlap ) then guiSetText ( aSpecSlap, "¡Pegar! "..aCurrentSlap.."hp" ) end
		end
		guiSetVisible ( aTab1.SlapOptions, false )
	elseif ( source == aTab2.ResourceList ) then
		if ( guiGridListGetSelectedItem ( aTab2.ResourceList ) ~= -1 ) then
			aManageSettings ( guiGridListGetItemText ( aTab2.ResourceList, guiGridListGetSelectedItem( aTab2.ResourceList ), 1 ) )
		end
	elseif ( source == aTab4.BansList ) then
		if ( guiGridListGetSelectedItem ( aTab4.BansList ) == -1 ) then
			aMessageBox ( "Error", "¡Casilla no seleccionada!" )
		else
			local selip = guiGridListGetItemText ( aTab4.BansList, guiGridListGetSelectedItem( aTab4.BansList ), 2 )
			local selserial = guiGridListGetItemText ( aTab4.BansList, guiGridListGetSelectedItem( aTab4.BansList ), 3 )
			aBanDetails ( aBans["Serial"][selserial] and selserial or selip )
		end
	end
	if ( guiGetVisible ( aTab1.WeaponOptions ) ) then guiSetVisible ( aTab1.WeaponOptions, false ) end
	if ( guiGetVisible ( aTab1.VehicleOptions ) ) then guiSetVisible ( aTab1.VehicleOptions, false ) end
	if ( guiGetVisible ( aTab1.SlapOptions ) ) then guiSetVisible ( aTab1.SlapOptions, false ) end
end

function aClientClick ( button )
	if ( ( source == aTab1.WeaponOptions ) or ( source == aTab1.VehicleOptions ) or ( source == aTab1.SlapOptions ) ) then return
	else
		if ( guiGetVisible ( aTab1.WeaponOptions ) ) then guiSetVisible ( aTab1.WeaponOptions, false ) end
		if ( guiGetVisible ( aTab1.VehicleOptions ) ) then guiSetVisible ( aTab1.VehicleOptions, false ) end
		if ( guiGetVisible ( aTab1.SlapOptions ) ) then guiSetVisible ( aTab1.SlapOptions, false ) end
	end
	if ( button == "left" ) then
		-- TAB 1, PLAYERS
		if ( getElementParent ( source ) == aTab1.Tab ) then
			if ( source == aTab1.Messages ) then
				aViewMessages()
			elseif ( source == aTab1.ScreenShots ) then
				aPlayerScreenShot()
			elseif ( source == aTab1.PlayerListSearch ) then

			elseif ( source == aTab1.HideColorCodes ) then
				updateColorCodes()
			elseif ( source == aTab1.AnonAdmin ) then
				setAnonAdmin( guiCheckBoxGetSelected ( aTab1.AnonAdmin ) )
			elseif ( getElementType ( source ) == "gui-button" )  then
				if ( source == aTab1.GiveVehicle ) then guiBringToFront ( aTab1.VehicleDropDown )
				elseif ( source == aTab1.GiveWeapon ) then guiBringToFront ( aTab1.WeaponDropDown )
				elseif ( source == aTab1.Slap ) then guiBringToFront ( aTab1.SlapDropDown ) end
				if ( guiGridListGetSelectedItem ( aTab1.PlayerList ) == -1 ) then
					aMessageBox ( "Error", "¡Jugador no seleccionado!" )
				else
					local name = guiGridListGetItemPlayerName ( aTab1.PlayerList, guiGridListGetSelectedItem( aTab1.PlayerList ), 1 )
					local player = getPlayerFromName ( name )
					if ( source == aTab1.Kick ) then aInputBox ( "Kickear jugador "..name, "Ingresar la razón de expulsión:", "", "kickPlayer", player )
					elseif ( source == aTab1.Ban ) then aBanInputBox ( player )
					elseif ( source == aTab1.Slap ) then triggerServerEvent ( "aPlayer", localPlayer, player, "slap", aCurrentSlap )
					elseif ( source == aTab1.Mute ) then if not aPlayers[player]["mute"] then aMuteInputBox ( player ) else aMessageBox ( "pregunta", "¿Seguro que quieres desmutear a "..name.."?", "unmute", player ) end
					elseif ( source == aTab1.Freeze ) then triggerServerEvent ( "aPlayer", localPlayer, player, "freeze" )
					elseif ( source == aTab1.Spectate ) then aSpectate ( player )
					elseif ( source == aTab1.Nick ) then aInputBox ( "Nombre", "Ingresar el nuevo apodo del jugador:", name, "setNick", player )
					elseif ( source == aTab1.Shout ) then aInputBox ( "¡Gritar!", "Ingresar el texto a mostrar en pantalla:", "", "shout", player )
					elseif ( source == aTab1.SetHealth ) then aInputBox ( "Salud", "Ingresar el valor de salud:", "100", "setHealth", player )
					elseif ( source == aTab1.SetArmour ) then aInputBox ( "Armadura", "Ingresar el valor de armadura:", "100", "setArmor", player )
					elseif ( source == aTab1.SetTeam ) then aPlayerTeam ( player )
					elseif ( source == aTab1.SetSkin ) then aPlayerSkin ( player )
					elseif ( source == aTab1.SetInterior ) then aPlayerInterior ( player )
					elseif ( source == aTab1.JetPack ) then triggerServerEvent ( "aPlayer", localPlayer, player, "jetpack" )
					elseif ( source == aTab1.SetMoney ) then aInputBox ( "Dinero", "Ingresar la cantidad de dinero:", "0", "setMoney", player )
					elseif ( source == aTab1.SetStats ) then aPlayerStats ( player )
					elseif ( source == aTab1.SetDimension ) then aInputBox ( "ID de dimensión requerido", "Ingresar un número entre 0 y 65535:", "0", "setDimension", player)
					elseif ( source == aTab1.GiveVehicle ) then triggerServerEvent ( "aPlayer", localPlayer, player, "givevehicle", aCurrentVehicle )
					elseif ( source == aTab1.GiveWeapon ) then triggerServerEvent ( "aPlayer", localPlayer, player, "giveweapon", aCurrentWeapon, aCurrentAmmo )
					elseif ( source == aTab1.Warp ) then triggerServerEvent ( "aPlayer", localPlayer, player, "warp" )
					elseif ( source == aTab1.WarpTo ) then aPlayerWarp ( player )
					elseif ( source == aTab1.VehicleFix ) then triggerServerEvent ( "aVehicle", localPlayer, player, "repair" )
					elseif ( source == aTab1.VehicleBlow ) then triggerServerEvent ( "aVehicle", localPlayer, player, "blowvehicle" )
					elseif ( source == aTab1.VehicleDestroy ) then triggerServerEvent ( "aVehicle", localPlayer, player, "destroyvehicle" )
					elseif ( source == aTab1.VehicleCustomize ) then aVehicleCustomize ( player )
					elseif ( source == aTab1.Admin ) then
						if ( aPlayers[player]["admin"] ) then aMessageBox ( "Advertencia", "¿Anular los derechos de administrador de "..name.."?", "revokeAdmin", player )
						else aMessageBox ( "Advertencia", "¿Dar derechos de administrador a "..name.."?", "giveAdmin", player ) end
					elseif ( source == aTab1.ACModDetails ) then
						aViewModdetails(player)
					end
				end
			elseif ( source == aTab1.VehicleDropDown ) then
				local x1, y1 = guiGetPosition ( aAdminForm, false )
				local x2, y2 = guiGetPosition ( aTabPanel, false )
				local x3, y3 = guiGetPosition ( aTab1.Tab, false )
				local x4, y4 = guiGetPosition ( aTab1.GiveVehicle, false )
				guiSetPosition ( aTab1.VehicleOptions, x1 + x2 + x3 + x4, y1 + y2 + y3 + y4 + 20, false )
				guiSetVisible ( aTab1.VehicleOptions, true )
				guiBringToFront ( aTab1.VehicleOptions )
			elseif ( source == aTab1.WeaponDropDown ) then
				guiSetVisible ( aTab1.WeaponOptions, true )
				guiBringToFront ( aTab1.WeaponOptions )
			elseif ( source == aTab1.SlapDropDown ) then
				guiSetVisible ( aTab1.SlapOptions, true )
				guiBringToFront ( aTab1.SlapOptions )
			elseif ( source == aTab1.PlayerList ) then
				if ( guiGridListGetSelectedItem( aTab1.PlayerList ) ~= -1 ) then
					local player = aAdminRefresh ()
					if ( player ) then
						triggerServerEvent ( "aSync", localPlayer, "player", player )
						if ( ( guiCheckBoxGetSelected ( aTab6.OutputPlayer ) ) and ( player ) ) then
							outputConsole ( "Nombre: "..aPlayers[player]["name"]
										..", IP: "..aPlayers[player]["IP"]
										..", Serial: "..aPlayers[player]["serial"]
									--	..", Community Username: "..aPlayers[player]["username"]
										..", Nombre de cuenta: "..aPlayers[player]["accountname"]
										..", D3D9.DLL: "..aPlayers[player]["d3d9dll"] )
						end
						guiSetText ( aTab1.IP, "IP: "..aPlayers[player]["IP"] )
						guiSetText ( aTab1.Serial, "Serial: "..aPlayers[player]["serial"] )
						--guiSetText ( aTab1.Username, "Community Username: "..aPlayers[player]["username"] )
						guiSetText ( aTab1.Accountname, "Nombre de cuenta: "..aPlayers[player]["accountname"] )
						guiSetText ( aTab1.ACDetected, "AC detectado: "..aPlayers[player]["acdetected"] )
						guiSetText ( aTab1.ACD3D, "D3D9.DLL: "..aPlayers[player]["d3d9dll"] )
						guiSetText ( aTab1.ACModInfo, "IMG mods: "..aPlayers[player]["imgmodsnum"] )
						local countryCode = aPlayers[player]["country"]
						loadFlagImage ( aTab1.Flag, countryCode )
						if not countryCode then
							guiSetText ( aTab1.CountryCode, "" )
						else
							local x, y = guiGetPosition ( aTab1.IP, false )
							local width = guiLabelGetTextExtent ( aTab1.IP )
							guiSetPosition ( aTab1.Flag, x + width + 7, y + 4, false )
							guiSetPosition ( aTab1.CountryCode, x + width + 30, y, false )
							guiSetText ( aTab1.CountryCode, tostring( countryCode ) )
						end
						guiSetText ( aTab1.Version, "Versión: " .. ( aPlayers[player]["version"] or "" ) )
					end
				else
					guiSetText ( aTab1.Name, "Nombre: ninguno" )
					guiSetText ( aTab1.IP, "IP: N/A" )
					guiSetText ( aTab1.Serial, "Serial: N/A" )
					--guiSetText ( aTab1.Username, "Community Username: N/A" )
					guiSetText ( aTab1.Version, "Versión: N/A" )
					guiSetText ( aTab1.Accountname, "Nombre de cuenta: N/A" )
					guiSetText ( aTab1.Groups, "Grupos: N/A" )
					guiSetText ( aTab1.ACDetected, "AC detectado: N/A" )
					guiSetText ( aTab1.ACD3D, "D3D9.DLL: N/A" )
					guiSetText ( aTab1.ACModInfo, "IMG mods: N/A" )
					guiSetText ( aTab1.Mute, "Mutear" )
					guiSetText ( aTab1.Freeze, "Congelar" )
					guiSetText ( aTab1.Admin, "Dar derechos de admin" )
					guiSetText ( aTab1.Health, "Salud: 0%" )
					guiSetText ( aTab1.Armour, "Armadura: 0%" )
					guiSetText ( aTab1.Skin, "Skin: N/A" )
					guiSetText ( aTab1.Team, "Team: ninguno" )
					guiSetText ( aTab1.Ping, "Ping: 0" )
					guiSetText ( aTab1.Money, "Dinero: 0" )
					guiSetText ( aTab1.Dimension, "Dimensión: 0" )
					guiSetText ( aTab1.Interior, "Interior: 0" )
					guiSetText ( aTab1.JetPack, "Otorgar JetPack" )
					guiSetText ( aTab1.Weapon, "Arma: N/A" )
					guiSetText ( aTab1.Area, "Zona: desconocida" )
					guiSetText ( aTab1.PositionX, "X: 0" )
					guiSetText ( aTab1.PositionY, "Y: 0" )
					guiSetText ( aTab1.PositionZ, "Z: 0" )
					guiSetText ( aTab1.Vehicle, "Vehículo: N/A" )
					guiSetText ( aTab1.VehicleHealth, "Estado del vehículo: 0%" )
					guiStaticImageLoadImage ( aTab1.Flag, "client\\images\\empty.png" )
					guiSetText ( aTab1.CountryCode, "" )
				end
			end
		-- TAB 2, RESOURCES
		elseif ( getElementParent ( source ) == aTab2.Tab ) then
			if ( source == aTab2.ResourceListSearch ) then

			elseif ( ( source == aTab2.ResourceStart ) or ( source == aTab2.ResourceRestart ) or ( source == aTab2.ResourceStop ) or ( source == aTab2.ResourceDelete ) or ( source == aTab2.ResourceSettings ) ) then
				if ( guiGridListGetSelectedItem ( aTab2.ResourceList ) == -1 ) then
					aMessageBox ( "Error", "¡Resource no seleccionado!" )
				else
					if ( source == aTab2.ResourceStart ) then triggerServerEvent ( "aResource", localPlayer, guiGridListGetItemText ( aTab2.ResourceList, guiGridListGetSelectedItem( aTab2.ResourceList ), 1 ), "start" )
					elseif ( source == aTab2.ResourceRestart ) then triggerServerEvent ( "aResource", localPlayer, guiGridListGetItemText ( aTab2.ResourceList, guiGridListGetSelectedItem( aTab2.ResourceList ), 1 ), "restart" )
					elseif ( source == aTab2.ResourceStop ) then triggerServerEvent ( "aResource", localPlayer, guiGridListGetItemText ( aTab2.ResourceList, guiGridListGetSelectedItem( aTab2.ResourceList ), 1 ), "stop" )
					elseif ( source == aTab2.ResourceDelete ) then aMessageBox ( "Advertencia", "¿Seguro de querer detener y eliminar el resource '" .. guiGridListGetItemText ( aTab2.ResourceList, guiGridListGetSelectedItem( aTab2.ResourceList ), 1 ) .. "' ?", "stopDelete", guiGridListGetItemText ( aTab2.ResourceList, guiGridListGetSelectedItem( aTab2.ResourceList ), 1 ) )
					elseif ( source == aTab2.ResourceSettings ) then aManageSettings ( guiGridListGetItemText ( aTab2.ResourceList, guiGridListGetSelectedItem( aTab2.ResourceList ) ) )
					end
				end
			elseif ( source == aTab2.ResourcesStopAll ) then aMessageBox ( "Advertencia", "¿Seguro de querer detener todos los resources? Esto también detendrá el resource de 'admin'.", "stopAll" )
			elseif ( source == aTab2.ResourceList ) then
				guiSetVisible ( aTab2.ResourceFailture, false )
				if ( guiGridListGetSelectedItem ( aTab2.ResourceList ) ~= -1 ) then
					guiSetText(aTab2.ResourceName, "Nombre completo: " .. guiGridListGetItemText(aTab2.ResourceList, guiGridListGetSelectedItem ( aTab2.ResourceList ), 4))
					guiSetText(aTab2.ResourceAuthor, "Autor: " .. guiGridListGetItemText(aTab2.ResourceList, guiGridListGetSelectedItem ( aTab2.ResourceList ), 5))
					guiSetText(aTab2.ResourceVersion, "Versión: " .. guiGridListGetItemText(aTab2.ResourceList, guiGridListGetSelectedItem ( aTab2.ResourceList ), 6))
					if ( guiGridListGetItemText ( aTab2.ResourceList, guiGridListGetSelectedItem( aTab2.ResourceList ), 3 ) == "Falló al cargar" ) then
						guiSetVisible ( aTab2.ResourceFailture, true )
					end
				end
			elseif ( source == aTab2.ManageACL ) then
				aManageACL()
			elseif ( source == aTab2.ResourceRefresh or source == aTab2.ResourceInclMaps ) then
				guiGridListClear ( aTab2.ResourceList )
				triggerServerEvent ( "aSync", localPlayer, "resources" )
			elseif ( source == aTab2.ExecuteClient ) then
				if ( ( guiGetText ( aTab2.Command ) ) and ( guiGetText ( aTab2.Command ) ~= "" ) ) then aExecute ( guiGetText ( aTab2.Command ), true ) end
			elseif ( source == aTab2.ExecuteServer ) then
				if ( ( guiGetText ( aTab2.Command ) ) and ( guiGetText ( aTab2.Command ) ~= "" ) ) then triggerServerEvent ( "aExecute", localPlayer, guiGetText ( aTab2.Command ), true ) end
			elseif ( source == aTab2.Command ) then

				guiSetVisible ( aTab2.ExecuteAdvanced, false )
			elseif ( source == aTab2.ExecuteAdvanced ) then
				guiSetVisible ( aTab2.ExecuteAdvanced, false )
			end
		-- TAB 3, WORLD
		elseif ( getElementParent ( source ) == aTab3.Tab ) then
			if ( source == aTab3.SetGameType ) then aInputBox ( "Tipo de juego", "Ingresar el tipo de juego:", "", "setGameType" )
			elseif ( source == aTab3.SetMapName ) then aInputBox ( "Nombre del mapa", "Ingresar el nombre del mapa:", "", "setMapName" )
			elseif ( source == aTab3.SetWelcome ) then aInputBox ( "Bienvenida", "Ingresar el mensaje de bienvenida:", "", "setWelcome" )
			elseif ( source == aTab3.SetPassword ) then aInputBox ( "Contraseña", "Ingresar la contraseña: (32 caracteres máx.)", "", "setServerPassword" )
			elseif ( source == aTab3.Shutdown ) then aInputBox ( "Apagar el servidor", "Ingresar la razón de apagado:", "", "serverShutdown" )
			elseif ( source == aTab3.ResetPassword ) then triggerServerEvent ( "aServer", localPlayer, "setpassword", "" )
			elseif ( ( source == aTab3.WeatherInc ) or ( source == aTab3.WeatherDec ) ) then
				local id = tonumber ( gettok ( guiGetText ( aTab3.Weather ), 1, 32 ) )
				if ( id ) then
					if ( ( source == aTab3.WeatherInc ) and ( id < _weathers_max ) ) then guiSetText ( aTab3.Weather, ( id + 1 ).." ("..getWeatherNameFromID ( id + 1 )..")" )
					elseif ( ( source == aTab3.WeatherDec ) and ( id > 0 ) ) then guiSetText ( aTab3.Weather, ( id - 1 ).." ("..getWeatherNameFromID ( id - 1 )..")" ) end
				else
					guiSetText ( aTab3.Weather, ( 14 ).." ("..getWeatherNameFromID ( 14 )..")" )
				end
			elseif ( source == aTab3.WeatherSet ) then triggerServerEvent ( "aServer", localPlayer, "setweather", gettok ( guiGetText ( aTab3.Weather ), 1, 32 ) )
			elseif ( source == aTab3.WeatherBlend ) then triggerServerEvent ( "aServer", localPlayer, "blendweather", gettok ( guiGetText ( aTab3.Weather ), 1, 32 ) )
			elseif ( source == aTab3.TimeSet ) then triggerServerEvent ( "aServer", localPlayer, "settime", guiGetText ( aTab3.TimeH ), guiGetText ( aTab3.TimeM ) )
			elseif ( ( source == aTab3.SpeedInc ) or ( source == aTab3.SpeedDec ) ) then
				local value = tonumber ( guiGetText ( aTab3.Speed ) )
				if ( value ) then
					if ( ( source == aTab3.SpeedInc ) and ( value < 10 ) ) then guiSetText ( aTab3.Speed, tostring ( value + 1 ) )
					elseif ( ( source == aTab3.SpeedDec ) and ( value > 0 ) ) then guiSetText ( aTab3.Speed, tostring ( value - 1 ) ) end
				else
					guiSetText ( aTab3.Speed, "1" )
				end
			elseif ( source == aTab3.SpeedSet ) then triggerServerEvent ( "aServer", localPlayer, "setgamespeed", guiGetText ( aTab3.Speed ) )
			elseif ( source == aTab3.GravitySet ) then triggerServerEvent ( "aServer", localPlayer, "setgravity", guiGetText ( aTab3.Gravity ) )
			elseif ( source == aTab3.WavesSet ) then triggerServerEvent ( "aServer", localPlayer, "setwaveheight", guiGetText ( aTab3.Waves ) )
			elseif ( source == aTab3.FPSSet ) then
			triggerServerEvent ( "aServer", localPlayer, "setfpslimit", guiGetText ( aTab3.FPS ) )
			triggerServerEvent ( "aSync", localPlayer, "server" )
			end
		-- TAB 4, BANS
		elseif ( getElementParent ( source ) == aTab4.Tab ) then
			if ( source == aTab4.Details ) then
				if ( guiGridListGetSelectedItem ( aTab4.BansList ) == -1 ) then
					aMessageBox ( "Error", "¡Casilla no seleccionada!" )
				else
					local selip = guiGridListGetItemText ( aTab4.BansList, guiGridListGetSelectedItem( aTab4.BansList ), 2 )
					local selserial = guiGridListGetItemText ( aTab4.BansList, guiGridListGetSelectedItem( aTab4.BansList ), 3 )
					aBanDetails ( aBans["Serial"][selserial] and selserial or selip )
				end
			elseif ( source == aTab4.Unban ) then
				if ( guiGridListGetSelectedItem ( aTab4.BansList ) == -1 ) then
					aMessageBox ( "Error", "¡Casilla no seleccionada!" )
				else
					local selip = guiGridListGetItemText ( aTab4.BansList, guiGridListGetSelectedItem( aTab4.BansList ), 2 )
					local selserial = guiGridListGetItemText ( aTab4.BansList, guiGridListGetSelectedItem( aTab4.BansList ), 3 )
					if ( aBans["Serial"][selserial] ) then aMessageBox ( "pregunta", "¿Desbanear a  "..selserial.."?", "unbanSerial", selserial )
					else aMessageBox ( "Pregunta", "¿Desbanear IP: "..selip.."?", "unbanIP", selip ) end
				end
			elseif ( source == aTab4.UnbanIP ) then
				aInputBox ( "Desbanear IP", "Ingresar la IP a desbanear:", "", "unbanIP" )
			elseif ( source == aTab4.UnbanSerial ) then
				aInputBox ( "Desbanear serial", "Ingresar la serial a desbanear:", "", "unbanSerial" )
			elseif ( source == aTab4.BanIP ) then
				aInputBox ( "Banear IP", "Ingresar la IP a banear:", "", "banIP")
			elseif ( source == aTab4.BanSerial ) then
				aInputBox ( "Banear serial", "Ingresar la serial a banear:", "", "banSerial" )
			elseif ( source == aTab4.BansRefresh ) then
				guiGridListClear ( aTab4.BansList )
				triggerServerEvent ( "aSync", localPlayer, "bans" )
			elseif ( source == aTab4.BansMore ) then
				triggerServerEvent ( "aSync", localPlayer, "bansmore", guiGridListGetRowCount( aTab4.BansList ) )
			end
		-- TAB 5, ADMIN CHAT
		elseif ( getElementParent ( source ) == aTab5.Tab ) then
			if ( source == aTab5.AdminSay ) then
				local message = guiGetText ( aTab5.AdminText )
				if ( ( message ) and ( message ~= "" ) ) then
					if ( gettok ( message, 1, 32 ) == "/clear" ) then guiSetText ( aTab5.AdminChat, "" )
					else triggerServerEvent ( "aAdminChat", localPlayer, message ) end
					guiSetText ( aTab5.AdminText, "" )
				end
			elseif ( source == aTab5.AdminText ) then

			end
		-- TAB 6, OPTIONS
		elseif ( getElementParent ( source ) == aTab6.Tab ) then
			if ( source == aTab6.PerformanceCPU ) then
				for id, element in ipairs ( getElementChildren ( aPerformanceForm ) ) do
					if ( getElementType ( element ) == "gui-checkbox" ) then
						guiCheckBoxSetSelected ( element, false )
					end
				end
			elseif ( source == aTab6.PerformanceRAM ) then
				for id, element in ipairs ( getElementChildren ( aPerformanceForm ) ) do
					if ( getElementType ( element ) == "gui-checkbox" ) then
						guiCheckBoxSetSelected ( element, true )
					end
				end
			elseif ( source == aTab6.PerformanceAdvanced ) then
				aPerformance()
			elseif ( source == aTab6.AutoLogin ) then
				triggerServerEvent ( "aAdmin", localPlayer, "autologin", guiCheckBoxGetSelected ( aTab6.AutoLogin ) )
			elseif ( source == aTab6.PasswordOld ) then

			elseif ( source == aTab6.PasswordNew ) then

			elseif ( source == aTab6.PasswordConfirm ) then

			elseif ( source == aTab6.PasswordChange ) then
				local passwordNew, passwordConf = guiGetText ( aTab6.PasswordNew ), guiGetText ( aTab6.PasswordConfirm )
				if ( passwordNew == "" ) then aMessageBox ( "Error", "¡Ingresa la nueva contraseña!" )
				elseif ( passwordConf == "" ) then aMessageBox ( "Error", "¡Confirma la nueva contraseña!" )
				elseif ( string.len ( passwordNew ) < 4 ) then aMessageBox ( "Error", "La contraseña debe tener al menos 4 caracteres." )
				elseif ( passwordNew ~= passwordConf ) then aMessageBox ( "Error", "¡La contraseña a confirmar no coincide!" )
				else triggerServerEvent ( "aAdmin", localPlayer, "password", guiGetText ( aTab6.PasswordOld ), passwordNew, passwordConf ) end
			end
		end
	elseif ( button == "right" ) then
		if ( source == aTab1.GiveWeapon ) then aInputBox ( "Munición de arma", "Valor de munición desde 1 hasta 9999:", "100", "setCurrentAmmo" )
		end
	end
end

function aClientRender ()
	if ( guiGetVisible ( aAdminForm ) ) then
		if ( getTickCount() >= aLastCheck ) then
			aAdminRefresh ()
			local th, tm = getTime()
			guiSetText ( aTab3.Players, "Jugadores: "..#getElementsByType ( "player" ).."/"..gettok ( guiGetText ( aTab3.Players ), 2, 47 ) )
			guiSetText ( aTab3.TimeCurrent,	string.format("Hora: %02d:%02d", th, tm ) )
			guiSetText ( aTab3.GravityCurrent, "Gravedad: "..string.sub ( getGravity(), 0, 6 ) )
			guiSetText ( aTab3.SpeedCurrent, "Velocidad del juego: "..getGameSpeed() )
			guiSetText ( aTab3.WeatherCurrent, "Clima: "..getWeather().." ("..getWeatherNameFromID ( getWeather() )..")" )
			local refreshTime = tonumber ( guiGetText ( aTab6.RefreshDelay ) )
			if ( ( refreshTime ) and ( refreshTime >= 20 ) ) then aLastCheck = getTickCount() + refreshTime
			else aLastCheck = getTickCount() + 50 end
		end
		if ( getTickCount() >= aLastSync ) then
			triggerServerEvent ( "aSync", localPlayer, "admins" )
			aLastSync = getTickCount() + 15000
		end
	end
end


function updateColorCodes()
	local lists = { aTab1.PlayerList, aTab5.AdminPlayers, aSpectator.PlayerList }
	for _,gridlist in ipairs(lists) do
		for row=0,guiGridListGetRowCount(gridlist)-1 do
			guiGridListSetItemPlayerName( gridlist, row, 1, guiGridListGetItemPlayerName( gridlist, row, 1 ) )
		end
	end
end

function guiGridListSetItemPlayerName( gridlist, row, col, name )
	local bHideColorCodes = guiCheckBoxGetSelected ( aTab1.HideColorCodes )
	guiGridListSetItemText( gridlist, row, col, bHideColorCodes and removeColorCoding(name) or name, false, false )
	guiGridListSetItemData( gridlist, row, col, name )
end

function guiGridListGetItemPlayerName( gridlist, row, col )
	return guiGridListGetItemData( gridlist, row, col ) or guiGridListGetItemText( gridlist, row, col )
end

-- remove color coding from string
function removeColorCoding( name )
	return type(name)=='string' and string.gsub ( name, '#%x%x%x%x%x%x', '' ) or name
end

-- Unix to date
--dependency:
function Check(funcname, ...)
    local arg = {...}

    if (type(funcname) ~= "string") then
        error("Argument type mismatch at 'Check' ('funcname'). Expected 'string', got '"..type(funcname).."'.", 2)
    end
    if (#arg % 3 > 0) then
        error("Argument number mismatch at 'Check'. Expected #arg % 3 to be 0, but it is "..(#arg % 3)..".", 2)
    end

    for i=1, #arg-2, 3 do
        if (type(arg[i]) ~= "string" and type(arg[i]) ~= "table") then
            error("Argument type mismatch at 'Check' (arg #"..i.."). Expected 'string' or 'table', got '"..type(arg[i]).."'.", 2)
        elseif (type(arg[i+2]) ~= "string") then
            error("Argument type mismatch at 'Check' (arg #"..(i+2).."). Expected 'string', got '"..type(arg[i+2]).."'.", 2)
        end

        if (type(arg[i]) == "table") then
            local aType = type(arg[i+1])
            for _, pType in next, arg[i] do
                if (aType == pType) then
                    aType = nil
                    break
                end
            end
            if (aType) then
                error("Argument type mismatch at '"..funcname.."' ('"..arg[i+2].."'). Expected '"..table.concat(arg[i], "' or '").."', got '"..aType.."'.", 3)
            end
        elseif (type(arg[i+1]) ~= arg[i]) then
            error("Argument type mismatch at '"..funcname.."' ('"..arg[i+2].."'). Expected '"..arg[i].."', got '"..type(arg[i+1]).."'.", 3)
        end
    end
end

local gWeekDays = { "Domingo", "Lunes", "Martes", "Miércoles", "Jueves", "Viernes", "Sábado" }
function FormatDate(format, escaper, timestamp)
	Check("FormatDate", "string", format, "format", {"nil","string"}, escaper, "escaper", {"nil","string"}, timestamp, "timestamp")

	escaper = (escaper or "'"):sub(1, 1)
	local time = getRealTime(timestamp)
	local formattedDate = ""
	local escaped = false

	time.year = time.year + 1900
	time.month = time.month + 1

	local datetime = { d = ("%02d"):format(time.monthday), h = ("%02d"):format(time.hour), i = ("%02d"):format(time.minute), m = ("%02d"):format(time.month), s = ("%02d"):format(time.second), w = gWeekDays[time.weekday+1]:sub(1, 2), W = gWeekDays[time.weekday+1], y = tostring(time.year):sub(-2), Y = time.year }

	for char in format:gmatch(".") do
		if (char == escaper) then escaped = not escaped
		else formattedDate = formattedDate..(not escaped and datetime[char] or char) end
	end

	return formattedDate
end

-- anon admin
function isAnonAdmin()
	return getElementData( localPlayer, "AnonAdmin" ) == true
end

function setAnonAdmin( bOn )
	guiCheckBoxSetSelected ( aTab1.AnonAdmin, bOn )
	setElementData( localPlayer, "AnonAdmin", bOn )
end

function loadFlagImage( guiStaticImage, countryCode )
	if countryCode then
		local flagFilename = "client\\images\\flags\\"..tostring ( countryCode )..".png"
		if getVersion().sortable and getVersion().sortable > "1.1.0" then
			-- 1.1
			if fileExists( flagFilename ) then
				if guiStaticImageLoadImage ( guiStaticImage, flagFilename ) then
					return
				end
			end
		else
			-- 1.0
			guiStaticImageLoadImage ( guiStaticImage, "client\\images\\empty.png" )
			guiStaticImageLoadImage ( guiStaticImage, flagFilename )
			return
		end
	end
	guiStaticImageLoadImage ( guiStaticImage, "client\\images\\empty.png" )
end
