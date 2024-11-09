speakerdb = dbConnect("sqlite", "speaker.db" )

speakers = { }
blips = { }

function speakercommand(thePlayer)
    triggerClientEvent (thePlayer, "speaker.openSpeakerGUI", thePlayer, isSpeaker )
end
addCommandHandler("parlante", speakercommand)

function placeSpeaker(url, inCar, dist)
    local plr = getPlayerName(source)
    if (url) then
        if (isElement (speakers [ source ] ) ) then
            local x, y, z = getElementPosition (speakers [ source ] )
            local zone = getZoneName (x, y, z, false)
            outputChatBox("Quitaste tu viejo parlante en "..zone, source, 0, 255, 0 )
            destroyElement (speakers [ source ] )
            removeEventHandler ("onPlayerQuit", source, destroySpeakersOnPlayerQuit )
            local playerName = getPlayerName(source)
            --dbExec(speakerdb, "DELETE FROM speakers WHERE owner = ?", playerName)
        end
            local x, y, z = getElementPosition(source)
            local rx, ry, rz = getElementRotation(source)
            speakers [ source ] = createObject(2229, x-0.5, y+0.5, z - 1, 0, 0, rx)
            outputChatBox("Parlante colocado en: "..math.floor (x)..", "..math.floor (y)..", "..math.floor (z).."", source, 0, 255, 255)
            setElementInterior(speakers [ source ], getElementInterior(source))
            setElementDimension(speakers [ source ], getElementDimension(source))
            setElementData(speakers [ source ], "speakerUrl", url)
            setElementData(speakers [ source ], "speakerInCar", false)
            setElementData(speakers [ source ], "speakerDistance", dist)
            setElementData(speakers [ source ], "speakerPlacer", source)
            addEventHandler("onPlayerQuit", source, destroySpeakersOnPlayerQuit )
            triggerClientEvent(root, "speaker.StartMusic", root, source, url, inCar, dist)
            local playerName = getPlayerName(source)
            --dbExec(speakerdb, "INSERT INTO speakers(distance, attached, owner, x, y, z, url) VALUES(?, ?, ?, ?, ?, ?, ?)", dist, inCar, playerName, x, y, z, url)
        if (inCar ) then
            local car = getPedOccupiedVehicle(source)
            local carname =  getVehicleName(car )
                setElementData(speakers [ source ], "speakerInCar", true)
                attachElements(speakers [ source ], car, -0.7, -1.5, -0.5, 0, 90, 0 )
                outputChatBox("Parlante colocado en: "..math.floor (x )..", "..math.floor (y )..", "..math.floor (z ).." (Anclado en "..carname..")", source, 0, 255, 255)    
        end
    end
end
addEvent ("speaker.PlaceSpeaker", true)
addEventHandler ("speaker.PlaceSpeaker", root, placeSpeaker)


function removeSpeaker()
    if (isElement(speakers [ source ])) then
        local x, y, z = getElementPosition(speakers [ source ])
        local zone = getZoneName(x, y, z, false)
        outputChatBox("Se ha quitado tu parlante", source, 255, 0, 0)
        destroyElement(speakers [ source ])
        triggerClientEvent("speaker.destroySpeaker", root, source)
        removeEventHandler("onPlayerQuit", source, destroySpeakersOnPlayerQuit)
        local playerName = getPlayerName(source)
        --(speakerdb, "DELETE FROM speakers WHERE owner = ?", playerName)
    else
        outputChatBox("¡No tienes un parlante!", source, 255, 0, 0)
    end
end
addEvent ("speaker.RemoveSpeaker", true )
addEventHandler ("speaker.RemoveSpeaker", root, removeSpeaker)


function destroySpeakersOnPlayerQuit ()
    if (isElement (speakers [ source ] ) ) then
        destroyElement (speakers [ source ] )
        triggerClientEvent("speaker.destroySpeaker", root, source )
        local playerName = getPlayerName(source)
        --dbExec(speakerdb, "DELETE FROM speakers WHERE owner = ?", playerName)
    end
    if (isElement (marker [ source ] ) ) then
        destroyElement(marker [ source ] )
    end
    if (isElement (blips [ source ] ) ) then
        destroyElement(blips [ source ] )
    end
end


function addSong(name, link, player)
    local player2 = getPlayerName(player)
    dbExec(speakerdb, "INSERT INTO songs(name, link, addedby) VALUES(?, ?, ?)", name, link, player2)
    triggerClientEvent("speaker.addSong", root, name, link)  
end
addEvent("speaker.addSongDB", true)
addEventHandler("speaker.addSongDB", root, addSong)


