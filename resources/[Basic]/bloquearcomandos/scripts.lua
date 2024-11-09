-- Script bloqueador de comandos


comandos = {
["logout"] = true
,["login"] = true
,["register"] = true
}

--
 
addEventHandler("onPlayerCommand", getRootElement(),
function(cmd)
    if ( comandos[cmd] ) then
         outputChatBox ( "Este comando se encuentra bloqueado.", source, 255, 255, 0)
        cancelEvent()
    end
end)