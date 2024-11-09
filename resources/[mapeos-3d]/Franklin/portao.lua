objeto0000010000portao = createObject (  976, 625.79998779297, -1118.5 , 45.299999237061, 0, 0, 34 )
x,y,z = getElementPosition (objeto0000010000portao)
Zona0000010000detran = createColCircle ( x,y, 7, 7 )

function abrirdetran00000010000 (player)
    local accName = getAccountName ( getPlayerAccount ( player ) ) 
        if isObjectInACLGroup ("user."..accName, aclGetGroup ( "Admin" ) ) then
        moveObject ( objeto0000010000portao,  500, 625.79998779297, -1118.5, 42.5)
    else
end
end
addEventHandler ( "onColShapeHit", Zona0000010000detran, abrirdetran00000010000 )

function fechardetran00000010000 (player)
moveObject ( objeto0000010000portao, 500, 625.79998779297, -1118.5 , 45.299999237061 )
end
addEventHandler ( "onColShapeLeave", Zona0000010000detran, fechardetran00000010000 )



------------------------------------------------------------------------------------------

