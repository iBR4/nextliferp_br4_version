local entrada = createMarker(640.769, -1145.61, 37.999, 'cylinder', 1.0, 0, 255, 255, 0 )


function entrar( hitElement, matchingDimension )
    if getElementType( hitElement ) == "player" and not isPedInVehicle(hitElement)    
       then
        setElementPosition(hitElement, 656.734, -1131.244, 40.992)
        end
end
addEventHandler( "onMarkerHit", entrada , entrar ) 
--------------------------------------------------
local saida = createMarker(655.335, -1132.786, 40.992, 'cylinder', 1.0, 0, 255, 255, 0 )

function sair( hitElement, matchingDimension )
    if getElementType( hitElement ) == "player" and not isPedInVehicle(hitElement)    
       then
        setElementPosition(hitElement, 642.862, -1148.765, 37.651)
        end
end
addEventHandler( "onMarkerHit", saida , sair ) 


-------------------------------------------------
