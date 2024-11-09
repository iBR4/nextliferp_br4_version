local pickup = createPickup( 204.41316223145, -159.93218994141, 1000.5234375, 3, 1275, 1)
setElementInterior( pickup, 14)
setElementDimension(pickup,0)
local skinidpedd=0
local skinpedd=createPed(skinidpedd,214.6764831543, -156.1540222168, 1000.5234375,95)
addEvent("onSkinnMarkerHit",true)
addEventHandler("onSkinnMarkerHit",getRootElement(),function()
	if not isPedInVehicle(getLocalPlayer()) then
		current = 1
		setElementFrozen(source,true)
		setElementDimension(source,2)
		setElementInterior(source,14)
		setElementDimension(skinpedd,2)
		setElementInterior(skinpedd,14)
		setCameraMatrix(208, -155.7, 1001,500, -180, 1000,0,50)
		skinbuttonvorherr=guiCreateButton(0.41, 0.75, 0.02, 0.04, "<<",true)
		
		skinbuttonnextt=guiCreateButton(0.57, 0.75, 0.02, 0.04, ">>",true)
		
		skinbuttonenterr=guiCreateButton(0.49, 0.75, 0.07, 0.04, "Comprar skin ($30)",true)
		guiSetProperty(skinbuttonenterr, "NormalTextColour", "FF1AFB03")
		
		skinbuttonbackk=guiCreateButton(0.44, 0.75, 0.04, 0.04, "Salir",true)
		guiSetProperty(skinbuttonbackk, "NormalTextColour", "FFFD0000")
		
		showCursor(true)
	end
end
)
addEventHandler("onClientGUIClick",getRootElement(),
	function (state)
		if state == "left" then
			if source == skinbuttonvorherr then
            if (current > 1) then
                current = current - 1
				end	
				setElementModel(skinpedd,skins[current].id)
			elseif source == skinbuttonnextt then
            if (current < #skins) then
                current = current + 1
				end	
				setElementModel(skinpedd,skins[current].id)
			elseif source == skinbuttonenterr then
				local x,y,z=getElementPosition(getLocalPlayer())
				setElementPosition(getLocalPlayer(),x,y,z+0.1)
				setCameraTarget(getLocalPlayer(),getLocalPlayer())
				destroyElement(skinbuttonvorherr)
				destroyElement(skinbuttonnextt)
				destroyElement(skinbuttonenterr)
				destroyElement(skinbuttonbackk)
				setElementInterior(localPlayer,14)
				setElementDimension(localPlayer,0)
				showCursor(false)
				setElementFrozen(getLocalPlayer(),false)
				triggerServerEvent("onPlayerSkinnChange",getLocalPlayer(),skins[current].id)
			elseif source == skinbuttonbackk then
				setCameraTarget(getLocalPlayer(),getLocalPlayer())
				destroyElement(skinbuttonvorherr)
				destroyElement(skinbuttonnextt)
				destroyElement(skinbuttonenterr)
				destroyElement(skinbuttonbackk)
				setElementInterior(localPlayer,14)
				setElementDimension(localPlayer,0)
				showCursor(false)
				setElementFrozen(getLocalPlayer(),false)
			end
		end
	end
)