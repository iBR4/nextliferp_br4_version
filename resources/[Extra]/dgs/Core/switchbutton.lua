--Dx Functions
local dxDrawImage = dxDrawImageExt
local dxDrawText = dxDrawText
local dxDrawRectangle = dxDrawRectangle
--DGS Functions
local dgsSetType = dgsSetType
local dgsGetType = dgsGetType
local dgsSetParent = dgsSetParent
local dgsSetData = dgsSetData
local applyColorAlpha = applyColorAlpha
local dgsTranslate = dgsTranslate
local dgsAttachToTranslation = dgsAttachToTranslation
local calculateGuiPositionSize = calculateGuiPositionSize
local dgsCreateTextureFromStyle = dgsCreateTextureFromStyle
--Utilities
local triggerEvent = triggerEvent
local createElement = createElement
local assert = assert
local tonumber = tonumber
local tostring = tostring
local tocolor = tocolor
local type = type
local mathMin = math.min
local mathMax = math.max

function dgsCreateSwitchButton(...)
	local x,y,w,h,textOn,textOff,state,relative,parent,textColorOn,textColorOff,scaleX,scaleY
	if select("#",...) == 1 and type(select(1,...)) == "table" then
		local argTable = ...
		x = argTable.x or argTable[1]
		y = argTable.y or argTable[2]
		w = argTable.width or argTable.w or argTable[3]
		h = argTable.height or argTable.h or argTable[4]
		textOn = argTable.textOn or argTable[5]
		textOff = argTable.textOff or argTable[6]
		state = argTable.state or argTable[7]
		relative = argTable.relative or argTable.rlt or argTable[8]
		parent = argTable.parent or argTable.p or argTable[9]
		textColorOn = argTable.textColorOn or argTable[10]
		textColorOff = argTable.textColorOff or argTable[11]
		scaleX = argTable.scaleX or argTable[12]
		scaleY = argTable.scaleY or argTable[13]
	else
		x,y,w,h,textOn,textOff,state,relative,parent,textColorOn,textColorOff,scaleX,scaleY = ...
	end
	if not(type(x) == "number") then error(dgsGenAsrt(x,"dgsCreateSwitchButton",1,"number")) end
	if not(type(y) == "number") then error(dgsGenAsrt(y,"dgsCreateSwitchButton",2,"number")) end
	if not(type(w) == "number") then error(dgsGenAsrt(w,"dgsCreateSwitchButton",3,"number")) end
	if not(type(h) == "number") then error(dgsGenAsrt(h,"dgsCreateSwitchButton",4,"number")) end
	local switchbutton = createElement("dgs-dxswitchbutton")
	dgsSetType(switchbutton,"dgs-dxswitchbutton")
	dgsSetParent(switchbutton,parent,true,true)
	local style = styleSettings.switchbutton
	local imageOn = style.imageOn
	local norimg_o,hovimg_o,cliimg_o = dgsCreateTextureFromStyle(imageOn[1]),dgsCreateTextureFromStyle(imageOn[2]),dgsCreateTextureFromStyle(imageOn[3])
	local imageOff = style.imageOff
	local norimg_f,hovimg_f,cliimg_f = dgsCreateTextureFromStyle(imageOff[1]),dgsCreateTextureFromStyle(imageOff[2]),dgsCreateTextureFromStyle(imageOff[3])
	local cursorImage = style.cursorImage
	local norimg_c,hovimg_c,cliimg_c = dgsCreateTextureFromStyle(cursorImage[1]),dgsCreateTextureFromStyle(cursorImage[2]),dgsCreateTextureFromStyle(cursorImage[3])
	local textSizeX,textSizeY = tonumber(scaleX) or style.textSize[1], tonumber(scaleY) or style.textSize[2]
	dgsElementData[switchbutton] = {
		renderBuffer = {};
		colorOn = style.colorOn,
		colorOff = style.colorOff,
		cursorColor = style.cursorColor,
		imageOn = {norimg_o,hovimg_o,cliimg_o},
		imageOff = {norimg_f,hovimg_f,cliimg_f},
		cursorImage = {norimg_c,hovimg_c,cliimg_c},
		textColorOn = tonumber(textColorOn) or style.textColorOn,
		textColorOff = tonumber(textColorOff) or style.textColorOff,
		textSize = {textSizeX,textSizeY},
		shadow = {nil,nil,nil},
		font = style.font or systemFont,
		textOffset = {0.25,true},
		state = state and true or false,
		cursorMoveSpeed = 0.2,
		stateAnim = state and 1 or -1,
		clickButton = "left"; --"left":LMB;"middle":Wheel;"right":RM,
		clickState = "up"; --"down":Down;"up":U,
		cursorWidth = style.cursorWidth,
		clip = false,
		wordbreak = false,
		colorcoded = false,
		style = 1,
	}
	dgsAttachToTranslation(switchbutton,resourceTranslation[sourceResource or resource])
	if type(textOn) == "table" then
		dgsElementData[switchbutton]._translationtextOn = textOn
		textOn = dgsTranslate(switchbutton,textOn,sourceResource)
	end
	if type(textOff) == "table" then
		dgsElementData[switchbutton]._translationtextOff = textOff
		textOff = dgsTranslate(switchbutton,textOff,sourceResource)
	end
	dgsElementData[switchbutton].textOn = tostring(textOn)
	dgsElementData[switchbutton].textOff = tostring(textOff)
	calculateGuiPositionSize(switchbutton,x,y,relative or false,w,h,relative or false,true)
	triggerEvent("onDgsCreate",switchbutton,sourceResource)
	return switchbutton
