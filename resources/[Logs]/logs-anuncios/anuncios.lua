local discordWebhookLOGS = "https://discord.com/api/webhooks/1143984192745640078/1Riv_A7d-VXvEfGtcLcWZBt-Enldf0aq7pQ5Df-Aqc-6eIgYyJRDT2DUJpssgJfInpEy"

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
    	            content=""..message..""
    	        },
    	    }
            fetchRemote ( discordWebhookLOGS, sendOptions, callback )
    	end
end