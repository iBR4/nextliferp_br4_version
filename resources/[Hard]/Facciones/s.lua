addCommandHandler( "sirena",
	function( p )
		if getPlayerFaction( p, "Policia" ) then
			local veh = getPedOccupiedVehicle(p)
			if veh then
				addVehicleSirens(veh, 2, 2)
				triggerClientEvent( root, "addSirena", root, veh, p )
			if not getVehicleSirensOn ( veh ) then
			setVehicleSirensOn ( veh, true )
		else
			setVehicleSirensOn ( veh, false )
			end
		end
	end
end
)
addEventHandler( "onCharacterLogin", getRootElement(),
	function()
		bindKey( source, "horn", "down", function( p ) 
			local v = getPedOccupiedVehicle(p)
			if v and getElementModel( v ) == 525 then
				triggerClientEvent( root, "addSirena", root, v, p )
			end
		end, source )
	end
)