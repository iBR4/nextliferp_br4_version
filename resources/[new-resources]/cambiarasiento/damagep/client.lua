function pantallaroja(attacker, weapon, bodypart, loss)
    if attacker and attacker ~= source then
        setPlayerHudComponentColor(source, "radar", 255, 0, 0, 200)
        setTimer(volvernormal, 500, 1, source)
    end
end
addEventHandler("onPlayerDamage", root, pantallaroja)

function volvernormal(player)
    setPlayerHudComponentColor(player, "radar", 255, 255, 255, 255)
end
