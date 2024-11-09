local RangosID = {}
local LugaresDeRobo = {}
local ExterioresDeRobo = {}
local LlamadosCentral = {}
local sqlRobos = dbConnect("sqlite", "Robos.db");
dbExec(sqlRobos, "CREATE TABLE IF NOT EXISTS Lugares(ID,x,y,z,int,dim,Creador)")
dbExec(sqlRobos, "CREATE TABLE IF NOT EXISTS Exteriores(ID,x,y,z,int,dim,Creador)")
dbExec(sqlRobos, "CREATE TABLE IF NOT EXISTS RobosID(ultimaID)")
--RectangleBloods = createColRectangle ( 2226.3254394531, -1767.6697998047, 200, 252 )
--RectangleCripz = createColRectangle ( 1656.79, -2161.13, 300, 200 )
addEventHandler( "onColShapeHit", getRootElement(), function(player)
    if getElementType(player) == "player" then
        if source == RectangleBloods then
            triggerClientEvent( player, "BarrioBloodOn", player)
            setTimer( function()
                triggerClientEvent( player, "BarrioBloodOff", player)
            end, 5500, 1)
        elseif source == RectangleCripz then
            triggerClientEvent( player, "BarrioCripzOn", player)
            setTimer( function()
                triggerClientEvent( player, "BarrioCripzOff", player)
            end, 5500, 1)
        end
    end
end)
addEventHandler( "onColShapeLeave", getRootElement(), function(player)
    if getElementType(player) == "player" then
        if source == RectangleBloods then
            triggerClientEvent( player, "BarrioBloodOff", player)
        elseif source == RectangleCripz then
            triggerClientEvent( player, "BarrioCripzOff", player)
        end
    end
end)
local MarkerLadron = createMarker( 2324.955078125, -1175.1456298828, 1027.9765625, "cylinder", 2.0, 0, 0, 0, 0 )
setElementDimension(MarkerLadron,0)
setElementInterior(MarkerLadron,5)
addCommandHandler("trabajar", function(player, cmd)
		local nivel = getElementData(player,"Nivel") or 0
        if not isPedInVehicle(player) then
            if (getElementData(player, "Roleplay:trabajo") == "") or (getElementData(player, "Roleplay:trabajoVIP") == "") then
                    if isElementWithinMarker(player, MarkerLadron) then
                            if (getElementData(player, "Roleplay:trabajoVIP") == "Ladron") or (getElementData(player, "Roleplay:trabajo") == "Ladron") then
                                outputChatBox("¡Ya estas trabajando aquí!", player, 150, 50, 50, true)
                            else
                            	if (nivel >= 3) then
                                setElementData(player, "Roleplay:trabajo", "Ladron")
                                outputChatBox("¡Bienvenido al trabajo de #ffff00Ladron#ffffff!", player, 255, 255, 255, true)
                   	else
                        outputChatBox("#4169E1[Ladron]#ffffff ¡Necesitas #FF646Enivel 3 #ffffffpara poder trabajar como Ladron!", player, 50, 150, 50, true)
                    end
                end
            end
        end
    end
end)
addCommandHandler("trabajar2", function(player, cmd)
		local nivel = getElementData(player,"Nivel") or 0
        if not isPedInVehicle(player) then
        	local account = getPlayerAccount(player)
			if ( isObjectInACLGroup("user."..getAccountName(account), aclGetGroup("VIP")) ) or ( isObjectInACLGroup("user."..getAccountName(account), aclGetGroup("VIP+")) ) then
            if (getElementData(player, "Roleplay:trabajo") == "") or (getElementData(player, "Roleplay:trabajoVIP") == "") then
                    if isElementWithinMarker(player, MarkerLadron) then
                            if (getElementData(player, "Roleplay:trabajoVIP") == "Ladron") or (getElementData(player, "Roleplay:trabajo") == "Ladron") then
                                outputChatBox("¡Ya estas trabajando aquí!", player, 150, 50, 50, true)
                            else
                            	if (nivel >= 7) then
                                setElementData(player, "Roleplay:trabajoVIP", "Ladron")
                                outputChatBox("¡Bienvenido al trabajo de #ffff00Ladron#ffffff!", player, 255, 255, 255, true)
                   	else
                        outputChatBox("#4169E1[Ladron]#ffffff ¡Necesitas #FF646Enivel 7 #ffffffpara poder trabajar como Ladron!", player, 50, 150, 50, true)
                    	end
                    end
                    
                end
				else
				player:outputChat("#ffffffYa no tienes mas slots para #FF8700trabajos#ffffff, si quieres adquirir mas usa #3EFF00/ayuda vip", 255, 255, 255, true)
            end
        end
    end
end)
addCommandHandler("renunciar", function(player, cmd)
        if not isPedInVehicle() then
            if (getElementData(player, "Roleplay:trabajo") == "Ladron") then
                    if isElementWithinMarker(player, MarkerLadron) then
                            if (getElementData(player, "Roleplay:trabajo") == "Ladron") then
                                outputChatBox("¡Acabas de renunciar!", player, 50, 150, 50, true)
                                setElementData(player, "Roleplay:trabajo", "")
                                --setElementData(player, "Roleplay:trabajoVIP", "")
                            else
                                outputChatBox("¡No has trabajado en este lugar, no puedes renunciar aquí!", player, 150, 50, 50, true)
                                outputChatBox("Tu trabajo actual es de: #ffff00"..getElementData(player, "Roleplay:trabajo"), player, 255, 255, 255, true)
                            
                        end
                    end
            end
        end
end)
addCommandHandler("renunciar", function(player, cmd)
        if not isPedInVehicle() then
            if (getElementData(player, "Roleplay:trabajoVIP") == "Ladron") then
                    if isElementWithinMarker(player, MarkerLadron) then
                            if (getElementData(player, "Roleplay:trabajoVIP") == "Ladron") then
                                outputChatBox("¡Acabas de renunciar!", player, 50, 150, 50, true)
                                --setElementData(player, "Roleplay:trabajo", "")
                                setElementData(player, "Roleplay:trabajoVIP", "")
                            else
                                outputChatBox("¡No has trabajado en este lugar, no puedes renunciar aquí!", player, 150, 50, 50, true)
                                outputChatBox("Tu trabajo actual es de: #ffff00"..getElementData(player, "Roleplay:trabajo"), player, 255, 255, 255, true)
                            
                        end
                    end
            end
        end
end)
addCommandHandler("infoladron", function(player, cmd)
		if not isPedInVehicle() then
			if isElementWithinMarker(player, MarkerLadron) then
				outputChatBox("#ffffff¡Este es el trabajo de #ffff00Ladron#ffffff!", player, 150, 50, 50, true)
				outputChatBox("#ffffffCon este trabajo podras robar negocios ya sea 24/7, gasolineras, etc", player, 150, 50, 50, true)
				outputChatBox("#ffffffPara poder trabajar aqui necesitaras ser #FF646Enivel 7", player, 150, 50, 50, true)
		end
	end
end)
function acudirLlamado(player, cmd, num)
	if getElementData(player,"Policia") == true then
	if num then
		local llamado = tonumber(num)
		if tonumber(num) then
			for k, v in pairs(ExterioresDeRobo) do
			  if LlamadosCentral[k] then
				if unpack(LlamadosCentral[k]) == "Nadie" then
					if getElementData(k, "Robo:ID") == llamado then
						local x, y, z = getElementPosition(k)
						blip = createBlip( x, y, z, 0, 3, 200, 50, 50, 255, 0, 99999.0, player)
						outputChatBox("#44A5CA[CENTRAL] #FFFFFFTomaste el llamado de #FFFF00#"..llamado.."#ffffff, te estaremos colocando la ubicación en el GPS.", player, 0,0,0, true)
						outputChatBox("#4169E1[Central#4169E1] #FFFFFF¡Tomaste el llamado numero ##FFFF00"..llamado.."#ffffff ! te estaremos colocando la ubicación en el GPS. ", player, 50, 150, 50, true)
						setTimer(function(blip)
							if blip then
								destroyElement( blip )
							end
						end, 60000, 1, blip)
					end
				end
			  end
			end
		end
	else
		outputChatBox("#44A5CASyntax: #FFFFFF/central # \n#44A5CAEjemplo: #FFFFFF/central 1", player, 0,0,0, true)	
	end
	end
