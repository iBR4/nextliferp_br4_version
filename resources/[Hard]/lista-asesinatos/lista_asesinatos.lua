local asesinatosPorJugador = {}
local dbConnection = dbConnect("sqlite", "asesinatos.db")

local function guardarDatosAsesinatos()
    if not dbConnection then
        outputDebugString("Error: No se pudo conectar a la base de datos.")
        return
    end
    dbExec(dbConnection, "CREATE TABLE IF NOT EXISTS asesinatos (asesino TEXT, victima TEXT, tiempo INTEGER)")
    for asesino, asesinatos in pairs(asesinatosPorJugador) do
        local jugadorAsesino = getPlayerFromName(asesino) -- Obtener el jugador a partir del nombre
        if jugadorAsesino then
            local nombreAsesino = getPlayerName(jugadorAsesino) -- Obtener el nombre del jugador
            for _, asesinato in ipairs(asesinatos) do
                dbExec(dbConnection, "INSERT INTO asesinatos (asesino, victima, tiempo) VALUES (?, ?, ?)", nombreAsesino, asesinato.victima, asesinato.tiempo)
            end
        else
            outputDebugString("Error: No se encontró al jugador " .. asesino)
        end
    end
end

local function cargarDatosAsesinatos()
    if not dbConnection then
        outputDebugString("Error: No se pudo conectar a la base de datos.")
        return
    end
    local query = dbQuery(dbConnection, "SELECT * FROM asesinatos")
    local result = dbPoll(query, -1)
    if type(result) == "table" then
        for _, row in ipairs(result) do
            local asesino = row.asesino
            local victima = row.victima
            local tiempo = row.tiempo
            if asesino and victima and tiempo then
                if not asesinatosPorJugador[asesino] then
                    asesinatosPorJugador[asesino] = {}
                end
                table.insert(asesinatosPorJugador[asesino], {victima = victima, tiempo = tiempo})
            end
        end
    else
        outputDebugString("Error: No se recuperaron datos de la base de datos.")
    end
    dbFree(query)
end

-- Función para registrar un asesinato de un jugador específico

local function registrarAsesinato(jugador, victima, tiempo)
    if not asesinatosPorJugador[jugador] then
        asesinatosPorJugador[jugador] = {}
    end
    table.insert(asesinatosPorJugador[jugador], {victima = victima, tiempo = tiempo})
    guardarDatosAsesinatos()
end

-- Función para obtener el tiempo transcurrido desde un asesinato

local function obtenerTiempoTranscurrido(tiempoAsesinato)
    local tiempoActual = getRealTime().timestamp
    local tiempoTranscurrido = tiempoActual - tiempoAsesinato
    local segundos = math.floor(tiempoTranscurrido % 60)
    local minutos = math.floor(tiempoTranscurrido / 60 % 60)
    local horas = math.floor(tiempoTranscurrido / (60 * 60) % 24)
    local dias = math.floor(tiempoTranscurrido / (60 * 60 * 24))
    local tiempoTranscurridoStr = ""
    if dias > 0 then
        tiempoTranscurridoStr = tiempoTranscurridoStr .. dias .. " día(s) "
    end
    if horas > 0 then
        tiempoTranscurridoStr = tiempoTranscurridoStr .. horas .. " hora(s) "
    end
    if minutos > 0 then
        tiempoTranscurridoStr = tiempoTranscurridoStr .. minutos .. " minuto(s) "
    end
    tiempoTranscurridoStr = tiempoTranscurridoStr .. segundos .. " segundo(s)"
    return tiempoTranscurridoStr
end

-- Función para limpiar la lista de asesinatos después de 24 horas

local function limpiarAsesinatos()
    local tiempoActual = getRealTime().timestamp
    for jugador, asesinatos in pairs(asesinatosPorJugador) do
        local nuevosAsesinatos = {}
        for _, asesinato in ipairs(asesinatos) do
            if tiempoActual - asesinato.tiempo < 24 * 60 * 60 then
                table.insert(nuevosAsesinatos, asesinato)
            end
        end
        asesinatosPorJugador[jugador] = nuevosAsesinatos
    end
    guardarDatosAsesinatos()
end

-- Cargar los datos de los asesinatos al iniciar el recurso

addEventHandler("onResourceStart", resourceRoot, function()
    cargarDatosAsesinatos()
    setTimer(guardarDatosAsesinatos, 24 * 60 * 60 * 1000, 0) -- Guardar datos cada 24 horas
end)

-- Función para obtener un jugador según su ID

