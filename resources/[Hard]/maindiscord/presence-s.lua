--[[
    https://discord.com/developers/applications <- LINK DISCORD DEVELOPERS PAGE
    CREATE APPLICATION (WITH YOUR SERVER NAME)
    INSERT YOUR SERVER LOGO
    COPY THIS APPLICATION ID
--]]

-- loadstring(exports.MySQL:getMyCode())()
-- import('*'):init('MySQL')

local application = {
    id = "1188689706641264751", -- Application ID
    logo_name = "Next Life",
    details = "Roleplay Server",
    state = "Jugadores",
    max_slots = tonumber(getServerConfigSetting("maxplayers")),
    logo = "https://i.imgur.com/knZwaEn.png",
    buttons = {
        [1] = {
            use = true,
            name = "Discord",
            link = "https://discord.gg/GrQRNsQu"
        },
        [2] = {
            use = true,
            name = "Conectar",
            link = "mtasa://26.0.147.32:22003"
        }
    }
};

addEventHandler("onPlayerResourceStart", root,
    function(theResource)
        if (theResource == resource) then
            triggerClientEvent(source, "addPlayerRichPresence", source, application);
        end
    end
);

addEventHandler( "onPlayerJoin", getRootElement(), 
function()
    triggerClientEvent(source, "addPlayerRichPresence", source, application);
end)