end
addCommandHandler("robotienda", acudirLlamado)
function buscarCamaras(player, cmd)
	if getElementData(player,"Roleplay:faccion") == "Policia" then
			for k, v in pairs(LugaresDeRobo) do
				if isElementWithinMarker( player, k ) then
					if getElementDimension( k ) == getElementDimension(player) then
						if not getElementData(k, "familias:TiendaRobada") then
							outputChatBox("#F06C6CEn las cámaras no pudiste encontrar ningún robo.", player, 0,0,0, true)
						elseif getElementData(k, "familias:TiendaRobada") == true then
							outputChatBox("#9CFF97Encontraste un robo en las cámaras pero el sujeto llevaba máscara.", player, 0,0,0, true)
						else
							outputChatBox("#9CFF97Después de tanto investigar detectaste que el ladrón fue: #FFFFFF"..getPlayerName(getElementData(k, "familias:TiendaRobada")), player, 0,0,0, true)
					end
				end
			end
		end
	end
end
addCommandHandler("buscarcamaras", buscarCamaras)
function nuevaID()
    local setIDArma = dbPoll(dbQuery(sqlRobos, "SELECT * FROM RobosID ORDER BY ultimaID DESC"), -1)
    if setIDArma[1] ~= nil then
    	for key, value in ipairs(setIDArma) do
    		local nuevaID = value.ultimaID + 1
    		dbExec(sqlRobos,"DELETE FROM RobosID WHERE ultimaID=?", value.ultimaID)
    		dbExec(sqlRobos,"INSERT INTO RobosID(ultimaID) VALUES(?)", nuevaID)
			return nuevaID
    	end
	end
end
function setRoboNuevaID(weapon)
	if isElement(weapon) then
    	if not getElementData(weapon, "Robo:ID") then
    		local nuevaID = nuevaID() or 1
    		setElementData(weapon, "Robo:ID", nuevaID)
    		if nuevaID == 1 then
    			dbExec(sqlRobos,"INSERT INTO RobosID(ultimaID) VALUES(?)", nuevaID)
    		end
    		return nuevaID
    	end
	end
end
function getRoboID(weapon)
	if isElement(weapon) then
    	local getIDArma = dbPoll(dbQuery(sqlRobos, "SELECT * FROM Lugares"), -1)
    	if getIDArma[1] ~= nil then
    		for key, value in ipairs(getIDArma) do
    			if getElementData(weapon, "Robo:ID") then
    				if value.ID == getElementData(weapon, "Robo:ID") then
    					return value.ID or getElementData(weapon, "Robo:ID")
    				end
    			end
    		end
    	end
	end
end
addEventHandler("onResourceStart", getRootElement(), function( res )
	if res == getThisResource() then
		local buscarLugares = dbPoll(dbQuery(sqlRobos, "SELECT * FROM Lugares"), -1)
		for key, value in ipairs(buscarLugares) do
			if value then
				local markerUsado = createMarker(value.x, value.y, value.z, "cylinder", 10.0, 255, 100, 100, 0)
				setElementInterior(markerUsado, value.int)
				setElementDimension(markerUsado, value.dim)
				LugaresDeRobo[markerUsado] = {value.x, value.y, value.z, value.int, value.dim}
				setElementData(markerUsado, "Robo:ID", value.ID)
				setElementData(markerUsado, "familias:TiendaRobada", false)
			end
		end
		local buscarExteriores = dbPoll(dbQuery(sqlRobos, "SELECT * FROM Exteriores"), -1)
		for key, value in ipairs(buscarExteriores) do
			if value then
				local markerUsado = createMarker(value.x, value.y, value.z, "cylinder", 3.0, 255, 100, 100, 0)
				setElementInterior(markerUsado, value.int)
				setElementDimension(markerUsado, value.dim)
				ExterioresDeRobo[markerUsado] = {value.x, value.y, value.z, value.int, value.dim}
				setElementData(markerUsado, "Robo:ID", value.ID)
			end
		end
	end
end)
function crearLugarRobo(player, cmd)
	if not notIsGuest then
		local cuenta = getAccountName(getPlayerAccount(player))
	    if isObjectInACLGroup ("user."..cuenta, aclGetGroup ( "Desarrollador" ) ) then
			local x, y, z = getElementPosition(player)
			local int = getElementInterior(player)
			local dim = getElementDimension(player)
			if x and y and z then
				local z = z-1
				local markerNuevo = createMarker(x, y, z, "cylinder", 3.0, 255, 100, 100, 75)
				setElementInterior(markerNuevo, int)
				setElementDimension(markerNuevo, dim)
				if markerNuevo then
					LugaresDeRobo[markerNuevo] = {x, y, z, int, dim}
					setElementData(markerNuevo, "familias:TiendaRobada", false)
					local MarkerID = setRoboNuevaID(markerNuevo)
					--exports["Logs-OC"]:sendDiscordLogMessage("creo un lugar de robo (Interior) `ID: "..MarkerID.."`", player)
					dbExec(sqlRobos,"INSERT INTO Lugares(ID,x,y,z,int,dim,Creador) VALUES(?,?,?,?,?,?,?)", MarkerID, x, y, z, int, dim, getAccountName(getPlayerAccount(player)))
					outputChatBox("\n#44A5CA[ROBOS] #9CFF97Creaste un lugar de robo con éxito.\n#FFFF00[IMPORTANTE]#00FFFF Ahora deberás usar #F06C6C/crearexteriorrobo ID #00FF00afuera de la tienda.\nLa ID de esta tienda es: #FFFFFF"..MarkerID.."\n", player, 0,0,0, true)
				end
			end
		end
	end
end
addCommandHandler("crearrobo", crearLugarRobo)
function crearExteriorRobo(player, cmd, id)
	if not notIsGuest then
		if tonumber(id) then
		local id = tonumber(id)
		local cuenta = getAccountName(getPlayerAccount(player))
	    if isObjectInACLGroup ("user."..cuenta, aclGetGroup ( "Desarrollador" ) ) then
			local x, y, z = getElementPosition(player)
			local int = getElementInterior(player)
			local dim = getElementDimension(player)
			if x and y and z then
				local z = z-1
				local markerNuevoExterior = createMarker(x, y, z, "cylinder", 3.0, 0, 0, 0, 50)
				setElementInterior(markerNuevoExterior, int)
				setElementDimension(markerNuevoExterior, dim)
				if markerNuevoExterior then
					ExterioresDeRobo[markerNuevoExterior] = {x, y, z, int, dim}
					dbExec(sqlRobos,"INSERT INTO Exteriores(ID,x,y,z,int,dim,Creador) VALUES(?,?,?,?,?,?,?)", id, x, y, z, int, dim, getAccountName(getPlayerAccount(player)))
					outputChatBox("#44A5CA[ROBOS] #9CFF97Creaste el exterior de la tienda "..id.." con éxito.", player, 0,0,0, true)
					--exports["Logs-OC"]:sendDiscordLogMessage("creo un lugar de robo (Exterior) `ID: "..id.."`", player)
				end
			end
		end
		end
	end
