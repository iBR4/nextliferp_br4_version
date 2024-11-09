local entrada = createMarker(643.151, -1126.675, 26.555, 'cylinder', 1.0, 0, 255, 255, 0 )


function entrar( hitElement, matchingDimension )
    if getElementType( hitElement ) == "player" and not isPedInVehicle(hitElement)    
       then
        setElementPosition(hitElement, 657.007, -1130.448, 40.992)
        end
end
addEventHandler( "onMarkerHit", entrada , entrar ) 
--------------------------------------------------
local saida = createMarker(658.547, -1128.81, 40.992, 'cylinder', 1.0, 0, 255, 255, 0 )

function sair( hitElement, matchingDimension )
    if getElementType( hitElement ) == "player" and not isPedInVehicle(hitElement)    
       then
        setElementPosition(hitElement, 646.932, -1127.085, 26.555)
        end
end
addEventHandler( "onMarkerHit", saida , sair ) 


-------------------------------------------------


