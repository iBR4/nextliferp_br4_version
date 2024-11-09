
modsFolder = "models/"
availables = {
	['ped'] = true,
	['player'] = true,
	['vehicle'] = true
}
isLoaded = {}
Modelos = {
	ped = {
		{id=10001, base_id=1, path=modsFolder, name="Pandillero"},
		{id=10002, base_id=1, path=modsFolder, name="Pandillero2"},
        {id=10003, base_id=41, path=modsFolder, name="mujer"},
		{id=10004, base_id=41, path=modsFolder, name="mujer2"},
		{id=10005, base_id=41, path=modsFolder, name="mujer3"},
		{id=10006, base_id=41, path=modsFolder, name="mujer4"},
		{id=10007, base_id=1, path=modsFolder, name="hombre"},
		{id=10008, base_id=1, path=modsFolder, name="mc"},
		{id=10009, base_id=14, path=modsFolder, name="mc2"},
		{id=10010, base_id=60, path=modsFolder, name="mc3"},
		{id=10011, base_id=47, path=modsFolder, name="mc3"},
		{id=10012, base_id=47, path=modsFolder, name="yakuza1"},
		{id=10013, base_id=47, path=modsFolder, name="yakuza2"},
		{id=10014, base_id=47, path=modsFolder, name="yakuza3"},
		{id=10015, base_id=47, path=modsFolder, name="yakuza4"},
		{id=10016, base_id=47, path=modsFolder, name="yakuza5"},
		{id=10017, base_id=47, path=modsFolder, name="pd1"},
		{id=10018, base_id=47, path=modsFolder, name="pd2"},
		{id=10019, base_id=47, path=modsFolder, name="pd3"},
		{id=10020, base_id=47, path=modsFolder, name="pd4"},
		{id=10021, base_id=47, path=modsFolder, name="pd5"},
	    --{id=20001, base_id=1, path=modsFolder, name="Mafioso 1"}, tenes q poner el nombre de los archivos igual q la id y agregarlos al meta
	},
	vehicle = {
		{id=237032, base_id=506, path=modsFolder, name="Mclaren 720s"},
		{id=20001, base_id=496, path=modsFolder, name="Dinka Blista"},
		{id=20002, base_id=439, path=modsFolder, name="Importe Dukes"},
		{id=20003, base_id=496, path=modsFolder, name="Vicent SX"},
        {id=20004, base_id=559, path=modsFolder, name="Dinka Jester"},
        {id=20005, base_id=506, path=modsFolder, name="Dinka Jester Sparkle"},
        {id=20006, base_id=560, path=modsFolder, name="Mitsubishi Lancer Evo"},
		{id=20007, base_id=579, path=modsFolder, name="Declasse Granger"},
		{id=20008, base_id=579, path=modsFolder, name="Vapid Sandking XL"},
		{id=20009, base_id=402, path=modsFolder, name="Ruiner Standart"},
		{id=20010, base_id=599, path=modsFolder, name="Police Ranger Sheriff"},
		{id=20011, base_id=411, path=modsFolder, name="Grotti Turismo Spider"},
		{id=20012, base_id=411, path=modsFolder, name="Invetero Coquette"},
		{id=20013, base_id=411, path=modsFolder, name="Chevrolet Corvette C8"},
		--{id=8003, base_id=idparaasignar, path=modsFolder, name="Nombre del Vehiculo"}, tenes q poner el nombre de los archivos igual q la id y agregarlos al meta
	},
}
getBaseFromID = {}
getDataFromID = {}
for type in pairs(Modelos) do
	for type, v in ipairs(Modelos[type]) do
		getBaseFromID[v.id] = v.base_id
		getDataFromID[v.id] = v
	end
end
function isCustomModel(model)
	if tonumber(model) then
		return getDataFromID[tonumber(model)]
	elseif isElement(model) then
		local customID = getElementData(model, 'ModelCustomID')
 		if tonumber(customID) then
			return getDataFromID[customID]
		end
	end
	return false
end
_createVehicle = createVehicle
function createVehicle(model, ...)
    local veh = _createVehicle(getBaseFromID[model], ...)
    setElementData(veh, 'ModelCustomID', model)
    return veh
end
_createPed = createPed
function createPed(model, ...)
    local ped = _createPed(getBaseFromID[model], ...)
    setElementData(ped, 'ModelCustomID', model)
    return ped
end
_getVehicleNameFromModel = getVehicleNameFromModel
function getVehicleNameFromModel(model)
	local model = tonumber(model)
    local check = isCustomModel(model)
	if check then
		return check.name
	else
		return _getVehicleNameFromModel(model)
	end
end
_getVehicleName = getVehicleName
function getVehicleName(veh)
	if isElement(veh) then
	    local check = isCustomModel(veh)
		if check then
			return check.name
		else
			return _getVehicleName(veh)
		end
	end
	return false
end