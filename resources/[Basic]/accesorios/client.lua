function reemplazarTextura()
	textura = engineLoadTXD("chaleco", 10040)
	engineImportTXD(textura, 10040)
	dff = engineLoadDFF("chaleco.dff", 10040 )
	engineReplaceModel(dff, 10040)
end
addEventHandler("onClientResourceStart", getResourceRootElement(getThisResource()), reemplazarTextura)