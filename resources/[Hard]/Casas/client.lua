-------------------------------------
-- HOUSE SYSTEM CREATED BY NONEATME --
-- -- - DO NOT REMOVE CREDITS - -- ---
--YOU ARE NOT ALLOWED TO COMPILE THIS-
--------------------------------------
-- EVENTS --
addEvent("onClientHouseSystemGUIStart", true)
addEvent("onClientHouseSystemMenueOpen", true)
addEvent("onClientHouseSystemMenueUpdate", true)
addEvent("onClientHouseSystemColshapeAdd", true)
addEvent("onClientHouseSystemInfoMenueOpen", true)
-- SOME SETTINGS --
local gMe = getLocalPlayer()
local houseInteriors = { -- I don't really use tables
	[1] = "223.0538482666, 1287.3552246094, 1082.140625, 1, Shitty house 1",
	[2] = "2233.6594238281, -1114.9837646484, 1050.8828125, 5, Hotel room 1",
	[3] = "2365.22265625, -1135.5612792969, 1050.8825683594, 8, Modern house 1",
	[4] = "2282.9401855469, -1140.1246337891, 1050.8984375, 11, Hotel room 2",
	[5] = "2196.7075195313, -1204.3569335938, 1049.0234375, 6, Modern house 2",
	[6] = "2270.0834960938, -1210.4854736328, 1047.5625, 10, Modern house 3",
	[7] = "2308.755859375, -1212.5498046875, 1049.0234375, 6, Shitty house 2",
	[8] = "2217.7729492188, -1076.2110595703, 1050.484375, 1, Hotel room 3",
	[9] = "2237.5009765625, -1080.9367675781, 1049.0234375, 2, Good house 1",
	[10] = "2317.7609863281, -1026.4268798828, 1050.2177734375, 9, Good Stair house 1",
	[11] = "261.05038452148, 1284.7646484375, 1080.2578125, 4, Goood house 2",
	[12] = "140.18000793457, 1366.7183837891, 1083.859375, 5, Modern house 4(Rich)",
	[13] = "83.037002563477, 1322.6156005859, 1083.8662109375, 9, Good Stair house 2",
	[14] = "-283.92623901367, 1471.0096435547, 1084.375, 15, Good Stair house 3",
	[15] = "-261.03778076172, 1456.6539306641, 1084.3671875, 4, Good Stair house 4",
	[16] = "-42.609268188477, 1405.8033447266, 1084.4296875, 8, Shitty house 3",
	[17] = "-68.839866638184, 1351.4775390625, 1080.2109375, 6, Shitty house 4",
	[18] = "2333.068359375, -1077.0648193359, 1049.0234375, 6, Shitty house 5",
	[19] = "1261.1168212891, -785.38037109375, 1091.90625, 5, Mad Doggs Mansion",
	[20] = "2215.1145019531, -1150.4993896484, 1025.796875, 15, Jefferson Motel",
	[21] = "2352.4575195313, -1180.9454345703, 1027.9765625, 5, Burning desire house(Buggy)",
	[22] = "421.94845581055, 2536.5021972656, 10, 10, Abandoned Tower",
	[23] = "2495.9753417969, -1692.4174804688, 1014.7421875, 3, Johnson house",
	[24] = "-2158.7209472656, 642.83074951172, 1052.375, 1, Bet Interior",
	[25] = "1701.1682128906, -1667.759765625, 20.21875, 18, Atrium lobby",
	[26] = "2324.499, -1147.071, 1050.71, 12, Modern House 5(Rich)",
	[27] = "244.411987,305.032989,999.148437, 1, 1 Room house",
	[28] = "271.884979,306.631988,999.148437, 2, 1 Room house",
	[29] = "302.180999,300.722991,999.148437, 4, 1 Room house",
}
local Guivar = 0 -- createhouse Menue
local Guivar2 = 0 -- MENUE
local Guivar3 = 0
local Fenster = {}
local Knopf = {}
local Label = {}
local Edit = {}
local Grid = {}
local Bild = {}
local Fenster2 = {}
local Knopf2 = {}
local Label2 = {}
local Edit2 = {}
local Radio2 = {}
local Checkbox2 = {}
local Grid2 = {}
local Fenster3 = {}
local Knopf3 = {}
local Label3 = {}
--------------------
-- EVENT HANDLERS --
--------------------
-- MENUE UPDATE --
addEventHandler("onClientHouseSystemMenueUpdate", getRootElement(), function(string, value, int)
	if(Guivar2 == 0) then return end
	if(string == "LOCKED") then
		if(value == 0) then
			guiSetText(Knopf2[6], "Bloquear")
		else
			guiSetText(Knopf2[6], "Desbloquear")
		end
	elseif(string == "MONEY") then
		guiSetText(Label2[3], "Dinero actualmente:\n"..value.."$")
	elseif(string == "WEAPON") then
		if(value == 1) then
			if(type(int) == "string") then
				guiSetText(Label2[6], "Slot 1: "..getWeaponNameFromID(gettok(int, 1, ",")).."\nAmmo: "..gettok(int, 2, ","))
			else
				guiSetText(Label2[6], "Slot 1: -\nAmmo: -")
			end
		elseif(value == 2) then
			if(type(int) == "string") then
				guiSetText(Label2[7], "Slot 2: "..getWeaponNameFromID(gettok(int, 1, ",")).."\nAmmo: "..gettok(int, 2, ","))
			else
				guiSetText(Label2[7], "Slot 2: -\nAmmo: -")
			end
		elseif(value == 3) then
			if(type(int) == "string") then
				guiSetText(Label2[9], "Slot 3: "..getWeaponNameFromID(gettok(int, 1, ",")).."\nAmmo: "..gettok(int, 2, ","))
			else
				guiSetText(Label2[9], "Slot 3: -\nAmmo: -")
			end
		end
	elseif(string == "RENTABLE") then
		if(value == true) then
			guiSetText(Knopf2[9], "Quitar renta")
		else
			guiSetText(Knopf2[9], "Poner en renta")
		end
	elseif(string == "RENTALPRICE") then
		guiSetText(Label2[15], "Rentalprice: $"..value)
	elseif(string == "TENANDS") then
		guiGridListClear(Grid2[1])
		for index, player in pairs(value) do
			if(player ~= "no-one") then
				local row = guiGridListAddRow(Grid2[1])
				guiGridListSetItemText(Grid2[1], row, 1, player, false, false)
			end
		end
	end
end)
-- INFO MENUE --
addEventHandler("onClientHouseSystemInfoMenueOpen", gMe, function(owner, x, y, z, price, locked, rentable, rentalprice, id, doingrent, isrentedin, canadd)
	if(Guivar3 == 1) then
		destroyElement(Fenster3[1])
		showCursor(false)
		Guivar3 = 0
		return
	end
	Guivar3 = 1
	showCursor(true)
	guiSetInputMode("no_binds_when_editing")
	-- Make the variables --
	
	local lockedstate = "no"
	if(tonumber(locked) == 1) then lockedstate = "yes" end
	local rentstate = "no"
	if(tonumber(rentable) == 1) then rentstate = "yes" end
	
	local X, Y, Width, Height = getMiddleGuiPosition(270,251)
	Fenster3[1] = guiCreateWindow(X, Y, Width, Height,"Informacion de la casa",false)
	Label3[1] = guiCreateLabel(12,43,253,15,"Casa ID: "..id,false,Fenster3[1])
	guiLabelSetHorizontalAlign(Label3[1],"center",false)
	guiSetFont(Label3[1],"default-bold-small")
	Label3[2] = guiCreateLabel(10,22,257,15,"Informacion de la casa:",false,Fenster3[1])
	guiLabelSetHorizontalAlign(Label3[2],"center",false)
	guiSetFont(Label3[2],"default-bold-small")
	Label3[3] = guiCreateLabel(10,25,259,15,"_______________________",false,Fenster3[1])
	guiLabelSetColor(Label3[3],0, 255, 0)
	guiLabelSetHorizontalAlign(Label3[3],"center",false)
	Label3[4] = guiCreateLabel(12,61,251,18,"Localizacion: "..getZoneName(x, y, z, false),false,Fenster3[1])
	guiLabelSetHorizontalAlign(Label3[4],"center",false)
	guiSetFont(Label3[4],"default-bold-small")
	Label3[5] = guiCreateLabel(12,81,250,14,"Due�o: "..owner,false,Fenster3[1])
	guiLabelSetHorizontalAlign(Label3[5],"center",false)
	guiSetFont(Label3[5],"default-bold-small")
	Label3[6] = guiCreateLabel(12,100,252,15,"Precio: $"..price,false,Fenster3[1])
	guiLabelSetHorizontalAlign(Label3[6],"center",false)
	guiSetFont(Label3[6],"default-bold-small")
	Label3[7] = guiCreateLabel(12,118,250,14,"Rentable: "..rentstate,false,Fenster3[1])
	guiLabelSetHorizontalAlign(Label3[7],"center",false)
	guiSetFont(Label3[7],"default-bold-small")
	Label3[8] = guiCreateLabel(12,137,247,14,"Precio de renta: $"..rentalprice,false,Fenster3[1])
	guiLabelSetHorizontalAlign(Label3[8],"center",false)
	guiSetFont(Label3[8],"default-bold-small")
	Label3[9] = guiCreateLabel(12,155,247,12,"Bloqueo: "..lockedstate,false,Fenster3[1])
	guiLabelSetHorizontalAlign(Label3[9],"center",false)
	guiSetFont(Label3[9],"default-bold-small")
	Knopf3[1] = guiCreateButton(9,175,124,32,"Comprar casa",false,Fenster3[1])
	Knopf3[2] = guiCreateButton(137,175,124,32,"Rentar casa",false,Fenster3[1])
	Knopf3[3] = guiCreateButton(9,210,124,32,"Cerrar",false,Fenster3[1])
	Knopf3[4] = guiCreateButton(137,209,124,32,"Entrar",false,Fenster3[1])
	
	--------------
	-- SETTINGS --
	--------------
	
	-- ENTER BUTTON --
	if(getPlayerName(gMe) ~= owner) then
		if(isrentedin == true) then
		
		else
			if(tonumber(locked) == 1) then
				guiSetEnabled(Knopf3[4], false)
			end
		end
	end
	
	-- RENT HOUSE BUTTON --
	if(getPlayerName(gMe) == owner) then
		guiSetEnabled(Knopf3[2], false)
	else
		if(doingrent == true) or(owner == "no-one") or (tonumber(rentable) == 0) or (canadd == false) then
			guiSetEnabled(Knopf3[2], false)
		end
		if(isrentedin == true) then
			guiSetEnabled(Knopf3[2], true)
			guiSetText(Knopf3[2], "Desrentar casa")
		end
	end
	
	-- BUYHOUSE BUTTON --
	if(owner ~= "no-one") then
		guiSetEnabled(Knopf3[1], false)
		if(owner == getPlayerName(gMe)) then
			guiSetEnabled(Knopf3[1], true)
			guiSetText(Knopf3[1], "Vender casa")
		end
	end
	-- EVENT HANDLERS --
	
	-- RENT --
	
	addEventHandler("onClientGUIClick", Knopf3[2], function()
		local text = guiGetText(Knopf3[2])
		Guivar3 = 0
		showCursor(false)
		destroyElement(Fenster3[1])
		if(text == "Rent house") then
			triggerServerEvent("onHouseSystemInfoRent", gMe, id, true)
		else
			triggerServerEvent("onHouseSystemInfoRent", gMe, id, false)
		end
	end, false)
	
	-- BUY HOUSE --
	addEventHandler("onClientGUIClick", Knopf3[1], function()
		local text = guiGetText(Knopf3[1])
		Guivar3 = 0
		showCursor(false)
		destroyElement(Fenster3[1])
		if (text == "Comprar casa") then
			triggerServerEvent("onHouseSystemInfoBuy", gMe, id, true)
		else
			triggerServerEvent("onHouseSystemInfoBuy", gMe, id, false)
		end
	end, false)
	
	-- ENTER --
	addEventHandler("onClientGUIClick", Knopf3[4], function()
		Guivar3 = 0
		showCursor(false)
		destroyElement(Fenster3[1])
		triggerServerEvent("onHouseSystemInfoEnter", gMe, id)
	end, false)
	
	-- CANCEL --
	addEventHandler("onClientGUIClick", Knopf3[3], function()
		Guivar3 = 0
		showCursor(false)
		destroyElement(Fenster3[1])
	end, false)
end)
-- OPEN MENUE --
addEventHandler("onClientHouseSystemMenueOpen", gMe, function(owner, locked, money, weap1, weap2, weap3, id, rentable, rent, tenands)
	if(locked == nil) then
		
	else
		if(Guivar2 == 1) then return end
		Guivar2 = 1
		guiSetInputMode("no_binds_when_editing")
		showCursor(true)
		
		local X, Y, Width, Height = getMiddleGuiPosition(752,218)
		Fenster2[1] = guiCreateWindow(X, Y, Width, Height, "Housemenue",false)
		-- Label2[1] = guiCreateLabel(149,23,81,14,"Armas",false,Fenster2[1])
		-- guiSetFont(Label2[1],"default-bold-small")
		Label2[3] = guiCreateLabel(17,40,106,32,"Dinero actualmente:\n0$",false,Fenster2[1])
		guiSetFont(Label2[3],"default-bold-small")
		Edit2[1] = guiCreateEdit(16,75,109,24,"",false,Fenster2[1])
		Knopf2[1] = guiCreateButton(16,105,110,29,"Depositar",false,Fenster2[1])
		Knopf2[2] = guiCreateButton(16,136,110,29,"Retirar",false,Fenster2[1])
		Knopf2[3] = guiCreateButton(15,175,110,29,"Cerrar",false,Fenster2[1])
		Label2[4] = guiCreateLabel(18,23,47,15,"Dinero",false,Fenster2[1])
		guiSetFont(Label2[4],"default-bold-small")
		
		Knopf2[6] = guiCreateButton(301,175,107,29,"Bloquear casa",false,Fenster2[1])
		Label2[12] = guiCreateLabel(412,22,10,189,"|\n|\n|\n|\n|\n|\n|\n|\n|\n|\n|\n|\n|\n|\n|\n|\n|\n|\n|\n|\n|\n",false,Fenster2[1])
		guiLabelSetColor(Label2[12],0, 255, 0)
		guiSetFont(Label2[12],"default-small")
		Label2[13] = guiCreateLabel(424,24,137,15,"Rentar",false,Fenster2[1])
		guiSetFont(Label2[13],"default-bold-small")
		Label2[14] = guiCreateLabel(424,24,92,14,"__________",false,Fenster2[1])
		guiLabelSetColor(Label2[14],0,255,0)
		Label2[15] = guiCreateLabel(424,41,137,15,"Precio de renta: $0",false,Fenster2[1])
		guiSetFont(Label2[15],"default-bold-small")
		Edit2[2] = guiCreateEdit(441,58,75,24,"",false,Fenster2[1])
		Knopf2[7] = guiCreateButton(424,88,114,27,"Precio de renta",false,Fenster2[1])
		Label2[16] = guiCreateLabel(425,60,20,22,"$",false,Fenster2[1])
		guiSetFont(Label2[16],"default-bold-small")
		Grid2[1] = guiCreateGridList(559,34,184,175,false,Fenster2[1])
		guiGridListSetSelectionMode(Grid2[1],1)
		guiGridListAddColumn(Grid2[1],"Tenant",0.8)
		Knopf2[8] = guiCreateButton(422,171,115,30,"Quitar inquilina",false,Fenster2[1])
		Checkbox2[1] = guiCreateCheckBox(425,116,111,17,"Estas seguro?",false,false,Fenster2[1])
		guiSetFont(Checkbox2[1],"default-bold-small")
		Knopf2[9] = guiCreateButton(423,137,115,30,"Rentable",false,Fenster2[1])
		-- SET THE SETTINGS --
		-- TENANDS --
		guiGridListClear(Grid2[1])
		for index, player in pairs(tenands) do
			if(player ~= "no-one") then
				local row = guiGridListAddRow(Grid2[1])
				guiGridListSetItemText(Grid2[1], row, 1, player, false, false)
			end
		end
		-- RENTABLE --
		rentable = tonumber(rentable)
		if(rentable == 1) then
			guiSetText(Knopf2[9], "Poner no rentable")
		end
		-- RENTALPRICE
		rent = rent or 0
		guiSetText(Label2[15], "Precio de renta: $"..rent)
		
		-- LOCKED --
		locked = tonumber(locked)
		if(locked == 1) then
			guiSetText(Knopf2[6], "Desbloquear")
		end
		
		-- MONEY --
		guiSetText(Label2[3], "Dinero :\n"..money.."$")
		
		
		-- WEAPONS --
	
		-- outputChatBox(tonumber(weap1))
		-- if(tonumber(weap1) == nil) then
		-- 	local weapon, ammo = gettok(weap1, 1, ","), gettok(weap1, 2, ",")
		-- 	if(weapon) and (ammo) then
		-- 		guiSetText(Label2[6], "Slot 1: "..getWeaponNameFromID(weapon).."\nAmmo: "..ammo)
		-- 	end
		-- end
		-- if(tonumber(weap2) == nil) then
		-- 	local weapon, ammo = gettok(weap2, 1, ","), gettok(weap2, 2, ",")
		-- 	if(weapon) and (ammo) then
		-- 		guiSetText(Label2[7], "Slot 2: "..getWeaponNameFromID(weapon).."\nAmmo: "..ammo)
		-- 	end
		-- end
		-- if(tonumber(weap3) == nil) then
		-- 	local weapon, ammo = gettok(weap3, 1, ","), gettok(weap3, 2, ",")
		-- 	if(weapon) and (ammo) then
		-- 		guiSetText(Label2[9], "Slot 3: "..getWeaponNameFromID(weapon).."\nAmmo: "..ammo)
		-- 	end
		-- end
		-- EVENT HANDLERS --
		
		-- REMOVE TENANDS --
		
		addEventHandler("onClientGUIClick", Knopf2[8], function()
			if(owner == false) then outputChatBox("Tu no eres el due�o de esta casa!", 255, 0, 0) return end
			local user = guiGridListGetItemText(Grid2[1], guiGridListGetSelectedItem(Grid2[1]), 1)
			if(user == "") or (user == " ") then return end
			if(guiCheckBoxGetSelected(Checkbox2[1]) == false) then outputChatBox("You must be sure!", 255, 0, 0) return end
			triggerServerEvent("onHouseSystemTenandRemove", gMe, id, user)
		end, false)
		
		-- SET RENTALPRICE --
		addEventHandler("onClientGUIClick", Knopf2[7], function()
			if(owner == false) then outputChatBox("Tu no eres el due�o de esta casa!", 255, 0, 0) return end
			local value = tonumber(guiGetText(Edit2[2]))
			if(value == nil) or(value < 1) or (value > 20000) then outputChatBox("Bad input!", 255, 0, 0) return end
			value = math.floor(value)
			triggerServerEvent("onHouseSystemRentalprice", gMe, id, value)
		end, false)
		
		-- SET RENTABLE --
		addEventHandler("onClientGUIClick", Knopf2[9], function()
			if(owner == false) then outputChatBox("Tu no eres el due�o de esta casa!", 255, 0, 0) return end
			triggerServerEvent("onHouseSystemRentableSwitch", gMe, id)
		end, false)
		
		-- WEAPON DEPOSIT --
		-- addEventHandler("onClientGUIClick", Knopf2[4], function()
		-- 	if(owner == false) then outputChatBox("Tu no eres el due�o de esta casa!", 255, 0, 0) return end
		-- 	local radio = {}
		-- 	for i = 1, #Radio2, 1 do 
		-- 		radio[i] = guiRadioButtonGetSelected(Radio2[i])
		-- 	end
		-- 	if(radio[1] == true) then
		-- 		triggerServerEvent("onHouseSystemWeaponDeposit", gMe, id, 1)
		-- 	elseif(radio[2] == true) then
		-- 		triggerServerEvent("onHouseSystemWeaponDeposit", gMe, id, 2)
		-- 	else
		-- 		triggerServerEvent("onHouseSystemWeaponDeposit", gMe, id, 3)
		-- 	end
		-- end, false)
		
		-- -- WEAPON WITHDRAW--
		-- addEventHandler("onClientGUIClick", Knopf2[5], function()
		-- 	if(owner == false) then outputChatBox("Tu no eres el due�o de esta casa!", 255, 0, 0) return end
		-- 	local radio = {}
		-- 	for i = 1, #Radio2, 1 do 
		-- 		radio[i] = guiRadioButtonGetSelected(Radio2[i])
		-- 	end
		-- 	if(radio[1] == true) then
		-- 		triggerServerEvent("onHouseSystemWeaponWithdraw", gMe, id, 1)
		-- 	elseif(radio[2] == true) then
		-- 		triggerServerEvent("onHouseSystemWeaponWithdraw", gMe, id, 2)
		-- 	else
		-- 		triggerServerEvent("onHouseSystemWeaponWithdraw", gMe, id, 3)
		-- 	end
		-- end, false)
		-- MONEY WITHDRAW --
		addEventHandler("onClientGUIClick", Knopf2[2], function()
			if(owner == false) then outputChatBox("Tu no eres el due�o de esta casa!", 255, 0, 0) return end
			local value = guiGetText(Edit2[1])
			if(value == "") then return end
			value = tonumber(value)
			if(value < 0)  then outputChatBox("Bad money input!", 255, 0, 0) return end
			value = math.floor(value)
			triggerServerEvent("onHouseSystemHouseWithdraw", gMe, id, value)
		end, false)
		
		-- MONEY DEPOSIT --
		addEventHandler("onClientGUIClick", Knopf2[1], function()
			if(owner == false) then outputChatBox("Tu no eres el due�o de esta casa!", 255, 0, 0) return end
			local value = guiGetText(Edit2[1])
			if(value == "") then return end
			value = tonumber(value)
			if(value < 0) or (value > getPlayerMoney(gMe)-1) then outputChatBox("Bad money input!", 255, 0, 0) return end
			value = math.floor(value)
			triggerServerEvent("onHouseSystemHouseDeposit", gMe, id, value)
		end, false)
		
		-- LOCK HOUSE --
		addEventHandler("onClientGUIClick", Knopf2[6], function()
			if(owner == false) then outputChatBox("Tu no eres el due�o de esta casa!", 255, 0, 0) return end
			triggerServerEvent("onHouseSystemHouseLock", gMe, id)
		end, false)
		
		-- CANCEL --
		addEventHandler("onClientGUIClick", Knopf2[3], function()
			Guivar2 = 0
			showCursor(false)
			destroyElement(Fenster2[1])
		end, false)
	end
end)
-- ON GUI START --
addEventHandler("onClientHouseSystemGUIStart", gMe, function()
	if(Guivar == 1) then return end
	Guivar = 1
	guiSetInputMode("no_binds_when_editing")
	
	showCursor(true)
	
	local X, Y, Width, Height = getMiddleGuiPosition(787,269) -- I'm too lazy :D
	Fenster[1] = guiCreateWindow(X, Y, Width, Height, "Creacion de casa[House System by Noneatme]",false)
	Label[1] = guiCreateLabel(495,24,107,17,"Vista de interior:",false,Fenster[1])
	guiSetFont(Label[1],"default-bold-small")
	Label[2] = guiCreateLabel(490,27,124,15,"___________________",false,Fenster[1])
	guiLabelSetColor(Label[2],0, 255, 0)
	Edit[1] = guiCreateEdit(159,84,33,27,"",false,Fenster[1]) -- X INT
	Label[3] = guiCreateLabel(161,52,135,30,"X, Y, Z and INT\nof the House(Inside):",false,Fenster[1])
	guiSetFont(Label[3],"default-bold-small")
	Edit[2] = guiCreateEdit(196,84,33,27,"",false,Fenster[1]) -- Y INT
	Edit[3] = guiCreateEdit(234,84,33,27,"",false,Fenster[1]) -- Z INT
	Knopf[1] = guiCreateButton(156,116,112,32,"Set ----->",false,Fenster[1])
	Edit[4] = guiCreateEdit(17,177,80,27,"",false,Fenster[1]) -- PRICE 
	Label[4] = guiCreateLabel(103,183,19,22,"$",false,Fenster[1])
	guiSetFont(Label[4],"default-bold-small")
	Knopf[2] = guiCreateButton(13,221,112,32,"Cancelar",false,Fenster[1])
	Knopf[3] = guiCreateButton(132,221,107,31,"Crear casa",false,Fenster[1])
	Label[5] = guiCreateLabel(15,22,107,17,"Configuracion:",false,Fenster[1])
	guiSetFont(Label[5],"default-bold-small")
	Label[6] = guiCreateLabel(10,25,124,15,"___________________",false,Fenster[1])
	guiLabelSetColor(Label[6],0,255,0)
	Knopf[4] = guiCreateButton(15,114,112,32,"Mi Posicion",false,Fenster[1])
	Label[7] = guiCreateLabel(20,50,135,30,"X, Y, Z Position\nof the House(Outside):",false,Fenster[1])
	guiSetFont(Label[7],"default-bold-small")
	Label[8] = guiCreateLabel(18,157,46,19,"Precio:",false,Fenster[1])
	guiSetFont(Label[8],"default-bold-small")
	Edit[5] = guiCreateEdit(18,82,33,27,"",false,Fenster[1]) -- X House
	Edit[6] = guiCreateEdit(55,82,33,27,"",false,Fenster[1]) -- Y ""
	Edit[7] = guiCreateEdit(93,82,33,27,"",false,Fenster[1]) -- Z ""
	Grid[1] = guiCreateGridList(314,23,162,237,false,Fenster[1])
	guiGridListSetSelectionMode(Grid[1],1)
	guiGridListAddColumn(Grid[1],"ID",0.2)
	guiGridListAddColumn(Grid[1],"Description",1)
	
	Edit[8] = guiCreateEdit(272,84,33,27,"",false,Fenster[1]) -- INT INT
	Bild[1] = guiCreateStaticImage(486,51,290,204,"data/images/choose.jpg",false,Fenster[1])
	Label[9] = guiCreateLabel(164,22,107,17,"Interior:",false,Fenster[1])
	guiSetFont(Label[9],"default-bold-small")
	Label[10] = guiCreateLabel(159,25,124,15,"___________________",false,Fenster[1])
	guiLabelSetColor(Label[10],0,255,0)
	
	-- FILL THE LIST --
	for i = 1, #houseInteriors, 1 do
		local row = guiGridListAddRow(Grid[1])
		guiGridListSetItemText(Grid[1], row, 1, i, false, false)
		guiGridListSetItemText(Grid[1], row, 2, gettok(houseInteriors[i], 5, string.byte(",")), false, false)
	end
	-- GRIDLIST EVENT --
	addEventHandler("onClientGUIClick", Grid[1], function()
		local text = guiGridListGetItemText(Grid[1], guiGridListGetSelectedItem(Grid[1]), 1)
		if(text == "") or (text == " ") then
			guiStaticImageLoadImage(Bild[1], "data/images/choose.jpg")
		else
			if(fileExists("data/images/"..text..".jpg")) then
				guiStaticImageLoadImage(Bild[1], "data/images/"..text..".jpg")
			else
				guiStaticImageLoadImage(Bild[1], "data/images/choose.jpg")
			end
		end
	end, false)
	---------------------------
	-- BUTTON EVENT HANDLERS --
	---------------------------
	
	-- CREATE HOUSE BUTTON --
	addEventHandler("onClientGUIClick", Knopf[3], function()
		local x, y, z, intx, inty, intz, int, price = guiGetText(Edit[5]), guiGetText(Edit[6]), guiGetText(Edit[7]), guiGetText(Edit[1]), guiGetText(Edit[2]), guiGetText(Edit[3]), guiGetText(Edit[8]), guiGetText(Edit[4])
		if(x == "") or (y == "") or (z == "") or (intx == "") or (inty == "") or (intz == "") then outputChatBox("You must insert a value in all text fields!", 255, 0, 0) return end
		price = tonumber(price)
		if(price < 0) or (price > 10000000) then outputChatBox("Bad Price!", 255, 0, 0) return end
		triggerServerEvent("onHouseSystemHouseCreate", gMe, x, y, z, int, intx, inty, intz, price)
	end, false)
	
	-- INTERIOR BUTTON --
	addEventHandler("onClientGUIClick", Knopf[1], function()
		local id = tonumber(guiGridListGetItemText(Grid[1], guiGridListGetSelectedItem(Grid[1]), 1))
		if(id == nil) then outputChatBox("You must select a house interior!", 255, 0, 0) return end
		local text = houseInteriors[id]
		local x, y, z, int = gettok(text, 1, string.byte(",")), gettok(text, 2, string.byte(",")), gettok(text, 3, string.byte(",")), gettok(text, 4, string.byte(","))
		guiSetText(Edit[1], x)
		guiSetText(Edit[2], y)
		guiSetText(Edit[3], z)
		guiSetText(Edit[8], int)
	end, false)
	
	-- MY POSITION BUTTON --
	addEventHandler("onClientGUIClick", Knopf[4], function()
		local x, y, z = getElementPosition(gMe)
		guiSetText(Edit[5], x)
		guiSetText(Edit[6], y)
		guiSetText(Edit[7], z)
	end, false)
	
	-- CANCEL BUTTON --
	addEventHandler("onClientGUIClick", Knopf[2], function()
		Guivar = 0
		showCursor(false)
		destroyElement(Fenster[1])
	end, false)
end)
------------
-- RENDER --
------------
-- Streamed in Houses --
local streamedHouses = {}
addEventHandler("onClientElementStreamIn", getRootElement(), function()
	if(getElementType(source) == "colshape") and (getElementData(source, "house") == true) then
		streamedHouses[source] = source
	end
end)
addEventHandler("onClientElementStreamOut", getRootElement(), function()
	if(getElementType(source) == "colshape") and (getElementData(source, "house") == true) then
		if(streamedHouses[source] == true) then
			streamedHouses[source] = nil
		end
	end
end)
for index, shit in pairs(getElementsByType("colshape", getRootElement(), true)) do
	if(getElementType(shit) == "colshape") and (getElementData(shit, "house") == true) then
		streamedHouses[shit] = shit
	end
