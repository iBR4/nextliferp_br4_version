function position()
	local x,y,z = getElementPosition(localPlayer)
	local posString = tostring(x)..", "..tostring(y)..", "..tostring(z)
	outputChatBox(posString, 0, 255, 0)
	setClipboard(posString)
	outputChatBox("tu posicion ha sido copiada al portapapeles.", 0, 255, 0)
end
addCommandHandler("getposs",position)
