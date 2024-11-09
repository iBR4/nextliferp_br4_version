local texturesimg = {
  {
    "img/radar_LocoSyndicate.png",
    "radar_LocoSyndicate"
  },
  {
    "img/radar_WOOZIE.png",
    "radar_WOOZIE"
  },
  {
    "img/radar_ZERO.png",
    "radar_ZERO"
  },
  {
    "img/radar_SWEET.png",
    "radar_SWEET"
  },
  {
    "img/radar_BIGSMOKE.png",
    "radar_BIGSMOKE"
  },
  {
    "img/radar_airYard.png",
    "radar_airYard"
  },
}
addEventHandler("onClientResourceStart", resourceRoot, function()
  for i = 1, #texturesimg do
    local shader = dxCreateShader("shader/shader.fx")
    engineApplyShaderToWorldTexture(shader, texturesimg[i][2])
    dxSetShaderValue(shader, "gTexture", dxCreateTexture(texturesimg[i][1]))
  end
end)
