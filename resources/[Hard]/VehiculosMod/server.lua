local sql = dbConnect("sqlite", "togvehmod.db");
dbExec(sql, "CREATE TABLE IF NOT EXISTS VehsTogueado(accountName,TogBool)")
addEventHandler( "onResourceStart", getRootElement(), function()
  for k, v in ipairs(getElementsByType("player")) do
    local vehTog = dbPoll(dbQuery(sql, "SELECT * FROM VehsTogueado WHERE accountName = ?", getPlayerName(v)), -1)
    if vehTog[1] ~= nil then
      for key, value in ipairs(vehTog) do
        if value.TogBool == "Activado" then
          outputChatBox("#44A5CA[VEHICULOS]#9CFF97 Los vehículos modeados se han activado automáticamente. \nPara desactivarlos utiliza #FFFFFF/togvehmods", source, 0,0,0, true)
          setTimer( function(v) 
            triggerClientEvent( v, "VehModActivar", v)
          end, 500, 1, v )
        elseif value.TogBool == "Desactivado" then
          outputChatBox("#44A5CA[VEHICULOS]#F06C6C Los vehículos modeados están desactivados. \nPara activarlos utiliza #FFFFFF/togvehmods", source, 0,0,0, true)
        end
      end
    else
      setTimer( function(v) 
        triggerClientEvent( v, "VehModActivar", v)
      end, 500, 1, v)
    end
  end
end)
addEventHandler("onCharacterLogin", getRootElement(), function()
  if exports.players:isLoggedIn(source) then
    local vehTog = dbPoll(dbQuery(sql, "SELECT * FROM VehsTogueado WHERE accountName = ?", getPlayerName(source)), -1)
    if vehTog[1] ~= nil then
      for key, value in ipairs(vehTog) do
        if value.TogBool == "Activado" then
          setTimer(function(source)
            outputChatBox("#44A5CA[VEHICULOS]#9CFF97 Los vehículos modeados se han activado automáticamente. \nPara desactivarlos utiliza #FFFFFF/togvehmods", source, 0,0,0, true)
            triggerClientEvent( source, "VehModActivar", source)
          end, 5000, 1, source)
        elseif value.TogBool == "Desactivado" then
          setTimer(function(source)
            outputChatBox("#44A5CA[VEHICULOS]#F06C6C Los vehículos modeados están desactivados. \nPara activarlos utiliza #FFFFFF/togvehmods", source, 0,0,0, true)
          end, 1500, 1, source)
        end
      end
    else
      outputChatBox("#44A5CA[VEHICULOS]#9CFF97 Los vehículos modeados se han activado automáticamente. \nPara desactivarlos utiliza #FFFFFF/togvehmods", source, 0,0,0, true)
      triggerClientEvent( source, "VehModActivar", source)
    end
  end
end)
addCommandHandler("togvehmods", function(p, cmd)
    if exports.players:isLoggedIn(p) then
      local vehTog = dbPoll(dbQuery(sql, "SELECT * FROM VehsTogueado WHERE accountName = ?", getPlayerName(p)), -1)
      if vehTog[1] ~= nil then
        for key, value in ipairs(vehTog) do
          if value.TogBool == "Activado" then
            outputChatBox("#44A5CA[VEHICULOS]#F06C6C Has desactivado los vehículos modeados.", p, 0,0,0, true)
            dbExec(sql,"UPDATE VehsTogueado SET TogBool=? WHERE accountName=?", "Desactivado", getPlayerName(p))
            triggerClientEvent( p, "VehModDesactivar", p)
          elseif value.TogBool == "Desactivado" then
            outputChatBox("#44A5CA[VEHICULOS]#9CFF97 Has activado los vehículos modeados.", p, 0,0,0, true)
            dbExec(sql,"UPDATE VehsTogueado SET TogBool=? WHERE accountName=?", "Activado", getPlayerName(p))
            triggerClientEvent( p, "VehModActivar", p)
          end
        end
      else
        outputChatBox("#44A5CA[VEHICULOS]#F06C6C Has desactivado los vehículos modeados.", p, 0,0,0, true)
        dbExec(sql,"INSERT INTO VehsTogueado(accountName, TogBool) VALUES(?,?)", getPlayerName(p), "Desactivado")
        triggerClientEvent( p, "VehModDesactivar", p)
      end
    end
end)