local function getPlayerFromID(playerID)
    for i, player in ipairs(getElementsByType("player")) do
        if tonumber(getElementData(player, "ID")) == tonumber(playerID) then
            return player
        end
    end
    return nil
end

-- Comando para ver la lista de asesinatos del jugador

addCommandHandler("verasesinatos", function(player)
    -- Comprobamos si el jugador tiene permisos para usar el comando (puedes modificar esta condición según tus necesidades)
    if not hasObjectPermissionTo(player, "command.verasesinatos") then
        outputChatBox("No tienes permisos para usar este comando.", player, 255, 0, 0, true)
        return
    end
    -- Obtenemos los asesinatos del jugador
    local asesinatosJugador = asesinatosPorJugador[getPlayerName(player)]
    -- Comprobamos si el jugador tiene asesinatos registrados
    if not asesinatosJugador or #asesinatosJugador == 0 then
        outputChatBox("No tienes asesinatos registrados.", player, 255, 0, 0, true)
        return
    end
    -- Enviamos la lista de asesinatos al jugador
    outputChatBox("#FFFFFF---- #FF0000Tus Asesinatos #FFFFFF----", player, 255, 255, 255, true)
    for i, asesinato in ipairs(asesinatosJugador) do
        local tiempoTranscurridoStr = obtenerTiempoTranscurrido(asesinato.tiempo)
        outputChatBox("[" .. i .. "] #FF0000" .. asesinato.victima .. "#FFFFFF - Hace " .. tiempoTranscurridoStr, player, 255, 255, 255, true)
    end
end)

-- Comando para ver la lista de asesinatos de un jugador específico por su ID

addCommandHandler("verasesinatosid", function(player, command, targetID)
    -- Comprobamos si el jugador tiene permisos para usar el comando (puedes modificar esta condición según tus necesidades)
    if not hasObjectPermissionTo(player, "command.verasesinatosid") then
        outputChatBox("No tienes permisos para usar este comando.", player, 255, 0, 0)
        return
    end
    -- Comprobamos si se proporcionó un ID de destino
    if not targetID or targetID == "" then
        outputChatBox("Debes proporcionar el ID de un jugador.", player, 255, 0, 0, true)
        return
    end
    -- Obtenemos el jugador objetivo según el ID proporcionado
    local targetPlayer = getPlayerFromID(targetID)
    -- Comprobamos si el jugador objetivo existe
    if not targetPlayer then
        outputChatBox("No se encontró ningún jugador con ese ID.", player, 255, 0, 0, true)
        return
    end
    -- Obtenemos los asesinatos del jugador objetivo
    local asesinatosJugador = asesinatosPorJugador[getPlayerSerial(targetPlayer)]
    -- Comprobamos si el jugador objetivo tiene asesinatos registrados
    if not asesinatosJugador or #asesinatosJugador == 0 then
        outputChatBox("El jugador objetivo no tiene asesinatos registrados.", player, 255, 0, 0, true)
        return
    end
    -- Enviamos la lista de asesinatos al jugador
    outputChatBox("#FFFFFF---- #FF0000Asesinatos #FFFFFFde " .. getPlayerName(targetPlayer) .. " ----", player, 255, 255, 255, true)
    for i, asesinato in ipairs(asesinatosJugador) do
        local tiempoTranscurridoStr = obtenerTiempoTranscurrido(asesinato.tiempo)
        outputChatBox("[" .. i .. "] #FF0000" .. asesinato.victima .. "#FFFFFF - Hace " .. tiempoTranscurridoStr, player, 255, 255, 255, true)
    end
end)

-----------------------------------------------------

-- Ejemplo de uso:

addEventHandler("onPlayerWasted", root, function(_, killer)
    if source ~= killer then
        if killer then
            -- Obtener el nombre del jugador asesinado y del asesino
            local nombreAsesinado = getPlayerName(source)
            local nombreAsesino
            -- Si fuiste asesinado por algún jugador
            if ( getElementType ( killer ) == "player" ) then
                nombreAsesino = getPlayerName ( killer )
            elseif ( getElementType ( killer ) == "vehicle" ) then
            -- Si fuiste asesinado por algún vehiculo, se obtendrá el nombre del conductor
                nombreAsesino = getPlayerName ( getVehicleController ( killer ) )
            end
            -- Registrar el asesinato para el asesino
            registrarAsesinato(nombreAsesino, nombreAsesinado, getRealTime().timestamp)
            
            -- Mostrar mensaje al asesino
            outputChatBox("[☠️] #FFFFFFHas asesinado a #FF0000" .. nombreAsesinado .. ".", killer, 255, 255, 255, true)
        end
    end
end)
