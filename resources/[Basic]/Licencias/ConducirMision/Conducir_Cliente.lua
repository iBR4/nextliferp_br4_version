local ValoresTrabajo = {}
local PosicionAuto = {}
local MarcadoresRuta = {}
local BlipsRuta = {}

local RutaConducir1 = {
[1]={2077.7517089844, -1910.5112304688, 12.954399108887},
[2]={2082.9736328125, -1875.125, 12.892501831055},
[3]={2083.7814941406, -1798.3005371094, 12.923283576965},
[4]={ 2059.9704589844, -1750.1428222656, 12.927453994751},
[5]={1967.8669433594, -1750.5578613281, 12.92290687561},
[6]={1894.2229003906, -1750.4788818359, 12.922420501709},
[7]={1823.7595214844, -1729.2385253906, 12.922781944275},
[8]={ 1823.0842285156, -1589.9827880859, 12.8939561843875},
[9]={ 1849.8034667969, -1492.7703857422, 12.890625},
[10]={1882.7275390625, -1466.9559326172, 12.92276096344},
[11]={1957.2623291016, -1466.3966064453, 12.92324256897},
[12]={2078.5756835938, -1466.60546875, 23.200214385986},
[13]={2111.0974121094, -1489.4558105469, 23.355184555054},
[14]={2110.9521484375, -1556.1861572266, 24.60800743103},
[15]={2110.7407226563, -1645.1619873047, 17.300315856934},
[16]={2095.9396972656, -1734.5520019531, 12.934856414795},
[17]={2156.9389648438, -1754.2392578125, 12.928623199463},
[18]={2213.8703613281, -1762.7215576172, 12.9284324646},
[19]={2215.22265625, -1826.1037597656, 12.735373497009},
[20]={2217.1843261719, -1878.4018554688, 12.922956466675},
[21]={2197.3967285156, -1892.4455566406, 13.291808128357},
[22]={ 2176.1296386719, -1892.1353759766, 12.88855266571},
[23]={ 2129.7475585938, -1892.2475585938, 12.885935783386},
[24]={2077.2680664063, -1908.4122314453, 12.909149169922},
}
function startMision(tip, ruta)
for i, v in ipairs(RutaConducir1) do
	local x, y, z = RutaConducir1[i][1], RutaConducir1[i][2], RutaConducir1[i][3]
	local x2, y2, z2 = RutaConducir1[i][4], RutaConducir1[i][5], RutaConducir1[i][6]
	mark = Marker(x, y, z - 1, "checkpoint", 3, 255, 255, 0, 100)
	createBlipAttachedTo(mark, 0, 2, 200, 200, 0, 255)
	if i <= 37 then
		setMarkerTarget(mark, x2, y2, z2)
		setMarkerIcon ( mark, "arrow" )
	else
		setMarkerIcon ( mark, "finish" )
	end