end
addCommandHandler("crearexteriorrobo", crearExteriorRobo)
function eliminarLugarRobo(player, cmd)
	if not notIsGuest then
		local cuenta = getAccountName(getPlayerAccount(player))
	    if isObjectInACLGroup ("user."..cuenta, aclGetGroup ( "Desarrollador" ) ) then
	    	for k, v in pairs(LugaresDeRobo) do
	    		if isElementWithinMarker( player, k ) then
					if getElementDimension( k ) == getElementDimension(player) then
	    			destroyElement(k)
					LugaresDeRobo[k] = nil
					local markerID = getRoboID(k)
					dbExec(sqlRobos,"DELETE FROM Lugares WHERE ID=?", markerID)
					dbExec(sqlRobos,"DELETE FROM Exteriores WHERE ID=?", markerID)
					outputChatBox("#44A5CA[ROBOS] #9CFF97Eliminaste un lugar de robo con éxito.", player, 0,0,0, true)
					--exports["Logs-OC"]:sendDiscordLogMessage("elimino un lugar de robo `ID: "..markerID.."`", player)
	    		end
				end
	    	end
			restartResource( getThisResource() )
		end
	end
end
addCommandHandler("eliminarrobo", eliminarLugarRobo)
addEventHandler("onMarkerHit", getRootElement(), function(element, dim)
	if LugaresDeRobo[source] then
		if getElementType(element) == "player" then
			if getElementDimension(element) == getElementDimension(source) then
				if (getElementData(element, "Roleplay:trabajo") == "Ladron") or (getElementData(element, "Roleplay:trabajoVIP") == "Ladron") then
					outputChatBox("#FFFFFFEsta tienda tiene suficiente dinero como para ser robada. \nPuedes iniciar el robo con #F06C6C/robar", element, 0,0,0, true)
				end
				if getElementData(element, "Roleplay:faccion") == "Policia" then
					outputChatBox("#FFFFFFPuedes revisar las camaras del lugar con #F06C6C/buscarcamaras", element, 0,0,0, true)
				end
			end
		end
	end
end)
addEventHandler("onMarkerLeave", getRootElement(), function(element)
	if LugaresDeRobo[source] then
		if getElementType(element) == "player" then
				print(getElementDimension(element))
				print(getElementDimension(source))
			if getElementDimension(element) == getElementDimension(source) then
                if (getElementData(element, "Roleplay:trabajo") == "Ladron") or (getElementData(element, "Roleplay:trabajoVIP") == "Ladron") and getElementData(element, "familias:RobandoTienda") then
					killTimer( getElementData(element, "familias:RobandoTienda") )
					removeElementData( element, "familias:RobandoTienda" )
					outputChatBox("#44A5CA[ROBOS] #F06C6CSaliste de la zona de robo, has cancelado el atraco.", element, 0,0,0, true)
				end
			end
		end
	end
end)
addCommandHandler("robar", function(player, cmd)
	if not notIsGuest then
		for k, v in pairs(LugaresDeRobo) do
			if isElementWithinMarker( player, k ) then
			if getElementDimension(k) == getElementDimension(player) then
				if (getElementData(player, "Roleplay:trabajo") == "Ladron") or (getElementData(player, "Roleplay:trabajoVIP") == "Ladron") then
				  if not getElementData(k, "familias:TiendaRobada") and not getElementData(player, "familias:RobandoTienda") then
				   if getPedWeaponSlot( player ) > 1 then 
					local tienda = setTimer(function(jugador, tienda)
					  if getElementDimension(tienda) == getElementDimension(jugador) then
						if getElementData(jugador, "familias:RobandoTienda") then
							if getElementData(jugador, "Familias:Enmascarado") then
								removeElementData(jugador, "familias:RobandoTienda")
								setElementData(tienda, "familias:TiendaRobada", true)
								local dinero = math.random(250,2151)
								exports.players:giveMoney(jugador, dinero)
								outputChatBox("#44A5CA[ROBOS] #FFFFFFLa tienda fue robada con éxito y las cámaras no te reconocieron por la máscara. #FFFF00\nEn este robo recibiste:#9CFF97 $"..dinero, jugador, 0,0,0, true)
								setTimer(function(tienda)
									if getElementData(tienda, "familias:TiendaRobada") then
										setElementData(tienda, "familias:TiendaRobada", false)
									end
								end, 900000, 1, tienda)
							else
								removeElementData(jugador, "familias:RobandoTienda")
								setElementData(tienda, "familias:TiendaRobada", jugador)
								local dinero = math.random(250,2151)
								setPlayerMoney(jugador,getPlayerMoney(jugador)+dinero)
								outputChatBox("#44A5CA[ROBOS] #FFFFFFLa tienda fue robada con éxito, corre de la policía, recuerda que las cámaras te grabaron. #FFFF00\nPor este robo recibiste:#9CFF97 $"..dinero, jugador, 0,0,0, true)
								setTimer(function(tienda)
									if getElementData(tienda, "familias:TiendaRobada") then
										setElementData(tienda, "familias:TiendaRobada", false)
									end
								end, 900000, 1, tienda)
							end
						end
					  else
					  	outputChatBox("#44A5CA[ROBOS] #FFFFFFComenzaste el robo pero saliste antes del que cajero te de el dinero.", jugador, 0,0,0, true)
						removeElementData(jugador, "familias:RobandoTienda")
					  end
					end, 30000, 1, player, k)
					setElementData(player, "familias:RobandoTienda", tienda)
					outputChatBox("#44A5CA[ROBOS] #FFFFFFEstás robando una tienda, apunta con el arma al vendedor y pidele todo el dinero", player, 0,0,0, true)
					for keys, values in pairs(ExterioresDeRobo) do
						if getElementData(keys, "Robo:ID") == getElementData(k, "Robo:ID") then
							LlamadosCentral[keys] = {"Nadie"}
							setTimer(function(k)
								if k then
									LlamadosCentral[k] = nil
								end
							end, 200000, 1, keys)
						end
					end
						for key, value in ipairs(getElementsByType("player")) do
							if exports.facciones:getFactionPlayer(value,"Policia") then
								--if getElementData(value,"LSPD:Disponible") == true then
								if player:getData("Familias:Enmascarado") then
									outputChatBox("#4169E1[Central#4169E1] #FFFFFF¡Recibimos una alerta, Estan robando una Tienda! #FFFD82(Acudir /robotienda "..getRoboID(k)..")", value, 50, 150, 50, true)
									outputChatBox("#4169E1[Central#4169E1] #FFFFFFEl presunto ladron fue identificado como -#FF00E4"..player:getData("Familias:Enmascarado").."#FFFFFF-", value, 50, 150, 50, true)
									triggerClientEvent( value, "central", value )
								else
									outputChatBox("#4169E1[Central#4169E1] #FFFFFF¡Recibimos una alerta, Estan robando una Tienda! #FFFD82(Acudir /robotienda "..getRoboID(k)..")", value, 50, 150, 50, true)
									outputChatBox("#4169E1[Central#4169E1] #FFFFFFEl presunto ladron fue identificado como -#FF00E4"..getPlayerName(player).."#FFFFFF-", value, 50, 150, 50, true)
									triggerClientEvent( value, "central", value )
								end
								--end
							end
						end
				    else
				   		outputChatBox("#F06C6CQue cabrón, ¿Piensas robar sin arma?", player, 0,0,0, true)
				   	end
				 else
				  outputChatBox("#F06C6CEsta tienda no cuenta con suministros suficientes para ser robada, intentalo más tarde.", player, 0,0,0, true)
				 		end
					end
				end
			end
		end
	end
end)
--------------------------------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------------------------
local sql = dbConnect("sqlite", "familias.db");
dbExec(sql, "CREATE TABLE IF NOT EXISTS Familias(familyName,Rango1,Rango2,Rango3,Rango4,Rango5,Rango6,Rango7,Rango8,Rango9,familyColor)")
dbExec(sql, "CREATE TABLE IF NOT EXISTS Miembros(memberName,memberFamily,memberRank)")
dbExec(sql, "CREATE TABLE IF NOT EXISTS Mascara(memberName,mascara,mascaraID)")
zonaComprarMascara = createColSphere( 1295.0397949219, -981.95129394531, 32.6953125, 3 )
--RectangleBloods = createColRectangle ( 2228.8828125, -1800.3717041016, 200, 80 )
--RectangleCripz = createColRectangle ( 1656.79, -2161.13, 300, 200 )
--------------------------------------------------------------------------------------------------------------------------------------------------
function tieneMascara(namePlayer)
	local buscardbg = dbPoll(dbQuery(sql, "SELECT * FROM Mascara WHERE memberName = ?", namePlayer), -1)
	for key, value in ipairs(buscardbg) do
		if value.mascara then
			return "true"
		end
	end
