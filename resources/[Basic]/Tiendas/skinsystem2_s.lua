skinmtabb={}
skinmtabb[2]={204.41316223145, -159.93218994141, 1000.5234375}
function skinmarkererstellenn()
	for variablee,zeilee in pairs(skinmtabb) do
		x,y,z=unpack(zeilee)
		skinchangemarkerr=createMarker(x,y,z,"cylinder",1.5,0,0,0,0)
		setElementInterior(skinchangemarkerr,14)
		setElementDimension(skinchangemarkerr,0)
		addEventHandler("onMarkerHit",skinchangemarkerr,function(player)
		triggerClientEvent(player,"onSkinnMarkerHit",player)
		end)
	end
end
addEventHandler("onResourceStart",getResourceRootElement(getThisResource()),skinmarkererstellenn)
addEvent("onPlayerSkinnChange",true)
addEventHandler("onPlayerSkinnChange",getRootElement(),function(skinid)
setElementModel(source,skinid)
takePlayerMoney(source, 50)
end
)
