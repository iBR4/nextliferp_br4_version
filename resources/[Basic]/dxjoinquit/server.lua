function showText(message, sendtO)
	if not (message and type(message) == "string") then error("Bad argument @ 'showText' [Expected player at argument 1, got "..type(message).."]") return false end
	if not (sendtO) and (isElement(sendtO)) then error("Bad argument @ 'showText' [Expected player at argument 2, got "..type(sendtO).."]") return false end
	return triggerClientEvent(sendtO, "onClientShowText", root, message)
end