end
function setPedMasked(p)
    local namePlayer = getPlayerName(p)
	local buscardbg = dbPoll(dbQuery(sql, "SELECT * FROM Miembros WHERE memberName = ?", namePlayer), -1)
	for keys, values in ipairs(buscardbg) do
		if values then
			if tieneMascara(getPlayerName(p)) == "true" then
				if not getElementData(p, "Nomascara") then
	    			if not getElementData(p, "Familias:Enmascarado") or getElementData(p, "Familias:Enmascarado") == false then
						local buscarenladb = dbPoll(dbQuery(sql, "SELECT * FROM Mascara WHERE memberName = ?", namePlayer), -1)
	    				for k, v in ipairs(buscarenladb) do
                			newTagPlayerMasked = "Enmascarado_"..v.mascaraID
                			setElementData(p, "Familias:Enmascarado", newTagPlayerMasked)
                			outputChatBox("#44A5CA[FAMILIAS]#9CFF97 Te colocaste una mascara, ahora nadie podrá reconocerte fácilmente.", p, 0, 0, 0, true)
                			outputDebugString("[ENMASCARADO] "..namePlayer.." AHORA ES "..newTagPlayerMasked)
                		end
                	else
                		local namePlayer = getElementData(p, "Familias:Enmascarado")
                		removeElementData(p, "Familias:Enmascarado")
                		outputChatBox("#44A5CA[FAMILIAS]#9CFF97 Te quitaste la mascara, ahora te verás normal.", p, 0, 0, 0, true)
                		outputDebugString("[ENMASCARADO] "..namePlayer.." AHORA ES "..getPlayerName(p))    
                		setElementData(p, "Nomascara", 1)
                		--
                        setTimer ( function(p)
                            removeElementData(p, "Nomascara")
                        end, 10000, 1, p)
                        --
           			end
           		else
           			outputChatBox("#44A5CA[FAMILIAS] #F06C6CDebes esperar un tiempo para colocarte la máscara nuevamente.", p, 0,0,0, true)
        		end
        	else
        		outputChatBox("#44A5CA[FAMILIAS] #F06C6CNo tienes mascara para colocarte.", p, 0,0,0, true)
        	end
    	end
    end
end
addCommandHandler("enmascarado", setPedMasked)
----------------------------------------------------------------------------------------------------------------------------------------------
addEventHandler( "onResourceStart", getRootElement(), function()
	local familia = dbPoll(dbQuery(sql, "SELECT * FROM Familias"), -1)
	if familia[1] ~= nil then
		for fkey, fvalue in ipairs(familia) do
			RangosID[fvalue.familyName] = {fvalue.Rango1, fvalue.Rango2, fvalue.Rango3, fvalue.Rango4, fvalue.Rango5, fvalue.Rango6, fvalue.Rango7, fvalue.Rango8, fvalue.Rango9}
		end
	end
end)
function buscarFamilia(familyName)
	if familyName then
		local familia = dbPoll(dbQuery(sql, "SELECT * FROM Familias WHERE familyName = ?", familyName), -1)
		if familia[1] ~= nil then
			for fkey, fvalue in ipairs(familia) do
				return true
			end
		end
	end
end
function getPlayerFamily(player)
	if getPlayerName(player) then
		local Miembros = dbPoll(dbQuery(sql, "SELECT * FROM Miembros WHERE memberName = ?", getPlayerName(player)), -1)
		for mKey, mvalue in ipairs(Miembros) do
			if mvalue.memberName == getPlayerName(player) then
				return true, mvalue.memberFamily
			end
		end
	else
		local Miembros = dbPoll(dbQuery(sql, "SELECT * FROM Miembros WHERE memberName = ?", player), -1)
		for mKey, mvalue in ipairs(Miembros) do
			if mvalue.memberName == player then
				return true, mvalue.memberFamily
			end
		end
	end
end
local Conectados = {}
function miembros(player, cmd, familyName)
	if not notIsGuest then
		if buscarFamilia(familyName) then
			local Familias = dbPoll(dbQuery(sql, "SELECT * FROM Familias WHERE familyName=?", familyName), -1)
			for k, v in ipairs(getElementsByType("player")) do
				local Miembros = dbPoll(dbQuery(sql, "SELECT * FROM Miembros WHERE memberName=?", getPlayerName(v)), -1)
				for key, value in ipairs(Miembros) do
					Conectados[player] = {Conectados[player][1] + 1}
				end
			end
    		for keys, values in ipairs(Familias) do
    			--print(inspect(Conectados))
    			--outputChatBox("\n#44A5CA[FAMILIAS] #FFFFFFMiembros de "..values.familyColor..familyName.." #FFFFFFconectados: "..Conectados[player][1].."\n", player, 255, 255, 255, true)
    			Conectados[player] = {0}
    		end
    	elseif getPlayerFromName(familyName) then
			local Owa = dbPoll(dbQuery(sql, "SELECT * FROM Miembros WHERE memberName=?", familyName), -1)
			for k, v in ipairs(Owa) do
				local Familias = dbPoll(dbQuery(sql, "SELECT * FROM Familias WHERE familyName=?", v.memberFamily), -1)
				local Miembros = dbPoll(dbQuery(sql, "SELECT * FROM Miembros WHERE memberFamily=?", v.memberFamily), -1)
    			for key, value in ipairs(Familias) do
    				outputChatBox("\n===== #FFA822Miembros de "..value.familyColor..v.memberFamily.." #FFFFFF=====\n", player, 255, 255, 255, true)
    			end
    			for key, value in ipairs(Miembros) do
    				outputChatBox("- #FFA822"..value.memberName.."#FFFFFF | #FFA822"..value.memberRank.." #FFFFFF("..key..")", player, 255, 255, 255, true)
    			end
    				outputChatBox("\n============================\n", player, 255, 255, 255, true)
    		end
    	else
			outputChatBox("#44A5CA[FAMILIAS] #F06C6CLa familia a buscar no existe. \nUsa #FFFFFF/familias #F06C6Cpara buscar el nombre correcto.", player, 0,0,0,true)
    	end
	end
