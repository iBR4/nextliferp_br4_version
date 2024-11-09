addEventHandler("onResourceStart", resourceRoot, function ( )
	dbVehiculos = Connection("sqlite", "Vehiculos.db")
	if dbVehiculos then
		print("Conectado a la base de datos 'Vehiculos.db'")
	else
		print("Error al conectar con la DB")
	end
end);
function databaseQuery( ... )
	if dbVehiculos then
		local s = dbVehiculos:query(...)
		local result = s:poll(-1)
		return result
	else
		return false
	end
end
function databaseUpdate( ... )
	if dbVehiculos then
		return dbVehiculos:exec(...)
	else
		return false
	end
end
function databaseInsert( ... )
	if dbVehiculos then
		return dbVehiculos:exec(...)
	else
		return false
	end
end
function databaseDelete( ... )
	if dbVehiculos then
		return dbVehiculos:exec(...)
	else
		return false
	end
end
