

--[[

	███╗░░██╗███████╗██╗░░██╗████████╗  ██╗░░░░░██╗███████╗███████╗
	████╗░██║██╔════╝╚██╗██╔╝╚══██╔══╝  ██║░░░░░██║██╔════╝██╔════╝
	██╔██╗██║█████╗░░░╚███╔╝░░░░██║░░░  ██║░░░░░██║█████╗░░█████╗░░
	██║╚████║██╔══╝░░░██╔██╗░░░░██║░░░  ██║░░░░░██║██╔══╝░░██╔══╝░░
	██║░╚███║███████╗██╔╝╚██╗░░░██║░░░  ███████╗██║██║░░░░░███████╗
	╚═╝░░╚══╝╚══════╝╚═╝░░╚═╝░░░╚═╝░░░  ╚══════╝╚═╝╚═╝░░░░░╚══════╝ Client.lua

]]



-- Resolución

local screenW, screenH = guiGetScreenSize()

local sx, sy = screenW/1920, screenH/1080
local sW,sH = screenW/1920, screenH/1080 -- screenW/1366, screenH/768

-- Files

local discordLink = "discord.gg/8EwmqwHR"

local dxfont0_PrototypeN = dxCreateFont(":nlogin/files/fonts/Prototype.ttf", 10*sy)

local dxfont1_chaletN = dxCreateFont(":nlogin/files/fonts/chalet.ttf", 11*sy)

local dxfont2_chaletN = dxCreateFont(":nlogin/files/fonts/chalet.ttf", 10*sy)

local img0 = dxCreateTexture(":nlogin/files/images/background.png", "dxt5", true, "clamp")

local img_0 = dxCreateTexture(":nlogin/files/images/background2.png", "dxt5", true, "clamp")

local img_01 = dxCreateTexture(":nlogin/files/images/background3.png", "dxt5", true, "clamp")

local img1 = dxCreateTexture(":nlogin/files/images/Next_life_foro_web.png", "dxt5", true, "clamp")

local img2 = dxCreateTexture(":nlogin/files/images/correo.png", "dxt5", true, "clamp")

local img3 = dxCreateTexture(":nlogin/files/images/mouse.png", "dxt5", true, "clamp")

local uCode = "registrate"
local uLogin = "ingresar"
local uRecover = "regresar"
local DataAcc = {}

local DataUser = ""
local DataPass = ""

-- Creacion de Personajes

local Color_CambiarPers = tocolor(0, 0, 0, 120)
local Color_Regresar_Create = tocolor(255, 255, 255, 180)
local Color_StartCreateChar = tocolor(245, 245, 245, 190)

local Genero_Selected = 0

-- Seleccion de Personaje Colores

local Color_CrearPers = tocolor(0, 0 ,0, 220)
local Color_RegresarLogin = tocolor(0, 0 ,0, 220)
local Color_LogearPersonaje = tocolor(0, 0 ,0, 220)

local Color_AnteriorSkin = tocolor(0, 0 ,0, 220)
local Color_NextSkin = tocolor(0, 0 ,0, 220)

-- Settings

local Posicion_SpawnTest = {1700.994140625, -1428.6181640625, 87.232925415039, 0, 0, 47.074371337891} -- x,y,z rotX,rotY,rotZ
local RatioData = {dim = 0, int = 0} -- Dimension,Interior

local Posicion_SpawnCamera = {1696.9045410156,-1425.1531982422,87.67236328125,1772.1452636719,-1490.8897705078,83.48558807373}

local color_logear = tocolor(255, 255, 255, 255)
local color_recuperar = tocolor(255, 255, 255, 227)
local color_ms = tocolor(143, 77, 23, 247)

-- Recover Colores
local color_recover_main = tocolor(255, 255, 255, 255)
local color_recuperar_2 = tocolor(255, 255, 255, 227)
--

local showLogin = false
local SVGCreated = false
local ventanaS = "Menu_Login"
local valPersonaje = 0 -- Valor para guardar el select del personaje para ver la info y usarlo

local DataPersonajes = {}
local DataUserID = 1
local Player_Data = {}

-- No Tocar (Anti-Spam)

local tick_antes, tick = nil, nil
local AntiSpamSkin = false

--

function setSound(t)
	if t == 1 then
		sound = playSound("files/sounds/enter.mp3")
		setSoundVolume(sound, 0.8)
	elseif t == 2 then
		sound = playSound("files/sounds/back.wav")
		setSoundVolume(sound, 0.8)
	elseif t == 3 then
		sound = playSound("files/sounds/notification.mp3")
		setSoundVolume(sound, 0.8)
	end
end

function onClientMTAFocusChange(windowFocused)
	if not windowFocused then
		showLogin = false
	else
		showLogin = true
	end
end

function utiles_login()

	-- registro text

	if isMouseInPosition ( 1142*sx, 428*sy, 64*sx, 16*sy ) then
		if uCode == "registrate" then
			uCode = "r̲e̲g̲i̲s̲t̲r̲a̲t̲e̲"
			setSound(1)
		end
	else
		if uCode == "r̲e̲g̲i̲s̲t̲r̲a̲t̲e̲" then
			uCode = "registrate"
			setSound(2)
		end
	end

	-- logear text

	if isMouseInPosition(968*sx, 596*sy, 294*sx, 30*sy) then
		if color_logear ~= tocolor(143, 77, 23, 247) then
			color_logear = tocolor(143, 77, 23, 247)
			setSound(1)
		end
	else
		if color_logear ~= tocolor(255, 255, 255, 255) then
			color_logear = tocolor(255, 255, 255, 255)
			setSound(2)
		end
	end

	-- recuperar text

	if isMouseInPosition(1030*sx, 560*sy, 172*sx, 24*sy) then
		if color_recuperar ~= tocolor(143, 77, 23, 247) then
			color_recuperar = tocolor(143, 77, 23, 247)
			setSound(1)
		end
	else
		if color_recuperar ~= tocolor(255, 255, 255, 227) then
			color_recuperar = tocolor(255, 255, 255, 227)
			setSound(2)
		end		
	end

	-- Sonido

	if isMouseInPosition( 977*sx, 762*sy, 16*sx, 16*sy ) then
		if isElement(Musica_Player) then
			if not (isSoundPaused(Musica_Player)) then
				color_ms = tocolor(143, 77, 23, 247)
			else
				color_ms = tocolor(255, 255, 255, 227)
			end
		end
	end
end

function utiles_characters()
	if isMouseInPosition ( 936*sx, 1008*sy, 54*sx, 24*sy ) then -- next skin
		Color_NextSkin = tocolor(245, 138, 2, 200)
	else
		Color_NextSkin = tocolor(0, 0, 0, 220)
	end
	if isMouseInPosition ( 876*sx, 1008*sy, 54*sx, 24*sy ) then -- prev skin
		Color_AnteriorSkin = tocolor(245, 138, 2, 200)
	else
		Color_AnteriorSkin = tocolor(0, 0, 0, 220)
	end
	if isMouseInPosition ( 802*sx, 104*sy, 270*sx, 54*sy ) then -- crear pers
		Color_CrearPers = tocolor(245, 138, 2, 200)
	else
		Color_CrearPers = tocolor(0, 0, 0, 220)
	end
	if isMouseInPosition ( 938*sx, 76*sy, 134*sx, 22*sy ) then -- logout
		Color_RegresarLogin = tocolor(245, 138, 2, 200)
	else
		Color_RegresarLogin = tocolor(0, 0, 0, 220)
	end
	if isMouseInPosition ( 802*sx, 76*sy, 132*sx, 22*sy) then -- login
		Color_LogearPersonaje = tocolor(245, 138, 2, 200)
	else
		Color_LogearPersonaje = tocolor(0, 0, 0, 220)
	end
end

function utiles_newcharacters()
	if isMouseInPosition ( 250*sx, 396*sy, 98*sx, 42*sy ) then -- crear pers
		Color_CambiarPers = tocolor(245, 138, 2, 99)
	else
		Color_CambiarPers = tocolor(0, 0, 0, 120)
	end
	if isMouseInPosition( 154*sx, 474*sy, 190*sx, 40*sy ) then -- Crear Pers
        Color_StartCreateChar = tocolor(245, 245, 245, 210)
    else
        Color_StartCreateChar = tocolor(245, 245, 245, 190)
    end
end

function utiles_recover()

	if isMouseInPosition ( 1146*sx, 428*sy, 70*sx, 18*sy ) then
		if uRecover == "regresar" then
			uRecover = "r̲e̲g̲r̲e̲s̲a̲r̲"
			setSound(1)
		end
	else
		if uRecover == "r̲e̲g̲r̲e̲s̲a̲r̲" then
			uRecover = "regresar"
			setSound(2)
		end
	end

	-- recuperar text

	if isMouseInPosition(1030*sx, 560*sy, 172*sx, 24*sy) then
		if color_recuperar_2 ~= tocolor(143, 77, 23, 247) then
			color_recuperar_2 = tocolor(143, 77, 23, 247)
			setSound(1)
		end
	else
		if color_recuperar_2 ~= tocolor(255, 255, 255, 227) then
			color_recuperar_2 = tocolor(255, 255, 255, 227)
			setSound(2)
		end		
	end

	-- recuperar

	if isMouseInPosition(968*sx, 596*sy, 294*sx, 30*sy) then
		if color_recover_main ~= tocolor(143, 77, 23, 247) then
			color_recover_main = tocolor(143, 77, 23, 247)
			setSound(1)
		end
	else
		if color_recover_main ~= tocolor(255, 255, 255, 255) then
			color_recover_main = tocolor(255, 255, 255, 255)
			setSound(2)
		end
	end

end

function utiles_register()
	-- registro text
	if isMouseInPosition ( 1036*sx, 444*sy, 158*sx, 20*sy ) then
		if uLogin == "ingresar" then
			uLogin = "i̲n̲g̲r̲e̲s̲a̲r̲"
			setSound(1)
		end
	else
		if uLogin == "i̲n̲g̲r̲e̲s̲a̲r̲" then
			uLogin = "ingresar"
			setSound(2)
		end
	end
end

local maleSkins = {
	  0,   1,   2,  5,   7,   8,  14,  15,
	 16,  17,  18,  19,  20,  21,  22,  23,  24,  25,
	 26,  27,  28,  29,  30,  32,  33,  34,  35,  36,
	 37,  42,  43,  44,  45,  46,  47,  48,  49,  50,
	 51,  52,  57,  58,  59,  60,  61,  62,  65,  66,
	 67,  68,  70,  72,  73,  78,  79,  80,  81,
	 82,  83,  84,  94,  95,  96,  97,  98,  99, 100,
	101, 102, 103, 104, 105, 106, 107, 108, 109, 110,
	111, 112, 113, 114, 115, 116, 117, 118, 120,
	121, 122, 123, 124, 125, 126, 127, 128, 132, 133,
	134, 135, 136, 137, 142, 143, 144, 146, 147, 153,
	154, 155, 156, 158, 159, 160, 161, 162, 163, 164,
	165, 166, 167, 168, 170, 171, 173, 174, 175, 176,
	177, 179, 180, 181, 182, 183, 184, 185, 186, 187,
	188, 189, 200, 202, 203, 204, 206, 209, 210, 212,
	213, 217, 220, 221, 222, 223, 227, 228, 229, 230,
	234, 235, 236, 239, 240, 241, 242, 247, 248, 249,
	250, 252, 253, 254, 255, 259, 260, 261, 262,
	264, 268, 269, 270, 271, 272,
	290, 291, 292, 293,
	294, 295, 296, 297, 299, 300, 301, 302, 303, 305,
	306, 307, 308, 309, 310, 311, 312
}

local femaleSkins = {
	  6,   9,  10,  11,  12,  13,  31,  38,  39,  40,
	 41,  53,  54,  55,  56,  63,  64,  69,  75,  76,
	 77,  85,  86,  87,  88,  89,  90,  91,  92,  93,
	129, 130, 131, 138, 139, 140, 141, 145, 148, 150,
	151, 152, 157, 169, 172, 178, 190, 191, 192, 193,
	194, 195, 196, 197, 198, 199, 201, 205, 207, 211,
	214, 215, 216, 218, 219, 224, 225, 226, 231, 232,
	233, 237, 238, 243, 244, 245, 246, 251, 256, 257,
	263, 298, 304
}