end

function dgsSwitchButtonGetState(switchbutton)
	if not(dgsGetType(switchbutton) == "dgs-dxswitchbutton") then error(dgsGenAsrt(switchbutton,"dgsSwitchButtonGetState",1,"dgs-dxswitchbutton")) end
	return dgsElementData[switchbutton].state
end

function dgsSwitchButtonSetState(switchbutton,state)
	if not(dgsGetType(switchbutton) == "dgs-dxswitchbutton") then error(dgsGenAsrt(switchbutton,"dgsSwitchButtonSetState",1,"dgs-dxswitchbutton")) end
	return dgsSetData(switchbutton,"state",state and true or false)
end

function dgsSwitchButtonSetText(switchbutton,textOn,textOff)
	if not(dgsGetType(switchbutton) == "dgs-dxswitchbutton") then error(dgsGenAsrt(switchbutton,"dgsSwitchButtonSetText",1,"dgs-dxswitchbutton")) end
	if type(textOn) == "table" then
		dgsElementData[switchbutton]._translationtextOn = textOn
		textOn = dgsTranslate(switchbutton,textOn,sourceResource)
	else
		dgsElementData[switchbutton]._translationtextOn = nil
	end
	if type(textOff) == "table" then
		dgsElementData[switchbutton]._translationtextOff = textOff
		textOff = dgsTranslate(switchbutton,textOff,sourceResource)
	else
		dgsElementData[switchbutton]._translationtextOff = nil
	end
	textOn = textOn or dgsElementData[switchbutton].textOn
	textOff = textOff or dgsElementData[switchbutton].textOff
	dgsSetData(switchbutton,"textOn",tostring(textOn))
	dgsSetData(switchbutton,"textOff",tostring(textOff))
end

function dgsSwitchButtonGetText(switchbutton)
	if not(dgsGetType(switchbutton) == "dgs-dxswitchbutton") then error(dgsGenAsrt(switchbutton,"dgsSwitchButtonGetText",1,"dgs-dxswitchbutton")) end
	return dgsElementData[switchbutton].textOn,dgsElementData[switchbutton].textOff
end

