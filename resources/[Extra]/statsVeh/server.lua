function loadHandling(v)		
			 -- Police LV --> 
			 if getElementModel(v) == 400 then
				setVehicleHandling(v, "mass", 2000)
				setVehicleHandling(v, "turnMass", 3500)
				setVehicleHandling(v, "dragCoeff", 1.8)
				setVehicleHandling(v, "centerOfMass", { 0, 35, -0.45 } )
				setVehicleHandling(v, "percentSubmerged", 75)
				setVehicleHandling(v, "tractionMultiplier", 0.9)
				setVehicleHandling(v, "tractioznLoss", 1)
				setVehicleHandling(v, "tractionBias", 0.497)
				setVehicleHandling(v, "numberOfGears", 5)
				setVehicleHandling(v, "maxVelocity", 203)
				setVehicleHandling(v, "engineAcceleration", 12)
				setVehicleHandling(v, "engineInertia", 28)
				setVehicleHandling(v, "driveType", "awd") 
				setVehicleHandling(v, "engineType", "petrol")
				setVehicleHandling(v, "brakeDeceleration", 50)
				setVehicleHandling(v, "ABS", false)
				setVehicleHandling(v, "steeringLock", 35)
				setVehicleHandling(v, "suspensionForceLevel", 2.0)
				setVehicleHandling(v, "suspensionDamping", 0.5)
				setVehicleHandling(v, "suspensionHighSpeedDamping", 0.1)
				setVehicleHandling(v, "suspensionUpperLimit", 0.4)
				setVehicleHandling(v, "suspensionLowerLimit", -0.1)
				setVehicleHandling(v, "suspensionFrontRearBias", 0.55)
				setVehicleHandling(v, "suspensionAntiDiveMultiplier", 0.5)
				setVehicleHandling(v, "seatOffsetDistance", 0.2)
				setVehicleHandling(v, "collisionDamageMultiplier", 0.20)
				setVehicleHandling(v, "monetary", 25000)
				setVehicleHandling(v, "modelFlags", 0x40000001)
				setVehicleHandling(v, "handlingFlags", 0x10308803)
				setVehicleHandling(v, "headLight", 0)
				setVehicleHandling(v, "tailLight", 1)
				setVehicleHandling(v, "animGroup", 0)
			end	
			
			if getElementModel(v) == 404 then
				setVehicleHandling(v, "numberOfGears", 5)
				setVehicleHandling(v, "maxVelocity", 160)
				setVehicleHandling(v, "engineAcceleration", 27)
				setVehicleHandling(v, "engineInertia", 120)
				setVehicleHandling(v, "driveType", "fwd") -- delantera
				setVehicleHandling(v, "engineType", "petrol")
			end

			if getElementModel(v) == 405 then
				setVehicleHandling(v, "numberOfGears", 5)
				setVehicleHandling(v, "maxVelocity", 205)
				setVehicleHandling(v, "engineAcceleration", 30)
				setVehicleHandling(v, "engineInertia", 120)
				setVehicleHandling(v, "driveType", "awd") -- trasera
				setVehicleHandling(v, "engineType", "petrol")
			end			
			 
			if getElementModel(v) == 426 then
				setVehicleHandling(v, "numberOfGears", 5)
				setVehicleHandling(v, "maxVelocity", 190)
				setVehicleHandling(v, "engineAcceleration", 12)
				setVehicleHandling(v, "engineInertia", 28)
				setVehicleHandling(v, "driveType", "awd") 
				setVehicleHandling(v, "engineType", "petrol")
			end

			if getElementModel(v) == 20003 then
				setVehicleHandling(v, "numberOfGears", 5)
				setVehicleHandling(v, "maxVelocity", 250)
				setVehicleHandling(v, "engineAcceleration", 12)
				setVehicleHandling(v, "engineInertia", 28)
				setVehicleHandling(v, "driveType", "awd") 
				setVehicleHandling(v, "engineType", "petrol")
			end

			if getElementModel(v) == 547 then
				setVehicleHandling(v, "numberOfGears", 5)
				setVehicleHandling(v, "maxVelocity", 205)
				setVehicleHandling(v, "engineAcceleration", 17)
				setVehicleHandling(v, "engineInertia", 28)
				setVehicleHandling(v, "driveType", "rwd") 
				setVehicleHandling(v, "engineType", "petrol")
			end	
			 
			if getElementModel(v) == 445 then
				setVehicleHandling(v, "numberOfGears", 5)
				setVehicleHandling(v, "maxVelocity", 200)
				setVehicleHandling(v, "engineAcceleration", 15)
				setVehicleHandling(v, "engineInertia", 28)
				setVehicleHandling(v, "driveType", "rwd") 
				setVehicleHandling(v, "engineType", "petrol")
			end	
			 
			if getElementModel(v) == 579 then
				setVehicleHandling(v, "numberOfGears", 5)
				setVehicleHandling(v, "maxVelocity", 190)
				setVehicleHandling(v, "engineAcceleration", 16)
				setVehicleHandling(v, "engineInertia", 28)
				setVehicleHandling(v, "driveType", "awd")
				setVehicleHandling(v, "engineType", "petrol")
			end			
	
			if getElementModel(v) == 546 then
				setVehicleHandling(v, "numberOfGears", 5)
				setVehicleHandling(v, "maxVelocity", 195)
				setVehicleHandling(v, "engineAcceleration", 40)
				setVehicleHandling(v, "engineInertia", 28)
				setVehicleHandling(v, "driveType", "rwd") 
				setVehicleHandling(v, "engineType", "petrol")
			end
			 
end

function loadHandlings()
	for k, v in ipairs(getElementsByType("vehicle")) do
		loadHandling(v)
	end
end
addEventHandler("onResourceStart", getResourceRootElement(getThisResource()), loadHandlings)

function vehicleEnter()
	loadHandling(source)
end
addEventHandler("onVehicleEnter", getRootElement(), vehicleEnter)

