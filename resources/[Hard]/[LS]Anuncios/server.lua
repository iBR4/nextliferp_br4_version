loadstring(exports.MySQL:getMyCode())()
import('*'):init('MySQL')
if getResourceFromName( '[LS]NewData' ):getState() ~= 'running' then 
	return outputDebugString( 'Activa el recurso [LS]NewData', 3, 255, 255, 255 )
end
loadstring(exports["[LS]NewData"]:getMyCode())()
import('*'):init('[LS]NewData')
local Pickup = Pickup(-2032.7354736328, -117.40480041504, 1035.171875, 3, 1239,0,0,0)
setElementInterior(Pickup, 3)
setElementDimension(Pickup, 1)
local Marcador = Marker(-2032.7354736328, -117.40480041504, 1035.171875, "cylinder", 1.3, 100, 100, 100, 0)
setElementInterior(Marcador, 3)
setElementDimension(Marcador, 1)
addCommandHandler("anuncio", function(player, cmd)
	if isElement(player) then
		if not notIsGuest(player) then
			if isElementWithinMarker(player,Marcador) then
				if ( getElementDimension(player) == 1 ) then
					player:triggerEvent("openanun", player)
				end
			end
		end
	end
end)
function sendDiscordLogMessage(message)
    local webhookURL = "https://discord.com/api/webhooks/1143984192745640078/1Riv_A7d-VXvEfGtcLcWZBt-Enldf0aq7pQ5Df-Aqc-6eIgYyJRDT2DUJpssgJfInpEy"
    local jsonData = toJSON({content = message})
    fetchRemote(webhookURL, function(responseData, responseInfo)
        if responseInfo.success then
            outputDebugString("Mensaje enviado a Discord: " .. message)
        else
            outputDebugString("Error al enviar mensaje a Discord: " .. tostring(responseInfo.statusCode))
        end
    end, jsonData, true)
end
local antiSpamAnuncio  = {} 
function anun(ano,text,msg)
local numero2 = source:getData("Roleplay:NumeroTelefono") or ""
if source:getMoney() >= 200 then
if ano then
	numero = ""
	else
	numero = ""..numero2
end
	
	local h = getRootElement()
	local a = getPlayerName(source)
	local telefono =  source:getData("Roleplay:Telefono") or "No"
	if telefono == "Si" then
	local tick = getTickCount()
		if (antiSpamAnuncio[source] and antiSpamAnuncio[source][1] and tick - antiSpamAnuncio[source][1] < 60000) then
			source:outputChat("No puedes anunciar después de 60 segundos", 150, 0, 0)
		return
	end
	if (not antiSpamAnuncio[source]) then
	antiSpamAnuncio[source] = {}
	outputChatBox("#E46500["..text.."] [Tel: "..numero.."] #FFFFFF"..msg,h,73,131,236,true)
	outputDebugString("#E46500["..text.."] [Tel: "..numero.."] "..a.." "..msg.."",73,131,236,true)
	takePlayerMoney(source,200)
    exports["Gamemode"]:message_admins("#00FF00"..a.." #FFFFFFmandó el anuncio.", 255, 255, 255, true)
	exports["[LS]logsAnuncio"]:sendDiscordLogMessage("["..text.."] [Tel: "..numero.."] "..msg)  
    end
	antiSpamAnuncio[source][1] = getTickCount()
	
	else
	source:outputChat("No tienes un telefono para hacer un anuncio",255,0,0,true)
	end
	else
	source:outputChat("No tienes suficiente dinero",255,0,0,true)
	end
end
addEvent("anuncioen",true)
addEventHandler("anuncioen",root,anun)
local antiSpamTaxi  = {} 
function taxi(source,cmd,... )
	local h = getRootElement()
	local g = getPlayerName(source)
	if getElementData(source,"Roleplay:trabajo") == "Taxista" or getElementData(source,"Roleplay:trabajoVIP") == "Taxista" then
		local tick = getTickCount()
		if (antiSpamTaxi[source] and antiSpamTaxi[source][1] and tick - antiSpamTaxi[source][1] < 60000) then
			source:outputChat("No puedes usar este comando después de 60 segundos", 150, 0, 0)
			return
		end
		if (not antiSpamTaxi[source]) then
		antiSpamTaxi[source] = {}
		if msg ~="" and msg ~=" " then
		outputChatBox("#EDE01E[TAXI] [555]: #FFFFFFTaxista Disponible, Llame ya!",h,0,0,0,true)
		exports["Gamemode"]:message_admins("#00FF00"..g.." #FFFFFFmandó el anuncio.", 255, 255, 255, true)
		end
		antiSpamTaxi[source][1] = getTickCount()
		end
		else
		outputChatBox("#FF7C7C[Taxista] #FFFFFF¿Que haces idiota, pensabas que eras taxista?",source,255,255,255,true)
	end
end
addCommandHandler("taxi", taxi)