end
-- COLSHAPE ADD --
addEventHandler("onClientHouseSystemColshapeAdd", getRootElement(), function(shit)
	streamedHouses[shit] = shit
end)
addEventHandler("onClientRender", getRootElement(), function()
	for index, house in pairs(streamedHouses) do
		if(house ~= false) and (house ~= nil) then
			if(isElement(house)) then
				local x, y, z = getElementPosition(house)
				local x2, y2, z2 = getElementPosition(gMe)
				if(isLineOfSightClear(x, y, z, x2, y2, z2, true, true, false, true)) then
					z = z+0.5
					local sx, sy = getScreenFromWorldPosition(x, y, z)
					if(sx) and (sy) then
						local distance = getDistanceBetweenElements(house, gMe)
						if(distance < 20) then
							local fontbig = 2-(distance/10)
							-- DRAW --
							local owner = getElementData(house, "OWNER")
							local price = getElementData(house, "PRICE")
							local locked = getElementData(house, "LOCKED")
							local houseid = getElementData(house, "ID")
							local lockedstate = "Desbloqueada"
							if(tonumber(locked) == 1) then lockedstate = "Bloqueada" end
							local zone = getZoneName(x, y, z, false)
							if(owner) and (price) and (locked) and (houseid) then
								if(owner ~= "no-one") then
									local rentable, rentalprice = tonumber(getElementData(house, "RENTABLE")), getElementData(house, "RENTALPRICE")
									if(rentable == 1) then
										--dxDrawText("Casa: "..houseid.." ("..zone..")\nDue�o: "..owner.."\nPrecio: $"..price.."\nEsta casa es rentable. Rentalprice: $"..rentalprice.."\nThis House is "..lockedstate..".", sx+2, sy+2, sx, sy, tocolor(0, 0, 0, 200), fontbig, "default-bold", "center")
										--dxDrawText("Casa: "..houseid.." ("..zone..")\nDue�o: "..owner.."\nPrecio: $"..price.."\nEsta casa es rentable. Rentalprice: $"..rentalprice.."\nThis House is "..lockedstate..".", sx+2, sy+2, sx, sy, tocolor(255, 255, 255, 200), fontbig, "default-bold", "center")
									else
										--dxDrawText("Casa: "..houseid.." ("..zone..")\nDue�o: "..owner.."\nPrecio: $"..price.."\nNo rentable\nEsta casa esta "..lockedstate..".", sx+2, sy+2, sx, sy, tocolor(0, 0, 0, 200), fontbig, "default-bold", "center")
										--dxDrawText("Casa: "..houseid.." ("..zone..")\nDue�o: "..owner.."\nPrecio: $"..price.."\nNo rentable\nEsta casa esta "..lockedstate..".", sx, sy, sx, sy, tocolor(255, 255, 255, 200), fontbig, "default-bold", "center")
									end
								else
									--dxDrawText("Casa: "..houseid.." ("..zone..")\nDue�o: "..owner.."\nPrecio: $"..price.."\nPara comprar la casa, usa /comprarcasa\nEsta casa "..lockedstate..".", sx+2, sy+2, sx, sy, tocolor(0, 0, 0, 200), fontbig, "default-bold", "center")
									--dxDrawText("Casa: "..houseid.." ("..zone..")\nDue�o: "..owner.."\nPrecio: $"..price.."\nPara comprar la casa, usa /comprarcasa\nEsta casa "..lockedstate..".", sx, sy, sx, sy, tocolor(255, 255, 255, 200), fontbig, "default-bold", "center")
								end
							end
						end
					end
				end
			else
				house = nil
			end
		end
	end
end)
------------------------
-- SETTINGS FUNCTIONS --
------------------------
function getMiddleGuiPosition(lol, lol2)
	local sWidth, sHeight = guiGetScreenSize()
 
    local Width,Height = lol, lol2
    local X = (sWidth/2) - (Width/2)
    local Y = (sHeight/2) - (Height/2)
	
	return X, Y, Width, Height
