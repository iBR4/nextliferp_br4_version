function giveMoneyToAllPlayers(thePlayer, cmd, amount)
    if not amount or tonumber(amount) == nil then
        outputChatBox("Uso: /todasputas <cantidad>", thePlayer)
        return
    end
    
    local amount = tonumber(amount)
    local playerCount = 0
    
    for _, player in ipairs(getElementsByType("player")) do
        givePlayerMoney(player, amount)
        playerCount = playerCount + 1
    end
    
    if playerCount > 0 then
        outputChatBox("#FFFFFF[#FF9B13Next Life#FFFFFF] #FFFFFFEl Samaritano de #00FC2A" .. getPlayerName(thePlayer) .. " #FFFFFFha regalado #00FC2A$" .. amount .. " #FFFFFFa todos ;)", thePlayer, 255, 255, 255, true)
    else
        outputChatBox("No se regaló dinero a ningún jugador.", thePlayer)
    end
end
addCommandHandler("todasputas", giveMoneyToAllPlayers)
