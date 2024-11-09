
function EstiloGTAClient ()

txd = engineLoadTXD("ground5_las.txd", 4848 )
engineImportTXD(txd, 4848)

--txd = engineLoadTXD("landlae2.txd", 17594 )
--engineImportTXD(txd, 17594)


end
addEventHandler( "onClientResourceStart", resourceRoot, EstiloGTAClient )