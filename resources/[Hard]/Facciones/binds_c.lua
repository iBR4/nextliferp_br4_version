function herido()
local heridoo = playSound("herido10.wav",false)
setSoundVolume(heridoo, 0.40)
end
addEvent("herido2",true)
addEventHandler("herido2",getRootElement(),herido)