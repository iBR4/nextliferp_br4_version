local VERSION = 10

-- addEventHandler( "onResourceStart", resourceRoot,
-- 	function ( )
--         fetchRemote("https://api.github.com/repos/clawsuit/dxLibrary/releases/latest", 
--         	function(data, status)
--            		assert(status == 0 and data, resource.name..": Can't fetch 'api.github.com' for new releases! ( Status code: "..tostring(status).." ) " )

-- 	            data = fromJSON( data )

-- 	            if data then

-- 	            	local dataTag = tostring( data[ "tag_name" ] )
--                 	local dataVersion = tonumber( ( dataTag:gsub("v",""):gsub("%.","") ) )                	

--                 	if dataVersion > VERSION then
                
--                         fetchRemote(data["zipball_url"], 
                              	
--                            	function(data, status)
--                                 assert(status == 0 and data, resource.name..": Can't download latest release ("..dataTag..") from Github! (Status code: "..tostring(status)..")")
--                                 local zip = fileCreate("releases/dxLibrary-"..dataTag..'.zip')
--                                 if zip then
--                                     fileWrite(zip, data)
--                                     fileClose(zip)
--                                     iprint(resource.name..": New release ("..dataTag..") available on Github! Automatically downloaded into 'releases' directory inside "..resource.name..", just replace the old one!")
--                                 end
--                             end
--                         )                      

--                 	end

-- 	            end

--         	end
--         )
		
-- 	end
-- )

