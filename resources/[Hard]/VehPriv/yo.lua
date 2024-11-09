local antiSpamYO = {}
local antiSpamGuardarYO = {}
local valoresYo = {}
addCommandHandler( "yoveh",
	function( player, cmd, ... )
		local veh = getPedOccupiedVehicle( player )
			local texto = table.concat( {...}, " " )
			if texto then
				if #texto < 50 then
					setElementData( veh, "yo", texto )
					outputChatBox( "Yo del vehiculo actualizado", player, 0, 255, 0 )
				else
					outputChatBox( "El texto del yo no puede tener mas de 25 caracteres.", player, 255, 0, 0 )
				end
			else
				setElementData( veh, "yo", nil )
			end
		end
)