end
addCommandHandler("vermiembros", miembros)
function familias(player, cmd)
	if not notIsGuest then
		local Familias = dbPoll(dbQuery(sql, "SELECT * FROM Familias"), -1)
    	outputChatBox("==== #FFFF00FAMILIAS OFICIALES #FFFFFF====", player, 255, 255, 255, true)
    	for key, value in ipairs(Familias) do
    		outputChatBox("- "..value.familyColor..value.familyName, player, 255, 255, 255, true)
    	end
	end
end
addCommandHandler("familias", familias)
function crearFamilia(player, cmd, familyName, Rango1, Rango2, Rango3, Rango4, Rango5, Rango6, Rango7, Rango8, Rango9, familyColor)
	if not notIsGuest and familyName and Rango1 and Rango2 and Rango3 and Rango4 and Rango5 and Rango6 and Rango7 and Rango8 and Rango9 and familyColor then
    	local accName = getAccountName ( getPlayerAccount ( player ) )
    	local staffAdministrador = isObjectInACLGroup("user."..accName, aclGetGroup("Desarrollador"))
    	local staffCreador = isObjectInACLGroup("user."..accName, aclGetGroup("Desarrollador"))
    	if staffCreador or staffAdministrador then
			if buscarFamilia(familyName) then
				outputChatBox("#44A5CA[FAMILIAS] #F06C6CLa familia a crear ya existe. \nUsa #FFFFFF/eliminarfamilia #F06C6Cpara eliminarla.", player, 0,0,0,true)
			else
				if dbExec(sql,"INSERT INTO Familias(familyName,Rango1,Rango2,Rango3,Rango4,Rango5,Rango6,Rango7,Rango8,Rango9,familyColor) VALUES(?,?,?,?,?,?,?,?,?,?,?)", familyName, Rango1, Rango2, Rango3, Rango4, Rango5, Rango6, Rango7, Rango8, Rango9, familyColor) then
					outputChatBox("#44A5CA[FAMILIAS] #9CFF97Se ha creado la familia "..familyColor..familyName.." #9CFF97correctamente. \nUsa #FFFFFF/colocarjefe #9CFF97para asignarle un miembro.", player, 0,0,0, true)
					--exports["Logs-OC"]:sendDiscordLogMessage("creo la familia `"..familyName.."`", player)
				end
			end
    	end
	else
		outputChatBox("#44A5CASyntax: #FFFFFF/crearfamilia [familyName] [Rango 1-9] [#Color]", player,0,0,0, true)
	end
end
addCommandHandler("crearfamilia", crearFamilia)
function eliminarFamilia(player, cmd, familyName)
	if not notIsGuest and familyName then
    	local accName = getAccountName ( getPlayerAccount ( player ) )
    	local staffAdministrador = isObjectInACLGroup("user."..accName, aclGetGroup("Desarrollador"))
    	local staffCreador = isObjectInACLGroup("user."..accName, aclGetGroup("Desarrollador"))
    	if staffCreador or staffAdministrador then
			if buscarFamilia(familyName) then
				if dbExec(sql,"DELETE FROM Familias WHERE familyName=?", familyName) then
					dbExec(sql,"DELETE FROM Miembros WHERE memberFamily=?", familyName)
					outputChatBox("#44A5CA[FAMILIAS] #9CFF97Se ha eliminado la familia "..familyName.." #9CFF97correctamente.", player, 0,0,0, true)
					--exports["Logs-OC"]:sendDiscordLogMessage("elimino la familia `"..familyName.."`", player)
					local Miembro = dbPoll(dbQuery(sql, "SELECT * FROM Miembros WHERE memberFamily = ?", familyName), -1)
					for fKey, fvalue in ipairs(Miembro) do
						if getPlayerFromName(fvalue.memberName) then
                			setElementData(getPlayerFromName(fvalue.memberName), "Familias:Enmascarado", false)
                		end
                	end
				end
			else
				outputChatBox("#44A5CA[FAMILIAS] #F06C6CLa familia a eliminar no existe. \nUsa #FFFFFF/familias #F06C6Cpara ver las existentes.", player, 0,0,0,true)
			end
    	end
	else
		outputChatBox("#44A5CASyntax: #FFFFFF/eliminarfamilia [familyName]", player,0,0,0, true)
	end
end
addCommandHandler("eliminarfamilia", eliminarFamilia)
function limpiarFamilia(player, cmd, familyName)
	if not notIsGuest and familyName then
    	local accName = getAccountName ( getPlayerAccount ( player ) )
    	local staffAdministrador = isObjectInACLGroup("user."..accName, aclGetGroup("Desarrollador"))
    	local staffCreador = isObjectInACLGroup("user."..accName, aclGetGroup("Desarrollador"))
    	if staffCreador or staffAdministrador then
			if buscarFamilia(familyName) then
				if dbExec(sql,"DELETE FROM Miembros WHERE memberFamily=?", familyName) then
					local Miembro = dbPoll(dbQuery(sql, "SELECT * FROM Miembros WHERE memberFamily = ?", familyName), -1)
					local Famiia = dbPoll(dbQuery(sql, "SELECT * FROM Familias WHERE familyName = ?", familyName), -1)
					for mKey, mvalue in ipairs(Famiia) do
						outputChatBox("#FFFFFFUn administrador ha limpiado la familia "..mvalue.familyColor..familyName, root, 0,0,0, true)
						--exports["Logs-OC"]:sendDiscordLogMessage("limpio la familia `"..familyName.."`", player)
						for fKey, fvalue in ipairs(Miembro) do
							if getPlayerFromName(fvalue.memberName) then
                				setElementData(getPlayerFromName(fvalue.memberName), "Familias:Enmascarado", false)
                			end
                		end
					end
				end
			else
				outputChatBox("#44A5CA[FAMILIAS] #F06C6CLa familia a eliminar no existe. \nUsa #FFFFFF/familias #F06C6Cpara ver las existentes.", player, 0,0,0,true)
			end
    	end
	else
		outputChatBox("#44A5CASyntax: #FFFFFF/eliminarfamilia [familyName]", player,0,0,0, true)
	end
