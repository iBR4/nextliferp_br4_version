local shaders = {"cables_sfw24", "cables_sfw", "des_powercable_08", "desn2_alphabit04", "wires_01c_SFS", "cables_sfw01", "cables16", "cables3","cables2", "des_powercable_20",
"des_powercable_19"}
local txd, dff = { }, { }
addEventHandler( "onClientResourceStart", resourceRoot,
	function( )
		setTimer( function( )
		for i=1, #toysList do 
			local name, id = unpack( toysList[i] )
			if name then
				txd[i] = engineLoadTXD ( "toys/"..name..".txd" )
				engineImportTXD ( txd[i], id )
				dff[i] = engineLoadDFF ( "toys/"..name..".dff" )
				engineReplaceModel ( dff[i], id )	
			end
		end
		end, 500, 1)
		local text = dxCreateTexture( "transparente.png" )
		local shader = dxCreateShader( "texreplace.fx" )
		for i=1, #shaders do 
			local v = shaders[i]
			engineApplyShaderToWorldTexture( shader, v )
			dxSetShaderValue( shader, "gTexture", text )
		end
	end
)