function addRadio(name, link, player)
    local player2 = getPlayerName(player)
    dbExec(speakerdb, "INSERT INTO radios(name, link, addedby) VALUES(?, ?, ?)", name, link, player2)
    triggerClientEvent("speaker.addRadio", root, name, link)   
end
addEvent("speaker.addRadioDB", true)
addEventHandler("speaker.addRadioDB", root, addRadio)

function startSpeakerOnLogin(player)
    local qh = dbQuery(speakerdb, "SELECT * FROM speakers")
    local stuff = dbPoll(qh, -1)

    for ind, ent in pairs(stuff) do
    local qh2, distance, attached, owner, x, y, z, url = dbQuery(speakerdb, {ent.distance, ent.attached, ent.owner, ent.x, ent.y, ent.z, ent.url}, "SELECT * FROM speakers")
    end
    local PS = dbPoll(qh2, -1)

    local theOwner = getPlayerFromName(owner)
    triggerClientEvent("speaker.StartMusic", player, theOwner, url, attached)
end

function startUp(player)
        dbQuery(startUp2, speakerdb, "SELECT * FROM songs")
        dbQuery(startUp3, speakerdb, "SELECT * FROM radios")
end
addEventHandler("onResourceStart", resourceRoot, startUp)
addEventHandler("onPlayerLogin", root, startUp)

function startUp2(qh)
    local stuff = dbPoll(qh, 0)
    for ind, ent in pairs(stuff) do
        dbQuery(songs, {ent.name, ent.link, ent.addedby}, speakerdb, "SELECT * FROM songs")
    end
end


function startUp3(qh)
    local stuff = dbPoll(qh, 0)
    for ind, ent in pairs(stuff) do
        dbQuery(radios, {ent.name, ent.link, ent.addedby}, speakerdb, "SELECT * FROM radios")
    end
end


function startUp4(player, stuff)
    for ind, ent in pairs(stuff) do
        local qh, attached, owner, x, y, z, url = dbQuery(speakerStart, {ent.attached, ent.owner, ent.x, ent.y, ent.z, ent.url}, speakerdb, "SELECT * FROM speakers")
    end
    local PS = dbPoll(qh, 0)
    speakerStart(player, PS, attached, owner, x, y, z, url)
end



function songs(qh, name, link, addedby)
    local PS = dbPoll(qh, 0)
    setTimer(function ()
        triggerClientEvent("speaker.onStartUp", root, name, link)
    end, 2000, 1)
end


function radios(qh, name, link, addedby)
    local PS = dbPoll(qh, 0)
    setTimer(function ()
        triggerClientEvent("speaker.onStartUp2", root, name, link)
    end, 2000, 1)
end


function speakerStart(player, PS, attached, owner, x, y, z, url)
    local theOwner = getPlayerFromName(owner)
        triggerClientEvent("speaker.StartMusic", player, theOwner, url, attached)
end


function deleteRadio(name, row, p)
    dbExec(speakerdb, "DELETE FROM radios WHERE name=?", name)
    triggerClientEvent(root, "speaker.removeRowRadio", root, row)
end
addEvent("speaker.deleteRadio", true)
addEventHandler("speaker.deleteRadio", root, deleteRadio)


function deleteRadio(name, row, p)
    dbExec(speakerdb, "DELETE FROM songs WHERE name=?", name)
    triggerClientEvent(root, "speaker.removeRowSong", root, row)
end
addEvent("speaker.deleteSong", true)
addEventHandler("speaker.deleteSong", root, deleteRadio)


function destroySpeakerOnDestroy()
  if getElementType(source) == "vehicle" then
    local occupant = getVehicleOccupant(source, 0)
      if occupant then
        if not (speakers[occupant]) or not (isElement(speakers[occupant])) then return end
        if (isElementAttached (speakers [ occupant ] ) ) then
            destroyElement (speakers [ occupant ] )
            triggerClientEvent (root, "speaker.destroySpeaker", root, occupant )
            end
        end
    end
end
addEventHandler("onElementDestroy", root, destroySpeakerOnDestroy)

function placeSpeakerOnLogin()
    for i, v in pairs(speakers) do
        if (isElement(v)) then
            local x, y, z = getElementPosition(v)
            local url = getElementData(v, "speakerUrl")
            local inCar = getElementData(v, "speakerInCar")
            local distance = getElementData(v, "speakerDistance")
            local placer = getElementData(v, "speakerPlacer")
            triggerClientEvent("speaker.StartSoundOnLogin", source, source, x, y, z, url, inCar, distance, placer, v)
        end
    end    
end
addEventHandler("onPlayerLogin", root, placeSpeakerOnLogin)