end
addCommandHandler("limpiarfamilia", limpiarFamilia)
function expulsarMiembro(player, cmd, otherPlayer)
	if player and otherPlayer then
			local otherPlayer = getPlayerFromName(otherPlayer)
			local Miembros = dbPoll(dbQuery(sql, "SELECT * FROM Miembros WHERE memberName = ?", getPlayerName(player)), -1)
			for mKey, mvalue in ipairs(Miembros) do
				local familia = dbPoll(dbQuery(sql, "SELECT * FROM Familias WHERE familyName = ?", mvalue.memberFamily), -1)
				if familia[1] ~= nil then
					for fKey, fvalue in ipairs(familia) do
						if fvalue.familyName == mvalue.memberFamily then
							if fvalue.Rango9 == mvalue.memberRank or fvalue.Rango8 == mvalue.memberRank then
								if dbExec(sql,"DELETE FROM Miembros WHERE memberFamily=? AND memberName=?", fvalue.familyName, getPlayerName(otherPlayer)) then
									outputChatBox("#44A5CA[FAMILIAS] #9CFF97Expulsaste a "..getPlayerName(otherPlayer).." de "..fvalue.familyColor..fvalue.familyName, player, 0,0,0, true)
									outputChatBox("#44A5CA[FAMILIAS] #9CFF97Has sido expulsado de "..fvalue.familyColor..fvalue.familyName, otherPlayer, 0,0,0, true)
                					setElementData(otherPlayer, "Familias:Enmascarado", false)
								end
							else
								outputChatBox("#44A5CA[FAMILIAS] #F06C6CNo tienes los permisos suficientes para hacer esto.", player, 0,0,0, true)
							end
						else
							outputChatBox("#44A5CA[FAMILIAS] #F06C6CNo eres miembro de esta familia o ha ocurrido un error.", player, 0,0,0, true)
						end
					end
				end
			end
		elseif not notIsGuest then
			local Miembros = dbPoll(dbQuery(sql, "SELECT * FROM Miembros WHERE memberName = ?", getPlayerName(player)), -1)
			for mKey, mvalue in ipairs(Miembros) do
				local familia = dbPoll(dbQuery(sql, "SELECT * FROM Familias WHERE familyName = ?", mvalue.memberFamily), -1)
				if familia[1] ~= nil then
					for fKey, fvalue in ipairs(familia) do
						if fvalue.familyName == mvalue.memberFamily then
							if fvalue.Rango9 == mvalue.memberRank or fvalue.Rango8 == mvalue.memberRank then
								if dbExec(sql,"DELETE FROM Miembros WHERE memberFamily=? AND memberName=?", fvalue.familyName, otherPlayer) then
									outputChatBox("#44A5CA[FAMILIAS] #9CFF97Expulsaste a "..otherPlayer.." de "..fvalue.familyColor..fvalue.familyName, player, 0,0,0, true)
									--exports["Logs-OC"]:sendDiscordLogMessage("expulso a "..otherPlayer.." de "..fvalue.familyName, player)
								end
							else
								outputChatBox("#44A5CA[FAMILIAS] #F06C6CNo tienes los permisos suficientes para hacer esto.", player, 0,0,0, true)
							end
						else
							outputChatBox("#44A5CA[FAMILIAS] #F06C6CNo eres miembro de esta familia o ha ocurrido un error.", player, 0,0,0, true)
						end
					end
				end
			end
	else
		outputChatBox("#44A5CASyntax: #FFFFFF/expulsar [Nombre_Apellido]", player, 0,0,0, true)
	end
end
addCommandHandler("expulsar", expulsarMiembro)
function ascenderMiembro(player, cmd, otherPlayer)
	if player and otherPlayer then
		if not notIsGuest(getPlayerFromName(otherPlayer)) and not notIsGuest then
			local otherPlayer = getPlayerFromName(otherPlayer)
			local Miembros = dbPoll(dbQuery(sql, "SELECT * FROM Miembros WHERE memberName = ?", getPlayerName(player)), -1)
			local MiembrosOther = dbPoll(dbQuery(sql, "SELECT * FROM Miembros WHERE memberName = ?", getPlayerName(otherPlayer)), -1)
			for mKey, mvalue in ipairs(Miembros) do
			for mKeys, mvalues in ipairs(MiembrosOther) do
				local familia = dbPoll(dbQuery(sql, "SELECT * FROM Familias WHERE familyName = ?", mvalue.memberFamily), -1)
				if familia[1] ~= nil then
					for fKey, fvalue in ipairs(familia) do
						if fvalue.familyName == mvalue.memberFamily and mvalue.memberFamily == mvalues.memberFamily then
							if fvalue.Rango9 == mvalue.memberRank or fvalue.Rango8 == mvalue.memberRank then
								for id=1, 8 do
									if RangosID[mvalues.memberFamily][id] == mvalues.memberRank then
										if dbExec(sql,"UPDATE Miembros SET memberRank=? WHERE memberFamily=? AND memberName=?", RangosID[mvalues.memberFamily][id+1], mvalues.memberFamily, getPlayerName(otherPlayer)) then
											outputChatBox("#44A5CA[FAMILIAS] #9CFF97Ascendiste a "..getPlayerName(otherPlayer).." de "..RangosID[mvalues.memberFamily][id].." a "..RangosID[mvalues.memberFamily][id+1], player, 0,0,0, true)
											outputChatBox("#44A5CA[FAMILIAS] #9CFF97Has sido ascendido de "..RangosID[mvalues.memberFamily][id].." a "..RangosID[mvalues.memberFamily][id+1], otherPlayer, 0,0,0, true)
										end
									end
								end
							else
								outputChatBox("#44A5CA[FAMILIAS] #F06C6CNo tienes los permisos suficientes para hacer esto.", player, 0,0,0, true)
							end
						else
							outputChatBox("#44A5CA[FAMILIAS] #F06C6CAl parecer quien intentas ascender no es miembro de tu familia.", player, 0,0,0, true)
						end
					end
				end
			end
			end
		else
			outputChatBox("#44A5CA[FAMILIAS] #F06C6CEl jugador no se encuentran logueado.", player, 0,0,0, true)
		end
	else
		outputChatBox("#44A5CASyntax: #FFFFFF/ascender [Nombre_Apellido]", player, 0,0,0, true)
	end
end
addCommandHandler("ascender", ascenderMiembro)
function degradarMiembro(player, cmd, otherPlayer)
	if player and otherPlayer then
		if not notIsGuest(getPlayerFromName(otherPlayer)) and not notIsGuest then
			local otherPlayer = getPlayerFromName(otherPlayer)
			local Miembros = dbPoll(dbQuery(sql, "SELECT * FROM Miembros WHERE memberName = ?", getPlayerName(player)), -1)
			local MiembrosOther = dbPoll(dbQuery(sql, "SELECT * FROM Miembros WHERE memberName = ?", getPlayerName(otherPlayer)), -1)
			for mKey, mvalue in ipairs(Miembros) do
			for mKeys, mvalues in ipairs(MiembrosOther) do
				local familia = dbPoll(dbQuery(sql, "SELECT * FROM Familias WHERE familyName = ?", mvalue.memberFamily), -1)
				if familia[1] ~= nil then
					for fKey, fvalue in ipairs(familia) do
						if fvalue.familyName == mvalue.memberFamily and mvalue.memberFamily == mvalues.memberFamily then
							if fvalue.Rango9 == mvalue.memberRank or fvalue.Rango8 == mvalue.memberRank then
								for id=2, 8 do
									if RangosID[mvalues.memberFamily][id] == mvalues.memberRank then
										if dbExec(sql,"UPDATE Miembros SET memberRank=? WHERE memberFamily=? AND memberName=?", RangosID[mvalues.memberFamily][id-1], mvalues.memberFamily, getPlayerName(otherPlayer)) then
											outputChatBox("#44A5CA[FAMILIAS] #9CFF97Bajaste el rango a "..getPlayerName(otherPlayer).." de "..RangosID[mvalues.memberFamily][id].." a "..RangosID[mvalues.memberFamily][id-1], player, 0,0,0, true)
											outputChatBox("#44A5CA[FAMILIAS] #9CFF97Tu rango fue bajado de "..RangosID[mvalues.memberFamily][id].." a "..RangosID[mvalues.memberFamily][id-1], otherPlayer, 0,0,0, true)
										end
									end
								end
							else
								outputChatBox("#44A5CA[FAMILIAS] #F06C6CNo tienes los permisos suficientes para hacer esto.", player, 0,0,0, true)
							end
						else
							outputChatBox("#44A5CA[FAMILIAS] #F06C6CAl parecer quien intentas ascender no es miembro de tu familia.", player, 0,0,0, true)
						end
					end
				end
			end
			end
		else
			outputChatBox("#44A5CA[FAMILIAS] #F06C6CEl jugador no se encuentran logueado.", player, 0,0,0, true)
		end
	else
		outputChatBox("#44A5CASyntax: #FFFFFF/degradar [Nombre_Apellido]", player, 0,0,0, true)
	end
