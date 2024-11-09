local ADMIN_GROUP = "Admin"
local MAX_PASSWORD_CHARS = 30
local g_console = getElementsByType"console"[1]
local g_inWizard,g_wizardCR,g_pattern,g_inputIgnore

function aStartWizard ()
	--Check if they have any admins
	for i,object in ipairs(aclGroupListObjects ( aclGetGroup(ADMIN_GROUP) )) do
		if string.find(object,"user.") == 1 then
			return
		end
	end
	outputServerLog ( "-> Parece que tu servidor carece de administradores." )
	outputServerLog ( "-> Se requiere un administrador para administrar un servidor.  Por favor use el comando 'adminwizard' para configurar admin." )
end

local function input(message)
	if message == "adminwizard" then return end
	if not g_pattern then return end
	--outputServerLog ( coroutine.status ( g_wizardCR ).." "..tostring(message) )
	if g_pattern(message) then
		g_wizardCR(false)
		return
	end
	g_wizardCR(message)
	--outputSevrerLog ( "|"..tostring( coroutine.resume(g_wizardCR,message) ) )
end


local wizard = {}
wizard[1] = function()
		outputServerLog ( "-> Por favor ingresar el nombre de usuario por defecto de la cuenta.  Podría ser un nombre alfanumérico." )
		g_pattern = function(msg) return string.find(msg,"%W") end
		local message = coroutine.yield()
		g_pattern = nil
		outputServerLog ( "mensaje: "..tostring(message) )
		if not message then
			outputServerLog ( "-> El nombre de usuario resultó inválido." )
			g_wizardCR = coroutine.wrap(wizard[1])
			g_wizardCR()
			return
		end
		outputServerLog ( "-> Aquí "..tostring(wizard[2]) )
		wizard.username = message
		g_wizardCR = coroutine.wrap(wizard[2])
		g_wizardCR()
	end
wizard[2] = function()
		outputServerLog ( "-> Por favor ingresar la contraseña por defecto de la cuenta.  Esta podría tener hasta "..MAX_PASSWORD_CHARS.." caracteres." )
		g_pattern = function(msg) return #msg <= MAX_PASSWORD_CHARS end
		addEventHandler ( "onConsole", g_console, input )
		local message = coroutine.yield()
		g_pattern = nil
		removeEventHandler ( "onConsole", g_console, input )
		if not message then
			outputServerLog ( "-> La contraseña resultó inválida." )
			g_wizardCR = coroutine.wrap(wizard[2])
			g_wizardCR()
			return
		end
		wizard.password = message
		g_wizardCR = coroutine.wrap(wizard[3])
		g_wizardCR()
	end
wizard[3] = function()
		outputServerLog ( "-> Elegiste crear una cuenta de admin con el nombre de usuario '"..wizard.username.."' y la contraseña '"..wizard.password.."'.  ¿Es correcto? (y/n)" )
		g_pattern = function(msg) return msg == "y" or msg == "yes" end
		local message = coroutine.yield()
		g_pattern = nil
		if message then
			if addAccount ( wizard.username, wizard.password ) then
				outputServerLog ( "-> La cuenta de admin se ha añadido con éxito.  Por favor usa el comando 'login' dentro del juego para conectarte.  Syntax: login <usuario> <contraseña>" )
				outputServerLog ( "-> Cuando quieras puedes usar esta herramienta nuevamente escribiendo 'adminwizard' en la consola del servidor." )
			else
				outputServerLog ( "-> La cuenta no pudo ser creada.  Es posible que ya exista.  Por favor escriba 'adminwizard' para inciar la herramienta nuevamente." )
			end
		else
			outputServerLog ( "-> Por favor escriba 'adminwizard' para iniciar la herramienta nuevamente." )
		end
		g_wizardCR,g_inWizard = nil,nil
	end


addCommandHandler ( "adminwizard",
	function(source)
		if source ~= g_console then return end
		if g_inWizard then
			outputServerLog ( "-> Ya te encuentras en la herramienta de administrador." )
			return
		end
		addEventHandler ( "onConsole", g_console, input )
		g_wizardCR = coroutine.wrap(wizard[1])
		g_wizardCR()
	end
)

--[[**********************************
*
*   Traducido al español por Zelev
*
**************************************]]