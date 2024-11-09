skinmtab={}
skinmtab[1]={207.54278564453, -100.93590545654, 1004}
function skinmarkererstellen()
	for variable,zeile in pairs(skinmtab) do
		x,y,z=unpack(zeile)
		skinchangemarker=createMarker(x,y,z,"cylinder",1.5,0,0,0,0)
		setElementInterior(skinchangemarker,15)
		setElementDimension(skinchangemarker,0)
		addEventHandler("onMarkerHit",skinchangemarker,function(player)
		triggerClientEvent(player,"onSkinMarkerHit",player)
		end)
	end
end
addEventHandler("onResourceStart",getResourceRootElement(getThisResource()),skinmarkererstellen)
addEvent("onPlayerSkinChange",true)
addEventHandler("onPlayerSkinChange",getRootElement(),function(skinid)
setElementModel(source,skinid)
takePlayerMoney(source, 50)
end
)
