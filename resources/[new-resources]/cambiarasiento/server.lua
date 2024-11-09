local asientos = {
    [0] = 1,
    [1] = 0,
    [2] = 3,
    [3] = 2
}

local sobrenombres = {
    [0] = "conductor",
    [1] = "copiloto",
    [2] = "trasero izquierdo",
    [3] = "trasero derecho"
}

local congelacion = {}
local cooldownTime = 5000  -- Tiempo en milisegundos antes de que el comando pueda ejecutarse nuevamente
local enProceso = {}

function cambiarasiento(player)
    local tiempoActual = getTickCount()
    local ultimaEjecucion = congelacion[player] or 0

    if tiempoActual - ultimaEjecucion < cooldownTime then
        outputChatBox("#FFFFFF[#01B90EAsiento#FFFFFF] #FFCD00No ejecutes el mismo comando muchas veces.", player, 255, 0, 0, true)
        return
    end

    local vehiculo = getPedOccupiedVehicle(player)
    if not vehiculo then
        outputChatBox("#FFFFFF[#01B90EAsiento#FFFFFF] #FFCD00Te has bajado del vehículo. Se cancela la acción.", player, 255, 0, 0, true)
        congelacion[player] = 0  -- Restablecer el tiempo de la última ejecución
        return
    end

    local asiento = getPedOccupiedVehicleSeat(player)
    local asientopuesto = asientos[asiento]


    if not asientopuesto then
        outputChatBox("#FFFFFF[#01B90EAsiento#FFFFFF] #FFCD00Te has bajado del vehículo. Se cancela la acción.", player, 255, 0, 0, true)
        congelacion[player] = 0  -- Restablecer el tiempo de la última ejecución
        return
    end

    if enProceso[player] then
        outputChatBox("#FFFFFF[#01B90EAsiento#FFFFFF] #FFCD00Ya hay un cambio de asiento en proceso.", player, 255, 0, 0, true)
        return
    end

    enProceso[player] = true

    if asientopuesto ~= nil then
        local vehicle = getPedOccupiedVehicle(player)
        local ocupado = getVehicleOccupant(vehicle, asientopuesto)

        local tipodeveh = getVehicleType(vehicle)
        if tipodeveh == "Helicopter" or tipodeveh == "Plane" then
            outputChatBox("No puedes cambiar de asiento en una aeronave!", player, 255, 0, 0)
            return
        end

        local asientosmax = getVehicleMaxPassengers(vehicle) + 1
        if asientosmax == 1 then
            outputChatBox("Este vehículo solo tiene un asiento disponible.", player, 255, 0, 0)
            return
        end

        if ocupado and isElement(ocupado) then
            outputChatBox("#FFFFFF[#01B90EAsiento#FFFFFF] #FFCD00¡El asiento del " .. sobrenombres[asientopuesto] .. " está ocupado!", player, 255, 0, 0, true)
            return
        end

        local tiempo = getTickCount()
        local ultimouso = congelacion[player] or 0
        local tiempoantes = math.max(0, (ultimouso + 5000) - tiempo)

        if tiempoantes > 0 then
            outputChatBox("#FFFFFF[#01B90EAsiento#FFFFFF] #FFCD00Debes esperar " .. math.ceil(tiempoantes / 5000) .. " segundos para cambiar de asiento.", player, 255, 0, 0, true)
            return
        end

        outputChatBox("#FFFFFF[#01B90EAsiento#FFFFFF] #FFCD00Cambiando de asiento...", player, 255, 255, 0, true)

        setTimer(function()
            warpPedIntoVehicle(player, vehicle, asientopuesto)
            outputChatBox("#FFFFFF[#01B90EAsiento#FFFFFF] #FFFFFFTe cambiaste al asiento del " .. sobrenombres[asientopuesto], player, 0, 255, 0, true)
            outputChatBox(getPlayerName(player) .. " se cambió al asiento del " .. sobrenombres[asientopuesto], vehicle, 0, 255, 0)
            exports['MySQL']:MensajeRol(player, " se cambió al asiento del " .. sobrenombres[asientopuesto])
            exports['Notificaciones']:setTextNoti(player, "Te cambiaste de " .. sobrenombres[asientopuesto])
            congelacion[player] = getTickCount()
        end, 3000, 1)
    else
        outputChatBox("#FFFFFF[#01B90EAsiento#FFFFFF] #FFCD00Necesitas estar arriba de un vehiculo.", player, 255, 0, 0, true)
    end

    -- Deshabilitar temporalmente el comando durante el tiempo de enfriamiento
    congelacion[player] = tiempoActual

    setTimer(function()
        congelacion[player] = 0  -- Restablecer el tiempo de la última ejecución
        enProceso[player] = false  -- Permitir futuros cambios de asiento
    end, cooldownTime, 1)
end

addCommandHandler("cambiarasiento", cambiarasiento)


addEventHandler("onVehicleExit", root, function(player, seat)
    if seat == 0 then
        -- Cancelar la acción si el jugador se baja del asiento del conductor
        if congelacion[player] then
            outputChatBox("#FFFFFF[#01B90EAsiento#FFFFFF] #FFCD00Te has bajado del vehículo. Se cancela la acción.", player, 255, 0, 0, true)
            enProceso[player] = false  -- Permitir futuros cambios de asiento
            congelacion[player] = 0  -- Restablecer el tiempo de la última ejecución
        end
    end
end)