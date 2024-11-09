local sirenasVeh = { }
local lDefensa = { }
local lTowtruck = {}
addEventHandler( "onClientResourceStart", resourceRoot, function( )
	local txd = engineLoadTXD( "sirena.txd" )
	engineImportTXD( txd, 9567 )
	local dff = engineLoadDFF( "sirena.dff" )
	engineReplaceModel( dff, 9567 )
end
)
local lucesDefensa = {
	[598] = {-0.27000004053116, 2.639997959137, -0.030000003054738, 359.96997070313, 0, 12, 0.21000003814697, 2.639997959137, -0.030000003054738, 359.96997070313, 0, 12},
}
local sirenasPos = { 
	[579] = {0.58999973535538, -0.090000003576279, 1.2599991559982, 1.260009765625, 0, 62}, -- Huntley
	[560] = {-0.29999972581863, 0.79398075804814, 0.26999952793121, 355.86975097656, 0, 60}, -- Sultan
	[426] = {-0.29999972581863, 0.79000002741814, 0.26999952793121, 355.86975097656, 0, 60}, -- Premier
	[562] = {0.45999985933304, -0.12999999523163, 0.81999957561493, 0.82000732421875, 0, 52}, -- Elegy
	[405] = {0.51999980211258, 0.099999994039536, 0.7799996137619, 0.77999877929688, 0, 68}, -- Sentinel
	[426] = {-0.29999972581863, 0.79398075804814, 0.26999952793121, 355.86975097656, 0, 60}, -- Premier
	[546] = {-0.29999972581863, 0.79398075804814, 0.26999952793121, 355.86975097656, 0, 60}, -- Intruder
	[492] = {-0.29999972581863, 0.79398075804814, 0.26999952793121, 355.86975097656, 0, 60}, -- Greenwood
	[516] = {-0.29999972581863, 0.79398075804814, 0.26999952793121, 355.86975097656, 0, 60}, -- Nebula
}
local sirenasTowtruck = {
	{-0.61999970674515, -0.48999983072281, 1.4399989843369, 1.4400329589844, 0, 342.99975585938},
	{-0.40999990701675, -0.48999983072281, 1.4399989843369, 1.4400329589844, 0, 342.99975585938},
	{-0.10000000149012, -0.48999983072281, 1.4399989843369, 1.4400329589844, 0, 342.99975585938},
	{0.12999999523163, -0.48999983072281, 1.4399989843369, 1.4400329589844, 0, 342.99975585938},
	{0.3999999165535, -0.48999983072281, 1.4399989843369, 1.4400329589844, 0, 342.99975585938},
	{0.63999968767166, -0.48999983072281, 1.4399989843369, 1.4400329589844, 0, 342.99975585938},
}
addEvent( "addSirena", true )
addEventHandler( "addSirena", getRootElement( ),
	function( veh, p )
		if isElement(veh) then
			if sirenasPos[getElementModel(veh)] then
				if not sirenasVeh[veh] then
					local x, y, z, rx, ry, rz = unpack( sirenasPos[getElementModel(veh)] )
					sirenasVeh[veh] = createObject( 9567, 0, 0, 0 )
					attachElements( sirenasVeh[veh], veh, x, y, z, rx, ry, rz )
					--triggerServerEvent( "me:sirena", getLocalPlayer(), p, 1 )
				else
					destroyElement( sirenasVeh[veh] )
					sirenasVeh[veh] = nil
					--triggerServerEvent( "me:sirena", getLocalPlayer(), p, 0 )
				end		
			else
				if lucesDefensa[getElementModel(veh)] then
					local x1, y1, z1, rx1, ry1, rz1, x2, y2, z2, rx2, ry2, rz2 = unpack( lucesDefensa[getElementModel(veh)] )
					if not lDefensa[veh] then
						lDefensa[veh] = { }
						lDefensa[veh].izquierda = createMarker( 0, 0, 0, "corona", 0.15, 255, 0, 0 )
						lDefensa[veh].derecha = createMarker( 0, 0, 0, "corona", 0.15, 0, 0, 150 )
						attachElements( lDefensa[veh].izquierda, veh, x1, y1, z1, rx1, ry1, rz1 )
						attachElements( lDefensa[veh].derecha, veh, x2, y2, z2, rx2, ry2, rz2 )
						--triggerServerEvent( "me:sirena", getLocalPlayer(), p, 2 )
					else
						destroyElement( lDefensa[veh].izquierda )
						destroyElement( lDefensa[veh].derecha )
						lDefensa[veh] = nil
						--triggerServerEvent( "me:sirena", getLocalPlayer(), p, 3 )
					end
				end			
			end
			if getElementModel(veh) == 525 then
				if not lTowtruck[veh] then
					lTowtruck[veh] = {}
					for i=1, #sirenasTowtruck do 
						local x, y, z, rx, ry, rz = unpack( sirenasTowtruck[i] )
						lTowtruck[veh][i] = createMarker( 0,0,0,"corona", 0.1,150,50,0,255 )
						attachElements( lTowtruck[veh][i], veh, x, y, z, rx, ry, rz )
					end
					lTowtruck[veh][7] = setTimer( function()
						for i=1, 6 do 
							local r, g, b, a = getMarkerColor( lTowtruck[veh][i] )
							if r == 150 and g == 50 then
								setMarkerColor( lTowtruck[veh][i], 250, 150, 0, 255 )
							elseif r == 250 and g == 150 then
								setMarkerColor( lTowtruck[veh][i], 150, 50, 0, 255 )
							end
						end
					end, 500, 0)
				else
					for i=1, 6 do 
						if isElement( lTowtruck[veh][i] ) then destroyElement( lTowtruck[veh][i] ) end
						lTowtruck[veh][i] = nil
					end
					if isTimer( lTowtruck[veh][7] ) then killTimer( lTowtruck[veh][7] ) end
					lTowtruck[veh][7] = nil
					lTowtruck[veh] = nil
				end
			end
		end
	end
)
--[[addEventHandler( "onClientRender", root,
	function( )
		local veh = getPedOccupiedVehicle( getLocalPlayer( ) )
		if getPedOccupiedVehicle( getLocalPlayer( ) ) and sirenasVeh[veh] then
			local x, y, z, rx, ry, rz = getElementAttachedOffsets( sirenasVeh[veh] )
			if getKeyState( "num_4" ) == true then
				setElementAttachedOffsets( sirenasVeh[veh], x, y, z, rx, ry, rz+1 )
				if getKeyState( "lshift" ) == true then
					setElementAttachedOffsets( sirenasVeh[veh], x, y, z, rx, ry, rz+3 )
				end
			elseif getKeyState( "num_6" ) == true then
				setElementAttachedOffsets( sirenasVeh[veh], x, y, z, rx, ry, rz-1 )
			elseif getKeyState( "num_2" ) == true then
				setElementAttachedOffsets( sirenasVeh[veh], x, y, z-0.01, rx-0.01, ry, rz )
			elseif getKeyState( "num_8" ) == true then
				setElementAttachedOffsets( sirenasVeh[veh], x, y, z+0.01, rx+0.01, ry, rz )
			elseif getKeyState( "arrow_l" ) == true then
				setElementAttachedOffsets( sirenasVeh[veh], x-0.01, y, z, rx, ry, rz )
			elseif getKeyState( "arrow_r" ) == true then
				setElementAttachedOffsets( sirenasVeh[veh], x+0.01, y, z, rx, ry, rz )
			elseif getKeyState( "arrow_u" ) == true then
				setElementAttachedOffsets( sirenasVeh[veh], x, y+0.01, z, rx, ry, rz )
			elseif getKeyState( "arrow_d" ) == true then
				setElementAttachedOffsets( sirenasVeh[veh], x, y-0.01, z, rx, ry, rz )
			elseif getKeyState( "pgup" ) == true then
				setElementAttachedOffsets( sirenasVeh[veh], x, y, z, rx+1, ry, rz )
			elseif getKeyState( "pgdn" ) == true then
				setElementAttachedOffsets( sirenasVeh[veh], x, y, z, rx-1, ry, rz )
			elseif getKeyState( "insert" ) == true then
				local x, y, z, rx, ry, rz = getElementAttachedOffsets( sirenasVeh[veh] )
				outputChatBox( "["..getElementModel(veh).."] = {"..x..", "..y..", "..z..", "..rx..", "..ry..", "..rz.."}," )			
			end
		end
	end
)--]]