local pickup = createPickup( 207.54278564453, -100.93590545654, 1005.2578125, 3, 1275, 1)
setElementInterior( pickup, 15)
setElementDimension(pickup,0)
local skinidped=0
local skinped=createPed(skinidped,216,-99,1005,90)
addEvent("onSkinMarkerHit",true)
addEventHandler("onSkinMarkerHit",getRootElement(),function()
	if not isPedInVehicle(getLocalPlayer()) then
		current = 1
		setElementFrozen(source,true)
		setElementDimension(source,1)
		setElementInterior(source,15)
		setElementDimension(skinped,1)
		setElementInterior(skinped,15)
		setCameraMatrix(210,-99,1007,216,-99,1005)
		skinbuttonvorher=guiCreateButton(0.41, 0.75, 0.02, 0.04, "<<",true)
		skinbuttonnext=guiCreateButton(0.57, 0.75, 0.02, 0.04, ">>",true)
		skinbuttonenter=guiCreateButton(0.49, 0.75, 0.07, 0.04, "Comprar skin ($30)",true)
		guiSetProperty(skinbuttonenter, "NormalTextColour", "FF1AFB03")
		skinbuttonback=guiCreateButton(0.44, 0.75, 0.04, 0.04, "Salir",true)
		guiSetProperty(skinbuttonback, "NormalTextColour", "FFFD0000")
		showCursor(true)
	end
end
)
addEventHandler("onClientGUIClick",getRootElement(),
	function (state)
		if state == "left" then
			if source == skinbuttonvorher then
            if (current > 1) then
                current = current - 1
				end	
				setElementModel(skinped,skins[current].id)
			elseif source == skinbuttonnext then
            if (current < #skins) then
                current = current + 1
				end	
				setElementModel(skinped,skins[current].id)
			elseif source == skinbuttonenter then
				local x,y,z=getElementPosition(getLocalPlayer())
				setElementPosition(getLocalPlayer(),x,y,z+0.1)
				setCameraTarget(getLocalPlayer(),getLocalPlayer())
				destroyElement(skinbuttonvorher)
				destroyElement(skinbuttonnext)
				destroyElement(skinbuttonenter)
				destroyElement(skinbuttonback)
				setElementInterior(localPlayer,15)
				setElementDimension(localPlayer,0)
				showCursor(false)
				setElementFrozen(getLocalPlayer(),false)
				triggerServerEvent("onPlayerSkinChange",getLocalPlayer(),skins[current].id)
			elseif source == skinbuttonback then
				setCameraTarget(getLocalPlayer(),getLocalPlayer())
				destroyElement(skinbuttonvorher)
				destroyElement(skinbuttonnext)
				destroyElement(skinbuttonenter)
				destroyElement(skinbuttonback)
				setElementInterior(localPlayer,15)
				setElementDimension(localPlayer,0)
				showCursor(false)
				setElementFrozen(getLocalPlayer(),false)
			end
		end
	end
)