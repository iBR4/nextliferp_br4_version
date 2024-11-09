volume = { }
myShader = { }
sound = { }
jblmao = { }
function tocarmsc(thePlayer, url, x, y, z, jblmao)
	if not sound[thePlayer] then
		local x, y, z = getElementPosition(jblmao)
    	sound[thePlayer] = playSound3D(url , x, y, z)
		attachElements(sound[thePlayer], jblmao) 
	elseif sound[thePlayer] then
		stopSound(sound[thePlayer])
		local x, y, z = getElementPosition(jblmao)
    	sound[thePlayer] = playSound3D(url , x, y, z)
		attachElements(sound[thePlayer], jblmao) 
	end
end 
addEvent("tocarmsc", true)
addEventHandler("tocarmsc", root, tocarmsc)
function pararmsc(thePlayer)
	if sound[thePlayer] then
		stopSound(sound[thePlayer])
		sound[thePlayer] = nil
	end
end
addEvent("pararmsc", true)
addEventHandler("pararmsc", root, pararmsc)
	 	 	 