addEvent( "mensajeImportante", true )
addEventHandler( "mensajeImportante", getRootElement( ),
	function( )
		setWindowFlashing( true, 5 )
	end
)
function playPmSoundc()
local pmsoundc = playSound("central.wav",false)
setSoundVolume(pmsoundca, 0.40)
end
addEvent("central",true)
addEventHandler("central",getRootElement(),playPmSoundc)
function playPmSoundc()
local pmsoundcs = playSound("beep.wav",false)
setSoundVolume(pmsoundcas, 0.40)
end
addEvent("beep",true)
addEventHandler("beep",getRootElement(),playPmSoundc)