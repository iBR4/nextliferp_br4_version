function wPanel()
        wPanel = guiCreateWindow(156, 90, 459, 343, "Panel Armas", false)
        guiWindowSetSizable(wPanel, false)

        Pistol = guiCreateButton(10, 295, 79, 28, "Pistol", false, wPanel)
        AK47 = guiCreateButton(10, 29, 79, 28, "AK47", false, wPanel)
        M4 = guiCreateButton(10, 67, 79, 28, "M4", false, wPanel)
        Minigun = guiCreateButton(10, 105, 79, 28, "Minigun", false, wPanel)
        Rocket = guiCreateButton(10, 143, 79, 28, "Rocket Launcher", false, wPanel)
        TEC9 = guiCreateButton(10, 181, 79, 28, "TEC9", false, wPanel)
        Uzi = guiCreateButton(10, 219, 79, 28, "UZI", false, wPanel)
        MP5 = guiCreateButton(10, 257, 79, 28, "MP5", false, wPanel)
        Grenade = guiCreateButton(370, 29, 79, 28, "Grenade", false, wPanel)
        Chainsaw = guiCreateButton(370, 67, 79, 28, "Chainsaw", false, wPanel)
        Shovel = guiCreateButton(370, 105, 79, 28, "Shovel", false, wPanel)
        Katana = guiCreateButton(370, 143, 79, 28, "Katana", false, wPanel)
        Spas12 = guiCreateButton(370, 181, 79, 28, "SPAS12", false, wPanel)
        Sawnoff = guiCreateButton(370, 219, 79, 28, "Sawnoff", false, wPanel)
        Molotov = guiCreateButton(370, 257, 79, 28, "Molotov", false, wPanel)
        DesertE = guiCreateButton(370, 295, 79, 28, "Desert Eagle", false, wPanel)
        Close = guiCreateButton(191, 295, 79, 28, "Close", false, wPanel)
        Infernus = guiCreateButton(170, 29, 124, 44, "Infernus", false, wPanel)
        Comet = guiCreateButton(170, 85, 124, 44, "Comet", false, wPanel)
        Hunter = guiCreateButton(170, 143, 124, 44, "Hunter", false, wPanel)
        Bullet = guiCreateButton(170, 199, 124, 44, "Bullet", false, wPanel)    
		
		showCursor( true )
		
		addEventHandler ( "onClientGUIClick", Close, Exit, false )
		addEventHandler ( "onClientGUIClick", Infernus, Infernuss, false )
		addEventHandler ( "onClientGUIClick", Comet, Comett, false )
		addEventHandler ( "onClientGUIClick", Hunter, Hunterr, false )
		addEventHandler ( "onClientGUIClick", Bullet, Bullett, false )
		addEventHandler ( "onClientGUIClick", Molotov, Molotovv, false )
		addEventHandler ( "onClientGUIClick", Pistol, Pistoll, false )
		addEventHandler ( "onClientGUIClick", AK47, AK477, false )
		addEventHandler ( "onClientGUIClick", M4, M44, false )
		addEventHandler ( "onClientGUIClick", Minigun, Minigunn, false )
		addEventHandler ( "onClientGUIClick", Rocket, Rockett, false )
		addEventHandler ( "onClientGUIClick", TEC9, TEC99, false )
		addEventHandler ( "onClientGUIClick", Uzi, Uzii, false )
		addEventHandler ( "onClientGUIClick", MP5, MP55, false )
		addEventHandler ( "onClientGUIClick", Grenade, Grenadee, false )
		addEventHandler ( "onClientGUIClick", Chainsaw, Chainsaww, false )
		addEventHandler ( "onClientGUIClick", Shovel, Shovell, false )
		addEventHandler ( "onClientGUIClick", Katana, Katanaa, false )
		addEventHandler ( "onClientGUIClick", Spas12, Spas122, false )
		addEventHandler ( "onClientGUIClick", Sawnoff, Sawnofff, false )
		addEventHandler ( "onClientGUIClick", DesertE, DesertEE, false )
end
addCommandHandler ( "abuelatrolita", wPanel )
function Exit()

guiSetVisible (wPanel, not guiGetVisible ( wPanel ) )
showCursor( false )

end

function Infernuss()
Player = getLocalPlayer()
x,y,z = getElementPosition(Player)
createVehicle ( 411, x+ 2, y, z + 2 )
end

function Bullett()
Player = getLocalPlayer()
x,y,z = getElementPosition(Player)
createVehicle ( 541, x+ 2, y, z + 2 )
end

function Comett()
Player = getLocalPlayer()
x,y,z = getElementPosition(Player)
createVehicle ( 480, x+ 2, y, z + 2 )
end

function Hunterr()
Player = getLocalPlayer()
x,y,z = getElementPosition(Player)
createVehicle ( 425, x+ 2, y, z + 2 )
end

function Molotovv()
    triggerServerEvent ( "onMolotovvv", getLocalPlayer() )
end

function Pistoll()
    triggerServerEvent ( "onPistolll", getLocalPlayer() )
end

function AK477()
    triggerServerEvent ( "onAK4777", getLocalPlayer() )
end

function M44()
    triggerServerEvent ( "onM444", getLocalPlayer() )
end

function Minigunn()
    triggerServerEvent ( "onMinigunnn", getLocalPlayer() )
end

function Rockett()
    triggerServerEvent ( "onRockettt", getLocalPlayer() )
end

function TEC99()
    triggerServerEvent ( "onTEC999", getLocalPlayer() )
end

function Uzii()
    triggerServerEvent ( "onUziii", getLocalPlayer() )
end

function MP55()
    triggerServerEvent ( "onMP555", getLocalPlayer() )
end

function Grenadee()
    triggerServerEvent ( "onGrenadeee", getLocalPlayer() )
end

function Chainsaww()
    triggerServerEvent ( "onChainsawww", getLocalPlayer() )
end

function Shovell()
    triggerServerEvent ( "onShovelll", getLocalPlayer() )
end

function Katanaa()
    triggerServerEvent ( "onKatanaaa", getLocalPlayer() )
end

function Spas122()
    triggerServerEvent ( "onSpas1222", getLocalPlayer() )
end

function Sawnofff()
    triggerServerEvent ( "onSawnoffff", getLocalPlayer() )
end

function DesertEE()
    triggerServerEvent ( "onDesertEEE", getLocalPlayer() )
end