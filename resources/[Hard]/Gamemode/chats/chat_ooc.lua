local antiSpamOOC = {}
function chatOCC( source, cmd, ... )
	if not source:getAccount():isGuest () then
		if (source:isMuted()) then
			source:outputChat("No puedes escribir, estás muteado.. ", 150, 0, 0)
		return
		end
		local tick = getTickCount()
		if (antiSpamOOC[source] and antiSpamOOC[source][1] and tick - antiSpamOOC[source][1] < 2000) then
			source:outputChat("Espera 2 segundos para enviar un mensaje.. ", 150, 0, 0)
			return
		end
		local message = table.concat({...}, " ")
		if message ~= "" and message ~= " " and message:len() >= 1 then
			local pos = Vector3(source:getPosition())
			local x, y, z = pos.x, pos.y, pos.z
			local nick = _getPlayerNameR( source )
			local cuenta = source:getAccount():getName()
			if isObjectInACLGroup ("user."..cuenta, aclGetGroup ( "Desarrollador" ) ) then
				tipo = " #D30400[Desarrollador]"
			elseif isObjectInACLGroup ("user."..cuenta, aclGetGroup ( "Administrador.General" ) ) then
				tipo = " #D30400[A.General]"
			elseif isObjectInACLGroup ("user."..cuenta, aclGetGroup ( "Admin" ) ) then
				tipo = " #D30400[Administrador]"
			elseif isObjectInACLGroup ("user."..cuenta, aclGetGroup ( "SuperModerador" ) ) then
				tipo = " [#57b9ffSuperMod#FFFFFF]"
			elseif isObjectInACLGroup ("user."..cuenta, aclGetGroup ( "Sup.Staff" ) ) then
				tipo = " [#006bffE.Staff#FFFFFF]"
			elseif isObjectInACLGroup ("user."..cuenta, aclGetGroup ( "Moderador" ) ) then
				tipo = " #028A00[MODER]"
			elseif isObjectInACLGroup ("user."..cuenta, aclGetGroup ( "Moderador A Pruebas" ) ) then
				tipo = " [#928D00Moder a prueba#FFFFFF]"
			elseif isObjectInACLGroup ("user."..cuenta, aclGetGroup ( "Sup.Facc" ) ) then
				tipo = " [#57b9ffSup.Facciones#FFFFFF]"
			elseif isObjectInACLGroup ("user."..cuenta, aclGetGroup ( "Sup.Asesor" ) ) then
				tipo = " [#57b9ffSup.Asesores#FFFFFF]"
			elseif isObjectInACLGroup ("user."..cuenta, aclGetGroup ( "Sup.Grupos" ) ) then
				tipo = " [#57b9ffSup.Grupos#FFFFFF]"
			elseif isObjectInACLGroup ("user."..cuenta, aclGetGroup ( "Donador" ) ) then
				tipo = " [#F2F609Donador#FFFFFF]"
			elseif isObjectInACLGroup ("user."..cuenta, aclGetGroup ( "Asesor" ) ) then
				tipo = " [#7a9fb9Asesor#FFFFFF]"
			elseif isObjectInACLGroup ("user."..cuenta, aclGetGroup ( "VIP" ) ) then
				tipo = " #F7FF00[VIP]"
			elseif isObjectInACLGroup ("user."..cuenta, aclGetGroup ( "VIP+" ) ) then
				tipo = " #F7FF00[VIP+]"
			else
				tipo = ""
			end
			local message2 = message
			chatCol = ColShape.Sphere(x, y, z, 20)
			nearPlayers = chatCol:getElementsWithin("player") 
			outputDebugString(nick.." ((OOC)): "..tipo..": #FFFFFF"..message2.."", 0, 165, 242, 255)
			for _,v in ipairs(nearPlayers) do
				if source:getData("Familias:Enmascarado") then
					v:outputChat("#FFFFFF[OOC] #FFFCD1"..source:getData("Familias:Enmascarado").." "..tipo..": #FFFFFF((#D6D6D6"..message2..".#FFFFFF))", 165, 242, 255, true)
				else
					v:outputChat("#FFFFFF[OOC] #FFFCD1"..nick.." "..tipo..": #FFFFFF((#D6D6D6"..message2..".#FFFFFF))", 165, 242, 255, true)
				end
			end
			if (not antiSpamOOC[source]) then
				antiSpamOOC[source] = {}
			end
			antiSpamOOC[source][1] = getTickCount()
			if isElement( chatCol ) then
				destroyElement( chatCol )
			end
		else
			source:outputChat("Debes escribir más de 1 carácteres.", 150, 0, 0)
		end
	end
end
addCommandHandler({"b", "ooc"}, chatOCC)
local mensajes_random = {
	"#FFB600[Malos Aires] #ffffff¿Quieres tener mas Slots para vehiculos?, ¿ganar mas exp por payday?, ¿Tener mas dinero?, Visita nuestra tienda online : www.url.com",
	"#FFB600[Malos Aires] #ffffff¿Quieres tener mas Slots para vehiculos?, ¿ganar mas exp por payday?, ¿Tener mas dinero?, Visita nuestra tienda online : www.url.com",
	"#FFB600[Malos Aires] #ffffff¿Quieres tener mas Slots para vehiculos?, ¿ganar mas exp por payday?, ¿Tener mas dinero?, Visita nuestra tienda online : www.url.com",
	"#FFB600[Malos Aires] #ffffff¿Quieres tener mas Slots para vehiculos?, ¿ganar mas exp por payday?, ¿Tener mas dinero?, Visita nuestra tienda online : www.url.com",
	"#FFB600[Malos Aires] #ffffff¿Quieres tener mas Slots para vehiculos?, ¿ganar mas exp por payday?, ¿Tener mas dinero?, Visita nuestra tienda online : www.url.com",
}
local m_actual = 1
addEventHandler( "onClientResourceStart", resourceRoot,
	function( )
		setTimer( function( )
			if m_actual == #mensajes_random then m_actual = 1 else
				m_actual = m_actual + 1
				outputChatBox( mensajes_random[m_actual], 0, 255, 0 ,true)
			end
		end, 5*90000, 0 )
	end
)