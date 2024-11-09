vehiculos = {
  -- {"pdls",596},
  --{"yosemite",554},
}
siempreOn = {
  {"copcarsf",597},
  {"copcarvg",598},
  {"ls",599},
  {"fbitruck",528},
  {"yosemiteFD",554},
}
skines = {
  {"211",211},
  {"288",288},
  {"245",245},
  {"283",283},
  {"266",266},
  {"267",267},
  {"298",298},
  {"190",190},
  {"248",248},
  {"254",254},
  {"247",247},
  {"100",100},
  {"73",73},
  --{"atomix",310},
}
function replaceModelSKIN()
  if skines then
    for k, v in ipairs(skines) do
      local modelo = v[1]
      local id = v[2]
      local txd = engineLoadTXD("carros/"..modelo..".txd", id )
      engineImportTXD(txd, id)
      local dff = engineLoadDFF("carros/"..modelo..".dff", id )
      engineReplaceModel(dff, id)
    end
  end
  if siempreOn then
    for k, v in ipairs(siempreOn) do
      local modelo = v[1]
      local id = v[2]
      local txd = engineLoadTXD("carros/"..modelo..".txd", id )
      engineImportTXD(txd, id)
      local dff = engineLoadDFF("carros/"..modelo..".dff", id )
      engineReplaceModel(dff, id)
    end
  end
end
addEventHandler ( "onClientResourceStart", getResourceRootElement(getThisResource()), replaceModelSKIN)
------------------------------------------------------------------------------------------------------
addEvent("VehModActivar", true)
function replaceModel()
  if vehiculos then
    for k, v in ipairs(vehiculos) do
      local modelo = v[1]
      local id = v[2]
      local txd = engineLoadTXD("carros/"..modelo..".txd", id )
      engineImportTXD(txd, id)
      local dff = engineLoadDFF("carros/"..modelo..".dff", id )
      engineReplaceModel(dff, id)
    end
  end
end
addEventHandler("VehModActivar", getRootElement(), replaceModel)
addEvent("VehModDesactivar", true)
function unreplaceModel()
  if vehiculos then
    for k, v in ipairs(vehiculos) do
      local id = v[2]
      engineRestoreModel( id )
    end
  end
end
addEventHandler("VehModDesactivar", getRootElement(), unreplaceModel)