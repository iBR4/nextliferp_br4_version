local blipTextureNames = {

}

local radarTextureNames = {
	"radar00",
	"radar01",
	"radar02",
	"radar03",
	"radar04",
	"radar05",
	"radar06",
	"radar07",
	"radar08",
	"radar09",
	"radar10",
	"radar11",
	"radar12",
	"radar13",
	"radar14",
	"radar15",
	"radar16",
	"radar17",
	"radar18",
	"radar19",
	"radar20",
	"radar21",
	"radar22",
	"radar23",
	"radar24",
	"radar25",
	"radar26",
	"radar27",
	"radar28",
	"radar29",
	"radar30",
	"radar31",
	"radar32",
	"radar33",
	"radar34",
	"radar35",
	"radar36",
	"radar37",
	"radar38",
	"radar39",
	"radar40",
	"radar41",
	"radar42",
	"radar43",
	"radar44",
	"radar45",
	"radar46",
	"radar47",
	"radar48",
	"radar49",
	"radar50",
	"radar51",
	"radar52",
	"radar53",
	"radar54",
	"radar55",
	"radar56",
	"radar57",
	"radar58",
	"radar59",
	"radar60",
	"radar61",
	"radar62",
	"radar63",
	"radar64",
	"radar65",
	"radar66",
	"radar67",
	"radar68",
	"radar69",
	"radar70",
	"radar71",
	"radar72",
	"radar73",
	"radar74",
	"radar75",
	"radar76",
	"radar77",
	"radar78",
	"radar79",
	"radar80",
	"radar81",
	"radar82",
	"radar83",
	"radar84",
	"radar85",
	"radar86",
	"radar87",
	"radar88",
	"radar89",
	"radar90",
	"radar91",
	"radar92",
	"radar93",
	"radar94",
	"radar95",
	"radar96",
	"radar97",
	"radar98",
	"radar99",
	"radar100",
	"radar101",
	"radar102",
	"radar103",
	"radar104",
	"radar105",
	"radar106",
	"radar107",
	"radar108",
	"radar109",
	"radar110",
	"radar111",
	"radar112",
	"radar113",
	"radar114",
	"radar115",
	"radar116",
	"radar117",
	"radar118",
	"radar119",
	"radar120",
	"radar121",
	"radar122",
	"radar123",
	"radar124",
	"radar125",
	"radar126",
	"radar127",
	"radar128",
	"radar129",
	"radar130",
	"radar131",
	"radar132",
	"radar133",
	"radar134",
	"radar135",
	"radar136",
	"radar137",
	"radar138",
	"radar139",
	"radar140",
	"radar141",
	"radar142",
	"radar143",
}

function replaceTexture(textureName, imgPath)
	local textureReplaceShader = dxCreateShader("client/shaders/texture_replace.fx", 0, 0, false, "world")
    local texture = dxCreateTexture(imgPath .. textureName .. ".png")
    dxSetShaderValue(textureReplaceShader, "gTexture", texture)
    engineApplyShaderToWorldTexture(textureReplaceShader, textureName)
end

function replaceRadarTextures()
    for i, textureName in ipairs(blipTextureNames) do
    	replaceTexture(textureName, "client/img/radar/blips/")
    end

    for i, textureName in ipairs(radarTextureNames) do
    	replaceTexture(textureName, "client/img/radar/map/")
    end
end

addEventHandler("onClientResourceStart", resourceRoot, replaceRadarTextures)