end
function getDistanceBetweenElements(element1, element2)
	local x, y, z = getElementPosition(element1)
	local x1, y1, z1 = getElementPosition(element2)
	return getDistanceBetweenPoints3D(x, y, z, x1, y1, z1)
end
  
local image = nil
local image2 = nil
local image3 = nil
function pic(toggle)   
	local screenW, screenH = guiGetScreenSize() 
	image = guiCreateStaticImage(screenW * 0.0132, screenH * 0.3711, screenW * 0.0952, screenH * 0.0534, ':Casas/data/images/H.png', false, nil) 
	image2 = guiCreateStaticImage(screenW * 0.0132, screenH * 0.4245, screenW * 0.0952, screenH * 0.0534, ':Casas/data/images/G.png', false, nil) 
	image3 = guiCreateStaticImage(screenW * 0.0132, screenH * 0.4779, screenW * 0.0952, screenH * 0.0534, ':Casas/data/images/F.png', false, nil) 
end 
addEvent("onGreeting", true) 
addEventHandler("onGreeting", getRootElement(), pic) 
function picdel() 
    validateElement(image) 
    validateElement(image2) 
    validateElement(image3) 
end 
addEvent("BorrarFoto", true) 
addEventHandler ( "BorrarFoto", getRootElement(), picdel) 
function validateElement(element)
	if isElement(element) then
		destroyElement(element)
	end
end