end
addCommandHandler("degradar", degradarMiembro)
function abandonarMiembro(player, cmd)
	if player then
		if not notIsGuest then
			local Miembros = dbPoll(dbQuery(sql, "SELECT * FROM Miembros WHERE memberName = ?", getPlayerName(player)), -1)
			for mKey, mvalue in ipairs(Miembros) do
				local familia = dbPoll(dbQuery(sql, "SELECT * FROM Familias WHERE familyName = ?", mvalue.memberFamily), -1)
				if familia[1] ~= nil then
					for fKey, fvalue in ipairs(familia) do
						if fvalue.familyName == mvalue.memberFamily then
							if fvalue.Rango9 == mvalue.memberRank or fvalue.Rango8 == mvalue.memberRank then
								if dbExec(sql,"DELETE FROM Miembros WHERE memberFamily=? AND memberName=?", fvalue.familyName, getPlayerName(player)) then
									outputChatBox("#44A5CA[FAMILIAS] #9CFF97Abandonaste la familia de "..fvalue.familyColor..fvalue.familyName, player, 0,0,0, true)
									--exports["Logs-OC"]:sendDiscordLogMessage("abandono la familia de `"..fvalue.familyName.."`", player)
                					removeElementData(player, "Familias:Enmascarado")
								end
							else
								outputChatBox("#44A5CA[FAMILIAS] #F06C6CNo tienes los permisos suficientes para hacer esto.", player, 0,0,0, true)
							end
						else
							outputChatBox("#44A5CA[FAMILIAS] #F06C6CNo eres miembro de esta familia o ha ocurrido un error.", player, 0,0,0, true)
						end
					end
				end
			end
		else
			outputChatBox("#44A5CA[FAMILIAS] #F06C6CNo estás logueado.", player, 0,0,0, true)
		end
	end
end
addCommandHandler("abandonarfamilia", abandonarMiembro)
function colocarJefe(player, cmd, otherPlayer, familyName)
	if not notIsGuest then
    	local accName = getAccountName ( getPlayerAccount ( player ) )
    	local staffAdministrador = isObjectInACLGroup("user."..accName, aclGetGroup("Desarrollador"))
    	local staffCreador = isObjectInACLGroup("user."..accName, aclGetGroup("Desarrollador"))
    	if staffCreador or staffAdministrador then
			if buscarFamilia(familyName) then
				if getPlayerFamily(otherPlayer) then
					outputChatBox("#44A5CA[FAMILIAS] #F06C6CEl jugador ya se encuentra en una familia.", player, 0,0,0,true)
				else
					local Famiia = dbPoll(dbQuery(sql, "SELECT * FROM Familias WHERE familyName = ?", familyName), -1)
					for key, value in ipairs(Famiia) do
						if dbExec(sql,"INSERT INTO Miembros(memberName,memberFamily,memberRank) VALUES(?,?,?)", otherPlayer, value.familyName, value.Rango9) then
							outputChatBox("#44A5CA[FAMILIAS] #9CFF97Has sido colocado como el "..value.familyColor..value.Rango9.."#9CFF97 de "..value.familyColor..familyName, getPlayerFromName(otherPlayer), 0,0,0, true)
							outputChatBox("#44A5CA[FAMILIAS] #9CFF97Has colocado a "..getPlayerName(otherPlayer).." como el "..value.familyColor..value.Rango9.."#9CFF97 de "..value.familyColor..familyName, player, 0,0,0, true)
							--exports["Logs-OC"]:sendDiscordLogMessage("coloco jefe de `"..familyName.."` a "..getPlayerName(otherPlayer).."", player)
						end
					end
				end
			else
				outputChatBox("#44A5CA[FAMILIAS] #F06C6CLa familia mencionada no existe. \nUsa #FFFFFF/familias #F06C6Cpara ver las existentes.", player, 0,0,0,true)
			end
    	end
	else
		outputChatBox("#44A5CASyntax: #FFFFFF/colocarjefe [Nombre_Apellido] [familia]", player,0,0,0, true)
	end
end
addCommandHandler("colocarjefe", colocarJefe)
function colocarColor(player, cmd, familyName, colorCode)
	if not notIsGuest then
    	local accName = getAccountName ( getPlayerAccount ( player ) )
    	local staffAdministrador = isObjectInACLGroup("user."..accName, aclGetGroup("Desarrollador"))
    	local staffCreador = isObjectInACLGroup("user."..accName, aclGetGroup("Desarrollador"))
    	if staffCreador or staffAdministrador then
			if buscarFamilia(familyName) then
				if #colorCode == 7 and colorCode:find("#") then
					local Famiia = dbPoll(dbQuery(sql, "SELECT * FROM Familias WHERE familyName = ?", familyName), -1)
					for key, value in ipairs(Famiia) do
						outputChatBox("#44A5CA[FAMILIAS] #9CFF97El color de "..value.familyColor..familyName.."#9CFF97 ha sido cambiado a "..colorCode..familyName, player, 0,0,0, true)
						dbExec(sql,"UPDATE Familias SET familyColor=? WHERE familyName=?", colorCode, familyName)
					end
				end
			else
				outputChatBox("#44A5CA[FAMILIAS] #F06C6CLa familia mencionada no existe. \nUsa #FFFFFF/familias #F06C6Cpara ver las existentes.", player, 0,0,0,true)
			end
    	end
	else
		outputChatBox("#44A5CASyntax: #FFFFFF/colocarcolor [Familia] [ColorCode] \n#44A5CA[EJEMPLO] #FFFFFF/colocarcolor Bloods #FF0000", player,0,0,0, true)
	end
end
addCommandHandler("colocarcolor", colocarColor)
function famOOC(player, cmd, ...)
	if not notIsGuest and ( ... ) then
		local message = table.concat( { ... }, " " )
		if #message > 0 then
			local Miembros = dbPoll(dbQuery(sql, "SELECT * FROM Miembros WHERE memberName = ?", getPlayerName(player)), -1)
			for key, value in ipairs(Miembros) do
				if value.memberFamily then
					local Miembrs = dbPoll(dbQuery(sql, "SELECT * FROM Miembros WHERE memberFamily = ?", value.memberFamily), -1)
					for ke, valu in ipairs(Miembrs) do
						if getPlayerFromName(valu.memberName) then
							local Miembr = dbPoll(dbQuery(sql, "SELECT * FROM Familias WHERE familyName = ?", value.memberFamily), -1)
							for k, val in ipairs(Miembr) do
								outputChatBox("#FFFFFF[OOC] "..val.familyColor..value.memberRank.." #FFFFFF| "..val.familyColor..getPlayerName(player)..":#FFFFFF "..message, getPlayerFromName(valu.memberName), 0,0,0, true)
								--exports["Logs-OC"]:sendDiscordLogMessage("hablo por `["..value.memberFamily.."-OOC]`: "..message, player)
							end
						end
					end
				end
			end
		end
	else
		outputChatBox("#44A5CASyntax: #FFFFFF/fam [mensaje]", player,0,0,0, true)
	end