----------------------------------------------------------------
--------------------------Renderer------------------------------
----------------------------------------------------------------
dgsRenderer["dgs-dxswitchbutton"] = function(source,x,y,w,h,mx,my,cx,cy,enabledInherited,enabledSelf,eleData,parentAlpha,isPostGUI,rndtgt)
	local imageOff,imageOn = eleData.imageOff,eleData.imageOn
	local colorOff,colorOn = eleData.colorOff,eleData.colorOn
	local textColor,text
	local xAdd = eleData.textOffset[2] and w*eleData.textOffset[1] or eleData.textOffset[1]
	if eleData.state then
		textColor,text,xAdd = eleData.textColorOn,eleData.textOn,-xAdd
	else
		textColor,text = eleData.textColorOff,eleData.textOff
	end
	local style = eleData.style
	local colorImgBgID = 1
	local colorImgID = 1
	local cursorWidth = eleData.cursorWidth[2] and w*eleData.cursorWidth[1] or eleData.cursorWidth[1]
	local animProgress = (eleData.stateAnim+1)*0.5
	local cursorX = x+animProgress*(w-cursorWidth)
	if MouseData.entered == v then
		local isHitCursor = mx >= cursorX and mx <= cursorX+cursorWidth
		colorImgBgID = 2
		if isHitCursor then
			colorImgID = 2
		end
		if eleData.clickType == 1 and MouseData.clickl == v then
			colorImgBgID = 3
			colorImgID = isHitCursor and 3 or colorImgID
		elseif eleData.clickType == 2 and MouseData.clickr == v then
			colorImgBgID = 3
			colorImgID = isHitCursor and 3 or colorImgID
		else
			if MouseData.clickl == v or MouseData.clickr == v then
				colorImgBgID = 3
				colorImgID = isHitCursor and 3 or colorImgID
			end
		end
	end
	local cursorImage = eleData.cursorImage[colorImgID]
	local cursorColor = eleData.cursorColor[colorImgID]
	if not enabledInherited and not enabledSelf then
		if type(eleData.disabledColor) == "number" then
			color = applyColorAlpha(eleData.disabledColor,parentAlpha)
		elseif eleData.disabledColor == true then
			local r,g,b,a = fromcolor(cursorColor,true)
			local average = (r+g+b)/3*eleData.disabledColorPercent
			cursorColor = tocolor(average,average,average,a*parentAlpha)
		end
	else
		cursorColor = applyColorAlpha(cursorColor,parentAlpha)
	end
	if not style then
		local color = colorOff[colorImgID]+(colorOn[colorImgID]-colorOff[colorImgID])*animProgress
		if not enabledInherited and not enabledSelf then
			if type(eleData.disabledColor) == "number" then
				color = applyColorAlpha(eleData.disabledColor,parentAlpha)
			elseif eleData.disabledColor == true then
				local r,g,b,a = fromcolor(color,true)
				local average = (r+g+b)/3*eleData.disabledColorPercent
				color = tocolor(average,average,average,a*parentAlpha)
			end
		else
			color = applyColorAlpha(color,parentAlpha)
		end
		if animProgress == 0 then
			local _empty = imageOff[colorImgBgID] and dxDrawImage(x,y,w,h,imageOff[colorImgBgID],0,0,0,color,isPostGUI,rndtgt) or dxDrawRectangle(x,y,w,h,color,isPostGUI)
		elseif animProgress == 1 then
			local _empty = imageOn[colorImgBgID] and dxDrawImage(x,y,w,h,imageOn[colorImgBgID],0,0,0,color,isPostGUI,rndtgt) or dxDrawRectangle(x,y,w,h,color,isPostGUI)
		else
			local offColor = applyColorAlpha(color,1-animProgress)
			local onColor = applyColorAlpha(color,animProgress)

			local _empty = imageOff[colorImgBgID] and dxDrawImage(x,y,w,h,imageOff[colorImgBgID],0,0,0,offColor,isPostGUI,rndtgt) or dxDrawRectangle(x,y,w,h,offColor,isPostGUI)
			local _empty = imageOn[colorImgBgID] and dxDrawImage(x,y,w,h,imageOn[colorImgBgID],0,0,0,onColor,isPostGUI,rndtgt) or dxDrawRectangle(x,y,w,h,onColor,isPostGUI)
		end
	elseif style == 1 then
		local colorOn = colorOn[colorImgID]
		local colorOff = colorOff[colorImgID]
		if not enabledInherited and not enabledSelf then
			if type(eleData.disabledColor) == "number" then
				colorOn = applyColorAlpha(eleData.disabledColor,parentAlpha)
				colorOff = applyColorAlpha(eleData.disabledColor,parentAlpha)
			elseif eleData.disabledColor == true then
				local r,g,b,a = fromcolor(colorOn,true)
				local average = (r+g+b)/3*eleData.disabledColorPercent
				colorOn = tocolor(average,average,average,a*parentAlpha)
				local r,g,b,a = fromcolor(colorOff,true)
				local average = (r+g+b)/3*eleData.disabledColorPercent
				colorOff = tocolor(average,average,average,a*parentAlpha)
			end
		else
			colorOn = applyColorAlpha(colorOn,parentAlpha)
			colorOff = applyColorAlpha(colorOff,parentAlpha)
		end

		local _empty = imageOff[colorImgBgID] and dxDrawImage(x,y,cursorX-x+cursorWidth/2,h,imageOff[colorImgBgID],0,0,0,colorOff,isPostGUI,rndtgt) or dxDrawRectangle(x,y,cursorX-x+cursorWidth/2,h,colorOff,isPostGUI)
		local _empty = imageOn[colorImgBgID] and dxDrawImage(cursorX+cursorWidth/2,y,w-(cursorX-x+cursorWidth/2),h,imageOn[colorImgBgID],0,0,0,colorOn,isPostGUI,rndtgt) or dxDrawRectangle(cursorX+cursorWidth/2,y,w-(cursorX-x+cursorWidth/2),h,colorOn,isPostGUI)
	end
	local font = eleData.font or systemFont
	local txtSizX,txtSizY = eleData.textSize[1],eleData.textSize[2] or eleData.textSize[1]
	local clip = eleData.clip
	local wordbreak = eleData.wordbreak
	local colorcoded = eleData.colorcoded
	local shadow = eleData.shadow
	local textX,textY,textWX,textHY = x+w*0.5+xAdd-cursorWidth,y,x+w*0.5+xAdd+cursorWidth,y+h
	if shadow then
		local shadowoffx,shadowoffy,shadowc,shadowIsOutline = shadow[1],shadow[2],shadow[3],shadow[4]
		if shadowoffx and shadowoffy and shadowc then
			local shadowc = applyColorAlpha(shadowc,parentAlpha)
			local shadowText = colorcoded and text:gsub('#%x%x%x%x%x%x','') or text
			dxDrawText(shadowText,textX+shadowoffx,textY+shadowoffy,textWX+shadowoffx,textHY+shadowoffy,shadowc,txtSizX,txtSizY,font,"center","center",clip,wordbreak,isPostGUI)
			if shadowIsOutline then
				dxDrawText(shadowText,textX-shadowoffx,textY+shadowoffy,textWX-shadowoffx,textHY+shadowoffy,shadowc,txtSizX,txtSizY,font,"center","center",clip,wordbreak,isPostGUI)
				dxDrawText(shadowText,textX-shadowoffx,textY-shadowoffy,textWX-shadowoffx,textHY-shadowoffy,shadowc,txtSizX,txtSizY,font,"center","center",clip,wordbreak,isPostGUI)
				dxDrawText(shadowText,textX+shadowoffx,textY-shadowoffy,textWX+shadowoffx,textHY-shadowoffy,shadowc,txtSizX,txtSizY,font,"center","center",clip,wordbreak,isPostGUI)
			end
		end
	end
	dxDrawText(text,textX,textY,textWX,textHY,applyColorAlpha(textColor,parentAlpha),txtSizX,txtSizY,font,"center","center",clip,wordbreak,isPostGUI,colorcoded)
	----Cursor
	if cursorImage then
		dxDrawImage(cursorX,y,cursorWidth,h,cursorImage,0,0,0,cursorColor,isPostGUI,rndtgt)
	else
		dxDrawRectangle(cursorX,y,cursorWidth,h,cursorColor,isPostGUI)
	end

	local state = eleData.state and 1 or -1
	if eleData.stateAnim ~= state then
		local stat = eleData.stateAnim+state*eleData.cursorMoveSpeed
		eleData.stateAnim = state == -1 and mathMax(stat,state) or mathMin(stat,state)
	end
	------------------------------------
	return rndtgt
end