
function EstiloGTAClient ()

txd = engineLoadTXD("sunset02_law2.txd", 6337 )
engineImportTXD(txd, 6337)

dff = engineLoadDFF("sunset01_law2.dff", 6337 )
engineReplaceModel(dff, 6337)

dff = engineLoadDFF("sunset04tr_law2.dff", 6357 )
engineReplaceModel(dff, 6357)

col = engineLoadCOL("law2_2.col")
engineReplaceCOL(col,6339)
engineSetModelLODDistance(6339, 1000000)

end
addEventHandler( "onClientResourceStart", resourceRoot, EstiloGTAClient )