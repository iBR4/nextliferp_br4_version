------------------------------------------
-- Author: estilogta						--
-- Name: soundTraducido 2.0				--
-- File: server.lua						--
-- Copyright 2013 ( C ) Braydon Davis	--
------------------------------------------

local isSpeaker = false

function print ( player, message, r, g, b )
	outputChatBox ( message, player, r, g, b )
end

speakerBox = { }
addCommandHandler ( "estereo", function ( thePlayer  )
	if isPedInVehicle( thePlayer ) then
		if ( isElement ( speakerBox [ thePlayer] ) ) then isSpeaker = true end
		triggerClientEvent ( thePlayer, "onPlayerViewSpeakerManagment", thePlayer, isSpeaker )
	else
		print ( source, "", 255,0,0)
	end
end )

addEvent ( "onPlayerPlaceSpeakerBox", true )
addEventHandler ( "onPlayerPlaceSpeakerBox", root, function ( url, isCar ) 
	if ( isCar ) then
	if ( url ) then
		if ( isElement ( speakerBox [ source ] ) ) then
			local x, y, z = getElementPosition ( speakerBox [ source ] ) 
			print ( source, "Se ha detenido la reproducción." )
			destroyElement ( speakerBox [ source ] )
			removeEventHandler ( "onPlayerQuit", source, destroySpeakersOnPlayerQuit )
		end
		local x, y, z = getElementPosition ( source )
		local rx, ry, rz = getElementRotation ( source )
		speakerBox [ source ] = createObject ( 2229, x-0.5, y+0.5, z - 1, 0, 0, rx )
		setObjectScale( speakerBox [ source ], 0.1 )
		setElementAlpha( speakerBox [ source ], 0 )
		setElementCollisionsEnabled( speakerBox [ source ], true )
		print ( source, "Estás reproduciendo algo en la radio." )
		addEventHandler ( "onPlayerQuit", source, destroySpeakersOnPlayerQuit )
		triggerClientEvent ( root, "onPlayerStartSpeakerBoxSound", root, source, url, isCar )
			local car = getPedOccupiedVehicle ( source )
			attachElements ( speakerBox [ source ], car, -0.7, -1.5, -0.5, 0, 90, 0 )
		end
	end
end )

addEvent ( "onPlayerDestroySpeakerBox", true )
addEventHandler ( "onPlayerDestroySpeakerBox", root, function ( )
	if ( isElement ( speakerBox [ source ] ) ) then
		destroyElement ( speakerBox [ source ] )
		triggerClientEvent ( root, "onPlayerDestroySpeakerBox", root, source )
		removeEventHandler ( "onPlayerQuit", source, destroySpeakersOnPlayerQuit )
		print ( source, "Parlante quitado.", 255, 0, 0 )
	else
		print ( source, "El parlante ya ha sido quitado.", 255, 255, 0 )
	end
end )

addEvent ( "onPlayerChangeSpeakerBoxVolume", true ) 
addEventHandler ( "onPlayerChangeSpeakerBoxVolume", root, function ( to )
	triggerClientEvent ( root, "onPlayerChangeSpeakerBoxVolumeC", root, source, to )
end )

function destroySpeakersOnPlayerQuit ( )
	if ( isElement ( speakerBox [ source ] ) ) then
		destroyElement ( speakerBox [ source ] )
		triggerClientEvent ( root, "onPlayerDestroySpeakerBox", root, source )
	end
end