toysList = {
	-- 9567 no, 1628 no
	{ "gorracadete", 9568, "Gorra cadete" },
	{ "gorrasheriff", 10267, "Gorra sheriff" },
	{ "chaleco", 10040, "Chaleco Policial" },
	{ "chaleco_M", 15028, "Chaleco para Mafias" },	
	{ "reflectante", 16041, "Chaleco reflectante" },	
	{ "gorracamionero", 9352, "Gorra de camionero" },
	{ "cascointegral", 9558, "Casco integral" },
	{ "bandanablanca", 10743, "Bandana blanca" },
	{ "bowler", 16039, "Sombrero estilo bowler" },
	{ "gafasvista", 10012, "Gafas de vista" },	
	{ "gasmask", 16373, "Mascara de gas" },
	{ "cascomilitar", 16042, "Casco motero militar" },
	{ "gafasaviador", 16047, "Gafas aviador" },
	{ "gafaspaco", 16048, "Gafas de policia" },
	{ "mascara", 14521, "Mascara Mafia" },	
	{ "mochila", 16049, "Mochila" },	
	-- 16049 utilizado para mochila
	
}
toys = { }
function tieneToy( player, value )
	local ptoys = toys[player]
	if ptoys then
		for i=1,#ptoys do 
			local v = ptoys[i]
			if tonumber(getElementModel(v.obj)) == tonumber(value) then
				return true
			end
		end
	end
end
function getListaToys( )
	return toysList
end
function isValueToy( value )
	for i=1, #toysList do 
		if toysList[i][2] == tonumber(value) then
			return true
		end
	end
end
function getToyName( value )
	for i=1, #toysList do 
		if toysList[i][2] == tonumber(value) then
			return toysList[i][3]
		end
	end	
end
