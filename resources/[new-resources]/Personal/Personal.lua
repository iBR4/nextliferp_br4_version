-- Creditos: Z·
local Personal = { 
          ["9B5B939B53264C229A38DCE5C7B21BF4"] = true, --UnitedTR
          ["A748A35F0F5C8E40EE022D6DAAC6BFE4"] = true, --Leox
          ["B9A01DBD7E4B3236B266015B319CA7B2"] = true, --Ivan

} 
    
  addEventHandler( "onPlayerConnect", root, function (_, _, _, serial) 
        if not ( Personal[ serial ] ) then 
          cancelEvent( true, "Servidor En Mentanimiento Estamos Actualizando Para Mas Informacion Accede a nuestro Discord : https://discord.gg/WFn3VuAk" ) 
      end 
  end ) 