addEvent( "mensajeImportante", true )
addEventHandler( "mensajeImportante", getRootElement( ),
	function( )
		setWindowFlashing( true, 5 )
	end
)
function playPmSound()
local pmsound = playSound("pm.mp3",false)
setSoundVolume(pmsound, 0.10)
end
addEvent("mensajeImportante",true)
addEventHandler("mensajeImportante",getRootElement(),playPmSound)
function playPmSoundc()
local pmsoundcd = playSound("duda.ogg",false)
setSoundVolume(pmsoundcad, 0.40)
end
addEvent("duda",true)
addEventHandler("duda",getRootElement(),playPmSoundc)
function playPmSoundc()
local pmsoundcsd = playSound("reporte.ogg",false)
setSoundVolume(pmsoundcasd, 0.40)
end
addEvent("reporte",true)
addEventHandler("reporte",getRootElement(),playPmSoundc)