end
end
function startMision(tip, ruta)
	if localPlayer:getData("Roleplay:Mision") == "Licencia" then
		if tip == "Conducir" then
			if ruta == 1 then
				ValoresTrabajo[localPlayer][1] = tonumber(#RutaConducir1)
				--
				for i=1, #RutaConducir1 do
					if i >= ValoresTrabajo[localPlayer][2] and i <= ValoresTrabajo[localPlayer][2] then
						local x, y, z = RutaConducir1[i][1], RutaConducir1[i][2], RutaConducir1[i][3]
						local x2, y2, z2 = RutaConducir1[i][4], RutaConducir1[i][5], RutaConducir1[i][6]
						MarcadoresRuta[i] = Marker(x, y, z - 1, "cylinder", 3, 255, 255, 0, 100)
						BlipsRuta[i] = createBlipAttachedTo(MarcadoresRuta[i], 0, 2, 200, 200, 0, 255)
						--
						if i <= 37 then
							setMarkerTarget(MarcadoresRuta[i], x2, y2, z2)
							setMarkerIcon ( MarcadoresRuta[i], "arrow" )
						else
							setMarkerIcon ( MarcadoresRuta[i], "finish" )
						end
						--
						addEventHandler("onClientMarkerHit", MarcadoresRuta[i], onMarkerRutHit)
					end
				end
			end
		end
	end
end

function onMarkerRutHit( hitElement )
	if isElement(hitElement) and hitElement:getType() == "player" and hitElement == localPlayer then
		if hitElement:isInVehicle() then
			if hitElement:getData("Roleplay:Mision") == "Licencia" and ValoresTrabajo[hitElement][3] == true then
				local veh = hitElement:getOccupiedVehicle()
				local seat = hitElement:getOccupiedVehicleSeat()
				if veh:getModel() == 410 and seat == 0 then
					if ValoresTrabajo[hitElement][1] ==ValoresTrabajo[hitElement][2] then
						local x, y, z, x2, y2, z2 = unpack(PosicionAuto[1])
						veh:setPosition(x, y, z)
						veh:setRotation(x2, y2, z2)
						veh:setLocked(true)
						veh:setFrozen(true)
						veh:setEngineState(false)
						setTimer(function(hit)
							ValoresTrabajo[hit] = nil
						end, 1000, 1, hitElement)
						triggerServerEvent("ObtenerLicencia", hitElement)
						table.remove(PosicionAuto, 1)
						hitElement:setControlState("enter_exit", true)
						setTimer(function(hitElement)
							if isElement(hitElement) then
								hitElement:setControlState("enter_exit", false)
							end
						end, 1000, 1, hitElement)
					else
						ValoresTrabajo[hitElement][2] = ValoresTrabajo[hitElement][2] + 1
						setTimer(startMision, 50, 1, "Conducir", 1)
					end
					for i=1, #RutaConducir1 do
						if i <= ValoresTrabajo[hitElement][2] then
							if isElement(MarcadoresRuta[i]) then
								destroyElement(MarcadoresRuta[i])
							end
								if isElement(BlipsRuta[i]) then
								destroyElement(BlipsRuta[i])
							end
						end
					end
				end
			end
		end
	end
end

addEvent("IniciarRutaLicencia", true)
function IniciarRutaLicencia(tip)
	if tip == "Conducir" then
		for i=1, #RutaConducir1 do
			if isElement(MarcadoresRuta[i]) then
				destroyElement(MarcadoresRuta[i])
			end
			if isElement(BlipsRuta[i]) then
				destroyElement(BlipsRuta[i])
			end
		end
		ValoresTrabajo[localPlayer] = {nil, 1, true}
		startMision("Conducir", 1)
		failedMision("Conducir", localPlayer, nil, 20)
	end
end
addEventHandler("IniciarRutaLicencia", root, IniciarRutaLicencia)

local TableFailed = {}
local TimerK = {}
local tableN = {}


addEventHandler("onClientVehicleExit", getRootElement(),
	function(thePlayer, seat)
        if thePlayer == getLocalPlayer() then
        	if seat == 0 then
        		if source:getModel() == 410 then
        			if thePlayer:getData("Roleplay:Mision") == "Licencia" then
				if thePlayer:getData("Roleplay:Mision") == "Licencia" then

        				if ValoresTrabajo[thePlayer] then

        					if ValoresTrabajo[thePlayer][3] == true then

        				outputChatBox("Tienes 30 segundos para subir al vehículo o se cancelara la misión.", 150, 50, 50, true)
        				failedMision("Conducir", thePlayer, source, 30)
						end        			
					end
				end
        		end
        	end
        end
end
end
)

addEventHandler("onClientVehicleEnter", getRootElement(),
    function(thePlayer, seat)
        if thePlayer == getLocalPlayer() then
        	if seat == 0 then
        		if source:getModel() == 410 then
        			if thePlayer:getData("Roleplay:Mision") == "Licencia" and ValoresTrabajo[thePlayer][3] == true then
        				if tableN[thePlayer] == true then
        					if isTimer(TimerK[thePlayer]) then
        						killTimer(TimerK[thePlayer])
								TimerK[thePlayer] = nil;
								tableN[thePlayer] = nil;
        						outputChatBox("¡Perfecto sigue con la misión!", 50, 150, 50, true)
        					end
        				end
        				if not TableFailed[thePlayer] then
        					TableFailed[thePlayer] = not TableFailed[thePlayer]
	        				local x, y, z = getElementPosition(thePlayer)
	        				local x2, y2, z2 = getElementRotation(thePlayer)
	        				table.insert(PosicionAuto, {x, y, z, x2, y2, z2})
	        				triggerEvent("callCinematic", localPlayer, "Conduce por los #FFFF00marcadores #ffffffintenta no ir tan rapido ni chocarte", 20000, "No")
	        			end
        			end
        		end
        	end
        end
    end
)

function failedMision(tip, thePlayer, vehiculo, timer)
	if tip == "Conducir" then
		tableN[thePlayer] = true
		TimerK[thePlayer] = setTimer(function(p, veh)
			if isElement(p) and isElement(veh) then
				p:setData("Roleplay:Mision", "")
				for i=1, #RutaConducir1 do
					if isElement(MarcadoresRuta[i]) then
						destroyElement(MarcadoresRuta[i])
					end
					if isElement(BlipsRuta[i]) then
						destroyElement(BlipsRuta[i])
					end
				end
				ValoresTrabajo[p] = {nil, 1, false}
				if veh and veh ~= nil then
					local x, y, z, x2, y2, z2 = unpack(PosicionAuto[1])
					veh:setPosition(x, y, z)
					veh:setRotation(x2, y2, z2)
					veh:setLocked(true)
					veh:setFrozen(true)
					veh:setEngineState(false)
				end
				--
				TableFailed[p] = nil;
				TimerK[p] = nil;
				tableN[p] = nil;
				--
				table.remove(PosicionAuto, 1)
			end
		end, timer*1000, 1, thePlayer, vehiculo)
	end
end