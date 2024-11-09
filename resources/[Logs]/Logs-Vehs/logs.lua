local discordWebhookLOGS = "https://discordapp.com/api/webhooks/1193333691276066846/PncJe2z_apyTQVeITkXKW_FrGp_wEZPuEp2lI-q5BdWtBp2TtaN-6LJvnUceSSu2YhTe"

local hours, minutes, seconds

function callback()
end

function sendDiscordLogMessage(message, thePlayer)
    	if message and #message > 0 then
            local time = getRealTime( )
            local hours = time.hour
            local minutes = time.minute
            local seconds = time.second

            if (hours < 10) then
                hours = "0"..hours
            end
            if (minutes < 10) then
                minutes = "0"..minutes
            end
            if (seconds < 10) then
                seconds = "0"..seconds
            end
    	    sendOptions = {
    	        queueName = "dcq",
    	        connectionAttempts = 3,
    	        connectTimeout = 5000,
    	        formFields = { 
    	            content="`"..( "[%04d/%02d/%02d" ):format( time.year + 1900, time.month + 1, time.monthday ).." - "..hours..":"..minutes..":"..seconds.."]` "..message..""
    	        },
    	    }
            fetchRemote ( discordWebhookLOGS, sendOptions, callback )
    	end
    
end