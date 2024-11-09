
function EstiloGTAClient ()
--[[txd = engineLoadTXD("gen_petrol.txd") 
engineImportTXD(txd,  1686 )
txd = engineLoadTXD("cunte_gas01.txd") 
engineImportTXD(txd,  12853 )]]
txd = engineLoadTXD("newstuff_sfn.txd")
engineImportTXD(txd,  9314 )
--[[txd = engineLoadTXD("firehouse_sfse.txd")
engineImportTXD(txd,  11245 )
txd = engineLoadTXD("cunte_lik.txd")
engineImportTXD(txd,  12843 )
txd = engineLoadTXD("cos_liquorstore.txd")
engineImportTXD(txd,  12845 )
txd = engineLoadTXD("stop.txd", 1270 )
engineImportTXD(txd, 1270)
dff = engineLoadDFF("stop.dff", 1270 )
engineReplaceModel(dff, 1270)
col= engineLoadCOL ( "stop.col" )
engineReplaceCOL ( col, 1270 )]]
end
addEventHandler( "onClientResourceStart", resourceRoot, EstiloGTAClient )