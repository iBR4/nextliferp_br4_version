local anims =
{
    beber =
    {
		{ block = "bar", anim = "dnk_stndm_loop", time = -1 },
		{ block = "bar", anim = "dnk_stndf_loop", time = -1 },
	},
	bar =
	{
		{ block = "bar", anim = "barcustom_loop", time = -1 },
		{ block = "bar", anim = "barman_idle", time = -1 },
		{ block = "bar", anim = "barserve_bottle", time = -1 },
		{ block = "bar", anim = "barserve_give", time = -1 },
		{ { block = "bar", anim = "barserve_in", time = 1000 }, { block = "bar", anim = "barserve_loop", time = -1 } },
	},
	bat =
	{
		{ block = "baseball", anim = "bat_1", time = 1000, updatePosition = true },
		{ block = "baseball", anim = "bat_2", time = 1000, updatePosition = true },
		{ block = "baseball", anim = "bat_3", time = 1000, updatePosition = true },
		{ block = "baseball", anim = "bat_4", time = 1000, updatePosition = true },
		{ block = "baseball", anim = "bat_hit_1", time = 1000, updatePosition = true },
		{ block = "baseball", anim = "bat_hit_2", time = 1000, updatePosition = true },
		{ block = "baseball", anim = "bat_hit_3", time = -1, updatePosition = true, loop = false },
	},
	buscando =
	{
		{ block = "bomber", anim = "bom_plant", time = 3000 },
		{ block = "bomber", anim = "BOM_Plant_Loop", time = 3000 },
	},
	herido =
	{
		{ block = "crack", anim = "crckidle1", time = -1 },
		{ block = "crack", anim = "crckidle2", time = -1 },
		{ block = "crack", anim = "crckidle3", time = -1 },
		{ block = "crack", anim = "crckidle4", time = -1 },
	},
	cpr =
	{
		{ block = "medic", anim = "cpr", time = -1 },
	},
	bailar =
	{
		{ block = "dancing", anim = "dance_loop", time = -1 },
		{ block = "dancing", anim = "dan_down_a", time = -1 },
		{ block = "dancing", anim = "dan_left_a", time = -1 },
		{ block = "dancing", anim = "dan_loop_a", time = -1 },
		{ block = "dancing", anim = "dan_right_a", time = -1 },
		{ block = "dancing", anim = "dan_up_a", time = -1 },
		{ block = "dancing", anim = "dnce_M_a", time = -1 },
		{ block = "dancing", anim = "dnce_M_b", time = -1 },
		{ block = "dancing", anim = "dnce_M_c", time = -1 },
		{ block = "dancing", anim = "dnce_M_d", time = -1 },
		{ block = "dancing", anim = "dnce_M_e", time = -1 },
	},
	reparar =
	{
		{ block = "car", anim = "fixn_car_loop", time = -1, updatePosition = false },
	},
	gestos =
	{
		{ block = "ghands", anim = "gsign1", time = 4000 },
		{ block = "ghands", anim = "gsign1lh", time = 4000 },
		{ block = "ghands", anim = "gsign2", time = 4000 },
		{ block = "ghands", anim = "gsign2lh", time = 4000 },
		{ block = "ghands", anim = "gsign3", time = 4000 },
		{ block = "ghands", anim = "gsign3lh", time = 4000 },
		{ block = "ghands", anim = "gsign4", time = 4000 },
		{ block = "ghands", anim = "gsign4lh", time = 4000 },
		{ block = "ghands", anim = "gsign5", time = 4000 },
		{ block = "ghands", anim = "gsign5lh", time = 4000 },
		{ block = "ghands", anim = "gsign1", time = 4000 },
	},
	nalguear =
	{
		{ block = "SWEET", anim = "sweet_ass_slap", time = 4000 },
	},
	rap =
	{
		{ block = "LOWRIDER", anim = "RAP_A_Loop", time = 4000 },
		{ block = "LOWRIDER", anim = "RAP_B_Loop", time = 4000 },
		{ block = "LOWRIDER", anim = "RAP_C_Loop", time = 4000 },
	},
	hablar =
	{
		{ block = "gangs", anim = "prtial_gngtlka", time = -1 },
		{ block = "gangs", anim = "prtial_gngtlkb", time = -1 },
		{ block = "gangs", anim = "prtial_gngtlkc", time = -1 },
		{ block = "gangs", anim = "prtial_gngtlkd", time = -1 },
		{ block = "gangs", anim = "prtial_gngtlke", time = -1 },
		{ block = "gangs", anim = "prtial_gngtlkf", time = -1 },
		{ block = "gangs", anim = "prtial_gngtlkg", time = -1 },
		{ block = "gangs", anim = "prtial_gngtlkh", time = -1 },
		{ block = "gangs", anim = "prtial_gngtlkh", time = -1 },
	},
	mirarlados =
	{
		{ block = "gangs", anim = "dealer_idle", time = -1 },
	},
	esperarse =
	{
		{ block = "dealer", anim = "dealer_idle", time = -1 },
		{ block = "dealer", anim = "dealer_idle_02", time = -1 },
		{ block = "dealer", anim = "dealer_idle_02", time = -1 },
		{ block = "dealer", anim = "dealer_idle_03", time = -1 },
		{ block = "fat", anim = "fatidle", time = -1 },
		{ block = "gangs", anim = "dealer_idle", time = -1 },
		{ block = "cop_ambient", anim = "coplook_loop", time = -1 },
		{ block = "graveyard", anim = "prst_loopa", time = -1 },
	},
	besar =
	{
		{ block = "kissing", anim = "grlfrd_kiss_01", time = 4000 },
		{ block = "kissing", anim = "grlfrd_kiss_02", time = 5000 },
		{ block = "kissing", anim = "grlfrd_kiss_03", time = 6000 },
		{ block = "kissing", anim = "playa_kiss_01", time = 4000 },
		{ block = "kissing", anim = "playa_kiss_02", time = 5000 },
		{ block = "kissing", anim = "playa_kiss_03", time = 6000 },
	},
	tirarse =
	{
		{ block = "beach", anim = "sitnwait_loop_w", time = -1 },
		{ block = "beach", anim = "lay_bac_loop", time = -1 },
		{ block = "beach", anim = "ParkSit_M_loop", time = -1 },
		{ block = "beach", anim = "ParkSit_W_loop", time = -1 },
		{ block = "int_house", anim = "bed_loop_l", time = -1 },
		{ block = "int_house", anim = "bed_loop_r", time = -1 },
	},
	apoyarse =
	{
		{ block = "gangs", anim = "leanidle", time = -1 },
		{ block = "gangs", anim = "leanIN", time = -1 },
		{ block = "lowrider", anim = "m_smklean_loop", time = -1 },
		{ block = "lowrider", anim = "f_smklean_loop", time = -1 },
		{ block = "misc", anim = "Plyrlean_loop", time = -1 },
	},
	paso =
	{
		{ block = "gangs", anim = "invite_no", time = 4000 },
	},
	mirarhora =
	{
		{ block = "clothes", anim = "clo_pose_watch", time = -1 },
	},
	reir =
	{
		{ block = "RAPPING", anim = "Laugh_01", time = -1 },
	},
	revisarse =
	{
		{ block = "clothes", anim = "clo_pose_torso", time = -1 },
		{ block = "clothes", anim = "clo_pose_shoes", time = -1 },
		{ block = "clothes", anim = "clo_pose_legs", time = -1 },
	},
	patada =
	{
		{ block = "police", anim = "Door_Kick", time = 4000 },
	},
	sentarse =
	{
		{ block = "ped", anim = "seat_idle", time = -1 },
		{ block = "food", anim = "ff_Sit_eat1", time = -1 },
		{ block = "beach", anim = "parksit_m_loop", time = -1 },
		{ block = "beach", anim = "parksit_w_loop", time = -1 },
		{ block = "sunbathe", anim = "parksit_m_idlec", time = -1 },
		{ block = "sunbathe", anim = "parksit_w_idlea", time = -1 },
		{ block = "attractors", anim = "stepsit_in", time = 1200 },
		{ block = "attractors", anim = "stepsit_loop", time = -1 },
		{ block = "int_house", anim = "lou_loop", time = -1 },
		{ block = "int_office", anim = "off_sit_drink", time = -1 },
		{ block = "int_office", anim = "off_sit_idle_loop", time = -1 },
		{ block = "int_office", anim = "off_sit_read", time = -1 },
		{ block = "int_office", anim = "off_sit_type_loop", time = -1 },
		{ block = "int_office", anim = "off_sit_watch", time = -1 },
		{ block = "jst_buisness", anim = "girl_02", time = -1 },
		{ block = "car", anim = "sit_relaxed", time = -1 },
		{ block = "car", anim = "tap_hand", time = -1 },
		{ block = "ped", anim = "tap_handP", time = -1 },
	},
	fumar =
	{
		{ block = "lowrider", anim = "m_smkstnd_loop", time = -1 },
		{ block = "gangs", anim = "smkcig_prtl", time = -1 },
	},
	pensar =
	{
		{ { block = "cop_ambient", anim = "coplook_think", time = 2000 }, { block = "cop_ambient", anim = "coplook_think", time = -1 } },
	},
	vomitar =
	{
		{ block = "food", anim = "eat_vomit_p", time = 7000 },
	},
	camara =
	{
		{ block = "camara", anim = "camcrch_idleloop", time = -1 },
	},
	cansado =
	{
		{ block = "fat", anim = "idle_tired", time = -1 },
	},
	acubierto =
	{
		{ block = "ped", anim = "EV_dive", time = 4000 },
	},
	esperar =
	{
		{ block = "cop_ambient", anim = "coplook_loop", time = -1 },
	},
	saludar =
	{
		{ block = "kissing", anim = "gfwave2", time = 2500 },
	},
	okey =
	{
		{ block = "gangs", anim = "invite_yes", time = 4000 },
	},
	chocar =
	{
		{ block = "gangs", anim = "hndshkfa", time = -1 },
    },
	strip =
	{
		{ block = "STRIP", anim = "PLY_CASH", time = -1 },
		{ block = "STRIP", anim = "strip_A", time = -1 },
		{ block = "STRIP", anim = "strip_B", time = -1 },
		{ block = "STRIP", anim = "strip_C", time = -1 },
		{ block = "STRIP", anim = "strip_D", time = -1 },
		{ block = "STRIP", anim = "strip_E", time = -1 },
		{ block = "STRIP", anim = "strip_F", time = -1 },
		{ block = "STRIP", anim = "strip_G", time = -1 },
    },
	cubrirse =
	{
	    { block = "PED", anim = "cower", time = -1 },
		
	},
	mear =
	{
	    { block = "PAULNMAC", anim = "Piss_loop", time = -1 },
	    { block = "PAULNMAC", anim = "Piss_in", time = -1 },
		
	},
	paja =
	{
	    { block = "PAULNMAC", anim = "Wank_loop", time = -1 },
		
	},
	acabar = 
	{
		{ block = "paulnmac", anim = "wank_out", time = -1},
	},
	si =
	{
		{ block = "gangs", anim = "invite_yes", time = 4000 },
	},
	llorar =
	{
	   { block = "GRAVEYARD", anim = "mrnF_loop", time = -1 },	
	},
	agonizar =
	{
	    { block = "WUZI", anim = "CS_Dead_Guy", time = -1 },
		
	},
	apuntar =
	{
	    { block = "PED", anim = "gang_gunstand", time = -1 },
	    { block = "SHOP", anim = "ROB_Loop_Threat", time = -1 },
		
	},
	mostrardedo =
	{
	    { block = "PED", anim = "fucku", time = -1 },
		{ block = "RIOT", anim = "RIOT_FUKU", time = -1 },
		
	},
	que =
	{
	    { block = "RIOT", anim = "RIOT_ANGRY", time = 4000 },
		
	},
	ganar =
	{
	    { block = "CASINO", anim = "manwind", time = 2000 },
		
	},
	tocar =
	{
	    { block = "ped", anim = "endchat_01", time = 2000 },
	    { block = "CRIB", anim = "CRIB_Use_Switch", time = 2000 },
		
	},
	saludo =
	{
	    { block = "ped", anim = "endchat_03", time = 2000 },
		
	},
	caer =
	{
	    { block = "PED", anim = "FLOOR_hit_f", time = 4000 },
	    { block = "PED", anim = "FLOOR_hit", time = 4000 },
	    { block = "ped", anim = "KO_shot_stom", time = 4000 },
	    { block = "ped", anim = "KD_rigth", time = 4000 },
		
	},
	cachetazo =
	{
	    { block = "MISC", anim = "Bitchslap", time = -1 },
		
	},
	rascarse =
	{
	    { block = "MISC", anim = "scratchballs_01", time = -1 },
		
	},
	asustado =
	{
	    { block = "PED", anim = "duck_cower", time = -1 },
		
	},
	rcp =
	{
	    { block = "medic", anim = "cpr", time = -1 },
		
	},
	tomagil =
	{
	    { block = "RIOT", anim = "RIOT_FUKU", time = 800 },
		
	},
	dedo =
	{
	    { block = "MISC", anim = "Hiker_Pose", time = 800 },
	    { block = "MISC", anim = "Hiker_Pose_L", time = 800 },
		
	},
	suplicar =
	{
	    { block = "SHOP", anim = "SHP_Rob_React", time = 4000 },
		
	},
	copaway =
	{
	    { block = "police", anim = "coptraf_away", time = 1300 },
		
	},
	copcome =
	{
	    { block = "police", anim = "CopTraf_Come", time = -1 },
		
	},
	copleft =
	{
	    { block = "police", anim = "CopTraf_Left", time = -1 },
		
	},
	copstop =
	{
	    { block = "police", anim = "CopTraf_Stop", time = -1 },
		
	},
	smoke =
	{
		{ block = "lowrider", anim = "m_smkstnd_loop", time = -1 },
		{ block = "lowrider", anim = "m_smklean_loop", time = -1 },
		{ block = "lowrider", anim = "f_smklean_loop", time = -1 },
		{ block = "gangs", anim = "smkcig_prtl", time = -1 },
	},
    alentar =
	{
		{ block = "OTB", anim = "wtchrace_win", time = -1 },
		{ block = "RIOT", anim = "RIOT_shout", time = -1 },
		{ block = "STRIP", anim = "PUN_HOLLER", time = -1 },
	},
	carchat =
	{
		{ block = "CAR_CHAT", anim = "car_talkm_loop", time = -1 },
	},
	no =
	{
		{ block = "gangs", anim = "invite_no", time = 4000 },
	},
}
	    
