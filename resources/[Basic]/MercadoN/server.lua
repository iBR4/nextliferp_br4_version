loadstring(exports.MySQL:getMyCode())()
import('*'):init('MySQL')

permisos = {
["Administrador"]=true,
["Moderador"]=true,
["SuperMod"]=true,
}


local spawnped = {}
local ped = {}
local timentrega = {}
local tiempoTimers = {}
local idpedidos = {}
local pedido = {}

spawnped = {
{2201.9033203125, -985.0478515625, 62.512733459473, 344.747},
{2870.3447265625, -2124.9052734375, 5.0073919296265, 284.21789550781},
{706.84375, -1182.2978515625, 16.004186630249, 258.19088745117},
{203.1259765625, -1758.37890625, 4.3046875, 86.219268798828},
},

addEventHandler("onResourceStart",resourceRoot,function()
	local pos = spawnped[math.random(1,#spawnped)]
	ped = createPed(127,pos[1],pos[2],pos[3],pos[4])	
	setTimer(function()
		local pos = spawnped[math.random(1,#spawnped)]
		destroyElement(ped)
		ped = createPed(127,pos[1],pos[2],pos[3],pos[4])
		triggerClientEvent(source,"vertext",source,pos)
	end,1000*60*30,0) --
	triggerClientEvent(source,"vertext",source,pos)
end)


addCommandHandler("pedido",function(source,cmd)
	local x, y, z = getElementPosition(source)
	if getDistanceBetweenPoints3D( x, y, z, unpack( { getElementPosition( ped ) } ) ) < 5 then
		triggerClientEvent(source,"vermercadon",source)
	end
end)


addEvent( "onClientGiveWeapon", true )
addEventHandler("onClientGiveWeapon", getRootElement(),function(weapon, ammo, cost, ID)
	if pedido[source] == nil then
		insert("insert into `Pedidos` VALUES (?,?,?,?,?)", AccountName(source), getWeaponIDFromName(weapon), ammo, cost, ID)
		tiempoentra(source)
		takePlayerMoney( client, cost )
	else
		source:outputChat("[ERROR] Se a cancelado tu pedido, ya tienes un pedido en marcha ",255,50,50,true)
	end
end)

addCommandHandler("pedidos",function(source,cmd,who)
	local player = exports["Gamemode"]:getFromName( source, who )
	if (player) then
		local s = query("SELECT * FROM Pedidos where Cuenta = ?", AccountName(player))
		if not ( type( s ) == "table" and #s == 0 ) or not s then
			source:outputChat("============ #A44B00Pedidos de "..player:getName():gsub("_"," ").." #FFFFFF============",255,255,255,true)
			for i, v in ipairs(s) do
				source:outputChat("#A44B00Arma: #FFFFFF"..getWeaponNameFromID(v.Arma).." #A44B00Cargadores: #FFFFFF"..v.Carg.." #A44B00Costo: #FFFFFF$"..v.Costo.." #A44B00ID: #FFFFFF"..v.ID, 255, 255, 255, true)
			end
			if timentrega[player] == nil then
				source:outputChat("#FFA800El pedido ya esta en el mercado negro",255,255,255,true)
			else
				source:outputChat("#A44B00Tiempo de entrega: #FFFFFF"..(math.floor((timentrega[player]/60)) or 0).." #A44B00Minutos",255,255,255,true)
			end		else
			source:outputChat("[ERROR] El Jugador no tienes pedidos",255,50,50,true)
		end
	else
		local s = query("SELECT * FROM Pedidos where Cuenta = ?", AccountName(source))
		if not ( type( s ) == "table" and #s == 0 ) or not s then
			source:outputChat("============ #A44B00Pedidos #FFFFFF============",255,255,255,true)
			for i, v in ipairs(s) do
				source:outputChat("#A44B00Arma: #FFFFFF"..getWeaponNameFromID(v.Arma).." #A44B00Cargadores: #FFFFFF"..v.Carg.." #A44B00Costo: #FFFFFF$"..v.Costo.." #A44B00ID: #FFFFFF"..v.ID, 255, 255, 255, true)
			end
			if timentrega[source] == nil then
				source:outputChat("#FFA800Tu pedido ya esta en el mercado negro",255,255,255,true)
			else
				source:outputChat("#A44B00Tiempo de entrega: #FFFFFF"..(math.floor((timentrega[source]/60)) or 0).." #A44B00Minutos",255,255,255,true)
			end
		else
			source:outputChat("[ERROR] No tienes pedidos",255,50,50,true)
		end
	end
end)

addCommandHandler("npedido",function(player,cmd,who,id)
	if permisos[getACLFromPlayer(player)] == true then
		local thePlayer = exports["Gamemode"]:getFromName( player, who )
		if (thePlayer) then
			if tonumber(id) then
				local s = query("SELECT * From Pedidos where ID = ? and Cuenta = ?", id, AccountName(thePlayer))
				if not ( type( s ) == "table" and #s == 0 ) or not s then
					player:outputChat("Has borrado el pedido #A44B00#"..id.." #FFFFFFdel jugador #A44B00"..thePlayer:getName():gsub("_"," "),255,255,255,true)
					thePlayer:outputChat("Te han borrado un pedido #A44B00#"..id,255,255,255,true)
					delete("DELETE FROM Pedidos WHERE ID=? and Cuenta = ?", id, AccountName(thePlayer))
				end
			elseif id == "all" then
				local s = query("SELECT * From Pedidos where Cuenta = ?",AccountName(thePlayer))
				if not ( type( s ) == "table" and #s == 0 ) or not s then
					player:outputChat("Has borrado todas los pedidos del jugador #A44B00"..thePlayer:getName():gsub("_"," "),255,255,255,true)
					thePlayer:outputChat("Te han borrado todas los pedidos",50,255,50,true)
					delete("DELETE FROM Pedidos WHERE Cuenta = ?", AccountName(thePlayer))
				end
			end
		end
	end
end)


local id = {}

function tiempoentra(source)
	if isElement(source) then
		local s = query("SELECT * FROM Pedidos where Cuenta = ?", AccountName(source))
		local result = (#s or 0) 
		if not ( type( s ) == "table" and #s == 0 ) or not s then
			timentrega[source] = tonumber(result * 5 * 60)
			tiempoTimers[source] = setTimer(bajarTiempo, 1000, 0, source)
		end
	end
end
addEventHandler("onPlayerLogin",getRootElement(),tiempoentra)

addEventHandler("onResourceStart",getRootElement(),function()
	for i,v in ipairs(Element.getAllByType("player")) do
		tiempoentra(v)
	end
end)




function bajarTiempo(player)

	pedido[player] = true

	if timentrega[player] then

		if timentrega[player] >= 1 then

			timentrega[player] = timentrega[player] - 1

		end

		if timentrega[player] == 0 then

			timentrega[player] = nil

			pedido[player] = nil

			player:outputChat("#FFA800Tu pedido ya esta en el mercado negro",255,255,255,true)

			if isTimer(tiempoTimers[player]) then

				killTimer(tiempoTimers[player])

				local s = query("SELECT * FROM Pedidos where Cuenta = ?", AccountName(player))

				for i,v in ipairs(s) do 

					idpedidos[v.ID] = v.ID

				end

			end

		end
	end
end

local marcador = Marker( 2351.4404296875, -653.3505859375, 128.0546875-1, "cylinder", 1.5, 100, 100, 100, 0 )

local p = Pickup( 2351.4404296875, -653.3505859375, 128.0546875, 3, 1239, 0 )


addCommandHandler("pedido",function(player,cmd,id)
	if player:isWithinMarker(marcador) then
		if not player:isInVehicle() then
			if tonumber(id) then
				if idpedidos[id] == id then
					local s = query("SELECT * From Pedidos where ID = ? and Cuenta = ?", id, AccountName(player))
					if not ( type( s ) == "table" and #s == 0 ) or not s then
						for i,v in ipairs(s) do
							giveWeapon(player, v.Arma, quecarga(v.Arma,v.Carg) )
						end
						delete("DELETE FROM Pedidos WHERE ID=? and Cuenta = ?", id, AccountName(player))
						player:outputChat("#FFA800Has recojido el pedido #ee0000#"..id,255,255,255,true)
						idpedidos[id] = nil
					end
				else
					player:outputChat("[ERROR] El Pedido no existe o no a llegado",255,50,50,true)
				end
			end
		end
	end
end)


local listamr = {
{30,30},
{22,17},
{24,7},
{31,30},
{28,35},
{32,30},
{25,1},
}

function quecarga(id,carga)
	for i,v in ipairs(listamr) do
		if tonumber(v[1]) == tonumber(id) then
			local car = v[2] * carga
			return car
		end
	end
	return 1
end
