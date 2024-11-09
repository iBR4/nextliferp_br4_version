function antiBlur () 
	for k,players in ipairs(getElementsByType("player") )do
	setPlayerBlurLevel(players,0) 
	end 
end 
	addEventHandler("onResourceStart",root,antiBlur) 
addEventHandler("onPlayerJoin",root,antiBlur) 
  