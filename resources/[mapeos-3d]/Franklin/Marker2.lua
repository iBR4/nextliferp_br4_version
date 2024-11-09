local entrada = createMarker(656.952, -1134.156, 40.593, 'cylinder', 1.0, 0, 255, 255, 0 )


function entrar( hitElement, matchingDimension )
    if getElementType( hitElement ) == "player" and not isPedInVehicle(hitElement)    
       then
        setElementPosition(hitElement, 653.969, -1124.192, 48.665)
        end
end
addEventHandler( "onMarkerHit", entrada , entrar ) 
--------------------------------------------------
local saida = createMarker(655.875, -1122.387, 48.665, 'cylinder', 1.0, 0, 255, 255, 0 )

function sair( hitElement, matchingDimension )
    if getElementType( hitElement ) == "player" and not isPedInVehicle(hitElement)    
       then
        setElementPosition(hitElement, 659.104, -1135.934, 40.593)
        end
end
addEventHandler( "onMarkerHit", saida , sair ) 


-------------------------------------------------


