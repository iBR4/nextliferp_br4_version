function luta1()

    if ( getPlayerMoney (source) >= 100 ) then

    takePlayerMoney(source, 100)

	outputChatBox("#00B7FFEstilo de pelea comprado por $ #00FFBF100!",source,0,255,0,true)

    setPedFightingStyle ( source, 4 )

	else

	outputChatBox("no tienes suficiente dinero para comprar!",source,255,0,0,true)

end

end

addEvent("luta1",true) 

addEventHandler("luta1",root,luta1)

 

function luta2()

    if ( getPlayerMoney (source) >= 600 ) then

    takePlayerMoney(source, 600)

    setPedFightingStyle ( source, 5 )

	outputChatBox("#00B7FFEstilo de pelea comprado por $ #00FFBF600",source,0,255,0,true)

	else

	outputChatBox("no tienes suficiente dinero para comprar!",source,255,0,0,true)

end

end

addEvent("luta2",true) 

addEventHandler("luta2",root,luta2)



function luta3 ()

    if ( getPlayerMoney (source) >= 800 ) then

    takePlayerMoney(source, 800)

    setPedFightingStyle ( source, 6 )

	outputChatBox("#00B7FFEstilo de pelea comprado por $ #00FFBF800!",source,0,255,0,true)

	else

	outputChatBox("no tienes suficiente dinero para comprar!",source,255,0,0,true)

end

end

addEvent("luta3",true) 

addEventHandler("luta3",root,luta3)



function luta4()

    if ( getPlayerMoney (source) >= 300 ) then

    takePlayerMoney(source, 300)

    setPedFightingStyle ( source, 7 )

	outputChatBox("#00B7FFEstilo de pelea comprado por $ #00FFBF800!",source,0,255,0,true)

	else

	outputChatBox("no tienes suficiente dinero para comprar!",source,255,0,0,true)

end

end

addEvent("luta4",true) 

addEventHandler("luta4",root,luta4)





function luta5()

    if ( getPlayerMoney (source) >= 200 ) then

    takePlayerMoney(source, 200)

    setPedFightingStyle ( source, 15 )

	outputChatBox("#00B7FFEstilo de pelea comprado por $ #00FFBF800!",source,0,255,0,true)

	else

	outputChatBox("no tienes suficiente dinero para comprar!",source,255,0,0,true)

end

end

addEvent("luta5",true) 

addEventHandler("luta5",root,luta5)



function luta6 ()

    if ( getPlayerMoney (source) >= 150 ) then

    takePlayerMoney(source, 150)

    setPedFightingStyle ( source, 16 )
	
    outputChatBox("#00B7FFEstilo de pelea comprado por $ #00FFBF800!",source,0,255,0,true)

	else

	outputChatBox("no tienes suficiente dinero para comprar!",source,255,0,0,true)

end

end

addEvent("luta6",true) 

addEventHandler("luta6",root,luta6)



local markfdp = createMarker(773.13220214844, 5.3888754844666, 999.8,"cylinder",1.3,255,0,0,90)

setElementInterior(markfdp,5)

setElementDimension(markfdp,0)



function abrirtrs(source)

triggerClientEvent (source, "abrir", source)

end

addEventHandler ("onMarkerHit", markfdp, abrirtrs)

------------------------------------------------------------------



local markfd = createMarker(773.13220214844, 5.3888754844666, 1000.7802124023,"cylinder",1.3,255,0,0,90)

setElementInterior(markfd,6)

setElementDimension(markfd,0)



function abrirtrs(source)

triggerClientEvent (source, "abrir", source)

end

addEventHandler ("onMarkerHit", markfd, abrirtrs)