end
addCommandHandler("fam", famOOC)
function invitarMiembro(player, otherPlayer, familia)
	if player and otherPlayer and familia then
		local otherPlayer = getPlayerFromName(otherPlayer)
		if not notIsGuest then
			local familia = dbPoll(dbQuery(sql, "SELECT * FROM Familias WHERE familyName = ?", familia), -1)
			if familia[1] ~= nil then
				for fKey, fvalue in ipairs(familia) do
					local Miembros = dbPoll(dbQuery(sql, "SELECT * FROM Miembros WHERE memberName = ?", getPlayerName(player)), -1)
					for mKey, mvalue in ipairs(Miembros) do
						if fvalue.familyName == mvalue.memberFamily then
							if fvalue.Rango9 == mvalue.memberRank or fvalue.Rango8 == mvalue.memberRank then
								local x1, y1, z1 = getElementPosition(player)
								local x2, y2, z2 = getElementPosition(otherPlayer)
								local distance = getDistanceBetweenPoints3D( x1, y1, z1, x2, y2, z2 )
								if distance < 5 then
									if not getElementData(otherPlayer, "Familias:Invitado") then
										setElementData(otherPlayer, "Familias:Invitado", mvalue.memberFamily)
										setTimer(function(otherPlayer, player)
										if getElementData(otherPlayer, "Familias:Invitado") then
												removeElementData( otherPlayer, "Familias:Invitado" )
												outputChatBox("#44A5CA[FAMILIAS] #F06C6C"..getPlayerName(otherPlayer).." no aceptó la solicitud y la rechazamos automáticamente.", player, 0,0,0, true)
												outputChatBox("#44A5CA[FAMILIAS] #F06C6CHemos rechazado automáticamente tu invitación a "..fvalue.familyName, otherPlayer, 0,0,0, true)
											end
										end, 15000, 1, otherPlayer, player)
										outputChatBox("#44A5CA[FAMILIAS] #9CFF97Hemos enviado una invitación a "..getPlayerName(otherPlayer).." para unirse a "..fvalue.familyName, player, 0,0,0, true)
										outputChatBox("#44A5CA[FAMILIAS] #9CFF97Recibiste una invitación a "..fvalue.familyName.." \nUsa #ffffff/unirme #9CFF97para aceptar la invitación.", otherPlayer, 0,0,0, true)
									else
										outputChatBox("#44A5CA[FAMILIAS] #F06C6CEl jugador tiene una invitación pendiente.", player, 0,0,0, true)
									end
								else
									outputChatBox("#44A5CA[FAMILIAS] #F06C6CEl jugador a invitar se encuentra lejos de ti.", player, 0,0,0, true)
								end
							else
								outputChatBox("#44A5CA[FAMILIAS] #F06C6CNo tienes los permisos suficientes para hacer esto.", player, 0,0,0, true)
							end
						else
							outputChatBox("#44A5CA[FAMILIAS] #F06C6CNo eres miembro de esta familia o ha ocurrido un error.", player, 0,0,0, true)
						end
					end
				end
				return true
			end
		else
			outputChatBox("#44A5CA[FAMILIAS] #F06C6CEl jugador no está logueado.", player, 0,0,0, true)
		end
	end
end
function enviarSolicitud(player, cmd, otherPlayer)
	if player and otherPlayer then
		if not notIsGuest then
			if getPlayerFamily(otherPlayer) then
				outputChatBox("#44A5CA[FAMILIAS] #F06C6CEl jugador ya pertenece a otra familia.", player, 0,0,0, true)
			else
				local Miembros = dbPoll(dbQuery(sql, "SELECT * FROM Miembros WHERE memberName = ?", getPlayerName(player)), -1)
				for mKey, mvalue in ipairs(Miembros) do
					if mvalue.memberFamily then
						invitarMiembro(player, otherPlayer, mvalue.memberFamily)
					end
				end
			end
		else
			outputChatBox("#44A5CA[FAMILIAS] #F06C6CEl jugador no está logueado o no existe.", player, 0,0,0, true)
		end
	else
		outputChatBox("#44A5CASyntax: #FFFFFF/invitar [Jugador]", player, 0,0,0, true)
	end
end
addCommandHandler("invitar", enviarSolicitud)
function aceptarSolicitud(player, cmd)
	if player then
		if not notIsGuest then
			if not getElementData(player, "Familias:Invitado") then
				outputChatBox("#44A5CA[FAMILIAS] #F06C6CNo tienes ninguna invitación pendiente.", player, 0,0,0, true)
			else
				if getPlayerFamily(otherPlayer) then
					outputChatBox("#44A5CA[FAMILIAS] #F06C6CYa perteneces a otra familia.", player, 0,0,0, true)
				else
					local Familia = dbPoll(dbQuery(sql, "SELECT * FROM Familias WHERE familyName = ?", getElementData(player, "Familias:Invitado")), -1)
					for key, value in ipairs(Familia) do
						if value.Rango1 then
							dbExec(sql,"INSERT INTO Miembros(memberName,memberFamily,memberRank) VALUES(?,?,?)", getPlayerName(player), getElementData(player, "Familias:Invitado"), value.Rango1)
							outputChatBox("#44A5CA[FAMILIAS] #9CFF97Te has unido ha "..getElementData(player, "Familias:Invitado")..".", player, 0,0,0, true)
							local Miembro = dbPoll(dbQuery(sql, "SELECT * FROM Miembros WHERE memberFamily = ?", getElementData(player, "Familias:Invitado")), -1)
							for ke, va in ipairs(Miembro) do
								if va.memberName then
									for k, v in ipairs(getElementsByType("player")) do
										if getPlayerName(v) == va.memberName then
											outputChatBox(value.familyColor.."["..value.familyName.."] #9CFF97"..getPlayerName(player).." se ha unido a la familia.", v, 0,0,0, true)
										end
									end
								end
							end
							removeElementData(player, "Familias:Invitado")
						end
					end
				end
			end
		else
			outputChatBox("#44A5CA[FAMILIAS] #F06C6CNo estás logueado.", player, 0,0,0, true)
		end
	end
end
addCommandHandler("unirme", aceptarSolicitud)
addCommandHandler("comprar", function(player, cmd, articulo)
	if player and articulo then
		if string.lower(articulo) == "mascara" then
			if isElementWithinColShape(player, zonaComprarMascara) then
				local namePlayer = getPlayerName(player)
				if tieneMascara(namePlayer) == "true" then
					outputChatBox("#44A5CA[FAMILIAS] #F06C6CYa tienes una mascara. ¿Para qué comprar otra?", player, 0,0,0, true)
				else
					local newTagPlayerMasked = "#"..math.random(1000, 9999)
					dbExec(sql,"INSERT INTO Mascara(memberName,mascara,mascaraID) VALUES(?,?,?)", namePlayer, "true", newTagPlayerMasked)
					outputChatBox("#44A5CA[FAMILIAS] #9CFF97Te has comprado una mascara. \n#44A5CA[OOC]#9CFF97 Ahora con esta mascara serás el #FFFFFFEnmascarado_"..newTagPlayerMasked.."#9CFF97 \nUsa #FFFFFF/enmascarado #9CFF97para colocartela, recuerda, si un policía se te con esta te podría retener por sospecha.", player, 0,0,0, true)
					--exports["Logs-OC"]:sendDiscordLogMessage("compro una mascara.", player)
				end
			end
		end
	end
end)