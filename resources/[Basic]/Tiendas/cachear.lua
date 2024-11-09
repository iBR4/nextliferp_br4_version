
local playerWeapons = {}
function getPedWeapons(ped)
	if ped and isElement(ped) and getElementType(ped) == "ped" or getElementType(ped) == "player" then
		for i=1,9 do
			local wep = getPedWeapon(ped,i)
			if wep and wep ~= 0 then
				table.insert(playerWeapons,wep)
			end
		end
	else
		return false
	end
	return playerWeapons
end
addCommandHandler( "cachear",
	function( p, cmd, otro )
			if otro then
			local other, name = exports["Gamemode"]:getFromName( p, otro )
			if other then
				local x, y, z = getElementPosition(p)
				if getDistanceBetweenPoints3D( x, y, z, unpack( { getElementPosition( other ) } ) ) < 5 and getElementDimension( other ) == getElementDimension( p ) and getElementInterior(other) == getElementInterior(p) then
					if getElementData(other, "intentoDeCachEo") then
						outputChatBox("#F06C6CEstán intentando cachear a "..otro.." esperemos que terminen de hacerlo.", p, 0,0,0, true)
					else
						setElementData(other, "intentoDeCachEo", p)
						outputChatBox("#90C2FFEstás intentando cachear a "..otro.." esperemos su respuesta.", p, 0,0,0, true)
						outputChatBox("#3A7EFF"..getPlayerName(p).." está intentado cachearte, para aceptarlo utiliza #FFFFFF/aceptarcacheo", other, 0,0,0, true)
						setTimer( function(user)
							if getElementData(user, "intentoDeCachEo") ~= false then
								setElementData(user, "intentoDeCachEo", false)
							end
						end, 10000, 1, other)
					end
				end
			else
				outputChatBox( "CMD: /"..cmd.." [id]", p, 255, 255, 255 )
			end
			else
				outputChatBox( "CMD: /"..cmd.." [id]", p, 255, 255, 255 )
			end
	end
)
addCommandHandler("aceptarcacheo", function(other)
	if getElementData(other, "intentoDeCachEo") then
		local pla = getElementData(other, "intentoDeCachEo")
		local armas = getPedWeapon( other )
		local Dinero = getPlayerMoney ( other ) 					
		MensajeRol( pla, "empieza a cachear a "..getPlayerName(other) )
		setElementData(other, "intentoDeCachEo", false)
		outputChatBox("#90C2FFHas aceptado una solicitud de cacheo", other, 255, 255, 255,true )
		outputChatBox("#3A7EFF Dinero y armas que hayas podido palpar:", pla, 255, 255, 255,true )
        outputChatBox("#3A7EFF Dinero:#87EA77 "..Dinero, pla, 255, 255, 255,true )
        if getPedWeapon( other ) then
		for i=1, 5 do 
				local v = getPedWeapon( other, i )
				local muni = getPedTotalAmmo(other,i)
				if v and v ~= 0 then
					if muni and muni ~= 0 then
				print(getWeaponNameFromID( v ))
				outputChatBox( "#F1B96B	- Has palpado un "..getWeaponNameFromID( v ).." con "..muni.." balas", pla, 255, 255, 0, true)
			end
		end
			end
		else
			outputChatBox( "#F1B96B	- No has palpado ningún arma.", pla, 255, 255, 0, true)
		end
	else
		outputChatBox("#F06C6CNadie te quiere cachear.", other, 255, 255, 255,true )
	end
end)