local animationCooldowns = {}
local function setAnim(player, anim)
    if isElement(player) and anim and not isPedInVehicle(player) then
        local x, y, z = getElementVelocity(player)
        local speed = math.sqrt(x * x + y * y + z * z)
        
        if isPedOnGround(player) and speed <= 0.05 then
            local currentTime = getTickCount()
            local lastAnimationTime = animationCooldowns[player] and animationCooldowns[player][anim.anim] or 0
            
            if currentTime - lastAnimationTime >= 1200 then
                if not player:getData("Muerto") then  
                    setPedAnimation(player, anim.block, anim.anim, -1, true, false, false)
                    player:setData("animPlayer", true)
                    animationCooldowns[player] = animationCooldowns[player] or {}
                    animationCooldowns[player][anim.anim] = currentTime
                end
            end
        end
    end
end
function rendirse(thePlayer)
    if not getElementData(thePlayer, "rendirse") then
        local x, y, z = getElementVelocity(thePlayer)
        local speed = math.sqrt(x * x + y * y + z * z)
        
        if isPedOnGround(thePlayer) and speed <= 0.05 then
            local currentTime = getTickCount()
            local lastAnimationTime = animationCooldowns[thePlayer] and animationCooldowns[thePlayer]["handsup"] or 0
            
            if currentTime - lastAnimationTime >= 1200 then
                if not (thePlayer:getData("Muerto") and not thePlayer:getData("AceptarMuertoo")) then  -- Verifica si el jugador no está muerto o no ha aceptado la muerte
                    setPedAnimation(thePlayer, "ped", "handsup", -1, false, true, true, true)
                    thePlayer:setData("rendirse", true)
                    thePlayer:setData("animPlayer", true)
                    animationCooldowns[thePlayer] = animationCooldowns[thePlayer] or {}
                    animationCooldowns[thePlayer]["handsup"] = currentTime
                end
            end
        end
    else
        setPedAnimation(thePlayer)
        thePlayer:setData("rendirse", false)
        thePlayer:setData("animPlayer", false)
    end
