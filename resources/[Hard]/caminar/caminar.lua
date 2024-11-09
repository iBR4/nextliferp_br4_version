--------------------------------
--Author: Nassan
--Descripcion: Systema Estilos de caminar
--Espero que les sirva este script :D 
--------------------------------
--------------------------------------------------------------
function caminar1()
	setPedWalkingStyle(localPlayer,0) 
	outputChatBox("Estilo Caminar off",source)
end
addEventHandler("caminar1",resourceRoot, caminar1)
addCommandHandler ( "normal", caminar1 )
--------------------------------------------------------------
function caminar2()
	setPedWalkingStyle(localPlayer,121) 
	outputChatBox ("Estilo Caminar 2 seleccionado", source)
end
addEventHandler("caminar2",resourceRoot, caminar2)
addCommandHandler ( "estilo2", caminar2 )
--------------------------------------------------------------
function caminar3()
	setPedWalkingStyle(localPlayer,132) 
	outputChatBox ("Estilo Caminar 3 seleccionado", source)
end
addEventHandler("caminar3",resourceRoot, caminar3)
addCommandHandler ( "estilo3", caminar3 )
--------------------------------------------------------------
function caminar4()
  setPedWalkingStyle(localPlayer,138)
  outputChatBox ("Estilo caminar 4 activado.",source)
  end
  addEventHandler("caminar4",resourceRoot,caminar4)
  addCommandHandler("estilo4",caminar4)
--------------------------------------------------------------
function GetPedWalkingStyle()
    local walkingStyle = getPedWalkingStyle(localPlayer)
    outputChatBox("Estilo de caminar actual: " .. walkingStyle, source)
end
addCommandHandler("getestilo", GetPedWalkingStyle)
