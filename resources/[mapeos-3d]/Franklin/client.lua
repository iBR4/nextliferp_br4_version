txd = engineLoadTXD ( "1.txd" )
engineImportTXD ( txd, 13755 )
col = engineLoadCOL ( "1.col" )
engineReplaceCOL ( col, 13755 )
dff = engineLoadDFF ( "1.dff" )
engineReplaceModel ( dff, 13755 )