end
local function playAnim(player, anim)
    local x, y, z = getElementVelocity(player)
    local speed = math.sqrt(x * x + y * y + z * z)
    
    if isPedOnGround(player) and speed <= 0.05 then
        local time = 0
        for key, value in ipairs(anim) do
            if time == 0 then
                setAnim(player, value)
            else
                setTimer(setAnim, time, 1, player, value)
            end
            
            if value.time == -1 then
                time = 0
                break
            else
                time = time + value.time
            end
        end
    end
end
-- Key animations
for key, value in pairs( anims ) do
	addCommandHandler( key,
		function( player, commandName, num )
			local anim = tonumber( num ) and value[ tonumber( num ) ] or value[ anim ] or #value == 0 and value or value[ 1 ]
			
			if #anim == 0 then
				anim = { anim }
			end
				
			playAnim( player, anim )
		end
	)
end
-- Stop animation
function stopAnim( player )
	if not player:getData("Roleplay:get_dead") == true then
		if player:getData("animPlayer") == true then
			setPedAnimation( player )
			player:setData("animPlayer", false)
		end
	end
end
addEventHandler("onResourceStart", resourceRoot, function()
	for _, player in ipairs(Element.getAllByType("player")) do
		bindKey(player, "space", "down", stopAnim)
		player:setData("animPlayer", false)
	end
end)
addEventHandler("onPlayerJoin", getRootElement(), function()
	bindKey(source, "space", "down", stopAnim)
	source:setData("animPlayer", false)
end)
-- Removes a players animation
addCommandHandler( {"parar"}, stopAnim )
-- Triggered when pressing 'space' as client
addEvent( "anims:reset", true )
addEventHandler( "anims:reset", root,
	function( )
		if client == source then
			stopAnim( source )
		end
	end
)
--
-- Animation help/commands
addCommandHandler("anim",
	function ( player, commandName, block, anim )
		if not notIsGuest( player ) then
			outputChatBox( "#7A7979/bar 1-7 /bat 1-7 /bomb /crack 1-4 /cpr /bailar 1-11 /fix", player, 255, 255, 255, true  )
			outputChatBox( "#7A7979/flag /gsign 1-11 /hablar 1-17 /gym 1-9 /provocar 1-6 /besar 1-6", player, 255, 255, 255, true  )
			outputChatBox( "#7A7979/tirarse 1-4 /recostar /no /pose 1-4 /sentar 1-14 /fumar 1-4 /observar", player, 255, 255, 255, true  )
			outputChatBox( "#7A7979/vomitar /cansado /cruzar /saludo 1-2 /si /caer 1-2 /sentar 1-17 /rendirse", player, 255, 255, 255, true )
		end
	end
)
