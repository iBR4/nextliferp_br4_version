objetoCasco = {}

function colocarCasco(source)
	if isElement(objetoCasco[source]) then
		destroyElement(objetoCasco[source])
	end
    local amour = getPlayerArmor(source) 
    if amour > 0 then 
	objetoCasco[source] = createObject(10040, 0, 0, 0)
	dimensao = getElementDimension(source)
    interior = getElementInterior(source)
	setElementDimension(objetoCasco[source], dimensao)
    setElementInterior(objetoCasco[source], interior )
	setObjectScale ( objetoCasco[source], 1.25 ) 
    setElementCollisionsEnabled(objetoCasco[source],false) 
    attachElements (objetoCasco[source],source,-0.0,0.0,0.3) ; 
	exports.bone_attach:attachElementToBone(objetoCasco[source], source, 3,0,0.03,-0.001,-8,270,10,70)
	outputChatBox("", source, 255, 200, 0)
end
end
addCommandHandler("pchaleco", colocarCasco)

function removerCasco(source)
	if isElement(objetoCasco[source]) then
		destroyElement(objetoCasco[source])
		outputChatBox("", source, 255, 200, 0)
	end
end
addCommandHandler("qchaleco", removerCasco)

function destruirCasco()
	if isElement(objetoCasco[source]) then
		destroyElement(objetoCasco[source])
	end
end
addEventHandler("onPlayerQuit", root, destruirCasco)
addEventHandler("onPlayerWasted", root, destruirCasco)