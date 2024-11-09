function playPmSoundc1()
    local pmsoundcd = playSound("ticket.mp3", false)
    if pmsoundcd then
        setSoundVolume(pmsoundcd, 0.40)
    end
end
addEvent("nuevoxp", true)
addEventHandler("nuevoxp", root, playPmSoundc1)  -- Cambié "getRootElement()" a "root"
function playPmSoundc2()
    local pmsoundcsd = playSound("lvlup.mp3", false)
    if pmsoundcsd then
        setSoundVolume(pmsoundcsd, 0.40)
    end
end
addEvent("nuevonivel", true)
addEventHandler("nuevonivel", root, playPmSoundc2)  -- Cambié "getRootElement()" a "root"
