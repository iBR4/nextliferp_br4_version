-- by AndrixX'
addEventHandler( "onClientResourceStart", getResourceRootElement( getThisResource()),
	function()
local desusound =playSound3D("music.mp3",2737.71484375, -1759.916015625, 44.137351989746, true)
setSoundVolume(desusound,1.3)
setSoundMaxDistance(desusound, 500)
    end
	           )
