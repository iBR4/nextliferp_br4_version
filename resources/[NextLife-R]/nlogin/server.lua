loadstring(exports.MySQL:getMyCode())()
import('*'):init('MySQL')


function isNewAccount(correo)
	local s = query("SELECT * FROM Registros where Correo = ?", correo)
	if not ( type( s ) == "table" and #s == 0 ) or not s then
		return true
	end
	return false
end

function getDatas(correo,value)
	local s = query("SELECT * FROM Registros where Correo = ?", correo)
	if not ( type( s ) == "table" and #s == 0 ) or not s then
		return s[1][value]
	end
	return false
end

function getAccs(player)
	local s = query("SELECT * FROM Registros where Serial = ?", getPlayerSerial(player))
	if not ( type( s ) == "table" and #s == 0 ) or not s then
		return false
	else
		return #s
	end
end

function getPersonaje(correo,value)
	local s = query("SELECT * FROM Datos_Personajes where Correo = ?", correo)
	if not ( type( s ) == "table" and #s == 0 ) or not s then
		return s[1][value]
	end
	return false
end

function getSaveData(Cuenta,value)
	local s = query("SELECT * FROM save_system where Cuenta = ?", Cuenta)
	if not ( type( s ) == "table" and #s == 0 ) or not s then
		return s[1][value]
	end
	return false
end


function Account1(user,pass)
	local s = query("SELECT * FROM Registros where Cuenta = ?", user)
	if #s > 0 then
		local user_,pass_ = s[1]["Cuenta"],s[1]["Clave"]
		-- print(user_,pass_,user,pass)
		if tostring(user_) == tostring(user) then
			if tostring(pass_) == tostring(pass) then
				return true
			end
		end
	end
	return false
end

function getCharacters(correo)
	local s = query("SELECT * FROM save_system where Correo = ?", correo)
	local cache = {}
	for i,data in pairs(s) do
		table.insert(cache,data)
	end
	return cache
end

function getCharactersAll()
	local s = query("SELECT * FROM save_system")
	local cache = {}
	for i,data in pairs(s) do
		table.insert(cache,data)
	end
	return cache
end


function getGlobalCharacters(player)
	if isElement(player) then
		local acc = mysql:AccountName(player)
		local correo = getSaveData(acc,"Correo")
		return #getCharacters(correo)
	end
	return false
end

function setUpdateCharacter(acc,value,newValue)
	local _,error = mysql:update("UPDATE save_system SET "..value.." = ?  WHERE "..data.." = ?", newValue, acc)
	if not error then
		return true
	end
	return false
end


--exports.["nlogin"]:setUpdateCharacter(personaje,"","")

local SaveOP = {}

function RecLoginPlayer(player)
	if source == player then
		if SaveOP[player] then
			triggerClientEvent(player,"Roleplay:EndLogin",player,player,4)
			mysql:update("UPDATE Registros SET TestRol = ?  WHERE Correo = ?", 'Si', tostring(SaveOP[player][3]))
			LoginPlayer(unpack(SaveOP[player]))
		end
	end
end
addEvent("Roleplay:RecoverLoginPlayer", true)
addEventHandler("Roleplay:RecoverLoginPlayer", root, RecLoginPlayer)

local function doCapitalizing( substring )
    return substring:sub( 1, 1 ):upper( ) .. substring:sub( 2 )
end

function convertName( text )
    assert( type( text ) == "string", "Bad argument 1 @ capitalize [String expected, got " .. type( text ) .. "]")
    return ( { string.gsub( text, "%a+", doCapitalizing ) } )[1]
end


function LoginPlayer(player, cat, correo, user, pass, extra)
	if player == source then
		if cat ~= "PreLogin" then

			local acc = getAccount(user, pass)
			if acc ~= false then

				local s = query("SELECT * FROM Registros where Correo = ?", correo)
				if not ( type( s ) == "table" and #s == 0 ) or not s then

					local test = s[1]["TestRol"]

					if test == "No" then
						SaveOP[player] = {player, cat, correo, user, pass, 0}
						triggerClientEvent(player,"Roleplay:EndLogin",player,player,3)
					else
						triggerClientEvent(player,"Roleplay:EndLogin",player,player,2)
						local nombre_ = getSaveData(user,"Nick")
						player:setName(convertName(nombre_))
						local nombre = tostring(getSaveData(user,"Nick")):gsub("_"," ")
						local lv = getSaveData(user,"Nivel")
						player:setData("Nivel",tonumber(lv))
						triggerClientEvent(player,"addPlayerUpdatePresenceState",player,player,"#"..(player:getData('ID') or 0).." (RP/ID)" )
						triggerClientEvent(player,"addPlayerUpdatePresence",player,player,convertName(nombre),tonumber(lv))
						setPlayerHudComponentVisible(player, "radar", true )
						setTimer(logIn, 500, 1, player, acc, pass)
						setTimer(function(player)
							if isElement(player) then
								clearChatBox(player)
								player:outputChat("#DDFFDD¡Bienvenido, Gracias por jugar en #EE8A02Next Life#ffffff!", 255, 255, 255, true)
							end
						end, 1000, 1, player)
						-- 
						setTimer(function(player)
							if isElement(player) then
								clearChatBox(player)
								local nick = user
								player:outputChat("#DDFFDD¡Bienvenido#DDFFDD a #EE8A02Next Life!", 255, 255, 255, true)
								player:outputChat("#FFAE00===Te dejamos nuestras redes del servidor===", 255, 255, 255, true)
								player:outputChat("#DDFFDDDiscord: #ffffffdiscord.gg/aHBFkNVJDX", 255, 255, 255, true)
								player:outputChat("#DDFFDDTienda: #ffffffnext-life-rp.tebex.io", 255, 255, 255, true)
								player:outputChat("#DDFFDDForo: #ffffffnextliferp.foroactivo.com", 255, 255, 255, true)
							end
						end, 1800, 1, player)
					end

				end

			else
				player:triggerEvent("callNotification", player, "error", "Por favor, contactate con un administrador Error #40559.", true)
			end

		else

			if isNewAccount(correo) ~= false then
				local correo_ = getDatas(correo,"Correo")
				local pass_ = getDatas(correo,"Clave")
				if correo == correo_ then
					if pass == pass_ then
						if isElement(player) then
							local Personajes = getCharacters(correo)
							local MyAcc = {getDatas(correo,"Cuenta"),correo}
							if #Personajes > 0 then
								triggerClientEvent(player,"Roleplay:EndLogin",player,player,1,Personajes,MyAcc)
							else
								triggerClientEvent(player,"Roleplay:EndLogin",player,player,1,{},MyAcc)
							end
						end
					else
						player:triggerEvent("callNotification", player, "error", "La contraseña no coincide con la cuenta!.", true)	
					end
				else
					player:triggerEvent("callNotification", player, "error", "Por favor, escriba un correo con cuenta!.", true)			
				end
			else
				player:triggerEvent("callNotification", player, "error", "Error, Esta cuenta no existe!.", true)
			end

		end
	end
end
addEvent("Roleplay:LoginPlayer", true)
addEventHandler("Roleplay:LoginPlayer", root, LoginPlayer)


function registerNextLife(player, t, correo, user, pass, data)
	if t == 1 then
		if getAccs(player) ~= false then
			onRegisterNext(player, correo, user, pass)
		else
			triggerClientEvent(player,"addTextMessage3D",player,"Solo puedes crear #F58A02una cuenta por PC #ffffff, no lo olvides!", 255, 255, 255)
		end
	else
		--print(correo, inspect(user), #user)
		onCharacterCreate(player, correo, user)
	end
end
addEvent("Roleplay:RegisterRPNextLife", true)
addEventHandler("Roleplay:RegisterRPNextLife", root, registerNextLife)

function recoverNextLife(player, correo, codigo)
	if source == player then
		if getDatas(correo,"Codigo") then
			local c = getDatas(correo,"Codigo")
			if c == codigo then
				triggerClientEvent(player,"addTextMessage3D",player,"Recuperado #F58A02Exitosamente #ffffff!", 255, 255, 255)
				triggerClientEvent(player,"addTextMessage3D",player,"La clave de tu correo es #F58A02"..getDatas(correo,"Clave").." #ffffffno la olvides!", 255, 255, 255)
			else
				player:triggerEvent("callNotification", player, "error", "Error, Este codigo no coincide con la cuenta!.", true)
			end
		else
			player:triggerEvent("callNotification", player, "error", "Error, Esta correo no esta vinculado a ninguna cuenta!.", true)
		end
	end
end
addEvent("Roleplay:RecoverRPNextLife", true)
addEventHandler("Roleplay:RecoverRPNextLife", root, recoverNextLife)


function onRegisterNext(player, correo, user, pass)
	if source == player then
		if isNewAccount(correo) == false then
			local code = generateString (5)
			mysql:insert("INSERT INTO Registros VALUES (?,?,?,?,?,?,?,?)", user, pass, getPlayerSerial(player), getPlayerIP(player), dataFecha(), "No", correo, code)
			triggerClientEvent(player,"Roleplay:EndLogin",player,player,5,getCharacters(correo),code)
		else
			player:triggerEvent("callNotification", player, "error", "Error, Esta cuenta ya existe!.", true)
		end
	end
end

function onCharacterCreate(player, correo, data)
	if source == player then
		if isNewAccount(correo) ~= false then
			local Personajes = getCharacters(correo)
			if #Personajes < LimitePersonajes then
				local MyAcc = {getDatas(correo,"Cuenta"),correo}
				local RandomAcc = "Acc"..generateString (14).."NL"
				local PassPersonaje = "01"..generateString (14)
				local Nacionalidad,Edad,Sexo,Dni,Cuenta,Serial,skin = unpack(data)
				-- print(unpack(data))
				if addAccount( RandomAcc, PassPersonaje ) then
					local Extra_Data = {}
					Extra_Data["Horas"] = 0
					Extra_Data["XP"] = 0
					Extra_Data["Banco"] = 0
					Extra_Data["PuntosA"] = 0
					Extra_Data["PuntosRol"] = 0
					local Extra_Empleos = {}
					Extra_Empleos["TaxistaLv"] = 1
					Extra_Empleos["TaxistaExp"] = 0
					Extra_Empleos["CamioneroLv"] = 1
					Extra_Empleos["CamioneroExp"] = 0
					Extra_Empleos["CarpinteroLv"] = 1
					Extra_Empleos["CarpinteroExp"] = 0
					Extra_Empleos["JardineroLv"] = 1
					Extra_Empleos["JardineroExp"] = 0
					Extra_Empleos["MeseroLv"] = 1
					Extra_Empleos["MeseroExp"] = 0
					Extra_Empleos["PizzeroLv"] = 1
					Extra_Empleos["PizzeroExp"] = 0
					Extra_Empleos["MineroLv"] = 1
					Extra_Empleos["MineroExp"] = 0
					mysql:insert("INSERT INTO save_system VALUES (?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)", toJSON ( { x = pRespawnx, y = pRespawnY, z = pRespawnZ} ), toJSON ( { rx = pRotX, ry = pRotY, rz = pRotZ} ), pVida, pChaleco, pInt, pDim, skin, "", pMoneyNew, '', getPlayerSerial(player), RandomAcc, toJSON ( { _caminar = 118, _pelea = 4} ), correo, 0, 1, 0, "Desempleado", "00:00:00", PassPersonaje,toJSON(Extra_Data),toJSON(Extra_Empleos),Cuenta)
					mysql:insert("INSERT INTO Datos_Personajes VALUES (?,?,?,?,?,?,?)", Nacionalidad,Edad,Sexo,Dni,RandomAcc,Serial,Cuenta)
					local MyAcc = {getDatas(correo,"Cuenta"),correo}
					triggerClientEvent(player,"Roleplay:EndLogin",player,player,6,getCharacters(correo),MyAcc)
				else
					player:triggerEvent("callNotification", player, "error", "Error, Este personaje ya existe! (#0FMV).", true)
				end
			else
				player:triggerEvent("callNotification", player, "error", "Error, Esta cuenta ya contiene muchos personajes!.", true)
			end
		else
			player:triggerEvent("callNotification", player, "error", "Error, Este personaje ya existe! (#0FFV).", true)
		end
	end
end

local playerid = { }

function getPlayerByID(ID)
    for i,who in ipairs(Element.getAllByType('player')) do
        local reID = who:getData('ID') or 0
        if reID then
            if reID == ID then
                return who
            end
        end
    end
    return false
end

function newPlayerID( player )
    for i = 1, getMaxPlayers( ) do
        if not ( playerid[ i ] ) then
            playerid[ i ] = player
            player:setData( "ID", i )
            break
        end
    end
end

function getPlayerByID( id )
    for i = 1, getMaxPlayers( ) do
        if ( playerid[ i ] ) then
            -- print( getPlayerName( playerid[ i ] ) )
            return playerid[ i ]
        end
    end
end

addEvent("NL:UpdateLogin:Data",true)
function setEdit(player)
	if isElement(player) then
	    local data = query("SELECT * FROM Registros where Serial = ?", player:getSerial())
	    if not ( type( data ) == "table" and #data == 0 ) or not data then
	    	local s1 = data[1]["Correo"]
	    	local s2 = data[1]["Clave"]
	    	triggerClientEvent(player,"NL:RecoverData:init",player,player,s1,s2)
	    end
	end
end
addEventHandler("NL:UpdateLogin:Data",root,setEdit)

function logoutAll ()
	for k, player in ipairs (getElementsByType("player")) do
		if ( not isGuestAccount(getPlayerAccount (player))) then 
			logOut ( player )
		end
	end
	for i,v in pairs ( getElementsByType ( 'player' ) ) do
		if v == player then
        	setElementData ( v, 'ID', i )
    	end
    end 
end
addEventHandler ( "onResourceStart", getResourceRootElement(getThisResource()), logoutAll )

addEventHandler("onPlayerJoin", getRootElement(), function()
    --newPlayerID( source )
    -- setTimer(setEdit,250,1,source,source)
end)

function newPlayerID( player )
    for ID = 1,1000 do
        if not getPlayerByID(ID) then
            player:setData('ID',ID)
            break
        end
    end
end


--[[
    local text = textCreateDisplay()
    local screentext = textCreateTextItem("¡Bienvenido a Next Life!\n\nEste es un servidor roleplay.\n...Por favor, espera mientras el servidor se carga...\nNo tardará mucho.\nUna vez terminado podrás disfrutar de\n cientos de horas de diversión.\nGracias por la espera,\n¡Esperamos que la pases genial!\n",0.5,0.2,"medium",255,255,255,255, 2.5, "center", "top", 255)

    textDisplayAddText(text,screentext)

    addEventHandler("onPlayerJoin", getRootElement(), function()
        textDisplayAddObserver(text, source)
    end);

    addEvent("removeTextP", true)
    function removeTextP()
        textDisplayRemoveObserver(text,source)
    end
    addEventHandler("removeTextP", root, removeTextP)

			local sexo = s[1]["Sexo"]
			if sexo == "Femenino" then
				source:setWalkingStyle(132)
			else
				source:setWalkingStyle(128)
			end
]]

-- Creamos una función que se ejecutará cada vez que un jugador intente cambiar su nombre
function bloquearCambioNombre(oldNick, newNick)
    -- Cancelamos el evento de cambio de nombre
    cancelEvent(true, "No se permiten cambios de nombre.")
end

-- Registramos nuestra función como un event handler para el evento "onPlayerChangeNick"
addEventHandler("onPlayerChangeNick", root, bloquearCambioNombre)
