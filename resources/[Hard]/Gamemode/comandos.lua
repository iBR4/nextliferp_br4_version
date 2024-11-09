
permisos = {
["Desarrollador"]=true,
["Administrador.General"]=true,
["Admin"]=true,
["Sup.Staff"]=true,
["SuperModerador"]=true,
["Moderador"]=true,
["Moderador A Pruebas"]=true,
}
loadstring(exports.MySQL:getMyCode())()
import('*'):init('MySQL')
local antiSpamPagarDinero  = {} 
addCommandHandler("setdni",function(source,cmd,nacionalidad,edad,sexo,nombre,serial)
	if getElementData(source,"Admin:Disponible") then
		if not nacionalidad and not edad and not sexo and not nombre and not serial then outputChatBox( "Syntax: /setdni <nacionalidad> <edad> <sexo> <nombre> <serial>", source, 255, 255, 0, true) return end
		local accounts = query("SELECT * FROM Datos_Personajes where Cuenta = ?", nombre)
		if not ( type( accounts ) == "table" and #accounts == 0 ) or not accounts then
			local nombre = accounts[1]["Cuenta"]
			local edad = accounts[1]["Edad"]
			local sexo = accounts[1]["Sexo"]
			local dni2 = accounts[1]["DNI"]
			local nacio = accounts[1]["Nacionalidad"]
			mysql:update("UPDATE datos_personajes SET Nacionalidad = ?  WHERE Cuenta = ?", nacionalidad, nombre)
			mysql:update("UPDATE datos_personajes SET Edad = ?  WHERE Cuenta = ?", edad, nombre)
			mysql:update("UPDATE datos_personajes SET Sexo = ?  WHERE Cuenta = ?", sexo, nombre)
			mysql:update("UPDATE datos_personajes SET DNI = ?  WHERE Cuenta = ?", 0, nombre)
			mysql:update("UPDATE datos_personajes SET Serial = ?  WHERE Cuenta = ?", serial, nombre)
			outputChatBox( "Datos Actualizados", source, 0, 255, 0, true)
		else
			insert("insert into `datos_personajes` VALUES (?,?,?,?,?,?,?)", nacionalidad, edad, sexo, 0, nombre, "Si", serial)
			outputChatBox( "Datos Insertados & Actualizados", source, 0, 255, 0, true)
		end
	else
		outputChatBox( "#44A5CA[STAFF - /sduty] #F06C6CNecesitas estar como staff en servicio para usar este comando", source, 255, 0, 0, true)
	end
end)
function pagar_jugador (source, cmd, jugador, monto )
	if not notIsGuest(source) then
		local tick = getTickCount()
		if (antiSpamPagarDinero[source] and antiSpamPagarDinero[source][1] and tick - antiSpamPagarDinero[source][1] < 5000) then
			source:outputChat("No puedes usar este comando después de 5 segundos", 150, 0, 0)
			return
		end
		local player = getFromName( source, jugador )
		if (player) then
			local x, y, z = getElementPosition(source)
			if getDistanceBetweenPoints3D(x,y,z,unpack({getElementPosition(player)})) < 5 and getElementDimension(player) == getElementDimension(source) and getElementInterior(player) == getElementInterior(source) then
				if player ~= source then
					monto = math.floor(monto)
					if tonumber(monto) >= 1 and tonumber(monto) <= source:getMoney() then
						local money = source:getMoney()
						if tonumber(money) >= tonumber(monto) then
							--
							source:outputChat("Le entregaste #329632$"..convertNumber(monto).." dolares #FFFFFFa #FF9000".._getPlayerNameR(player), 255, 255, 255, true)
							player:outputChat("Recibiste #329632$"..convertNumber(monto).." dolares #FFFFFF de parte de #FF9000".._getPlayerNameR(source), 255, 255, 255, true)
							--
							player:giveMoney((monto))
							source:takeMoney((monto))
						else
							source:outputChat("No tienes suficiente dinero", 150, 50, 50, true)
						end
					else
						source:outputChat("No tienes suficiente dinero", 150, 50, 50, true)
					end
				end
			else
				source:outputChat("[ERROR] No estas suficientemente serca de la otra persona", 255, 50, 50, true)
			end
			if (not antiSpamPagarDinero[source]) then
				antiSpamPagarDinero[source] = {}
			end
			antiSpamPagarDinero[source][1] = getTickCount()
		end
	end
end
addCommandHandler({"dardinero", "pagar"}, pagar_jugador)
local caminatas = {
["Hombre"] = {"Hombre", 118},
["Mujer"] = {"Mujer", 129},
["Mujer2"] = {"Mujer2", 131},
["Mujer3"] = {"Mujer3", 132},
["Borracho"] = {"Borracho", 126},
["Prostituta"] = {"Prostituta", 133},
["Gang"] = {"Gang", 121},
["Gang2"] = {"Gang2", 122},
["Gordo"] = {"Gordo", 55},
["Viejo"] = {"Viejo", 120},
}
addCommandHandler({"caminar", "walk", "caminata"}, function(p, cmd, ...)
	if not notIsGuest(p) then
		local walk = table.concat({...}, " ")
		if walk ~="" and walk ~=" " then
			local s = trunklateText( p, walk )
			if s:find("Hombre") or s:find("hombre") or s:find("Mujer") or s:find("mujer") or s:find("Borracho") or s:find("borracho") or s:find("Prostituta") or s:find("prostituta") or s:find("Gang") or s:find("gang") or s:find("Gang2") or s:find("gang2") or s:find("Gordo") or s:find("Mujer2") or s:find("Mujer3") or s:find("Viejo") then
				p:outputChat("Estilo de caminar: #FF0033"..tostring(caminatas[s][1]), 30, 150, 30, true)
				p:setWalkingStyle(caminatas[s][2])
				local save = mysql:query("SELECT * From save_system WHERE Cuenta = '"..mysql:AccountName(p).."'")
				if ( type ( save ) == "table" and #save == 0 ) or not save then else
					local dt = fromJSON(save[1]["Pelea"])
					mysql:update("UPDATE save_system SET Pelea = ?  WHERE Cuenta = ?", toJSON ( { _caminar = tonumber(caminatas[s][2]), _pelea = tonumber(dt["_pelea"])} ), mysql:AccountName(p))
				end
			else
				p:outputChat("Solamente puedes poner estos estilos: ", 255, 100, 100, true)
				for i, v in pairs(caminatas) do
					p:outputChat("#FF9000"..caminatas[i][1], 60, 30, 100, true)
				end
			end
		else 
			p:outputChat("Syntax: /caminar [texto]", 255, 50, 50, true)
		end
	end
end)
addEventHandler("onPlayerLogin",getRootElement(),function()
	source:setWalkingStyle(118)
end)
local antiSpamChat  = {} 
function limpiar_chat( source )
	local tick = getTickCount()
	if (antiSpamChat[source] and antiSpamChat[source][1] and tick - antiSpamChat[source][1] < 2000) then
		return
	end
	clearChatBox(source)
	if (not antiSpamChat[source]) then
		antiSpamChat[source] = {}
	end
	antiSpamChat[source][1] = getTickCount()
end
addCommandHandler({"cc", "limpiarchat", "chatlimpio"}, limpiar_chat)
local pmApagado = { }
local pmStaff = { }
-- /pm to message other players
local function pm( player, target, message )
	outputChatBox( "#00FF00[ID:" ..(target:getData("ID") or 0).. "] " .. getPlayerName( target ) .. " #00FF00-> #ffffff" .. message, player, 255, 255, 0, true)
	outputChatBox( "#ff4c4c[ID:" ..(player:getData("ID") or 0).. "] " .. getPlayerName( player ) .. " #ff4c4c-> #ffffff" .. message, target, 0, 180, 180, true)
	--exports["Logs-OC"]:sendDiscordLogMessage(" `envio un MP a " .. getPlayerName( target ) .. " ->` "..message, player)
	for k, v in ipairs(getElementsByType("player")) do
		if pmStaff[v] then
			if player ~= v and target ~= v then
				outputChatBox( "#589EF2[MP] " .. getPlayerName( player ) .. " -> " .. getPlayerName( target ) .. ":#ffffff " .. message, v, 0, 180, 180, true)
			end
		end
	end
	triggerClientEvent( target, "mensajeImportante", target )
end
function getPMState( p )
	return pmApagado[p] and true or nil
end
addCommandHandler( {"togmp","toguearmp"},
	function( p )
		if not notIsGuest(thePlayer) then
			if pmApagado[p] then
				outputChatBox( "Has activado tus mensajes privados (/mp).", p, 0, 255, 0 )
				pmApagado[p] = nil
			else
				outputChatBox( "Has desactivado tus mensajes privados (/mp).", p, 255, 0, 0 )
				pmApagado[p] = true
			end
		end
	end
)
addCommandHandler( {"vermps","vermp"},
	function( source )
	if permisos[getACLFromPlayer(source)] == true then
				if pmStaff[source] then
					outputChatBox( "#F06C6CAhora no podrás ver todos los mensajes privados.", source, 0, 255, 0, true)
					pmStaff[source] = nil
				else
					outputChatBox( "#9CFF97Ahora podrás ver todos los mensajes privados.", source, 255, 150, 0, true )
					pmStaff[source] = true
				end
		end
	end
)
addCommandHandler( { "pm", "mp" },
	function( thePlayer, commandName, otherPlayer, ... )
		if not notIsGuest(thePlayer) then
			if otherPlayer and ( ... ) then
				local message = table.concat( { ... }, " " )
				local player, name = getFromName( thePlayer, otherPlayer )
				if player then
					if pmApagado[player] then
						outputChatBox( "#F06C6CEl jugador "..name.." tiene los PM's desactivados.", thePlayer, 255, 0, 0, true)
					else
						pm( thePlayer, player, message )
					end
				end
			else
				outputChatBox( "Comando: /" .. commandName .. " [jugador] [texto ooc]", thePlayer, 255, 255, 255 )
			end
		end
	end
)
function aiudaa(source,cmd,ayuda)
	if not notIsGuest( source ) then
		if ayuda == "general" then
			source:outputChat(" ",200,50,50)
			source:outputChat("/dardni /darlicencia /bug /desbug /cachear",255,255,255,true)
			source:outputChat("/servicios /yo /guardaryo",150,150,150,true)
			source:outputChat("/fp  /lag /tengolag /stats",255,255,255,true)
			source:outputChat("/multas /caminar /aceptarmuerte /avisarmuerto /comoempezar",150,150,150,true)
			source:outputChat("/limpiarchat /cc /afk /asesino /parlante /r /mp /pm",255,255,255,true)
			source:outputChat("/duda /re /ayuda /staff",150,150,150,true)
		elseif ayuda == "faccion" then
			if getElementData(source,"Roleplay:faccion") == "Policia" then
			source:outputChat("#ffffffComandos disponibles para tu faccion actual #007FCDLos Santos Police Departament",255,255,255,true)
			source:outputChat("#90C2FF/fduty - /taser - /rec - /arrestar - /esposar - /quitaresposas - /quitarcables",255,255,255,true)
			source:outputChat("#3A7EFF/m - /meg - /megafono - /cono - /qcono - /barra - /qbarra - /limpref",255,255,255,true)
			source:outputChat("#90C2FF/rf - /f - /d - /departamental - /multar - /mostrarplaca - /miembros",255,255,255,true)
			source:outputChat("#3A7EFF/balizas - /sirena - /dejarfaccion - /data - /pinchos - /quitarpinchos",255,255,255,true)
			source:outputChat("#ffffffComandos disponibles para #007FCDsuperiores",255,255,255,true)
			source:outputChat("#90C2FF/contratar - /despedir - /data - /asignardivision - /quitardivision",255,255,255,true)
			source:outputChat("#3A7EFF/meterdivision - /sacardivision - /subirrango - /bajarrango",255,255,255,true)
		else
			if getElementData(source,"Roleplay:faccion") == "Mecanico" then
			source:outputChat("#ffffffComandos disponibles para tu faccion actual #007E52Mecanico",255,255,255,true)
			source:outputChat("#90C2FF/rf - /f - /mostrarplaca - /miembros - /limpref",200,50,50,true)
			source:outputChat("#3A7EFF/dejarfaccion - /data - /repararmotor - /panelmecanico - /anunciomecanico",200,50,50,true)
			source:outputChat("#90C2FF/mecanico - /fasear - /panelsuspe - /repararveh - /luz",200,50,50,true)
			source:outputChat("#ffffffComandos disponibles para #007E52superiores",255,255,255,true)
			source:outputChat("#90C2FF/contratar - /despedir - /data - /subirrango - /bajarrango",255,255,255,true)
		else
			if getElementData(source,"Roleplay:faccion") == "Medico" then
			source:outputChat("#ffffffComandos disponibles para tu faccion actual #F43C33Medicos",255,255,255,true)
			source:outputChat("#90C2FF/fduty - /rec - /m - /meg - /megafono - /miembros - /data",255,255,255,true)
			source:outputChat("#3A7EFF/cono - /qcono - /barra - /qbarra - /limpref - /mostrarplaca",255,255,255,true)
			source:outputChat("#90C2FF/balizas - /sirena - /dejarfaccion - /llamadomuerte",255,255,255,true)
			source:outputChat("#ffffffComandos disponibles para #F43C33superiores",255,255,255,true)
			source:outputChat("#3A7EFF/contratar - /despedir - /data - /subirrango - /bajarrango",255,255,255,true)
		else
			if getElementData(source,"Roleplay:faccion") == "Aseguradora" then
			source:outputChat("#ffffffComandos disponibles para tu faccion actual #007E52Aseguradora",255,255,255,true)
			source:outputChat("#90C2FF/rf - /f - /seguros - /verseguro - /rastrear - /asegurar",200,50,50,true)
			source:outputChat("#3A7EFF/dejarfaccion - /miembros - /mostrarplaca - /data",255,255,255,true)
			source:outputChat("#ffffffComandos disponibles para #007E52superiores",255,255,255,true)
			source:outputChat("#90C2FF/contratar - /despedir - /data - /subirrango - /bajarrango",255,255,255,true)
		else
			source:outputChat("#90C2FFActualmente no perteneces a ninguna faccion.",255,255,255,true)
					end
				end
			end
		end
		elseif ayuda == "casa" then
			source:outputChat(" ",200,50,50)
			source:outputChat("/comprarcasa /vendercasa /infocasa",255,255,255,true)
			source:outputChat("/rentar /unrentar /entrar /salir",150,150,150,true)
		elseif ayuda == "animaciones" then
			source:outputChat(" ",200,50,50)
			source:outputChat("/rendirse [1,2] /sentarse [1,12] /dormir /apoyarse [1,5] /parado [1,3]",255,255,255,true)
			source:outputChat("/tirarse [1,5] /jodete /pelea /herido [1,3] /bailar [1,11] /apuntar [1,2]",150,150,150,true)
			source:outputChat("/gang [1,13] /rascarbolas /paja /reir /llorar /rap",255,255,255,true)
			source:outputChat("/nalguear /rap [1,3] /strip [1,3] /lavar /reparar /cambiarrueda",150,150,150,true)
			source:outputChat("/asustado /contrapared /cruzarbrazos /reloj /mear /bate [1,2]",255,255,255,true)
			source:outputChat("/patada /quepaso /alentar [1,2] /mirar [1,2] /cansado [1,2] /saludos",150,150,150,true)
			source:outputChat("/plantando /pose /buscando /buscandop [1,2] /tocar /squat",255,255,255,true)
			source:outputChat("/dj [1,6] /kungfu /agonizar",150,150,150,true)
			source:outputChat(" ",150,150,150,true)
			source:outputChat("#FFEC02Animaciones solo disponibles con el rango VIP o VIP+",150,150,150,true)
			source:outputChat("/fortnite [1,13] /bailarvip [1,6] /breakdance [1,4]",255,255,255,true)
		elseif ayuda == "vehiculos" then
			source:outputChat(" ",200,50,50)
			source:outputChat("#2EFF00/vendervehiculo #FFFFFFes para venderlo a un jugador",255,255,255,true)
			source:outputChat("#2EFF00/vendervehestado #FFFFFFes para venderlo al estado, recibiras un 40% menos de su valor",255,255,255,true)
			source:outputChat(" ",200,50,50)
			source:outputChat("/motor /luces /bloqueo /localizarveh",255,255,255,true)
			source:outputChat("/venderveh /vendervehiculo /cinturon /maletero",150,150,150,true)
			source:outputChat("/sirenas /vermaletero /metermaletero /sacarmaletero",255,255,255,true)
			source:outputChat("/capo /estereo /ventanilla /dondevendervehestado",150,150,150,true)
			source:outputChat("/estadoveh /candado /repararveh /rpagar",255,255,255,true)
			source:outputChat("/abrirveh /cerrarveh /vendervehestado /realvendervehestado",150,150,150,true)
		elseif ayuda == "chat" then
			source:outputChat(" ",200,50,50)
			source:outputChat("/g /s /me /do /b /ooc /hz /llamar /sms /r /mp /togmp /f /rf /ame",255,255,255,true)
			source:outputChat("/frecuencia /comoempezar /veryo /yo /guardaryo",150,150,150,true)
		elseif ayuda == "familias" then
			source:outputChat(" ",200,50,50)
			source:outputChat("/familias /enmascarado /comprar /invitar",255,255,255,true)
			source:outputChat("/vermiembros /expulsar /ascender /degradar /abandonarfamilia",150,150,150,true)
			source:outputChat("/colocarjefe /colocarcolor /fam /unirme",255,255,255,true)
		elseif ayuda == "armas" then
			source:outputChat(" ",200,50,50)
			source:outputChat("/usarmateriales | Para crear un arma",255,255,255,true)
			source:outputChat("/dejararma | Para dejar el arma",150,150,150,true)
			source:outputChat("/dararma | Para dar un arma",255,255,255,true)
		elseif ayuda == "telefono" then
			source:outputChat(" ",200,50,50)
			source:outputChat("/minumero /llamar /colgar /servicios /sms /prendertelefono /apagartelefono",255,255,255,true)
		elseif ayuda == "ver" then
			source:outputChat(" ",200,50,50)
			source:outputChat("Con estos comandos podras desactivar cosas visuales",255,255,255,true)
			source:outputChat(" ",255,255,255,true)
			source:outputChat("/veryo /vermiyo /borrarcp /borrarblips /cblips /limpiarref",255,255,255,true)
			source:outputChat("/showhud /showchat /vertodo",150,150,150,true)
		elseif ayuda == "ladron" then
			source:outputChat(" ",200,50,50)
			source:outputChat("Con este trabajo podras robar las tiendas de tu ciudad",255,255,255,true)
			source:outputChat("Robando las tiendas obtendras tu dinero para beneficiarte",255,255,255,true)
			source:outputChat("Este trabajo se encuentra oculto, tendras que averiguarlo IC su ubicacion",150,150,150,true)
			source:outputChat(" ",200,50,50)
			source:outputChat("#F43C33Cuidado, Tambien la policia sabra cuando robaras una tienda y podra meterte a la carcel",255,255,255,true)
		elseif ayuda == "vips" then
			source:outputChat(" ",200,50,50)
			source:outputChat("#FFEC02¿Para que sirve el VIP o VIP+?",255,255,255,true)
			source:outputChat("Con estos rangos podras tener #2EFF00beneficios IC",255,255,255,true)
			source:outputChat("Podras tener mas #2EFF00slots #FFFFFFpara vehiculos, mas reputacion por cada #2EFF00Payday",255,255,255,true)
			source:outputChat("Tendras animaciones #2EFF00VIPS #FFFFFFque nadie mas tendra acceso",255,255,255,true)
			source:outputChat("Tendras acceso al comando #2EFF00/afk#FFFFFF, con este podras estar afk sin que te kickeen",255,255,255,true)
			source:outputChat("Tendras beneficios en el #2EFF00Discord",255,255,255,true)
			source:outputChat("al abrir #2EFF00/b u #2EFF00/ooc #FFFFFFaparecera tu rango alli",255,255,255,true)
			source:outputChat("Aparte ayudaras al servidor a crecer y tener mucho mas tiempo activo",255,255,255,true)
			source:outputChat(" ",255,255,255,true)
			source:outputChat("#FFEC02¿Como compro este rango?",255,255,255,true)
			source:outputChat("Puedes comprarlo en la tienda :",255,255,255,true)
			source:outputChat("Una vez lo compres se te activara en el servidor manualmente.",255,255,255,true)
		else
			source:outputChat(" ",200,50,50)
			source:outputChat("#F43C33/ayuda #FFFFFF<seccion>",228, 207, 31,true)
			source:outputChat("#ffffffgeneral | animaciones | staff | dueño | chat | vehiculos | faccion | casa",200,50,50,true)
			source:outputChat("#00FF00armas | ladron",200,50,50,true)
			source:outputChat("#198700 telefono | ver ",200,50,50,true)
			source:outputChat("#198700accesibilidad | vips",200,50,50,true)
		end
	end
end
addCommandHandler("ayuda",aiudaa)