function getModel()
	if Genero_Selected == 0 then
		return femaleSkins[math.random(6,#femaleSkins)]
	else
		return maleSkins[math.random(0,#maleSkins)]
	end
end

local IDTest = 0
local PedTest,ObjetoTest,RolTest,RolCode

function goEndLogin(player,tipo,personajes,acc)
	if source == player then
		if isElement(Musica_Player) then
			destroyElement(Musica_Player)
		end
		if tipo == 1 then -- Accede al Correo
			ventanaS = "Menu_Characters"
			DataPersonajes = personajes or {}
			DataAcc = {acc[1],#personajes,acc[2]}
			-- print(inspect(DataPersonajes))
		elseif tipo == 2 then	-- Login Personaje
			if isElement(ObjetoTest) then
				destroyElement(ObjetoTest)
			end
			if isElement(PedTest) then
				destroyElement(PedTest)
			end
			if isElement(PedCreate) then
				destroyElement(PedCreate)
			end
			removeEventHandler("onClientMTAFocusChange", root, onClientMTAFocusChange)
			showCursor(false)
			showLogin = false
			showChat(true)
		elseif tipo == 3 then   -- StartRol
			if isElement(ObjetoTest) then
				destroyElement(ObjetoTest)
			end
			if isElement(PedTest) then
				destroyElement(PedTest)
			end
			if isElement(PedCreate) then
				destroyElement(PedCreate)
			end
			removeEventHandler("onClientMTAFocusChange", root, onClientMTAFocusChange)
			RolTest = true
			triggerEvent("setVisibleTestRol",player)
		elseif tipo == 4 then   -- EndRol
			RolTest = false
			showLogin = false
			showCursor(false)
			showChat(true)
			sendMessage("Felicidades #F58A02Pasaste#ffffff la prueba con exito!",255,255,255)
		elseif tipo == 5 then -- Registro
			ventanaS = "Menu_Login"
			RolCode = acc
			sendMessage("Felicidades #F58A02Creaste#ffffff tu #F58A02cuenta #ffffffcon exito!",255,255,255)
			sendMessage("Tu codigo de recuperacion es #F58A02'"..RolCode.."' #ffffffNo lo pierdas!",255,255,255)
		elseif tipo == 6 then -- Registro Character
			DataPersonajes = personajes or {}
			DataAcc = {acc[1],#personajes,acc[2]}
			if isElement(PedCreate) then
				destroyElement(PedCreate)
			end
			ventanaS = "Menu_Characters"
			sendMessage("Felicidades #F58A02Creaste#ffffff tu #F58A02personaje #ffffffcon exito!",255,255,255)
			AntiSpamSkin = false
			--setTimer(AntiSpamSkin,400,1,true)
		elseif tipo == 0 then   -- New Pers
			ventanaS = "Menu_CreateCharacter"

		end
		if tipo ~= 2 and tipo ~= 3 and tipo ~= 4 and tipo ~= 5  then
			endTransicion()
		else
			removeEventHandler("onClientRender", getRootElement(), moveCamera)
		end
	end
end
addEvent("Roleplay:EndLogin",true)
addEventHandler("Roleplay:EndLogin",root,goEndLogin)

function getClientExp(tab,empleo)
	local tabs = fromJSON(tab)
	if tabs[empleo.."Exp"] then
		return tabs[empleo.."Exp"]
	end
	return 0
end

--[[
function getClientExp(tab,empleo)
	local tabs = fromJSON(tab)
	if tabs[empleo.."Exp"] then
		return tabs[empleo.."Exp"]
	end
	return 0
end
]]

local dxfont0_perv = dxCreateFont(":nlogin/files/fonts/perv.ttf", 38*sy)
local dxfont0n_perv = dxCreateFont(":nlogin/files/fonts/perv.ttf", 28*sy)
local dxfont2n_perv = dxCreateFont(":nlogin/files/fonts/perv.ttf", 42*sy)
local Color_SetInfo = tocolor(255, 255, 255, 255)

local function doCapitalizing( substring )
    return substring:sub( 1, 1 ):upper( ) .. substring:sub( 2 )
end

function convertName( text )
    assert( type( text ) == "string", "Bad argument 1 @ capitalize [String expected, got " .. type( text ) .. "]")
    return ( { string.gsub( text, "%a+", doCapitalizing ) } )[1]
end


addEventHandler("onClientRender", root,
    function()

    	if showLogin == true and not isMTAWindowActive() then
			-- dxDrawImage(1004*sx, 320*sy, 220*sx, 50*sy, ":nlogin/files/images/Next_life_foro_web.png", 0, 0, 0, tocolor(255, 255, 255, 255), true)
	        --dxCreateFramedText("Next Life",1004*sx,320*sy,1224*sx,370*sy,tocolor(0,0,0),3,dxfont0_perv,'left','top',false,false,true)
    		if ventanaS == "Menu_Login" then

    			dxDrawImage(622*sx, 250*sy, 678*sx, 580*sy, img0, 0, 0, 0, tocolor(255, 255, 255, 255), false)
		        dxDrawText("Next Life", (1004 - 1)*sx, (320 - 1)*sy, (1224 - 1)*sx, (370 - 1)*sy, tocolor(255, 130, 0, 110), 1.00, dxfont0_perv, "center", "center", false, false, true, false, false)
		        dxDrawText("Next Life", (1004 + 1)*sx, (320 - 1)*sy, (1224 + 1)*sx, (370 - 1)*sy, tocolor(255, 130, 0, 110), 1.00, dxfont0_perv, "center", "center", false, false, true, false, false)
		        dxDrawText("Next Life", (1004 - 1)*sx, (320 + 1)*sy, (1224 - 1)*sx, (370 + 1)*sy, tocolor(255, 130, 0, 110), 1.00, dxfont0_perv, "center", "center", false, false, true, false, false)
		        dxDrawText("Next Life", (1004 + 1)*sx, (320 + 1)*sy, (1224 + 1)*sx, (370 + 1)*sy, tocolor(255, 130, 0, 110), 1.00, dxfont0_perv, "center", "center", false, false, true, false, false)
		        dxDrawText("Next Life", 1004*sx, 320*sy, 1224*sx, 370*sy, tocolor(1, 0, 0, 250), 1.00, dxfont0_perv, "center", "center", false, false, true, false, false)
		        dxDrawText("NextLife.gg | New RP", 950*sx, 374*sy, 1286*sx, 402*sy, tocolor(255, 255, 255, 200), 1.00, dxfont0_PrototypeN, "center", "center", false, false, true, false, false)

    			utiles_login()

	        	dxDrawText("¡Hola! Ingresa tus datos para conectarte.\nSi no tienes cuenta #e66f0e"..uCode..".", 968*sx, 412*sy, 1262*sx, 440*sy, tocolor(255, 255, 255, 227), 1.00, dxfont1_chaletN, "center", "center", false, false, true, true, false)   

		        dxDrawRectangleBorde(968*sx, 470*sy, 294*sx, 30*sy, tocolor(43, 43, 43, 100), true)
		        dxDrawRectangleBorde(968*sx, 514*sy, 294*sx, 30*sy, tocolor(43, 43, 43, 100), true)
		        dxDrawEditBox("correo_login", "Correo electronico", 998*sx, 474*sy, 260*sx, 22*sy, dxfont1_chaletN, false, 255, 255, 255, 255, true, tocolor(255,255,255,255), "left", true)
		        dxDrawEditBox("pswrd_login", "Contraseña", 998*sx, 518*sy, 260*sx, 22*sy, dxfont1_chaletN, true, 255, 255, 255, 255, true, tocolor(255,255,255,255), "left", true)

		        dxDrawText("¿Problemas para ingresar?", 969*sx, 558*sy, 1262*sx, 586*sy, color_recuperar, 1.00, dxfont1_chaletN, "center", "center", false, false, true, false, false)

		        dxDrawRectangleBorde(968*sx, 596*sy, 294*sx, 30*sy, tocolor(84, 52, 1, 227), true)

		        dxDrawText("➥ Ingresar", 968*sx, 596*sy, 1262*sx, 626*sy, color_logear, 1.00, dxfont1_chaletN, "center", "center", false, false, true, false, false)

		        if correoSVG then
		        	dxDrawImage(978*sx, 478*sy, 14*sx, 14*sy, correoSVG, 0, 0, 0, tocolor(255, 255, 255, 255), true)
		    	end

				if passSVG then
		        	dxDrawImage(977*sx, 522*sy, 16*sx, 16*sy, passSVG, 0, 0, 0, tocolor(255, 255, 255, 255), true)
				end

				if songSVG then
		        	dxDrawImage(977*sx, 762*sy, 16*sx, 16*sy, songSVG, 0, 0, 0, color_ms, true)
				end

				if not (isSoundPaused(Musica_Player)) then
					dxDrawText("Estas escuchando : Young, Wild & Free...", 1000*sx, 758*sy, 1266*sx, 780*sy, tocolor(255, 255, 255, 255), 1.00, dxfont2_chaletN, "left", "center", true, false, true, false, false)
				end
				--if supSVG then
		        --	dxDrawImage(1007*sx, 762*sy, 16*sx, 16*sy, supSVG, 0, 0, 0, tocolor(255, 255, 255, 255), true)
				--end

			end

    		if ventanaS == "Menu_Recover" then

    			dxDrawImage(622*sx, 250*sy, 678*sx, 580*sy, img_01, 0, 0, 0, tocolor(255, 255, 255, 255), false)
		        dxDrawText("Next Life", (1004 - 1)*sx, (320 - 1)*sy, (1224 - 1)*sx, (370 - 1)*sy, tocolor(255, 130, 0, 110), 1.00, dxfont0_perv, "center", "center", false, false, true, false, false)
		        dxDrawText("Next Life", (1004 + 1)*sx, (320 - 1)*sy, (1224 + 1)*sx, (370 - 1)*sy, tocolor(255, 130, 0, 110), 1.00, dxfont0_perv, "center", "center", false, false, true, false, false)
		        dxDrawText("Next Life", (1004 - 1)*sx, (320 + 1)*sy, (1224 - 1)*sx, (370 + 1)*sy, tocolor(255, 130, 0, 110), 1.00, dxfont0_perv, "center", "center", false, false, true, false, false)
		        dxDrawText("Next Life", (1004 + 1)*sx, (320 + 1)*sy, (1224 + 1)*sx, (370 + 1)*sy, tocolor(255, 130, 0, 110), 1.00, dxfont0_perv, "center", "center", false, false, true, false, false)
		        dxDrawText("Next Life", 1004*sx, 320*sy, 1224*sx, 370*sy, tocolor(1, 0, 0, 250), 1.00, dxfont0_perv, "center", "center", false, false, true, false, false)
		        dxDrawText("NextLife.gg | New RP", 950*sx, 374*sy, 1286*sx, 402*sy, tocolor(255, 255, 255, 200), 1.00, dxfont0_PrototypeN, "center", "center", false, false, true, false, false)

    			utiles_recover()

	        	dxDrawText("Ingresa los datos para recuperar.\nSi no tienes problema #e66f0e"..uRecover..".", 968*sx, 412*sy, 1262*sx, 440*sy, tocolor(255, 255, 255, 227), 1.00, dxfont1_chaletN, "center", "center", false, false, true, true, false)   
	        	dxDrawText("Completa los datos\nY recuperarás tu cuenta rapidamente!\nBienvenido a #e66f0eNext Life RP#ffffff!", 644*sx, 278*sy, 924*sx, 372*sy, tocolor(255, 255, 255, 227), 1.00, dxfont1_chaletN, "center", "center", false, false, true, true, false)   

		        dxDrawRectangleBorde(968*sx, 470*sy, 294*sx, 30*sy, tocolor(43, 43, 43, 100), true)
		        dxDrawRectangleBorde(968*sx, 514*sy, 294*sx, 30*sy, tocolor(43, 43, 43, 100), true)
		        dxDrawEditBox("correo_recover", "Correo electronico", 998*sx, 474*sy, 260*sx, 22*sy, dxfont1_chaletN, false, 255, 255, 255, 255, false, tocolor(255,255,255,255), "left", true)
		        dxDrawEditBox("pswrd_recover", "Codigo de Recuperacion", 998*sx, 518*sy, 260*sx, 22*sy, dxfont1_chaletN, false, 255, 255, 255, 255, false, tocolor(255,255,255,255), "left", true)

		        dxDrawText("¿Problemas para recuperar?", 969*sx, 558*sy, 1262*sx, 586*sy, color_recuperar_2, 1.00, dxfont1_chaletN, "center", "center", false, false, true, false, false)

		        dxDrawRectangleBorde(968*sx, 596*sy, 294*sx, 30*sy, tocolor(84, 52, 1, 227), true)

		        dxDrawText("➥ Recuperar", 968*sx, 596*sy, 1262*sx, 626*sy, color_recover_main, 1.00, dxfont1_chaletN, "center", "center", false, false, true, false, false)

		        if correoSVG then
		        	dxDrawImage(978*sx, 478*sy, 14*sx, 14*sy, correoSVG, 0, 0, 0, tocolor(255, 255, 255, 255), true)
		    	end

				if passSVG then
		        	dxDrawImage(977*sx, 522*sy, 16*sx, 16*sy, passSVG, 0, 0, 0, tocolor(255, 255, 255, 255), true)
				end

			end

			if ventanaS == "Menu_Registro" then

				dxDrawImage(622*sx, 250*sy, 678*sx, 580*sy, img_0, 0, 0, 0, tocolor(255, 255, 255, 255), false)

		        dxDrawText("Next Life", (1004 - 1)*sx, (320 - 1)*sy, (1224 - 1)*sx, (370 - 1)*sy, tocolor(255, 130, 0, 110), 1.00, dxfont0_perv, "center", "center", false, false, true, false, false)
		        dxDrawText("Next Life", (1004 + 1)*sx, (320 - 1)*sy, (1224 + 1)*sx, (370 - 1)*sy, tocolor(255, 130, 0, 110), 1.00, dxfont0_perv, "center", "center", false, false, true, false, false)
		        dxDrawText("Next Life", (1004 - 1)*sx, (320 + 1)*sy, (1224 - 1)*sx, (370 + 1)*sy, tocolor(255, 130, 0, 110), 1.00, dxfont0_perv, "center", "center", false, false, true, false, false)
		        dxDrawText("Next Life", (1004 + 1)*sx, (320 + 1)*sy, (1224 + 1)*sx, (370 + 1)*sy, tocolor(255, 130, 0, 110), 1.00, dxfont0_perv, "center", "center", false, false, true, false, false)
		        dxDrawText("Next Life", 1004*sx, 320*sy, 1224*sx, 370*sy, tocolor(1, 0, 0, 250), 1.00, dxfont0_perv, "center", "center", false, false, true, false, false)

		        dxDrawText("NextLife.gg | New RP", 950*sx, 374*sy, 1286*sx, 402*sy, tocolor(255, 255, 255, 200), 1.00, dxfont0_PrototypeN, "center", "center", false, false, true, false, false)

				utiles_register()

	        	dxDrawText("¡Hola! Antes de entrar a jugar debes registrar.\nuna cuenta", 968*sx, 412*sy, 1262*sx, 440*sy, tocolor(255, 255, 255, 227), 1.00, dxfont1_chaletN, "center", "center", false, false, true, true, false)   
				dxDrawText("¿Ya tienes Cuenta? #e66f0e"..uLogin..".", 968*sx, 468*sy, 1262*sx, 440*sy, tocolor(255, 255, 255, 227), 1.00, dxfont2_chaletN, "center", "center", false, false, true, true, false)   
	        	dxDrawText("Completa los datos\nY comienza a crear tus personajes\nen #e66f0eNext Life RP#ffffff!", 644*sx, 278*sy, 924*sx, 372*sy, tocolor(255, 255, 255, 227), 1.00, dxfont1_chaletN, "center", "center", false, false, true, true, false)   

		        dxDrawRectangleBorde(968*sx, 472*sy, 294*sx, 30*sy, tocolor(43, 43, 43, 100), true)

		        dxDrawRectangleBorde(968*sx, 514*sy, 294*sx, 30*sy, tocolor(43, 43, 43, 100), true)

		        dxDrawRectangleBorde(968*sx, 558*sy, 294*sx, 30*sy, tocolor(43, 43, 43, 100), true)

		        dxDrawRectangleBorde(968*sx, 602*sy, 294*sx, 30*sy, tocolor(43, 43, 43, 100), true)

		        dxDrawEditBox("user_register", "Nombre de usuario", 998*sx, 476*sy, 260*sx, 22*sy, dxfont1_chaletN, false, 255, 255, 255, 255, false,tocolor(255,255,255,255), "left", true)

		        dxDrawEditBox("correo_register", "Correo electronico", 998*sx, 518*sy, 260*sx, 22*sy, dxfont1_chaletN, false, 255, 255, 255, 255, false,tocolor(255,255,255,255), "left", true)

		        dxDrawEditBox("pswrd_register", "Contraseña", 998*sx, 562*sy, 260*sx, 22*sy, dxfont1_chaletN, true, 255, 255, 255, 255, false,tocolor(255,255,255,255), "left", true)

		        dxDrawEditBox("pswrd_register_rep", "Repetir Contraseña", 998*sx, 606*sy, 260*sx, 22*sy, dxfont1_chaletN, true, 255, 255, 255, 255, false,tocolor(255,255,255,255), "left", true)

		        if userSVG then
		        	dxDrawImage(978*sx, 480*sy, 14*sx, 14*sy, userSVG, 0, 0, 0, tocolor(255, 255, 255, 255), true)
		    	end		    	

				if correoSVG then
		        	dxDrawImage(978*sx, 522*sy, 14*sx, 14*sy, correoSVG, 0, 0, 0, tocolor(255, 255, 255, 255), true)
				end		    	

				if passSVG then
		        	dxDrawImage(977*sx, 566*sy, 16*sx, 16*sy, passSVG, 0, 0, 0, tocolor(255, 255, 255, 255), true)
				end

				if passSVG then
		        	dxDrawImage(977*sx, 610*sy, 16*sx, 16*sy, passSVG, 0, 0, 0, tocolor(255, 255, 255, 255), true) -- + 44
				end

		        dxDrawRectangleBorde(968*sx, 654*sy, 294*sx, 30*sy, tocolor(84, 52, 1, 227), true)
		        dxDrawText("Registrarse", 968*sx, 714*sy, 1262*sx, 626*sy, color_logear, 1.00, dxfont1_chaletN, "center", "center", false, false, true, false, false)

	    	end

	    	if ventanaS == "Menu_Characters" and RolTest ~= true then

	    		utiles_characters()

		        dxDrawRectangleBorde( 802*sx, 32*sy, 270*sx, 40*sy, tocolor(0, 0, 0, 220), false)

		        dxDrawText("Next Life", (1044 - 1)*sx, (18 - 1)*sy, (830 - 1)*sx, (42 - 1)*sy, tocolor(255, 130, 0, 110), 1.00, dxfont0n_perv, "center", "center", false, false, true, false, false)
		        dxDrawText("Next Life", (1044 + 1)*sx, (18 - 1)*sy, (830 + 1)*sx, (42 - 1)*sy, tocolor(255, 130, 0, 110), 1.00, dxfont0n_perv, "center", "center", false, false, true, false, false)
		        dxDrawText("Next Life", (1044 - 1)*sx, (18 + 1)*sy, (830 - 1)*sx, (42 + 1)*sy, tocolor(255, 130, 0, 110), 1.00, dxfont0n_perv, "center", "center", false, false, true, false, false)
		        dxDrawText("Next Life", (1044 + 1)*sx, (18 + 1)*sy, (830 + 1)*sx, (42 + 1)*sy, tocolor(255, 130, 0, 110), 1.00, dxfont0n_perv, "center", "center", false, false, true, false, false)
		        dxDrawText("Next Life", 1044*sx, 18*sy, 830*sx, 42*sy, tocolor(1, 0, 0, 250), 1.00, dxfont0n_perv, "center", "center", false, false, true, false, false)

                if DataAcc[2] == 1 then 
                	dxDrawBourdeText(1.0,"Bienvenido #F58A02"..DataAcc[1].."#ffffff! , Actualmente tienes #F58A02"..DataAcc[2].." #ffffffpersonaje!",1642*sx, 42*sy, 1840*sx, 66*sy, tocolor(255, 255, 255, 230), tocolor(0, 0, 0, 209), 1.00, dxfont4_ref, "right", "center", false, false, false, true, false)
            	else
					dxDrawBourdeText(1.0,"Bienvenido #F58A02"..DataAcc[1].."#ffffff! , Actualmente tienes #F58A02"..DataAcc[2].." #ffffffpersonajes!",1642*sx, 42*sy, 1840*sx, 66*sy, tocolor(255, 255, 255, 230), tocolor(0, 0, 0, 209), 1.00, dxfont4_ref, "right", "center", false, false, false, true, false)
            	end
		        
		        if #DataPersonajes > 0 then 
		            dxDrawText("Selecciona tu #F58A02Personaje", 1036*sx, 42*sy, 832*sx, 66*sy, tocolor(255, 255, 255, 255), 1.00, dxfont1_chaletN, "center", "center", false, false, false, true, false)
		        else
		            dxDrawText("¡Crea tu primer #F58A02Personaje!", 1036*sx, 42*sy, 832*sx, 66*sy, tocolor(255, 255, 255, 255), 1.00, dxfont1_chaletN, "center", "center", false, false, false, true, false)
		        end

		        dxDrawRectangleBorde( 802*sx, 76*sy, 132*sx, 22*sy, Color_LogearPersonaje, false)
		        dxDrawText("▶ Conectarme", 934*sx, 78*sy, 812*sx, 97*sy, tocolor(255, 255, 255, 255), 1.00, dxfont2_chaletN, "center", "center", false, false, false, false, false)

		        dxDrawRectangleBorde( 938*sx, 76*sy, 134*sx, 22*sy, Color_RegresarLogin, false)
		        dxDrawText("Salir de Cuenta", 940*sx, 78*sy, 1072*sx, 98*sy, tocolor(255, 255, 255, 255), 1.00, dxfont2_chaletN, "center", "center", false, false, false, false, false)
		  
		        dxDrawRectangleBorde(802*sx, 104*sy, 270*sx, 54*sy, Color_CrearPers, false)
		        dxDrawText("Crear Personaje", 806*sx, 108*sy, 1068*sx, 154*sy, tocolor(255, 255, 255, 255), 1.00, dxfont2_chaletN, "center", "center", false, false, false, false, false)

		        if #DataPersonajes > 0 then

			        dxDrawRectangleBorde(936*sx, 1008*sy, 54*sx, 24*sy, Color_NextSkin, false)
			        dxDrawText(">", 986*sx, 1008*sy, 936*sx, 1032*sy, tocolor(255, 255, 255, 255), 1.00, dxfont2_chaletN, "center", "center", false, false, false, false, false)
			        
			        dxDrawRectangleBorde(876*sx, 1008*sy, 54*sx, 24*sy, Color_AnteriorSkin, false)
			        dxDrawText("<", 876 *sx, 1008*sy, 936*sx, 1032*sy, tocolor(255, 255, 255, 255), 1.00, dxfont2_chaletN, "center", "center", false, false, false, false, false)

		    	end

		        for i,chars in pairs(DataPersonajes) do
		            if chars then
		                if i == DataUserID then

								dxDrawBourdeText(1.0,"#F58A02"..convertName(chars["Nick"]).."#ffffff", 790*sW, 954*sH, 1080*sW, 986*sH, tocolor(245, 245, 245, 255), tocolor(0, 0, 0, 209), 1.00, dxfont1_chaletN, "center", "center", false, false, false, true, false)
								dxDrawBourdeText(1.0,"#ffffff$#F58A02"..chars["Money"], 790*sW, 984*sH, 1080*sW, 986*sH, tocolor(245, 245, 245, 255), tocolor(0, 0, 0, 209), 1.00, dxfont1_chaletN, "center", "center", false, false, false, true, false)

								local hours, mins, secs = unpack ( split (chars["Tiempo"], ":" ) or { } )
								local xpe = getClientExp(chars["Empleos"],chars["Empleo"]) or 0

								dxDrawBourdeText(1.0,"XP:#F58A02 "..xpe.."% #ffffffNivel: #F58A02"..chars["Nivel"].." #ffffffEmpleo: #F58A02"..chars["Empleo"], 1660*sW, 1000*sH, 1898*sW, 1002*sH, tocolor(255, 255, 255, 255), tocolor(0, 0, 0, 209), 1.00, dxfont1_chaletN, "right", "center", false, false, false, true, false)
								dxDrawBourdeText(1.0,"Tiempo: #F58A02"..hours.." #ffffffHoras - #F58A02"..mins.." #ffffffMinutos - #F58A02"..secs.." #ffffffSegundos.", 1660*sW, 1036*sH, 1898*sW, 1002*sH, tocolor(255, 255, 255, 255), tocolor(0, 0, 0, 209), 1.00, dxfont1_chaletN, "right", "center", false, false, false, true, false)
		                    
		                    if AntiSpamSkin == false then
		                        setskin(PedTest,chars["Skin"])
		                        Player_Data = {pers = chars["Cuenta"], pass = chars["Clave"], correo = DataAcc[3], skin = chars["Skin"]}
		                        AntiSpamSkin = true
		                    end
		                end
		            end
		        end

		    
	    	end

	    	if ventanaS == "Menu_CreateCharacter" then
	    		utiles_newcharacters()
		        --
		            dxDrawRectangleBorde(37*sx, 182*sy, 412*sx, 406*sy, tocolor(0, 0, 0, 110), false)
					dxDrawText("Next Life", (36 - 1)*sx, (136 - 1)*sy, (468 - 1)*sx, (235 - 1)*sy, tocolor(255, 130, 0, 106), 1.00, dxfont2n_perv, "center", "center", false, false, true, false, false)
			        dxDrawText("Next Life", (36 + 1)*sx, (136 - 1)*sy, (468 + 1)*sx, (235 - 1)*sy, tocolor(255, 130, 0, 106), 1.00, dxfont2n_perv, "center", "center", false, false, true, false, false)
			        dxDrawText("Next Life", (36 - 1)*sx, (136 + 1)*sy, (468 - 1)*sx, (235 + 1)*sy, tocolor(255, 130, 0, 106), 1.00, dxfont2n_perv, "center", "center", false, false, true, false, false)
			        dxDrawText("Next Life", (36 + 1)*sx, (136 + 1)*sy, (468 + 1)*sx, (235 + 1)*sy, tocolor(255, 130, 0, 106), 1.00, dxfont2n_perv, "center", "center", false, false, true, false, false)
			        dxDrawText("Next Life", 36*sx, 136*sy, 468*sx, 235*sy, tocolor(1, 0, 0, 255), 1.00, dxfont2n_perv, "center", "center", false, false, true, false, false)
		            --dxDrawBourdeText(4.5,"Next Life #F58A02RP", 36*sx, 136*sy, 468*sx, 235*sy, tocolor(245, 245, 245, 255), tocolor(0, 0, 0, 209), 1.0, dxfont0n_perv, "center", "center", false, false, false, true, false)
		        --
		            dxDrawText("Crea un nuevo personaje",( 36 + 1 )*sx, (418 + 1)*sy, (468 + 1 )*sx,( 90 + 1)*sy, tocolor(0, 0, 0, 74), 1.00, dxfont1_chaletN, "center", "center", false, false, false, false, false)
		            dxDrawText("Crea un nuevo #F58A02personaje", 36*sx, 418*sy, 468*sx, 90*sy, tocolor(245, 245, 245, 255), 1.00, dxfont1_chaletN, "center", "center", false, false, true, true, false)
		        --
		            dxDrawRectangleBorde(154*sx, 474*sy, 190*sx, 40*sy, tocolor(245, 138, 2, 99), false)
		            dxDrawText("Crear Personaje", 153*sx, 502*sy, 344*sx, 487*sy, Color_StartCreateChar, 1.00, dxfont1_chaletN, "center", "center", false, false, false, false, false)
		        --
		            dxDrawRectangleBorde(142*sx, 290*sy, 104*sx, 42*sy, tocolor(0, 0, 0, 99), false)
		            dxDrawEditBox("nickpers", "Nombre", 144*sx, 290*sy, 104*sx, 42*sy, dxfont1_chaletN, false, 99, 255, 255, 255, false, tocolor(245, 245, 245, 110), "left", true)
		        --
					dxDrawRectangleBorde(250*sx, 290*sy, 108*sx, 42*sy, tocolor(0, 0, 0, 99), false)
		            dxDrawEditBox("apellido", "Apellido", 256*sx, 290*sy, 100*sx, 42*sy, dxfont1_chaletN, false, 9, 255, 255, 255, false, tocolor(245, 245, 245, 110), "left", true)
		        --
		            dxDrawRectangleBorde(142*sx, 340*sy, 214*sx, 43*sy, tocolor(0, 0, 0, 99), false)
		            dxDrawEditBox("Nacionalidad", "Nacionalidad", 144*sx, 340*sy, 214*sx, 43*sy, dxfont1_chaletN, false, 8, 255, 255, 255, false, tocolor(245, 245, 245, 110), "left", true)
		        --
		            dxDrawRectangleBorde(142*sx, 396*sy, 104*sx, 42*sy, tocolor(0, 0, 0, 99), false)
		            dxDrawEditBox("Edad", "Edad (10/100)", 144*sx, 396*sy, 104*sx, 42*sy, dxfont1_chaletN, false, 2, 255, 255, 255, false, tocolor(245, 245, 245, 110), "left", true)
		        --
		            dxDrawRectangleBorde(250*sx, 396*sy, 106*sx, 42*sy, Color_CambiarPers, false)
		            dxDrawText("Cambiar\nSkin", 252*sx, 398*sy, 356*sx, 436*sy, tocolor(255, 255, 255, 255), 1.00, dxfont1_chaletN, "center", "center", false, false, false, false, false)
		        --
		        	if Genero_Selected == 1 then
		        		dxDrawText("♀ #FF8200♂", 36*sx, 208*sy, 450*sx, 240*sy, tocolor(255, 255, 255, 255), 1.4, dxfont1_chaletN, "center", "center", false, false, true, true, false)
		        	else
		        		dxDrawText("#FF8200♀ #FFFEFE♂", 36*sx, 208*sy, 450*sx, 240*sy, tocolor(255, 255, 255, 255), 1.4, dxfont1_chaletN, "center", "center", false, false, true, true, false)
		        	end
		        --
		            dxDrawText("Regresarme", 141*sx, 527*sy, 357*sx, 548*sy, Color_Regresar_Create, 1.00, dxfont1_chaletN, "center", "center", false, false, true, false, false)
		        -- 
		            dxDrawText("© NextLife Roleplay 2024", 38*sx, 558*sy, 450*sx, 586*sy, tocolor(255, 254, 254, 74), 1.00, dxfont1_chaletN, "center", "center", false, false, true, false, false)
		        --
	    	end

    	end
    end
)

function getStateLogin()
	return showLogin
end

addEventHandler ( "onClientClick", root,
function (button, state, absoluteX, absoluteY, worldX, worldY, worldZ, clickedElement)
    if (state == "down") and (button == "left") then 
        if showLogin == true then
            if not tick_antes or ( getTickCount() - tick_antes ) > 700 then
                tick_antes = getTickCount()
                if isMouseInPosition ( 1142*sx, 428*sy, 64*sx, 16*sy ) then -- Registro open
                	if ventanaS == "Menu_Login" then
                		ventanaS = "Menu_Registro"
                	end
                elseif isMouseInPosition ( 1036*sx, 444*sy, 158*sx, 20*sy ) then
                	if ventanaS ~= "Menu_Recover" and ventanaS == "Menu_Registro" then
                		ventanaS = "Menu_Login"
                	end          
                elseif isMouseInPosition( 977*sx, 762*sy, 16*sx, 16*sy ) then
                	if isElement(Musica_Player) then
                		if isSoundPaused(Musica_Player) then
                			setSoundPaused( Musica_Player, false)
                		else
                			setSoundPaused( Musica_Player, true)
                		end
                	end   
                elseif isMouseInPosition( 154*sx, 474*sy, 190*sx, 40*sy ) then -- hombre
                	if ventanaS == "Menu_CreateCharacter" then
                        local nombre = editGetText("nickpers")
                        local apellido = editGetText("apellido")
                        local nacionalidad = editGetText("Nacionalidad")
                        local edad = editGetText("Edad")
                        if (nombre) and (apellido) and (nacionalidad) and (edad) then
                        	if nombre ~= "" then
                        		if apellido ~= "" then
                        			if nacionalidad ~= "" then
                        				if edad ~= "" then
                        					if tonumber(edad) then
	                        					if tonumber(edad) > 0 then
	                        						--print(IDTest)
						                			if Genero_Selected == 1 then -- Masculino
						                				local NickFix = string.gsub(tostring(nombre), "%s+", "")
						                				local ApeFix = string.gsub(tostring(apellido), "%s+", "")
						                				local Nick = tostring(NickFix.."_"..ApeFix)
						                				local data = {nacionalidad,tonumber(edad),"Masculino",0,Nick,getPlayerSerial(localPlayer),IDTest}
						                				triggerServerEvent( "Roleplay:RegisterRPNextLife", getLocalPlayer(), getLocalPlayer(), 2, DataAcc[3], data)
						                			else -- Femenino
														local NickFix = string.gsub(tostring(nombre), "%s+", "")
						                				local ApeFix = string.gsub(tostring(apellido), "%s+", "")
						                				local Nick = tostring(NickFix.."_"..ApeFix)
						                				local data = {nacionalidad,tonumber(edad),"Femenino",0,Nick,getPlayerSerial(localPlayer),IDTest}
						                				triggerServerEvent( "Roleplay:RegisterRPNextLife", getLocalPlayer(), getLocalPlayer(), 2, DataAcc[3], data)
						                			end
						                		else
													sendMessage("Escribe una #F58A02edad#ffffff valida mayor a 0!",255,255,255)
													setSound(3)
					                			end
					                		else
												sendMessage("Escribe una #F58A02edad#ffffff valida!",255,255,255)
												setSound(3)
				                			end
										else
											sendMessage("Escribe una #F58A02edad#ffffff!",255,255,255)
											setSound(3)
			                			end
		                			else
										sendMessage("Escribe una #F58A02nacionalidad#ffffff!",255,255,255)
										setSound(3)
		                			end
		                		else
									sendMessage("Escribe un #F58A02apellido#ffffff!",255,255,255)
									setSound(3)
	                			end
	                		else
								sendMessage("Escribe un #F58A02nombre#ffffff!",255,255,255)
								setSound(3)
                			end
                		end
                	end
                elseif isMouseInPosition(248*sx, 216*sy, 14*sx, 14*sy) then -- hombre
                	if ventanaS == "Menu_CreateCharacter" then
                		if Genero_Selected == 0 then
                			Genero_Selected = 1
                			local sk = getModel()
                			IDTest = tonumber(sk)
                			setskin(PedCreate,sk)
                		end
                	end
                elseif isMouseInPosition(224*sx, 216*sy, 14*sx, 14*sy) then -- mujer
                	if ventanaS == "Menu_CreateCharacter" then
                		if Genero_Selected == 1 then
                			Genero_Selected = 0
                			local sk = getModel()
                			IDTest = tonumber(sk)
                			setskin(PedCreate,sk)
                		end
                	end
                elseif isMouseInPosition(250*sx, 396*sy, 106*sx, 42*sy) then
                	if ventanaS == "Menu_CreateCharacter" then
            			local sk = getModel()
            			IDTest = tonumber(sk)
            			setskin(PedCreate,sk)
                	end
                elseif isMouseInPosition(207*sx, 527*sy, 78*sx, 21*sy) then -- Regresar a Characters
                	if ventanaS == "Menu_CreateCharacter" then
                		ventanaS = "Menu_Characters"
						if isElement(PedCreate) then
							destroyElement(PedCreate)
						end

						PedTest = createPed( 0, Posicion_SpawnTest[1],Posicion_SpawnTest[2],Posicion_SpawnTest[3])
						setElementDimension( PedTest, RatioData["dim"] )
						setElementInterior( PedTest, RatioData["int"] )
						setPedAnimation(PedTest, "dealer", "dealer_idle", -1, true, false, false, false )
						setElementRotation( PedTest, Posicion_SpawnTest[4],Posicion_SpawnTest[5],Posicion_SpawnTest[6])
                	end
                elseif isMouseInPosition(802*sx, 104*sy, 270*sx, 54*sy) then -- Crear Personaje
                	if ventanaS == "Menu_Characters" then
                		if RolTest ~= true then
                			if #DataPersonajes < LimitePersonajes then
		                		ventanaS = "Menu_CreateCharacter"
								if isElement(PedTest) then
									destroyElement(PedTest)
								end
								local sk = getModel()
								IDTest = tonumber(sk)
								PedCreate = createPed( sk, Posicion_SpawnTest[1],Posicion_SpawnTest[2],Posicion_SpawnTest[3])
								setElementDimension( PedCreate, RatioData["dim"] )
								setElementInterior( PedCreate, RatioData["int"] )
								setElementRotation( PedCreate, Posicion_SpawnTest[4],Posicion_SpawnTest[5],Posicion_SpawnTest[6])
								setPedAnimation(PedCreate, "dealer", "dealer_idle", -1, true, false, false, false )
							else
								sendMessage("Ya tienes un maximo de #F58A02"..LimitePersonajes.." Personajes#ffffff!",255,255,255)
							end
						end
                	end
                elseif isMouseInPosition(802*sx, 76*sy, 132*sx, 22*sx) then -- Logear
                	if ventanaS == "Menu_Characters" then
                		if RolTest ~= true then
							if not tick_antes_login or ( getTickCount() - tick_antes_login ) > 700 then
				                tick_antes_login = getTickCount()
	                			if #DataPersonajes > 0 then
									triggerServerEvent("Roleplay:LoginPlayer",localPlayer,localPlayer,"Login",Player_Data.correo,Player_Data.pers,Player_Data.pass)
								else
									sendMessage("Comienza un #F58A02Personaje#ffffff Primero!",255,255,255)
									setSound(3)
								end
							end
						end
                	end
                elseif isMouseInPosition(938*sx, 76*sy, 134*sx, 22*sy) then -- Salir de la cuenta
                	if ventanaS == "Menu_Characters" then
                		if RolTest ~= true then
							if isElement(ObjetoTest) then
								destroyElement(ObjetoTest)
							end
							if isElement(PedTest) then
								destroyElement(PedTest)
							end
							if isElement(PedCreate) then
								destroyElement(PedCreate)
							end
							AntiSpamSkin = false
							Musica_Player = playSound("files/sounds/intro.mp3",true)
							setSoundVolume(Musica_Player, 0.10)
							cameraMoveSoft(1582.1903076172,-1443.5068359375,55.896156311035,1574.3370361328,-1428.5705566406,154.4620513916,1543.9533691406,-1390.2562255859,354.99435424805,1541.4802246094,-1293.2023925781,331.02682495117)
							fadeCamera(false, 0)
							fadeCamera(true, 1)
							ventanaS = "Menu_Login"
						end
                	end
			    elseif isMouseInPosition(936*sx, 1008*sy, 54*sx, 24*sy) then -- +
                    if ventanaS == "Menu_Characters" then
                        if AntiSpamSkin == true then
                        	if RolTest ~= true then
	                            DataUserID = math.min( DataUserID + 1, #DataPersonajes )
	                            AntiSpamSkin = false
                        	end
                        end
                    end
			    elseif isMouseInPosition(876*sx, 1008*sy, 54*sy, 24*sy) then -- -
					if ventanaS == "Menu_Characters" then
                        if AntiSpamSkin == true then
                        	if RolTest ~= true then
                            	DataUserID = math.max( DataUserID - 1,1)   
                            	AntiSpamSkin = false
                        	end
                        end
                    end
                elseif isMouseInPosition ( 968*sx, 596*sy, 294*sx, 30*sy ) then --
                    if ventanaS == "Menu_Login" then
                        local user = editGetText("correo_login")
                        local pass = editGetText("pswrd_login")
                        if (user) and (pass) then
                            if user ~= "" then
                            	if string.find(user,"@") then
	                                if pass ~= "" then
	                                    triggerServerEvent( "Roleplay:LoginPlayer", getLocalPlayer(), getLocalPlayer(), "PreLogin", user, "@adminaccess", pass )
	                                else
	                                    sendMessage("Escribe una #F58A02contraseña#ffffff!",255,255,255)
	                                    setSound(3)
	                                end
	                            else
	                            	sendMessage( "Ingresa el correo #F58A02correctamente '@'!",255,255,255)
	                            	setSound(3)
                            	end
                            else
                                sendMessage("Escribe un #F58A02Correo Electronico#ffffff!",255,255,255)
                                setSound(3)
                            end
                        else
                            sendMessage("Completa los datos #F58A02correctamente#ffffff!",255,255,255)
                            setSound(3)
                        end
                    
                	elseif ventanaS == "Menu_Recover" then
						local correo_rec = editGetText("correo_recover")
                        local code_rec = editGetText("pswrd_recover")
                        if (correo_rec) and (code_rec) then
                        	if correo_rec ~= "" or string.find(correo_rec,"@") then
                        		if code_rec ~= "" then
                					triggerServerEvent("Roleplay:RecoverRPNextLife", getLocalPlayer(), getLocalPlayer(), correo_rec, code_rec)
                				else
                					sendMessage( "Ingresa el codigo #F58A02correctamente!",255,255,255)
                					setSound(3)
                				end
                			else
                				sendMessage( "Ingresa el correo #F58A02correctamente!",255,255,255)
                				setSound(3)
                			end
                		end
                    end
               	elseif isMouseInPosition(1030*sx, 560*sy, 172*sx, 24*sy) then
                	if ventanaS == "Menu_Login" then
                		ventanaS = "Menu_Recover"
                	
                	elseif ventanaS == "Menu_Recover" then
                		--ventanaS = "Menu_Login"
                		sendMessage("Escribenos a nuestro discord #F58A02"..discordLink.." #ffffffy un staff te ayudará!",255,255,255)
                		setSound(1)
                	end
                elseif isMouseInPosition(968*sx, 654*sy, 294*sx, 30*sy) then -- Registro
                    if ventanaS == "Menu_Registro" then
                        local user = editGetText("user_register")
                        local mail = editGetText("correo_register")
                        local pass = editGetText("pswrd_register")
                        local rpass = editGetText("pswrd_register_rep")
                        if (user) and (pass) and (rpass) and (mail) then
                            if user ~= "" then
                            	if mail ~= "" then
	                                if pass ~= ""  or string.find(pass," ") then
	                                    if rpass ~= "" then
	                                        if #user >= 3 then
	                                            if #pass >= 8 then
	                                                if (pass == rpass) then
	                                                	if string.find(mail,"@") then
	                                                    	triggerServerEvent( "Roleplay:RegisterRPNextLife", getLocalPlayer(), getLocalPlayer(), 1, mail, user, pass )
	                                                    else
	                                                    	sendMessage( "Ingresa el correo #F58A02correctamente!",255,255,255)
	                                                	end
	                                                else
	                                                    sendMessage( "Las contraseñas no #F58A02coinciden!",255,255,255)
	                                                end
	                                            else
	                                                sendMessage( "Su contraseña debe tener al menos #F58A028 #ffffffcaracteres.",255,255,255)
	                                            end
	                                        else
	                                            sendMessage( "Su nombre de usuario debe tener al menos #F58A023 #ffffffcaracteres.",255,255,255)
	                                        end
	                                    else
	                                        sendMessage("Repite la #F58A02contraseña#ffffff!",255,255,255)
	                                    end
	                                else
	                                    sendMessage("Escribe una #F58A02contraseña#ffffff!",255,255,255)
	                                end
                                else
                                    sendMessage("Escribe un #F58A02correo#ffffff!",255,255,255)	                                
                            	end
                            else
                                sendMessage("Escribe un #F58A02usuario#ffffff!",255,255,255)
                            end
                        else
                            sendMessage("Completa los #F58A02datos correctamente#ffffff!",255,255,255)
                        end
                    end

                end
                if isMouseInPosition(1152*sx, 428*sy, 58*sx, 16*sy) then
                	if ventanaS == "Menu_Recover" then
                		ventanaS = "Menu_Login"
                	end    
                end
            end
        end
    end
end)


function cameraMoveSoft(camPosX, camPosY, camPosZ, newCamPosX, newCamPosY, newCamPosZ, camLookX, camLookY, camLookZ, newCamLookX, newCamLookY, newCamLookZ, typeCameraMove)
    local savePos = {camPosX, camPosY, camPosZ, newCamPosX, newCamPosY, newCamPosZ, camLookX, camLookY, camLookZ, newCamLookX, newCamLookY, newCamLookZ, typeCameraMove}
    local x = 0 
    local y = 0 
    function moveCamera() 
        x = x + 0.00011
        y = y + 1.5000
        local cameraX, cameraY, cameraZ = interpolateBetween(camPosX, camPosY, camPosZ, newCamPosX, newCamPosY, newCamPosZ, x, "Linear") 
        local lookX, lookY, lookZ = interpolateBetween(camLookX, camLookY, camLookZ, newCamLookX, newCamLookY, newCamLookZ, y, "Linear") 
        setCameraMatrix(cameraX, cameraY, cameraZ, lookX, lookY, lookZ)
        if cameraX == newCamPosX and cameraY == newCamPosY and cameraZ == newCamPosZ and lookX == newCamLookX and lookY == newCamLookY and lookZ == newCamLookZ then 
            --removeEventHandler("onClientRender", getRootElement(), moveCamera)
            cameraMoveSoft(unpack(savePos))
        end 
    end 
    addEventHandler("onClientRender", getRootElement(), moveCamera) 
end


function showLoginT(t)
	if t == true then
		setSVG()
		showCursor(t)
		showLogin = t
		tick_antes_login = getTickCount()
		Musica_Player = playSound("files/sounds/intro.mp3",true)
		setSoundVolume(Musica_Player, 0.10)
		RatioData = {dim = math.random(10,65000), int = 0}
		cameraMoveSoft(1582.1903076172,-1443.5068359375,55.896156311035,1574.3370361328,-1428.5705566406,154.4620513916,1543.9533691406,-1390.2562255859,354.99435424805,1541.4802246094,-1293.2023925781,331.02682495117)
		addEventHandler("onClientMTAFocusChange", root, onClientMTAFocusChange)
		fadeCamera(false, 0)
		fadeCamera(true, 1)
		showChat(false)
		setPlayerHudComponentVisible ( "radar", false )
		outputConsole(RatioData["dim"])
		setElementDimension( localPlayer, RatioData["dim"] )
		setElementInterior( localPlayer, RatioData["int"] )
		setTimer(function() triggerServerEvent("NL:UpdateLogin:Data",localPlayer,localPlayer) end,250,1)
	else
		showLogin = false
	end
end


function recargarLog(player,data1,data2)
	if isElement(player) then
		if source == player then
			DataUser = data1
			DataPass = data2
			if exports.nlconfig:recoverData() ~= false then
				if exports.nlconfig:recoverData() == "Si" then
			        setTimer(editSetText,500,1,"correo_login", tostring(DataUser))
			        setTimer(editSetText,500,1,"pswrd_login", tostring(DataPass))
				end
			end
			if exports.nlconfig:recoverSong() ~= false then
				if exports.nlconfig:recoverSong() == "Si" then
					if isElement(Musica_Player) then
                		if not isSoundPaused(Musica_Player) then
                			setSoundPaused( Musica_Player, true)
							color_ms = tocolor(255, 255, 255, 227)
                		end
                	end   
				end
			end
		end
	end
end
addEvent("NL:RecoverData:init",true)
addEventHandler("NL:RecoverData:init",root,recargarLog)

function setSVG()
	if SVGCreated == false then
		rawSVGData1 = [[<svg xmlns="http://www.w3.org/2000/svg" height="16" viewBox="0 0 16 16" width="16"><path d="m8 1.75c3.4517797 0 6.25 2.79822031 6.25 6.25 0 1.80742408-1.2364936 3.25-2.75 3.25-.7281305 0-1.271692-.2898434-1.64197818-.8038333-.46377622.4963711-1.09698752.8038333-1.85802182.8038333-1.69027009 0-2.75-1.51668519-2.75-3.25s1.05972991-3.25 2.75-3.25c.51089834 0 .96419044.13856458 1.34802449.37979351.12831294-.22667052.37226233-.37979351.65197551-.37979351.3796958 0 .693491.28215388.7431534.64822944l.0068466.10177056v2.5c0 1.2431283.2811264 1.75.75 1.75.6293508 0 1.25-.72409074 1.25-1.75 0-2.62335256-2.1266474-4.75-4.75-4.75-2.62335256 0-4.75 2.12664744-4.75 4.75 0 2.6233526 2.12664744 4.75 4.75 4.75.39547699 0 .78387496-.0481767 1.15931645-.1422976l.27905994-.0791705.19471945-.0665019c.38896416-.142407.81972556.0574671.96213266.4464313.1305397.3565504-.0265317.7482222-.3532182.9207145l-.0932131.0414181-.2567669.0876926c-.60703442.192609-1.24330282.2917135-1.8920303.2917135-3.45177969 0-6.25-2.7982203-6.25-6.25 0-3.45177969 2.79822031-6.25 6.25-6.25zm0 4.5c-.72318279 0-1.25.75398066-1.25 1.75s.52681721 1.75 1.25 1.75 1.25-.75398066 1.25-1.75-.52681721-1.75-1.25-1.75z" fill="#ffffff"/></svg>]]
		rawSVGData2 = [[<svg xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" enable-background="new 0 0 139 139" height="139px" id="Safety" version="1.1" viewBox="0 0 139 139" width="139px" xml:space="preserve"><path d="M109.92,59.988c0.426-2.44,0.661-4.95,0.661-7.516c0-23.326-18.429-42.305-41.081-42.305  c-22.653,0-41.083,18.979-41.083,42.305c0,2.566,0.236,5.074,0.663,7.516c-3.567,2.278-5.939,6.261-5.939,10.81v41.415  c0,7.084,5.743,12.826,12.825,12.826h67.067c7.08,0,12.822-5.742,12.822-12.826h0.004V70.798  C115.859,66.25,113.489,62.266,109.92,59.988z M75.159,96.15v9c0,3.128-2.534,5.662-5.661,5.662c-3.127,0-5.661-2.534-5.661-5.662  v-9.004c-3.631-2.001-6.094-5.862-6.094-10.302c0-6.492,5.263-11.756,11.757-11.756c6.494,0,11.758,5.264,11.758,11.756  C81.258,90.286,78.793,94.15,75.159,96.15z M94.95,57.971H44.049c-0.349-1.775-0.535-3.616-0.535-5.499  c0-15.003,11.657-27.208,25.986-27.208c14.328,0,25.984,12.204,25.984,27.208C95.484,54.355,95.3,56.196,94.95,57.971z" fill="#fff6f6"/></svg>]]
		rawSVGData3 = [[<svg xmlns="http://www.w3.org/2000/svg" width="220" height="44" viewBox="0 0 220 44" version="1.1"><path d="M 181.004 3.292 C 179.632 3.986, 177.461 6.455, 176.180 8.777 C 173.621 13.416, 171.460 14.552, 173.025 10.435 C 174.844 5.650, 174.378 5, 169.122 5 C 164.017 5, 162.729 5.846, 161.513 10 C 161.110 11.375, 159.480 15.264, 157.890 18.643 C 156.301 22.022, 155 25.284, 155 25.893 C 155 26.589, 152.590 27, 148.515 27 L 142.029 27 143.934 22.250 C 144.981 19.637, 146.828 15.152, 148.039 12.283 C 150.911 5.474, 150.290 4, 144.554 4 C 138.986 4, 138.868 4.163, 131.591 21.959 C 127.444 32.099, 126.362 35.732, 127.191 36.730 C 128.881 38.766, 160.942 38.096, 162.148 36 C 162.622 35.175, 164.275 31.596, 165.821 28.048 C 169.402 19.826, 170.644 21.389, 167.253 29.851 C 164.360 37.068, 164.791 37.958, 171.191 37.985 C 175.335 38.002, 175.492 37.833, 179.091 29.500 C 180.520 26.191, 182.417 23.357, 183.319 23.181 C 184.808 22.891, 184.823 23.180, 183.478 26.399 C 179.960 34.818, 182.611 38, 193.141 38 C 201.627 38, 202.657 37.570, 204.013 33.459 C 204.624 31.609, 205.966 29.828, 206.995 29.502 C 209.244 28.788, 213 21.419, 213 17.719 C 213 16.124, 212.231 14.659, 211.066 14.035 C 208.681 12.759, 193.499 12.663, 191.170 13.909 C 190.032 14.518, 188.835 14.353, 187.545 13.409 C 185.761 12.105, 185.896 12, 189.360 12 C 192.714 12, 193.259 11.625, 194.613 8.383 C 195.444 6.394, 195.886 4.144, 195.594 3.383 C 194.907 1.593, 184.492 1.528, 181.004 3.292 M 22.654 6.250 C 19.643 11.118, 10.717 34.820, 11.311 36.369 C 12.080 38.371, 20.207 38.660, 21.799 36.742 C 22.374 36.050, 23.715 33.264, 24.781 30.551 L 26.719 25.618 27.971 29.559 C 30.241 36.705, 31.549 38, 36.500 38 C 40.032 38, 41.247 37.534, 42.372 35.750 C 45.306 31.092, 54.284 7.183, 53.685 5.621 C 52.925 3.640, 46.183 3.389, 43.744 5.250 C 42.843 5.938, 41.245 8.723, 40.193 11.441 L 38.281 16.382 37.029 12.441 C 34.759 5.295, 33.451 4, 28.500 4 C 24.960 4, 23.761 4.462, 22.654 6.250 M 181.219 4.672 C 180.515 4.955, 178.820 7.395, 177.453 10.094 C 176.085 12.792, 174.288 15, 173.458 15 C 171.438 15, 169.478 20.059, 171.108 21.067 C 171.976 21.603, 171.586 23.565, 169.647 28.410 C 168.191 32.046, 167 35.241, 167 35.511 C 167 35.780, 168.716 36, 170.812 36 C 174.602 36, 174.642 35.957, 177.627 28.750 C 179.922 23.209, 181.147 21.424, 182.826 21.179 C 184.040 21.002, 185.699 19.549, 186.537 17.929 C 187.971 15.156, 187.944 15, 186.026 15 C 183.910 15, 183.591 14.231, 184.607 11.582 C 184.994 10.574, 186.432 10, 188.572 10 C 191.788 10, 194 7.989, 194 5.066 C 194 3.988, 183.712 3.671, 181.219 4.672 M 20.034 16.250 C 17.701 21.888, 14.945 28.637, 13.910 31.250 L 12.029 36 16.426 36 L 20.823 36 23.570 29 C 25.080 25.150, 26.606 22, 26.961 22 C 27.316 22, 28.621 25.150, 29.861 29 L 32.115 36 36.419 36 L 40.723 36 44.966 25.750 C 47.299 20.112, 50.055 13.363, 51.090 10.750 L 52.971 6 48.574 6 L 44.177 6 41.430 13 C 39.920 16.850, 38.394 20, 38.039 20 C 37.684 20, 36.379 16.850, 35.139 13 L 32.885 6 28.581 6 L 24.277 6 20.034 16.250 M 139.060 8.250 C 138.570 9.488, 135.881 16.027, 133.085 22.783 C 130.288 29.538, 128 35.276, 128 35.533 C 128 35.790, 132.938 36, 138.974 36 L 149.949 36 151.474 33.050 C 153.887 28.383, 153.510 28, 146.500 28 C 142.925 28, 140 27.827, 140 27.616 C 140 27.405, 141.800 22.908, 144 17.622 C 146.200 12.335, 148 7.558, 148 7.005 C 148 6.452, 146.189 6, 143.975 6 C 140.732 6, 139.778 6.437, 139.060 8.250 M 163.975 8.565 C 162.631 12.101, 162.546 12, 166.893 12 C 169.520 12, 170.983 11.486, 171.393 10.418 C 172.707 6.993, 172.052 6, 168.475 6 C 165.612 6, 164.768 6.481, 163.975 8.565 M 107.235 9.938 C 105.598 12.815, 105.154 12.988, 99.372 12.994 C 95.042 12.998, 92.864 13.458, 91.948 14.563 C 90.816 15.927, 90.545 15.938, 89.826 14.654 C 89.157 13.459, 86.051 13.169, 73.386 13.116 C 64.659 13.081, 56.939 13.497, 55.885 14.061 C 53.274 15.459, 51.519 18.382, 48.543 26.289 L 45.988 33.079 48.448 35.539 C 50.616 37.707, 51.784 38, 58.255 38 C 62.295 38, 66.089 37.511, 66.687 36.913 C 67.470 36.130, 67.962 36.130, 68.446 36.913 C 69.479 38.584, 79.526 38.276, 80.977 36.528 C 82.053 35.232, 82.375 35.232, 83.671 36.528 C 84.571 37.428, 87.069 38, 90.103 38 C 96.140 38, 96.920 36.685, 94.806 30.071 L 93.306 25.381 96.368 23.205 C 100.691 20.134, 101.845 21.750, 99.662 27.821 C 96.919 35.448, 98.996 38, 107.949 38 C 112.605 38, 113.196 37.728, 115.025 34.750 C 117.569 30.607, 117.188 28.582, 113.791 28.188 C 111.344 27.905, 111.198 27.660, 112.186 25.492 C 112.931 23.856, 114.250 23.011, 116.383 22.803 C 121.530 22.302, 124.824 13, 119.855 13 C 118.346 13, 117.987 12.400, 118.212 10.250 C 118.486 7.630, 118.274 7.486, 113.735 7.195 C 109.332 6.912, 108.839 7.121, 107.235 9.938 M 108 12 C 106.691 15.160, 106.334 15.276, 98.695 15.012 C 91.757 14.772, 89.315 17.323, 92.426 21.559 C 93.820 23.457, 93.913 23.444, 96.676 20.950 C 98.229 19.547, 100.352 17.751, 101.394 16.958 C 103.152 15.620, 103.234 15.686, 102.537 17.883 C 102.081 19.320, 102.219 20.517, 102.889 20.931 C 103.650 21.402, 103.306 23.237, 101.779 26.850 C 98.839 33.809, 99.796 35.397, 107.173 35.795 C 112.215 36.066, 112.730 35.888, 113.819 33.497 C 115.391 30.048, 115.374 30, 112.559 30 C 109.253 30, 108.951 29.142, 110.711 24.750 C 112.005 21.520, 112.654 21, 115.388 21 C 117.996 21, 118.763 20.465, 119.694 18 C 120.796 15.079, 120.747 15, 117.806 15 C 114.689 15, 114.715 15.112, 116.703 10.250 C 117.061 9.374, 116.023 9, 113.228 9 C 109.743 9, 109.087 9.376, 108 12 M 55.182 16.818 C 54.142 17.858, 52.034 21.912, 50.499 25.825 C 46.818 35.206, 47.415 36, 58.147 36 C 65.710 36, 66.091 35.890, 67.025 33.435 C 67.561 32.024, 68 30.674, 68 30.435 C 68 30.196, 65.525 30, 62.500 30 C 59.475 30, 57 29.784, 57 29.520 C 57 29.256, 57.724 27.231, 58.609 25.020 C 60.107 21.276, 60.489 21, 64.168 21 C 66.744 21, 67.886 21.376, 67.450 22.081 C 67.082 22.676, 65.699 22.890, 64.375 22.558 C 62.414 22.066, 61.779 22.452, 60.945 24.644 C 59.623 28.121, 61.049 29.107, 66.899 28.761 C 72.246 28.444, 75.193 25.170, 75.378 19.340 L 75.500 15.500 66.287 15.213 C 58.347 14.966, 56.813 15.187, 55.182 16.818 M 79.823 20.126 L 81.462 25.251 75.481 30.601 L 69.500 35.951 74.595 35.976 C 78.488 35.994, 80.129 35.515, 81.552 33.943 L 83.414 31.886 84.175 33.943 C 84.802 35.640, 85.803 36, 89.887 36 L 94.838 36 92.326 27.821 C 88.148 14.214, 88.712 15, 83.117 15 L 78.184 15 79.823 20.126 M 157.747 23.250 C 152.188 36.530, 152.230 36, 156.737 36 L 160.609 36 164.409 26.750 C 166.499 21.663, 168.435 16.938, 168.711 16.250 C 169.063 15.374, 168.014 15, 165.207 15 L 161.200 15 157.747 23.250 M 190.145 16.855 C 189.125 17.875, 187.034 21.912, 185.499 25.825 C 181.818 35.206, 182.415 36, 193.147 36 C 200.710 36, 201.091 35.890, 202.025 33.435 C 202.561 32.024, 203 30.674, 203 30.435 C 203 30.196, 200.525 30, 197.500 30 C 194.475 30, 192 29.784, 192 29.520 C 192 29.256, 192.724 27.231, 193.609 25.020 C 195.107 21.276, 195.489 21, 199.168 21 C 201.744 21, 202.886 21.376, 202.450 22.081 C 202.082 22.676, 200.699 22.890, 199.375 22.558 C 197.414 22.066, 196.779 22.452, 195.945 24.644 C 194.668 28.004, 195.917 28.963, 201.595 28.985 C 206.355 29.002, 208.264 27.338, 210.389 21.315 C 212.384 15.661, 211.381 15, 200.800 15 C 193.563 15, 191.671 15.329, 190.145 16.855 M 75.620 25 C 74.649 27.200, 73.470 29, 72.999 29 C 71.826 29, 69 31.917, 69 33.129 C 69 33.671, 71.422 32.024, 74.383 29.468 C 78.303 26.084, 79.630 24.301, 79.266 22.910 C 78.515 20.037, 77.571 20.578, 75.620 25" stroke="none" fill="#cc6804" fill-rule="evenodd"/><path d="M 181.219 4.672 C 180.515 4.955, 178.820 7.395, 177.453 10.094 C 176.085 12.792, 174.288 15, 173.458 15 C 171.438 15, 169.478 20.059, 171.108 21.067 C 171.976 21.603, 171.586 23.565, 169.647 28.410 C 168.191 32.046, 167 35.241, 167 35.511 C 167 35.780, 168.716 36, 170.812 36 C 174.602 36, 174.642 35.957, 177.627 28.750 C 179.922 23.209, 181.147 21.424, 182.826 21.179 C 184.040 21.002, 185.699 19.549, 186.537 17.929 C 187.971 15.156, 187.944 15, 186.026 15 C 183.910 15, 183.591 14.231, 184.607 11.582 C 184.994 10.574, 186.432 10, 188.572 10 C 191.788 10, 194 7.989, 194 5.066 C 194 3.988, 183.712 3.671, 181.219 4.672 M 20.034 16.250 C 17.701 21.888, 14.945 28.637, 13.910 31.250 L 12.029 36 16.426 36 L 20.823 36 23.570 29 C 25.080 25.150, 26.606 22, 26.961 22 C 27.316 22, 28.621 25.150, 29.861 29 L 32.115 36 36.419 36 L 40.723 36 44.966 25.750 C 47.299 20.112, 50.055 13.363, 51.090 10.750 L 52.971 6 48.574 6 L 44.177 6 41.430 13 C 39.920 16.850, 38.394 20, 38.039 20 C 37.684 20, 36.379 16.850, 35.139 13 L 32.885 6 28.581 6 L 24.277 6 20.034 16.250 M 139.060 8.250 C 138.570 9.488, 135.881 16.027, 133.085 22.783 C 130.288 29.538, 128 35.276, 128 35.533 C 128 35.790, 132.938 36, 138.974 36 L 149.949 36 151.474 33.050 C 153.887 28.383, 153.510 28, 146.500 28 C 142.925 28, 140 27.827, 140 27.616 C 140 27.405, 141.800 22.908, 144 17.622 C 146.200 12.335, 148 7.558, 148 7.005 C 148 6.452, 146.189 6, 143.975 6 C 140.732 6, 139.778 6.437, 139.060 8.250 M 163.975 8.565 C 162.631 12.101, 162.546 12, 166.893 12 C 169.520 12, 170.983 11.486, 171.393 10.418 C 172.707 6.993, 172.052 6, 168.475 6 C 165.612 6, 164.768 6.481, 163.975 8.565 M 108 12 C 106.691 15.160, 106.334 15.276, 98.695 15.012 C 91.757 14.772, 89.315 17.323, 92.426 21.559 C 93.820 23.457, 93.913 23.444, 96.676 20.950 C 98.229 19.547, 100.352 17.751, 101.394 16.958 C 103.152 15.620, 103.234 15.686, 102.537 17.883 C 102.081 19.320, 102.219 20.517, 102.889 20.931 C 103.650 21.402, 103.306 23.237, 101.779 26.850 C 98.839 33.809, 99.796 35.397, 107.173 35.795 C 112.215 36.066, 112.730 35.888, 113.819 33.497 C 115.391 30.048, 115.374 30, 112.559 30 C 109.253 30, 108.951 29.142, 110.711 24.750 C 112.005 21.520, 112.654 21, 115.388 21 C 117.996 21, 118.763 20.465, 119.694 18 C 120.796 15.079, 120.747 15, 117.806 15 C 114.689 15, 114.715 15.112, 116.703 10.250 C 117.061 9.374, 116.023 9, 113.228 9 C 109.743 9, 109.087 9.376, 108 12 M 55.182 16.818 C 54.142 17.858, 52.034 21.912, 50.499 25.825 C 46.818 35.206, 47.415 36, 58.147 36 C 65.710 36, 66.091 35.890, 67.025 33.435 C 67.561 32.024, 68 30.674, 68 30.435 C 68 30.196, 65.525 30, 62.500 30 C 59.475 30, 57 29.784, 57 29.520 C 57 29.256, 57.724 27.231, 58.609 25.020 C 60.107 21.276, 60.489 21, 64.168 21 C 66.744 21, 67.886 21.376, 67.450 22.081 C 67.082 22.676, 65.699 22.890, 64.375 22.558 C 62.414 22.066, 61.779 22.452, 60.945 24.644 C 59.623 28.121, 61.049 29.107, 66.899 28.761 C 72.246 28.444, 75.193 25.170, 75.378 19.340 L 75.500 15.500 66.287 15.213 C 58.347 14.966, 56.813 15.187, 55.182 16.818 M 79.823 20.126 L 81.462 25.251 75.481 30.601 L 69.500 35.951 74.595 35.976 C 78.488 35.994, 80.129 35.515, 81.552 33.943 L 83.414 31.886 84.175 33.943 C 84.802 35.640, 85.803 36, 89.887 36 L 94.838 36 92.326 27.821 C 88.148 14.214, 88.712 15, 83.117 15 L 78.184 15 79.823 20.126 M 157.747 23.250 C 152.188 36.530, 152.230 36, 156.737 36 L 160.609 36 164.409 26.750 C 166.499 21.663, 168.435 16.938, 168.711 16.250 C 169.063 15.374, 168.014 15, 165.207 15 L 161.200 15 157.747 23.250 M 190.145 16.855 C 189.125 17.875, 187.034 21.912, 185.499 25.825 C 181.818 35.206, 182.415 36, 193.147 36 C 200.710 36, 201.091 35.890, 202.025 33.435 C 202.561 32.024, 203 30.674, 203 30.435 C 203 30.196, 200.525 30, 197.500 30 C 194.475 30, 192 29.784, 192 29.520 C 192 29.256, 192.724 27.231, 193.609 25.020 C 195.107 21.276, 195.489 21, 199.168 21 C 201.744 21, 202.886 21.376, 202.450 22.081 C 202.082 22.676, 200.699 22.890, 199.375 22.558 C 197.414 22.066, 196.779 22.452, 195.945 24.644 C 194.668 28.004, 195.917 28.963, 201.595 28.985 C 206.355 29.002, 208.264 27.338, 210.389 21.315 C 212.384 15.661, 211.381 15, 200.800 15 C 193.563 15, 191.671 15.329, 190.145 16.855" stroke="none" fill="#120a04" fill-rule="evenodd"/></svg>]]
		rawSVGData4 = [[<svg xmlns="http://www.w3.org/2000/svg" xmlns:cc="http://creativecommons.org/ns#" xmlns:dc="http://purl.org/dc/elements/1.1/" xmlns:inkscape="http://www.inkscape.org/namespaces/inkscape" xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#" xmlns:sodipodi="http://sodipodi.sourceforge.net/DTD/sodipodi-0.dtd" xmlns:svg="http://www.w3.org/2000/svg" height="14" id="svg8" version="1.1" viewBox="0 0 6.3499998 6.3500002" width="14"><defs id="defs2" fill="#ffffff"/><g id="layer1"><path d="M 3.1708661,3.2974124 C 1.907863,3.2997936 0.86304935,4.299744 0.79995125,5.5634239 A 0.26460945,0.26460945 0 0 0 1.0655682,5.8404096 H 5.2864993 A 0.26460945,0.26460945 0 0 0 5.5500489,5.5634239 C 5.48687,4.2981438 4.4396051,3.2975523 3.1750001,3.2974124 Z" id="path1332" style="color:#ffffff;font-style:normal;font-variant:normal;font-weight:normal;font-stretch:normal;font-size:medium;line-height:normal;font-family:sans-serif;font-variant-ligatures:normal;font-variant-position:normal;font-variant-caps:normal;font-variant-numeric:normal;font-variant-alternates:normal;font-variant-east-asian:normal;font-feature-settings:normal;font-variation-settings:normal;text-indent:0;text-align:start;text-decoration:none;text-decoration-line:none;text-decoration-style:solid;text-decoration-color:#ffffff;letter-spacing:normal;word-spacing:normal;text-transform:none;writing-mode:lr-tb;direction:ltr;text-orientation:mixed;dominant-baseline:auto;baseline-shift:baseline;text-anchor:start;white-space:normal;shape-padding:0;shape-margin:0;inline-size:0;clip-rule:nonzero;display:inline;overflow:visible;visibility:visible;isolation:auto;mix-blend-mode:normal;color-interpolation:sRGB;color-interpolation-filters:linearRGB;solid-color:#ffffff;solid-opacity:1;vector-effect:none;fill:#ffffff;fill-opacity:1;fill-rule:nonzero;stroke:none;stroke-width:0.529167;stroke-linecap:butt;stroke-linejoin:round;stroke-miterlimit:4;stroke-dasharray:none;stroke-dashoffset:0;stroke-opacity:1;paint-order:stroke fill markers;color-rendering:auto;image-rendering:auto;shape-rendering:auto;text-rendering:auto;enable-background:accumulate;stop-color:#ffffff"/><path d="m 3.1750901,0.5095872 c -0.669506,0 -1.2153281,0.54839 -1.2153321,1.21864 -1.9e-6,0.6702501 0.5458221,1.2205301 1.2153321,1.2205301 0.6695099,0 1.217222,-0.55028 1.2172191,-1.2205301 -4e-6,-0.67025 -0.5477132,-1.21864 -1.2172191,-1.21864 z" id="path1292" style="color:#ffffff;font-style:normal;font-variant:normal;font-weight:normal;font-stretch:normal;font-size:medium;line-height:normal;font-family:sans-serif;font-variant-ligatures:normal;font-variant-position:normal;font-variant-caps:normal;font-variant-numeric:normal;font-variant-alternates:normal;font-variant-east-asian:normal;font-feature-settings:normal;font-variation-settings:normal;text-indent:0;text-align:start;text-decoration:none;text-decoration-line:none;text-decoration-style:solid;text-decoration-color:#ffffff;letter-spacing:normal;word-spacing:normal;text-transform:none;writing-mode:lr-tb;direction:ltr;text-orientation:mixed;dominant-baseline:auto;baseline-shift:baseline;text-anchor:start;white-space:normal;shape-padding:0;shape-margin:0;inline-size:0;clip-rule:nonzero;display:inline;overflow:visible;visibility:visible;isolation:auto;mix-blend-mode:normal;color-interpolation:sRGB;color-interpolation-filters:linearRGB;solid-color:#ffffff;solid-opacity:1;vector-effect:none;fill:#ffffff;fill-opacity:1;fill-rule:nonzero;stroke:none;stroke-width:0.529167;stroke-linecap:butt;stroke-linejoin:round;stroke-miterlimit:4;stroke-dasharray:none;stroke-dashoffset:0;stroke-opacity:1;paint-order:stroke fill markers;color-rendering:auto;image-rendering:auto;shape-rendering:auto;text-rendering:auto;enable-background:accumulate;stop-color:#ffffff"/></g></svg>]]
		rawSVGData5 = [[<?xml version="1.0" encoding="utf-8"?> <!-- Svg Vector Icons : http://www.onlinewebfonts.com/icon --> <!DOCTYPE svg PUBLIC "-//W3C//DTD SVG 1.1//EN" "http://www.w3.org/Graphics/SVG/1.1/DTD/svg11.dtd"> <svg version="1.1" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" x="0px" y="0px" viewBox="0 0 256 256" enable-background="new 0 0 256 256" xml:space="preserve"> <metadata> Svg Vector Icons : http://www.onlinewebfonts.com/icon </metadata> <g><g><g><g><path fill="#ffffff" d="M207.3,152.9c-6,5.6-13.3,9.8-21.5,11.9c7.6,12.1,12.9,26,14.8,40.9c0.4,2.9-0.2,5.7-1.4,8.2h42c1.3,0,2.6-0.6,3.6-1.7c0.9-1,1.3-2.3,1.2-3.6C242.9,184.6,227.7,164.1,207.3,152.9z"/><path fill="#ffffff" d="M159,136.3c1.7,1.2,3.3,2.5,4.9,3.8c1.6,1.3,3.2,2.6,4.7,4c4.3,4,8.3,8.3,11.9,12.9c6.8-1.2,13-4.1,18.2-8.3c1.3-1,2.6-2.1,3.7-3.3c1.1-1.1,2.1-2.3,3.1-3.5c5.5-7,8.9-15.9,8.9-25.5c0-22.8-18.5-41.3-41.3-41.3c-4.8,0-9.4,0.9-13.6,2.4c1.5,5.3,2.3,10.8,2.3,16.5c0,13.7-4.6,26.2-12.2,36.4C152.8,132.2,155.9,134.2,159,136.3z"/><path fill="#ffffff" d="M97.1,214h7.7H185c2.1,0,4.1-0.9,5.4-2.4c1.2-1.3,1.7-3,1.5-4.7c-1.9-15-7.4-28.7-15.6-40.5c-1-1.4-2-2.9-3.1-4.3c-1.2-1.6-2.5-3.1-3.9-4.6c-3.8-4.3-8-8.2-12.5-11.7c-1.5-1.2-3.1-2.3-4.7-3.4c-1.6-1.1-3.2-2.1-4.8-3.1c-1.2-0.7-2.5-1.4-3.8-2.1c-1.3,1.2-2.5,2.4-3.9,3.5c-1.1,0.9-2.3,1.8-3.5,2.6s-2.4,1.6-3.7,2.4c-0.6,0.4-1.2,0.7-1.8,1.1c-0.2,0.1-0.4,0.2-0.5,0.3c-8.7,4.8-18.6,7.5-29.2,7.5c-16.6,0-31.7-6.7-42.7-17.6C32.7,150.8,14,176.3,10,206.8c-0.2,1.7,0.3,3.4,1.5,4.8c1.3,1.5,3.3,2.4,5.4,2.4h75.3L97.1,214L97.1,214z"/><path fill="#ffffff" d="M63.5,129.9c1.1,1.1,2.2,2.2,3.4,3.3c9.1,7.9,21,12.8,34,12.8c9.9,0,19.1-2.8,27-7.7c1.3-0.8,2.5-1.6,3.7-2.5c1.2-0.8,2.3-1.7,3.3-2.6c0.1-0.1,0.1-0.1,0.2-0.2c1.1-1,2.2-2,3.2-3.1c1.1-1.1,2.1-2.3,3.1-3.5c7.1-8.9,11.4-20.1,11.4-32.4c0-4.4-0.6-8.6-1.6-12.6c-0.4-1.5-0.8-2.9-1.3-4.4c-0.5-1.4-1-2.8-1.6-4.1C140.3,54.7,122.1,42,101,42C72.3,42,49.1,65.3,49.1,94c0,12.3,4.3,23.5,11.4,32.4C61.4,127.6,62.5,128.8,63.5,129.9z"/></g></g><g></g><g></g><g></g><g></g><g></g><g></g><g></g><g></g><g></g><g></g><g></g><g></g><g></g><g></g><g></g></g></g> </svg>]]
		rawSVGData6 = [[<?xml version="1.0" encoding="utf-8"?> <!-- Svg Vector Icons : http://www.onlinewebfonts.com/icon --> <!DOCTYPE svg PUBLIC "-//W3C//DTD SVG 1.1//EN" "http://www.w3.org/Graphics/SVG/1.1/DTD/svg11.dtd"> <svg version="1.1" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" x="0px" y="0px" viewBox="0 0 256 256" enable-background="new 0 0 256 256" xml:space="preserve"> <metadata> Svg Vector Icons : http://www.onlinewebfonts.com/icon </metadata> <g><g><path fill="#ffffff" d="M201.6,125.8c0-38.4-32.9-69.5-73.4-69.5c-40.6,0-73.4,31.1-73.4,69.5c0,18.8,7.9,35.9,20.7,48.4c5.8,5,12.2,9.3,19.1,12.8c3.8,1.9,8,3.7,12.4,5.4c6.7,1.9,13.8,3,21.2,3C168.8,195.3,201.6,164.2,201.6,125.8z M128.2,174.2c-40,0-40-34.4-40-34.4c41.6,33.3,80,0,80,0S168.2,174.2,128.2,174.2z M221.7,103.9c-10.3-39.8-48.3-69.3-93.4-69.3c-45.2,0-83.1,29.5-93.4,69.3c0,0-25.9,3.9-24.8,28.6c1.2,24.7,28.5,26.2,28.5,26.2c0.3,0.8,6.1-0.8,8.1-1.1c-4.3-9.8-6.6-20.5-6.6-31.8c0-46.2,39.5-83.6,88.2-83.6c48.7,0,88.2,37.4,88.2,83.6c0,36.8-25.1,68.1-60,79.2c-2.3,0.7-4.6-0.2-4.6-0.2s-5.9-1.1-13.3,0.9c-3.7,1-5.2,4.7-5,7.9c0.3,3.9,1.8,6.6,6.1,7.2c5.5,0.8,13.2,1.7,16.2-3.8c0.8-1.5,1.7-4.3,3.5-4.9c27-8.7,48.5-28.4,58.8-53.5c0,0,27.2-3,28-26.8S221.7,103.9,221.7,103.9z"/></g></g> </svg>]]
		rawSVGData7 = [[<?xml version="1.0" encoding="utf-8"?> <!-- Svg Vector Icons : http://www.onlinewebfonts.com/icon --> <!DOCTYPE svg PUBLIC "-//W3C//DTD SVG 1.1//EN" "http://www.w3.org/Graphics/SVG/1.1/DTD/svg11.dtd"> <svg version="1.1" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" x="0px" y="0px" viewBox="0 0 256 256" enable-background="new 0 0 256 256" xml:space="preserve"> <metadata> Svg Vector Icons : http://www.onlinewebfonts.com/icon </metadata> <g><g><g><path fill="#ffffff" d="M162.5,22.5C117.2,29.3,79.2,35,78.1,35.2l-2,0.3v69.9c0,38.4-0.2,69.9-0.4,69.9s-1.6-0.4-3-0.9c-13.8-4.9-30.1-2.9-43.4,5.2c-4.7,2.8-11.5,9.5-14,13.7c-6.4,10.6-7,21.5-1.9,31.9c9.5,19.4,37.5,26.8,60.3,15.9c9.8-4.6,17-11.6,21.2-20.4c3.5-7.5,3.2-1.6,3.4-73l0.1-64l1-0.2c0.6-0.1,28.3-4.3,61.7-9.3c33.4-5,61.1-9.2,61.7-9.3l1-0.2v44.2c0,24.3-0.1,44.2-0.3,44.2c-0.2,0-1.8-0.5-3.6-1.1c-9.5-3.2-21.9-3.1-32,0.4c-14.5,4.9-25.5,15.7-28.8,28.1c-1.8,6.7-1.7,11.9,0.4,18.4c3.5,11.1,14.3,20.2,28.3,23.8c3.3,0.8,5.2,1,11.8,1c6.9,0,8.4-0.2,12.4-1.3c16.3-4.4,28.1-14.6,32.8-28.8l1.1-3.2l0.1-90.2c0.1-72.5,0-90.1-0.5-90.1C245.2,10,207.8,15.7,162.5,22.5z"/></g></g></g> </svg>]]
		rawSVGData8 = [[<?xml version="1.0" standalone="no"?> <!DOCTYPE svg PUBLIC "-//W3C//DTD SVG 20010904//EN"  "http://www.w3.org/TR/2001/REC-SVG-20010904/DTD/svg10.dtd"> <svg version="1.0" xmlns="http://www.w3.org/2000/svg"  width="512.000000pt" height="512.000000pt" viewBox="0 0 512.000000 512.000000"  preserveAspectRatio="xMidYMid meet"> <g transform="translate(0.000000,512.000000) scale(0.100000,-0.100000)" fill="#ffffff" stroke="none"> <path d="M3221 4939 c-71 -14 -137 -65 -174 -134 -17 -31 -22 -58 -22 -115 0 -88 22 -137 81 -190 76 -66 66 -65 533 -68 l425 -3 -468 -468 -469 -469 -91 60 c-478 315 -1081 394 -1620 214 -680 -228 -1157 -828 -1237 -1557 -14 -127 -6 -370 16 -494 69 -393 237 -717 515 -995 279 -279 601 -445 1000 -516 128 -23 450 -26 575 -5 429 69 805 269 1092 581 394 429 561 1047 439 1625 -47 221 -145 453 -269 636 l-65 96 469 469 468 468 3 -430 c3 -473 2 -462 68 -538 118 -134 341 -102 422 62 l23 47 3 744 c2 504 -1 761 -8 796 -15 73 -59 128 -128 162 l-57 28 -740 2 c-407 0 -760 -3 -784 -8z m-1001 -1594 c206 -31 416 -116 582 -235 105 -75 254 -227 326 -333 357 -520 294 -1239 -147 -1687 -260 -264 -591 -403 -961 -403 -273 0 -514 73 -745 224 -105 69 -297 261 -364 364 -154 236 -225 474 -224 755 1 223 45 407 146 604 188 368 560 642 957 706 41 6 82 13 90 15 46 9 258 3 340 -10z"/> </g> </svg> ]]
		rawSVGData9 = [[<?xml version="1.0" standalone="no"?> <!DOCTYPE svg PUBLIC "-//W3C//DTD SVG 20010904//EN" "http://www.w3.org/TR/2001/REC-SVG-20010904/DTD/svg10.dtd"> <svg version="1.0" xmlns="http://www.w3.org/2000/svg" width="978.000000pt" height="1280.000000pt" viewBox="0 0 978.000000 1280.000000" preserveAspectRatio="xMidYMid meet"> <metadata> Created by potrace 1.15, written by Peter Selinger 2001-2017 </metadata> <g transform="translate(0.000000,1280.000000) scale(0.100000,-0.100000)" fill="#ffffff" stroke="none"> <path d="M3925 12790 c-781 -50 -1552 -320 -2162 -758 -573 -412 -1012 -928 -1327 -1562 -228 -459 -350 -872 -413 -1405 -31 -267 -22 -722 22 -1030 148 -1033 660 -1953 1455 -2614 263 -220 520 -386 835 -541 404 -199 713 -301 1144 -376 352 -61 842 -71 1211 -23 417 53 807 162 1188 331 63 27 115 48 117 46 1 -2 225 -367 497 -813 272 -445 513 -840 536 -876 l40 -67 -699 -427 c-384 -235 -697 -430 -695 -434 10 -17 419 -686 420 -688 1 -1 314 189 696 422 381 234 697 425 700 425 4 0 267 -426 585 -947 794 -1299 762 -1248 778 -1247 10 1 612 361 685 410 2 1 -301 500 -673 1109 -372 609 -675 1108 -673 1109 2 1 315 193 695 425 381 233 693 427 693 431 0 7 -402 672 -416 689 -2 2 -317 -189 -700 -423 -384 -235 -701 -423 -704 -419 -6 6 -1049 1713 -1066 1744 -2 4 29 33 69 65 581 470 1024 1068 1296 1752 211 531 313 1149 281 1709 -45 808 -281 1523 -712 2160 -301 443 -712 846 -1173 1149 -487 319 -1022 530 -1585 625 -284 48 -662 67 -945 49z m685 -835 c508 -72 935 -228 1352 -492 723 -458 1231 -1146 1453 -1968 134 -497 150 -1085 44 -1575 -176 -808 -649 -1531 -1324 -2025 -382 -280 -871 -487 -1355 -574 -221 -40 -375 -53 -625 -53 -223 1 -306 6 -490 33 -805 118 -1590 572 -2108 1219 -394 491 -622 1031 -714 1690 -22 158 -25 663 -5 810 49 350 119 614 240 900 373 883 1116 1581 1997 1876 291 97 530 146 870 178 92 9 566 -4 665 -19z"/></g></svg>]]
		correoSVG = svgCreate(14, 14, rawSVGData1) -- Correo
		passSVG = svgCreate(16, 16, rawSVGData2) -- Pass
		logoSVG = svgCreate(220, 44, rawSVGData3) -- Logo
		userSVG = svgCreate(14, 14, rawSVGData4) -- User
		persSVG = svgCreate(16, 24, rawSVGData5) -- Personajes
		supSVG = svgCreate(16, 16, rawSVGData6) -- Soporte
		songSVG = svgCreate(16, 16, rawSVGData7) -- Song
		masculinoSVG = svgCreate(16, 16, rawSVGData8) -- Song
		femeSVG = svgCreate(24, 24, rawSVGData9) -- Song
		SVGCreated = true
	end
end

showLoginT(true)

function dxCreateFramedText(text, left, top, width, height, color, scale, font, alignX, alignY, clip, wordBreak, postGUI)
	local self = {}
	local rt = dxCreateRenderTarget(1920, 1080, true)
	self.draw = function(x, y, w, h)
		dxDrawImage(left, top, width, height, rt)
	end
	self.update = function()
		dxSetRenderTarget(rt, true)
		dxDrawText(text, 1, 1, width + 1, height + 1, tocolor(255, 130, 0, 110), scale, font, alignX, alignY, clip, wordBreak, postGUI)
		dxDrawText(text, 1, -1, width + 1, height - 1, tocolor(255, 130, 0, 110), scale, font, alignX, alignY, clip, wordBreak, postGUI)
		dxDrawText(text, -1, 1, width - 1, height + 1, tocolor(255, 130, 0, 110), scale, font, alignX, alignY, clip, wordBreak, postGUI)
		dxDrawText(text, 1, 1, width - 1, height - 1, tocolor(255, 130, 0, 110), scale, font, alignX, alignY, clip, wordBreak, postGUI)
		dxDrawText(text, 0, 0, width, height, color, scale, font, alignX, alignY, clip, wordBreak, postGUI)
		dxSetRenderTarget()
	end
	self.setText = function(v)
		text = v
		self.update()
	end
	self.setColor = function(v)
		color = v
		self.update()
	end
	self.update()
	return self
end


function endTransicion()
	removeEventHandler("onClientRender", getRootElement(), moveCamera)

	ObjetoTest = createObject(idObjeto, 1692.73828125, -1420.396484375, 91.529800415039)
	setElementDimension( ObjetoTest, RatioData["dim"] )
	setElementInterior( ObjetoTest, RatioData["int"] )
    setElementRotation( ObjetoTest, 0, 0, 90)

	setCameraMatrix(unpack(Posicion_SpawnCamera))

	PedTest = createPed( 0, Posicion_SpawnTest[1],Posicion_SpawnTest[2],Posicion_SpawnTest[3])
	setElementDimension( PedTest, RatioData["dim"] )
	setElementInterior( PedTest, RatioData["int"] )
	setPedAnimation(PedTest, "dealer", "dealer_idle", -1, true, false, false, false )
	setElementRotation( PedTest, Posicion_SpawnTest[4],Posicion_SpawnTest[5],Posicion_SpawnTest[6])
end

function setskin(ped,id)
	if isElement(ped) then
		ped:setModel(tonumber(id))
	end
end
