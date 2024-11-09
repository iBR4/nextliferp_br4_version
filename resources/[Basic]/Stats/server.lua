local DatosDe = {}
local data = {}
local statsSQL = dbConnect("sqlite", ":stats/sanciones.db");
local PuntosSQL = dbConnect("sqlite", ":stats/puntosrol.db");
dbExec(PuntosSQL, "CREATE TABLE IF NOT EXISTS puntosrol(accountName,punto,staff)")
loadstring(exports.MySQL:getMyCode())()
import('*'):init('MySQL')
loadstring(exports["[LS]NewData"]:getMyCode())()
import('*'):init('[LS]NewData')
function getPlayerSanciones( player )
    if player then
        if getPlayerName(player) then
            local sancioNl = dbPoll(dbQuery(statsSQL, "SELECT * FROM datosOOC WHERE accountName = ?", getPlayerName(player)), -1)
            if sancioNl[1] ~= nil then
                for k, v in ipairs(sancioNl) do
                    return v
                end
            end
        end
    end
end
function abrirStats(p, cmd, o)
	if o then
    else
        DatosDe[p] = {}
        data[p] = {}
		--if getPlayerSanciones(p) then
    	local sancioNl = dbPoll(dbQuery(statsSQL, "SELECT * FROM datosOOC WHERE accountName = ?", getPlayerName(p)), -1)
    	local s = query("SELECT * FROM Datos_Personajes where Nick = ?", getPlayerName(p), -1)
    	if not ( type( s ) == "table" and #s == 0 ) or not s then
        	for i,v in ipairs(s) do
            	table.insert(DatosDe[p], sancioNl)
                data[p] = {
                    ["TaxistaLv"] = exports.nlogin:getCharacterData(p,"TaxistaLv"),
                    ["TaxistaExp"] = exports.nlogin:getCharacterData(p,"TaxistaExp"),
                    ["CamioneroLv"] = exports.nlogin:getCharacterData(p,"CamioneroLv"),
                    ["CamioneroExp"] = exports.nlogin:getCharacterData(p,"CamioneroExp"),
                    ["CarpinteroLv"] = exports.nlogin:getCharacterData(p,"CarpinteroLv"),
                    ["CarpinteroExp"] = exports.nlogin:getCharacterData(p,"CarpinteroExp"),
                    ["JardineroLv"] = exports.nlogin:getCharacterData(p,"JardineroLv"),
                    ["JardineroExp"] = exports.nlogin:getCharacterData(p,"JardineroExp"),
                    ["MeseroLv"] = exports.nlogin:getCharacterData(p,"MeseroLv"),
                    ["MeseroExp"] = exports.nlogin:getCharacterData(p,"MeseroExp"),
                    ["PizzeroLv"] = exports.nlogin:getCharacterData(p,"PizzeroLv"),
                    ["PizzeroExp"] = exports.nlogin:getCharacterData(p,"PizzeroExp"),
                    ["MineroLv"] = (exports["job-minero"]:getPlayerNivel(p) or 0),
                    ["MineroExp"] = (exports["job-minero"]:getPlayerExp(p) or 0),
                }
                --print(inspect(data[p]))
				triggerClientEvent(p, "winstats", p, unpack(DatosDe[p]),personajes(p),v.Nacionalidad,v.Sexo,v.Edad,data)
                data[p] = {}
				DatosDe[p] = {}	
			end
		end
	end
end
addCommandHandler("stats", abrirStats)
function personajes(source)
	local name = source:getName()
	local s = query("SELECT * FROM save_system where Nick = ?", name)
	if not ( type( s ) == "table" and #s == 0 ) or not s then
		return s
	end
end
addCommandHandler("darpuntorol", function(player, cmd, who, punto)
    local rol = getElementData(player, "Roleplay:rol")
    if not rol then
        setElementData(player, "Roleplay:rol", nil)
    end
    local accName = getAccountName(getPlayerAccount(player))
    if isObjectInACLGroup("user." .. accName, aclGetGroup("Admin")) or
       isObjectInACLGroup("user." .. accName, aclGetGroup("GameOperator")) or
       isObjectInACLGroup("user." .. accName, aclGetGroup("SuperModerador")) or
       isObjectInACLGroup("user." .. accName, aclGetGroup("Moderador")) or
       isObjectInACLGroup("user." .. accName, aclGetGroup("Moderador a pruebas")) or
       isObjectInACLGroup("user." .. accName, aclGetGroup("Desarrollador")) then
       
        local tPlayer = getPlayerFromName(who)
        local a = getPlayerName(player)
        local rol = getElementData(player, "Roleplay:rol") or 0
        local v = tonumber(punto) or 1
        -- Verificar si el jugador objetivo es el mismo que el jugador que ejecutó el comando
        if tPlayer and tPlayer ~= player then
            local pRol = tonumber(exports.nlogin:getCharacterData(tPlayer,"PuntosRol")) + v
            outputDebugString("El Jugador " .. a .. " le dio " .. v .. " puntos de rol a " .. who, player, 0, 255, 255, 255)
            outputChatBox("Le has dado #3EE816" .. v .. " #FFFFFFpuntos de rol a #3EE816" .. who, player, 255, 255, 255, true)
            outputChatBox("#3EE816" .. a .. " #FFFFFFte ha dado #3EE816" .. v .. " #FFFFFFpunto de rol", tPlayer, 255, 255, 255, true)
            
            exports.nlogin:setCharacterData(tPlayer,"PuntosRol",pRol)
            dbExec(PuntosSQL, "INSERT INTO puntosrol(accountName, punto, staff) VALUES(?,?,?)", who, v, getAccountName(getPlayerAccount(player)))
        else
            outputChatBox("#FF0000No puedes darte un punto de rol a ti mismo", player, 255, 255, 255, true)
        end
    end
end)
addCommandHandler("puntosrol", function (player, cmd, who)
    if who and who ~= "" then
        local targetPlayer = getPlayerFromName(who)  -- Obtener el jugador en lugar de la cuenta
        if targetPlayer then
            --local rol = getElementData(targetPlayer, "Roleplay:rol") or 0
            local pRol = tonumber(exports.nlogin:getCharacterData(targetPlayer,"PuntosRol")) or 0
            outputChatBox("El Jugador #3EE816 " .. who .. " #FFFFFF Tiene: #3EE816" .. pRol .. " #FFFFFF puntos de rol", player, 255, 255, 255, true)
        else
            outputChatBox("El jugador " .. who .. " no está en línea o no existe.", player, 255, 0, 0, true)
        end
    else
        outputChatBox("Uso correcto: /puntosrol Nombre_Apellido.", player, 255, 165, 0, true)
    end
end)
