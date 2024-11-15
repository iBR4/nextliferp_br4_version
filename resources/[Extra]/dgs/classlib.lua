-------OOP
if not getElementData(root,"__DGSRes") then assert(false,"Invalid DGS Resource! Please check whether your dgs resource is started") end
if not dgsImportHead then loadstring(exports[getElementData(root,"__DGSRes")]:dgsImportFunction())() end
if dgsOOP and dgsOOP.dgsRes and isElement(getResourceRootElement(dgsOOP.dgsRes)) then return end
local getmetatable = getmetatable
local setmetatable = setmetatable
local tostring = tostring
local tonumber = tonumber
local call = call
local setfenv = setfenv
dgsOOP = {
	dgsClasses = {},
	dgsInstances = {},
	eventHandler = {},
	dgsRes = getElementData(root,"__DGSRes"),
	dgsRoot = getResourceRootElement(getElementData(root,"__DGSRes")),
	transfromEventName = function(eventName,isReverse)
		--local isFindDGS = eventName:lower():find("dgs") and true or false
		return isReverse and (eventName:sub(3,3):lower()..eventName:sub(4)) or ("on"..eventName:sub(1,1):upper()..eventName:sub(2))
	end,
	getVectorType = function(vec)
		local vecData = tostring(vec)
		local typeName = vecData:sub(1,6)
		if typeName == "vector" then
			return strToIntCache[vecData:sub(7,7)] or false
		elseif typeName == "table:" then
			return "table"
		end
		return false
	end,
	deepCopy = function(obj)
		local InTable = {}
		local function Func(obj)
			if type(obj) ~= "table" then
				return obj
			end
			local NewTable = {}
			InTable[obj] = NewTable
			for k,v in pairs(obj) do
				NewTable[Func(k)] = Func(v)
			end
			return setmetatable(NewTable,getmetatable(obj))
		end
		return Func(obj)
	end,
	shallowCopy = function(obj)
		local InTable = {}
		for k,v in pairs(obj) do
			InTable[k] = v
		end
		return InTable
	end,
}
dgsRoot = dgsOOP.dgsRoot

do
-------Utils
local strToIntCache = {
	["1"]=1,
	["2"]=2,
	["3"]=3,
	["4"]=4,
}

local function class(tab)
	dgsOOP.dgsClasses[tab.dgsType or tab.type] = tab
	local meta = {
		__call = function(self,...)	--can be  optimized with class cache
			local meta = getmetatable(self)
			setmetatable(self,nil)
			local newMeta = dgsOOP.deepCopy(self)
			setmetatable(self,meta)
			local newInstance = {extends=newMeta.extends}
			if newMeta.preInstantiate then
				newInstance.dgsElement = newMeta.preInstantiate(...)	--Pre Instantiate function doesn't include meta table
				dgsOOP.dgsInstances[newInstance.dgsElement] = newInstance
			end
			newInstance.extends = nil
			newMeta.extends = nil
			newMeta.preInstantiate = nil
			newMeta.default = newMeta.default or {}
			newMeta.public = newMeta.public or {}
			newMeta.__index = newMeta.default.__index or newMeta.public.__index
			newMeta.__newindex = newMeta.default.__newindex or newMeta.public.__newindex
			newMeta.public.__index = nil
			newMeta.public.__newindex = nil
			newMeta.default.__index = nil
			newMeta.default.__newindex = nil
			for k,v in pairs(newMeta.public) do
				newInstance[k] = v
			end
			for k,v in pairs(newMeta.default) do
				newInstance[k] = v
			end
			newMeta.public = nil
			newMeta.default = nil
			setmetatable(newInstance,newMeta)
			if newMeta.init then
				newMeta.init(newInstance)
			end
			return newInstance
		end,
		__index = function(self,dgsElement)
			local meta = getmetatable(self)
			setmetatable(self,nil)
			local newMeta = dgsOOP.deepCopy(self)
			setmetatable(self,meta)
			local newInstance = {extends=newMeta.extends}
			if newMeta.preInstantiate then
				newInstance.dgsElement = dgsElement	--For converting dgs pop element to oop instance
				dgsOOP.dgsInstances[newInstance.dgsElement] = newInstance
			end
			newInstance.extends = nil
			newMeta.extends = nil
			newMeta.preInstantiate = nil
			newMeta.default = newMeta.default or {}
			newMeta.public = newMeta.public or {}
			newMeta.__index = newMeta.default.__index or newMeta.public.__index
			newMeta.__newindex = newMeta.default.__newindex or newMeta.public.__newindex
			newMeta.public.__index = nil
			newMeta.public.__newindex = nil
			newMeta.default.__index = nil
			newMeta.default.__newindex = nil
			for k,v in pairs(newMeta.public) do
				newInstance[k] = v
			end
			for k,v in pairs(newMeta.default) do
				newInstance[k] = v
			end
			newMeta.public = nil
			newMeta.default = nil
			setmetatable(newInstance,newMeta)
			return newInstance
		end
	}
	if tab.extends then
		tab.public = tab.public or {}
		if type(tab.extends) ~= "table" then
			local extendsClass = dgsOOP[tab.extends]
			for k,v in pairs(extendsClass.public or {}) do
				tab.public[k] = v
			end
		else
			for key,extend in ipairs(tab.extends) do
				local extendsClass = dgsOOP[extend]
				for k,v in pairs(extendsClass.public or {}) do
					tab.public[k] = v
				end
			end
		end
	end
	if tab.inject then
		for theType,space in pairs(tab.inject) do
			local classData = dgsOOP[theType]
			for name,fnc in pairs(space.default) do
				classData.public[name] = fnc
			end
		end
	end
	setmetatable(tab,meta)
	dgsOOP[tab.type] = tab
end
dgsOOP.class = class

function dgsOOP.genInterface(dgsElement,meta)
	local newmeta = dgsOOP.shallowCopy(meta)
	newmeta.dgsElement = dgsElement
	return setmetatable({"DGS OOP: Bad usage"},newmeta)()
end

dgsOOP.genOOPFnc = function(pop,isChain) return isChain and (function(self,...) return call(dgsOOP.dgsRes,pop,self.dgsElement,...) and self or false end) or (function(self,...) return dgsGetInstance(call(dgsOOP.dgsRes,pop,self.dgsElement,...)) end) end
dgsOOP.genOOPFncNonObj = function(pop,isChain) return (function(self,...) return dgsGetInstance(call(dgsOOP.dgsRes,pop,...)) end) end
local gObjFnc = dgsOOP.genOOPFnc
local gNObjFnc = dgsOOP.genOOPFncNonObj
----------------DGS 2D
dgsOOP.position2D = {
	__index=function(self,key)
		local meta = getmetatable(self)
		if not isElement(meta.dgsElement) then return false end
		if key == "relative" then
			return dgsGetProperty(meta.dgsElement,"relative")[1]
		elseif key == "x" then
			local pos = dgsGetProperty(meta.dgsElement,"relative")[1] and dgsGetProperty(meta.dgsElement,"rltPos") or dgsGetProperty(meta.dgsElement,"absPos")
			return pos[1]
		elseif key == "y" then
			local pos = dgsGetProperty(meta.dgsElement,"relative")[1] and dgsGetProperty(meta.dgsElement,"rltPos") or dgsGetProperty(meta.dgsElement,"absPos")
			return pos[2]
		elseif key == "toVector" then
			local pos = dgsGetProperty(meta.dgsElement,"relative")[1] and dgsGetProperty(meta.dgsElement,"rltPos") or dgsGetProperty(meta.dgsElement,"absPos")
			return Vector2(pos)
		end
	end,
	__newindex=function(self,key,value)
		local meta = getmetatable(self)
		if not isElement(meta.dgsElement) then return false end
		if key == "relative" then
			local rlt = dgsGetProperty(meta.dgsElement,"relative")
			rlt[1] = value
			return dgsSetProperty(meta.dgsElement,"relative",rlt)
		elseif key == "x" then
			local rlt = dgsGetProperty(meta.dgsElement,"relative")
			return dgsSetPosition(meta.dgsElement,value,_,rlt[1])
		elseif key == "y" then
			local rlt = dgsGetProperty(meta.dgsElement,"relative")
			return dgsSetPosition(meta.dgsElement,_,value,rlt[1])
		end
	end,
	__call=function(self,key)
		local meta = getmetatable(self)
		setmetatable(self,nil)
		local rlt = dgsGetProperty(meta.dgsElement,"relative")
		self[1],self[2] = dgsGetPosition(meta.dgsElement,rlt[1])
		setmetatable(self,meta)
		return self
	end,
}

dgsOOP.size2D = {
	__isAvailable = true,
	__index=function(self,key)
		local meta = getmetatable(self)
		if not isElement(meta.dgsElement) then return false end
		if key == "relative" then
			return dgsGetProperty(meta.dgsElement,"relative")[2]
		elseif key == "w" or key == "width" then
			local size = dgsGetProperty(meta.dgsElement,"relative")[2] and dgsGetProperty(meta.dgsElement,"rltSize") or dgsGetProperty(meta.dgsElement,"absSize")
			return size[1]
		elseif key == "h" or key == "height" then
			local size = dgsGetProperty(meta.dgsElement,"relative")[2] and dgsGetProperty(meta.dgsElement,"rltSize") or dgsGetProperty(meta.dgsElement,"absSize")
			return size[2]
		elseif key == "toVector" then
			local size = dgsGetProperty(meta.dgsElement,"relative")[2] and dgsGetProperty(meta.dgsElement,"rltSize") or dgsGetProperty(meta.dgsElement,"absSize")
			return Vector2(size)
		end
	end,
	__newindex=function(self,key,value)
		local meta = getmetatable(self)
		if not isElement(meta.dgsElement) then return false end
		if key == "relative" then
			local rlt = dgsGetProperty(meta.dgsElement,"relative")
			rlt[2] = value
			return dgsSetProperty(meta.dgsElement,"relative",rlt)
		elseif key == "w" then
			local rlt = dgsGetProperty(meta.dgsElement,"relative")
			return dgsSetSize(meta.dgsElement,value,_,rlt[2])
		elseif key == "h" then
			local rlt = dgsGetProperty(meta.dgsElement,"relative")
			return dgsSetSize(meta.dgsElement,_,value,rlt[2])
		end
	end,
	__call=function(self,key)
		local meta = getmetatable(self)
		setmetatable(self,nil)
		local rlt = dgsGetProperty(meta.dgsElement,"relative")
		self[1],self[2] = dgsGetSize(meta.dgsElement,rlt[2])
		setmetatable(self,meta)
		return self
	end,
}

--2 Types:
--default: Will not inherit
--public: Will inherit

class {
	type = "dgsRoot";
	dgsType = "resourceRoot";
	preInstantiate = function(self)
		return getResourceRootElement(dgsOOP.dgsRes)
	end;
	init = function(self)
		--Expose Functions
		for k,v in pairs(self) do
			_G[k] = v
		end
	end;
	default = {
		isStyleAvailable = gNObjFnc("dgsIsStyleAvailable"),
		getLoadedStyleList = gNObjFnc("dgsGetLoadedStyleList"),
		setCurrentStyle = gNObjFnc("dgsSetCurrentStyle"),
		getCurrentStyle = gNObjFnc("dgsGetCurrentStyle"),
		getScreenSize = function(self) return Vector2(guiGetScreenSize()) end,
		setInputEnabled = function(self,...) return guiSetInputEnabled(...) end,
		getInputEnabled = function(self,...) return guiGetInputEnabled(...) end,
		setInputMode = function(self,...) return guiSetInputMode(...) end,
		getInputMode = function(self,...) return guiGetInputMode(...) end,
		setRenderSetting = gNObjFnc("dgsSetRenderSetting"),
		getRenderSetting = gNObjFnc("dgsGetRenderSetting"),
		getLayerElements = gNObjFnc("dgsGetLayerElements"),
		addEasingFunction = gNObjFnc("dgsAddEasingFunction"),
		easingFunctionExists = gNObjFnc("dgsEasingFunctionExists"),
		removeEasingFunction = gNObjFnc("dgsRemoveEasingFunction"),
		getSystemFont = gNObjFnc("dgsGetSystemFont"),
		setSystemFont = gNObjFnc("dgsSetSystemFont"),
		translationTableExists = gNObjFnc("dgsTranslationTableExists"),
		setTranslationTable = gNObjFnc("dgsSetTranslationTable"),
		setAttachTranslation = gNObjFnc("dgsSetAttachTranslation"),
		setMultiClickInterval = gNObjFnc("dgsSetMultiClickInterval"),
		getMultiClickInterval = gNObjFnc("dgsGetMultiClickInterval"),
		setCursorImage = gNObjFnc("dgsSetCustomCursorImage"),
		getCursorImage = gNObjFnc("dgsGetCustomCursorImage"),
		setCustomCursorEnabled = gNObjFnc("dgsSetCustomCursorEnabled"),
		getCustomCursorEnabled = gNObjFnc("dgsGetCustomCursorEnabled"),
		setCursorSize = gNObjFnc("dgsSetCursorSize"),
		getCursorSize = gNObjFnc("dgsGetCursorSize"),
		setCursorColor = gNObjFnc("dgsSetCursorColor"),
		getCursorColor = gNObjFnc("dgsGetCursorColor"),
		getCursorType = gNObjFnc("dgsGetCursorType"),
		RGBToHSV = gNObjFnc("dgsRGBToHSV"),
		RGBToHSL = gNObjFnc("dgsRGBToHSL"),
		HSLToRGB = gNObjFnc("dgsHSLToRGB"),
		HSVToRGB = gNObjFnc("dgsHSVToRGB"),
		HSVToHSL = gNObjFnc("dgsHSVToHSL"),
		HSLToHSV = gNObjFnc("dgsHSLToHSV"),
		dgs3DImage = function(...) return dgsOOP.dgs3DImage(dgsRootInstance,...) end,
		dgs3DInterface = function(...) return dgsOOP.dgs3DInterface(dgsRootInstance,...) end,
		dgs3DLine = function(...) return dgsOOP.dgs3DLine(dgsRootInstance,...) end,
		dgs3DText = function(...) return dgsOOP.dgs3DText(dgsRootInstance,...) end,
		dgsBrowser = function(...) return dgsOOP.dgsBrowser(dgsRootInstance,...) end,
		dgsButton = function(...) return dgsOOP.dgsButton(dgsRootInstance,...) end,
		dgsCheckBox = function(...) return dgsOOP.dgsCheckBox(dgsRootInstance,...) end,
		dgsComboBox = function(...) return dgsOOP.dgsComboBox(dgsRootInstance,...) end,
		dgsCustomRenderer = function(...) return dgsOOP.dgsCustomRenderer(dgsRootInstance,...) end,
		dgsDetectArea = function(...) return dgsOOP.dgsDetectArea(dgsRootInstance,...) end,
		dgsEdit = function(...) return dgsOOP.dgsEdit(dgsRootInstance,...) end,
		dgsGridList = function(...) return dgsOOP.dgsGridList(dgsRootInstance,...) end,
		dgsImage = function(...) return dgsOOP.dgsImage(dgsRootInstance,...) end,
		dgsLabel = function(...) return dgsOOP.dgsLabel(dgsRootInstance,...) end,
		dgsMemo = function(...) return dgsOOP.dgsMemo(dgsRootInstance,...) end,
		dgsProgressBar = function(...) return dgsOOP.dgsProgressBar(dgsRootInstance,...) end,
		dgsRadioButton = function(...) return dgsOOP.dgsRadioButton(dgsRootInstance,...) end,
		dgsSelector = function(...) return dgsOOP.dgsSelector(dgsRootInstance,...) end,
		dgsScrollBar = function(...) return dgsOOP.dgsScrollBar(dgsRootInstance,...) end,
		dgsScrollPane = function(...) return dgsOOP.dgsScrollPane(dgsRootInstance,...) end,
		dgsSwitchButton = function(...) return dgsOOP.dgsSwitchButton(dgsRootInstance,...) end,
		dgsTabPanel = function(...) return dgsOOP.dgsTabPanel(dgsRootInstance,...) end,
		dgsWindow = function(...) return dgsOOP.dgsWindow(dgsRootInstance,...) end,
		dgsGetInstance = function(dgsElement,...)
			local typ = type(dgsElement)
			if typ ~= "table" and typ ~= "userdata" then return dgsElement end
			if typ == "table" then
				local t = {}
				for i=1,#dgsElement do
					t[i] = dgsRootInstance.dgsGetInstance(dgsElement[i])
				end
				return t
			end
			if not isElement(dgsElement) then return dgsElement end
			local originalClass = dgsOOP.dgsInstances[dgsElement]
			if originalClass and originalClass.dgsElement == dgsElement then
				return originalClass
			else
				local eleType = dgsGetPluginType(dgsElement)
				if dgsOOP[eleType] then
					return dgsOOP[eleType][dgsElement]
				else
					return dgsElement
				end
			end
		end
	};
	public = {
		on = function(self,eventName,theFnc,p)
			local eventName = dgsOOP.transfromEventName(eventName)
			removeEventHandler(eventName,self.dgsElement,theFnc)
			dgsOOP.eventHandler[eventName] = dgsOOP.eventHandler[eventName] or {}
			dgsOOP.eventHandler[eventName][self.dgsElement] = dgsOOP.eventHandler[eventName][self.dgsElement] or {}
			local eventFncEnv = {}
			setmetatable(eventFncEnv,{__index = _G,__newindex = _G})
			setfenv(theFnc,eventFncEnv)
			local function callBack(...)
				local s = dgsGetInstance(source)
				eventFncEnv.source = s
				attachedFnc(...)
			end
			local newfenv = {attachedFnc=theFnc}
			setmetatable(newfenv,{__index=_G})
			setfenv(callBack,newfenv)
			dgsOOP.eventHandler[eventName][self.dgsElement][theFnc] = callBack
			return addEventHandler(eventName,self.dgsElement,callBack,p and true or false) and self or false
		end,
		removeOn = function(self,eventName,theFnc)
			local eventName = dgsOOP.transfromEventName(eventName)
			dgsOOP.eventHandler[eventName] = dgsOOP.eventHandler[eventName] or {}
			dgsOOP.eventHandler[eventName][self.dgsElement] = dgsOOP.eventHandler[eventName][self.dgsElement] or {}
			if dgsOOP.eventHandler[eventName][self.dgsElement][theFnc] then
				local oFnc = dgsOOP.eventHandler[eventName][self.dgsElement][theFnc]
				dgsOOP.eventHandler[eventName][self.dgsElement][theFnc] = nil
				return removeEventHandler(eventName,self.dgsElement,oFnc) and self or false
			end
			return true
		end,
		dgsBrowser = function(...) return dgsOOP.dgsBrowser(...) end,
		dgsButton = function(...) return dgsOOP.dgsButton(...) end,
		dgsCheckBox = function(...) return dgsOOP.dgsCheckBox(...) end,
		dgsComboBox = function(...) return dgsOOP.dgsComboBox(...) end,
		dgsCustomRenderer = function(...) return dgsOOP.dgsCustomRenderer(...) end,
		dgsDetectArea = function(...) return dgsOOP.dgsDetectArea(...) end,
		dgsEdit = function(...) return dgsOOP.dgsEdit(...) end,
		dgsGridList = function(...) return dgsOOP.dgsGridList(...) end,
		dgsImage = function(...) return dgsOOP.dgsImage(...) end,
		dgsLabel = function(...) return dgsOOP.dgsLabel(...) end,
		dgsMemo = function(...) return dgsOOP.dgsMemo(...) end,
		dgsProgressBar = function(...) return dgsOOP.dgsProgressBar(...) end,
		dgsRadioButton = function(...) return dgsOOP.dgsRadioButton(...) end,
		dgsSelector = function(...) return dgsOOP.dgsSelector(...) end,
		dgsScrollBar = function(...) return dgsOOP.dgsScrollBar(...) end,
		dgsScrollPane = function(...) return dgsOOP.dgsScrollPane(...) end,
		dgsSwitchButton = function(...) return dgsOOP.dgsSwitchButton(...) end,
		dgsTabPanel = function(...) return dgsOOP.dgsTabPanel(...) end,
		dgsWindow = function(...) return dgsOOP.dgsWindow(...) end,
		
		----------Plugins
		dgsColorPicker = function(...) return dgsOOP.dgsColorPicker(...) end,
		dgsComponentSelector = function(...) return dgsOOP.dgsComponentSelector(...) end,
	};
}

----------------------------------------------------------
----------------------------------------------------DGS 2D
----------------------------------------------------------
class {
	extends = "dgsRoot";
	type = "dgs2D";
	preInstantiate = nil;
	public = {
		__index=function(self,key)
			if key == "parent" then
				local parent = call(dgsOOP.dgsRes,"dgsGetParent",self.dgsElement,key)
				return parent and dgsGetInstance(parent) or false
			elseif key == "children" then
				return self:getChildren()
			elseif key == "size" then
				return dgsOOP.genInterface(self.dgsElement,dgsOOP.size2D)
			elseif key == "position" then
				return dgsOOP.genInterface(self.dgsElement,dgsOOP.position2D)
			end
			return call(dgsOOP.dgsRes,"dgsGetProperty",self.dgsElement,key)
		end,
		__newindex=function(self,key,value)
			if key == "parent" then
				local targetEle
				if type(value) == "table" then targetEle = value.dgsElement end
				return call(dgsOOP.dgsRes,"dgsSetParent",self.dgsElement,targetEle)
			elseif key == "size" then
				local vType = dgsOOP.getVectorType(value)
				if vType == "table" then
					local rlt = dgsGetProperty(self.dgsElement,"relative")
					return dgsSetSize(self.dgsElement,value[1],value[2],value[3] ~= nil and value[3] or rlt[2])
				elseif vType == 2 then
					local rlt = dgsGetProperty(self.dgsElement,"relative")
					return dgsSetSize(self.dgsElement,value.x,value.y,rlt[2])
				end
			elseif key == "position" then
				local vType = dgsOOP.getVectorType(value)
				if vType == "table" then
					local rlt = dgsGetProperty(self.dgsElement,"relative")
					return dgsSetPosition(self.dgsElement,value[1] or value.x,value[2] or value.y,value[3] ~= nil and value[3] or rlt[1])
				elseif vType == 2 then
					local rlt = dgsGetProperty(self.dgsElement,"relative")
					return dgsSetPosition(self.dgsElement,value.x,value.y,rlt[1])
				end
			end
			return call(dgsOOP.dgsRes,"dgsSetProperty",self.dgsElement,key,value) and self or false
		end,
		getPosition = gObjFnc("dgsGetPosition"),
		setPosition = gObjFnc("dgsSetPosition",true),
		getParent = gObjFnc("dgsGetParent"),
		setParent = function(self,parent)
			if type(parent) == "table" and isElement(parent.dgsElement) then parent = parent.dgsElement	end
			return call(dgsOOP.dgsRes,"dgsSetParent",self.dgsElement,parent) and self or false
		end,
		getChild = gObjFnc("dgsGetChild"),
		getChildren = gObjFnc("dgsGetChildren"),
		getSize = gObjFnc("dgsGetSize"),
		setSize = gObjFnc("dgsSetSize",true),
		getType = gObjFnc("dgsGetType"),
		setLayer = gObjFnc("dgsSetLayer",true),
		getLayer = gObjFnc("dgsSetLayer"),
		setCurrentLayerIndex = gObjFnc("dgsSetCurrentLayerIndex",true),
		getCurrentLayerIndex = gObjFnc("dgsGetCurrentLayerIndex"),
		getProperty = gObjFnc("dgsGetProperty"),
		setProperty = gObjFnc("dgsSetProperty",true),
		getProperties = function(self,...) return call(dgsOOP.dgsRes,"dgsGetProperties",self.dgsElement,...) end,
		setProperties = gObjFnc("dgsSetProperties",true),
		getVisible = gObjFnc("dgsGetVisible"),
		setVisible = gObjFnc("dgsSetVisible",true),
		getEnabled = gObjFnc("dgsGetEnabled"),
		setEnabled = gObjFnc("dgsSetEnabled",true),
		blur = gObjFnc("dgsBlur",true),
		focus = gObjFnc("dgsFocus",true),
		getPositionAlignment = gObjFnc("dgsGetPositionAlignment"),
		setPositionAlignment = gObjFnc("dgsSetPositionAlignment",true),
		getAlpha = gObjFnc("dgsGetAlpha"),
		setAlpha = gObjFnc("dgsSetAlpha",true),
		getFont = gObjFnc("dgsGetFont"),
		setFont = gObjFnc("dgsSetFont",true),
		getText = gObjFnc("dgsGetText"),
		setText = gObjFnc("dgsSetText",true),
		bringToFront = gObjFnc("dgsBringToFront",true),
		moveToBack = gObjFnc("dgsMoveToBack",true),
		simulateClick = gObjFnc("dgsSimulateClick",true),
		animTo = gObjFnc("dgsAnimTo",true),
		isAniming = gObjFnc("dgsIsAniming"),
		stopAniming = gObjFnc("dgsStopAniming",true),
		moveTo = gObjFnc("dgsMoveTo",true),
		isMoving = gObjFnc("dgsIsMoving"),
		stopMoving = gObjFnc("dgsStopMoving",true),
		sizeTo = gObjFnc("dgsSizeTo",true),
		isSizing = gObjFnc("dgsIsSizing"),
		stopSizing = gObjFnc("dgsStopSizing",true),
		alphaTo = gObjFnc("dgsAlphaTo",true),
		isAlphaing = gObjFnc("dgsIsAlphaing"),
		stopAlphaing = gObjFnc("dgsStopAlphaing",true),
		getPostGUI = gObjFnc("dgsGetPostGUI"),
		setPostGUI = gObjFnc("dgsSetPostGUI",true),
		detachFromGridList = gObjFnc("dgsDetachFromGridList",true),
		getAttachedGridList = gObjFnc("dgsGetAttachedGridList",true),
		attachToGridList = gObjFnc("dgsAttachToGridList",true),
		center = gObjFnc("dgsCenterElement",true),
		destroy = function(self) return destroyElement(self.dgsElement) end;
		isElement = gObjFnc("isElement",true);
		getElement = function(self) return self.dgsElement end,
		addMoveHandler = gObjFnc("dgsAddMoveHandler",true),
		removeMoveHandler = gObjFnc("dgsRemoveMoveHandler",true),
		isMoveHandled = gObjFnc("dgsIsMoveHandled"),
		addSizeHandler = gObjFnc("dgsAddSizeHandler",true),
		removeSizeHandler = gObjFnc("dgsRemoveSizeHandler",true),
		isSizeHandled = gObjFnc("dgsIsSizeHandled"),
		attachToTranslation = gObjFnc("dgsAttachToTranslation",true),
		detachFromTranslation = gObjFnc("dgsDetachFromTranslation",true),
		getTranslationName = gObjFnc("dgsGetTranslationName"),
		attach = gObjFnc("dgsAttachElements",true),
		detach = gObjFnc("dgsDetachElements",true),
		isAttached = gObjFnc("dgsElementIsAttached"),
	};
	default = {

	};
}

--------------------------Button
class {
	extends = "dgs2D";
	type = "dgsButton";
	dgsType = "dgs-dxbutton";
	preInstantiate = function(parent,x,y,w,h,text,rlt,...)
		return call(dgsOOP.dgsRes,"dgsCreateButton",x,y,w,h,text,rlt,parent.dgsElement,...)
	end;
	public = {
	};
}

--------------------------Browser
class {
	extends = "dgs2D";
	type = "dgsBrowser";
	dgsType = "dgs-dxbrowser";
	preInstantiate = function(parent,x,y,w,h,rlt,...)
		return call(dgsOOP.dgsRes,"dgsCreateBrowser",x,y,w,h,rlt,parent.dgsElement,...)
	end;
	public = {
	};
}

--------------------------CheckBox
class {
	extends = "dgs2D";
	type = "dgsCheckBox";
	dgsType = "dgs-dxcheckbox";
	preInstantiate = function(parent,x,y,w,h,text,state,rlt,...)
		return call(dgsOOP.dgsRes,"dgsCreateCheckBox",x,y,w,h,text,state,rlt,parent.dgsElement,...)
	end;
	public = {
		getSelected = gObjFnc("dgsCheckBoxGetSelected"),
		setSelected = gObjFnc("dgsCheckBoxSetSelected",true),
		getHorizontalAlign = gObjFnc("dgsCheckBoxGetHorizontalAlign"),
		setHorizontalAlign = gObjFnc("dgsCheckBoxSetHorizontalAlign",true),
		getVerticalAlign = gObjFnc("dgsCheckBoxGetVerticalAlign"),
		setVerticalAlign = gObjFnc("dgsCheckBoxSetVerticalAlign",true),
	};
}

--------------------------ComboBox
class {
	extends = "dgs2D";
	type = "dgsComboBox";
	dgsType = "dgs-dxcombobox";
	preInstantiate = function(parent,x,y,w,h,text,rlt,...)
		return call(dgsOOP.dgsRes,"dgsCreateComboBox",x,y,w,h,text,rlt,parent.dgsElement,...)
	end;
	public = {
		addItem = gObjFnc("dgsComboBoxAddItem"),
		removeItem = gObjFnc("dgsComboBoxRemoveItem",true),
		setItemText = gObjFnc("dgsComboBoxSetItemText",true),
		getItemText = gObjFnc("dgsComboBoxGetItemText"),
		clear = gObjFnc("dgsComboBoxClear",true),
		setSelectedItem = gObjFnc("dgsComboBoxSetSelectedItem",true),
		getSelectedItem = gObjFnc("dgsComboBoxGetSelectedItem"),
		getSelectedItem = gObjFnc("dgsComboBoxGetSelectedItem"),
		setItemColor = gObjFnc("dgsComboBoxSetItemColor",true),
		getItemColor = gObjFnc("dgsComboBoxGetItemColor"),
		setItemFont = gObjFnc("dgsComboBoxSetItemFont",true),
		getItemFont = gObjFnc("dgsComboBoxGetItemFont"),
		setItemImage = gObjFnc("dgsComboBoxSetItemImage",true),
		getItemImage = gObjFnc("dgsComboBoxGetItemImage"),
		removeItemImage = gObjFnc("dgsComboBoxRemoveItemImage",true),
		getState = gObjFnc("dgsComboBoxGetState"),
		setState = gObjFnc("dgsComboBoxSetState",true),
		getItemCount = gObjFnc("dgsComboBoxGetItemCount"),
		getBoxHeight = gObjFnc("dgsComboBoxGetBoxHeight"),
		setBoxHeight = gObjFnc("dgsComboBoxSetBoxHeight",true),
		getScrollBar = gObjFnc("dgsComboBoxGetScrollBar"),
		setScrollPosition = gObjFnc("dgsComboBoxSetScrollPosition",true),
		getScrollPosition = gObjFnc("dgsComboBoxGetScrollPosition"),
		setCaptionText = gObjFnc("dgsComboBoxSetCaptionText",true),
		getCaptionText = gObjFnc("dgsComboBoxGetCaptionText"),
		setEditEnabled = gObjFnc("dgsComboBoxSetEditEnabled",true),
		getEditEnabled = gObjFnc("dgsComboBoxGetEditEnabled"),
		setViewCount = gObjFnc("dgsComboBoxSetViewCount",true),
		getViewCount = gObjFnc("dgsComboBoxGetViewCount"),
		getText = gObjFnc("dgsComboBoxGetText"),
	};
}

--------------------------CustomRenderer
class {
	extends = "dgs2D";
	type = "dgsCustomRenderer";
	dgsType = "dgs-dxcustomrenderer";
	preInstantiate = function(parent,customFnc)
		return call(dgsOOP.dgsRes,"dgsCreateCustomRenderer",customFnc)
	end;
	public = {
		setFunction = gObjFnc("dgsCustomRendererSetFunction",true),
	};
}

--------------------------DetectArea
class {
	extends = "dgs2D";
	type = "dgsDetectArea";
	dgsType = "dgs-dxdetectarea";
	preInstantiate = function(parent,x,y,w,h,rlt,...)
		return call(dgsOOP.dgsRes,"dgsCreateDetectArea",x,y,w,h,text,rlt,parent.dgsElement,...)
	end;
	public = {
		setFunction = gObjFnc("dgsDetectAreaSetFunction",true),
		setDebugModeEnabled = gObjFnc("dgsDetectAreaSetDebugModeEnabled",true),
		getDebugModeEnabled = gObjFnc("dgsDetectAreaGetDebugModeEnabled"),
	};
}

--------------------------Edit
class {
	extends = "dgs2D";
	type = "dgsEdit";
	dgsType = "dgs-dxedit";
	preInstantiate = function(parent,x,y,w,h,text,rlt,...)
		return call(dgsOOP.dgsRes,"dgsCreateEdit",x,y,w,h,text,rlt,parent.dgsElement,...)
	end;
	public = {
		moveCaret = gObjFnc("dgsEditMoveCaret",true),
		setCaretPosition = gObjFnc("dgsEditSetCaretPosition",true),
		getCaretPosition = gObjFnc("dgsEditGetCaretPosition"),
		setCaretStyle = gObjFnc("dgsEditSetCaretStyle",true),
		getCaretStyle = gObjFnc("dgsEditGetCaretStyle"),
		setWhiteList = gObjFnc("dgsEditSetWhiteList",true),
		setMaxLength = gObjFnc("dgsEditSetMaxLength",true),
		getMaxLength = gObjFnc("dgsEditGetMaxLength"),
		setReadOnly = gObjFnc("dgsEditSetReadOnly",true),
		getReadOnly = gObjFnc("dgsEditGetReadOnly"),
		setMasked = gObjFnc("dgsEditSetMasked",true),
		getMasked = gObjFnc("dgsEditGetMasked"),
		setUnderlined = gObjFnc("dgsEditSetUnderlined",true),
		getUnderlined = gObjFnc("dgsEditGetUnderlined"),
		setHorizontalAlign = gObjFnc("dgsEditSetHorizontalAlign",true),
		getHorizontalAlign = gObjFnc("dgsEditGetHorizontalAlign"),
		setVerticalAlign = gObjFnc("dgsEditSetVerticalAlign",true),
		getVerticalAlign = gObjFnc("dgsEditGetVerticalAlign"),
		setAlignment = gObjFnc("dgsEditSetAlignment",true),
		getAlignment = gObjFnc("dgsEditGetAlignment"),
		insertText = gObjFnc("dgsEditInsertText",true),
		deleteText = gObjFnc("dgsEditDeleteText",true),
		getPartOfText = gObjFnc("dgsEditGetPartOfText"),
		clearText = gObjFnc("dgsEditClearText",true),
		replaceText = gObjFnc("dgsEditReplaceText",true),
		setTypingSound = gObjFnc("dgsEditSetTypingSound",true),
		getTypingSound = gObjFnc("dgsEditGetTypingSound"),
		setPlaceHolder = gObjFnc("dgsEditSetPlaceHolder",true),
		getPlaceHolder = gObjFnc("dgsEditGetPlaceHolder"),
		setAutoComplete = gObjFnc("dgsEditSetAutoComplete",true),
		getAutoComplete = gObjFnc("dgsEditGetAutoComplete"),
		addAutoComplete = gObjFnc("dgsEditAddAutoComplete",true),
		removeAutoComplete = gObjFnc("dgsEditRemoveAutoComplete",true),
	};
}
--------------------------GridList
class {
	extends = "dgs2D";
	type = "dgsGridList";
	dgsType = "dgs-dxgridlist";
	preInstantiate = function(parent,x,y,w,h,rlt,...)
		return call(dgsOOP.dgsRes,"dgsCreateGridList",x,y,w,h,rlt,parent.dgsElement,...)
	end;
	public = {
		getScrollBar = gObjFnc("dgsGridListGetScrollBar"),
		setScrollPosition = gObjFnc("dgsGridListSetScrollPosition",true),
		getScrollPosition = gObjFnc("dgsGridListGetScrollPosition"),
		scollTo = gObjFnc("dgsGridListScrollTo",true),
		setHorizontalScrollPosition = gObjFnc("dgsGridListSetHorizontalScrollPosition",true),
		getHorizontalScrollPosition = gObjFnc("dgsGridListGetHorizontalScrollPosition"),
		setVerticalScrollPosition = gObjFnc("dgsGridListSetVerticalScrollPosition",true),
		getVerticalScrollPosition = gObjFnc("dgsGridListGetVerticalScrollPosition"),
		resetScrollBarPosition = gObjFnc("dgsGridListResetScrollBarPosition",true),
		setColumnRelative = gObjFnc("dgsGridListSetColumnRelative",true),
		getColumnRelative = gObjFnc("dgsGridListGetColumnRelative"),
		addColumn = gObjFnc("dgsGridListAddColumn"),
		getColumnCount = gObjFnc("dgsGridListGetColumnCount"),
		removeColumn = gObjFnc("dgsGridListRemoveColumn",true),
		getColumnAllWidth = gObjFnc("dgsGridListGetColumnAllWidth"),
		getColumnHeight = gObjFnc("dgsGridListGetColumnHeight"),
		setColumnHeight = gObjFnc("dgsGridListSetColumnHeight",true),
		getColumnWidth = gObjFnc("dgsGridListGetColumnWidth"),
		setColumnWidth = gObjFnc("dgsGridListSetColumnWidth",true),
		autoSizeColumn = gObjFnc("dgsGridListAutoSizeColumn",true),
		getColumnTitle = gObjFnc("dgsGridListGetColumnTitle"),
		setColumnTitle = gObjFnc("dgsGridListSetColumnTitle",true),
		getColumnFont = gObjFnc("dgsGridListGetColumnFont"),
		setColumnFont = gObjFnc("dgsGridListSetColumnFont",true),
		getColumnAlignment = gObjFnc("dgsGridListGetColumnAlignment"),
		setColumnAlignment = gObjFnc("dgsGridListSetColumnAlignment",true),
		addRow = gObjFnc("dgsGridListAddRow"),
		insertRowAfter = gObjFnc("dgsGridListInsertRowAfter"),
		removeRow = gObjFnc("dgsGridListRemoveRow",true),
		clearRow = gObjFnc("dgsGridListClearRow",true),
		clearColumn = gObjFnc("dgsGridListClearColumn",true),
		clear = gObjFnc("dgsGridListClear",true),
		getRowCount = gObjFnc("dgsGridListGetRowCount"),
		setItemText = gObjFnc("dgsGridListSetItemText",true),
		getItemText = gObjFnc("dgsGridListGetItemText"),
		setItemTextOffset = gObjFnc("dgsGridListSetItemTextOffset",true),
		getItemTextOffset = gObjFnc("dgsGridListGetItemTextOffset"),
		getItemAlignment = gObjFnc("dgsGridListGetItemAlignment"),
		setItemAlignment = gObjFnc("dgsGridListSetItemAlignment",true),
		getPreselectedItem = gObjFnc("dgsGridListGetPreselectedItem"),
		getSelectedItem = gObjFnc("dgsGridListGetSelectedItem"),
		setSelectedItem = gObjFnc("dgsGridListSetSelectedItem",true),
		setItemColor = gObjFnc("dgsGridListSetItemColor",true),
		getItemColor = gObjFnc("dgsGridListGetItemColor"),
		setItemData = gObjFnc("dgsGridListSetItemData",true),
		getItemData = gObjFnc("dgsGridListGetItemData"),
		setItemImage = gObjFnc("dgsGridListSetItemImage",true),
		getItemImage = gObjFnc("dgsGridListGetItemImage"),
		getItemBackGroundImage = gObjFnc("dgsGridListGetItemBackGroundImage"),
		setItemBackGroundImage = gObjFnc("dgsGridListSetItemBackGroundImage",true),
		getItemBackGroundColor = gObjFnc("dgsGridListGetItemBackGroundColor"),
		setItemBackGroundColor = gObjFnc("dgsGridListSetItemBackGroundColor",true),
		removeItemImage = gObjFnc("dgsGridListRemoveItemImage",true),
		getRowBackGroundImage = gObjFnc("dgsGridListGetRowBackGroundImage"),
		setRowBackGroundImage = gObjFnc("dgsGridListSetRowBackGroundImage",true),
		getRowBackGroundColor = gObjFnc("dgsGridListGetRowBackGroundColor"),
		setRowBackGroundColor = gObjFnc("dgsGridListSetRowBackGroundColor",true),
		setRowAsSection = gObjFnc("dgsGridListSetRowAsSection",true),
		selectItem = gObjFnc("dgsGridListSelectItem",true),
		itemIsSelected = gObjFnc("dgsGridListItemIsSelected"),
		setMultiSelectionEnabled = gObjFnc("dgsGridListSetMultiSelectionEnabled",true),
		getMultiSelectionEnabled = gObjFnc("dgsGridListGetMultiSelectionEnabled"),
		setSelectionMode = gObjFnc("dgsGridListSetSelectionMode",true),
		getSelectionMode = gObjFnc("dgsGridListGetSelectionMode"),
		setSelectedItems = gObjFnc("dgsGridListSetSelectedItems",true),
		getSelectedItems = gObjFnc("dgsGridListGetSelectedItems"),
		getSelectedCount = gObjFnc("dgsGridListGetSelectedCount"),
		setSortFunction = gObjFnc("dgsGridListSetSortFunction",true),
		setAutoSortEnabled = gObjFnc("dgsGridListSetAutoSortEnabled",true),
		getAutoSortEnabled = gObjFnc("dgsGridListGetAutoSortEnabled"),
		setSortEnabled = gObjFnc("dgsGridListSetSortEnabled",true),
		getSortEnabled = gObjFnc("dgsGridListGetSortEnabled"),
		setSortColumn = gObjFnc("dgsGridListSetSortColumn",true),
		getSortColumn = gObjFnc("dgsGridListGetSortColumn"),
		getEnterColumn = gObjFnc("dgsGridListGetEnterColumn"),
		sort = gObjFnc("dgsGridListSort",true),
		setNavigationEnabled = gObjFnc("dgsGridListSetNavigationEnabled",true),
		getNavigationEnabled = gObjFnc("dgsGridListGetNavigationEnabled"),
		setItemTextSize = gObjFnc("dgsGridListSetItemTextSize",true),
		getItemTextSize = gObjFnc("dgsGridListGetItemTextSize"),
		setColumnTextSize = gObjFnc("dgsGridListSetColumnTextSize",true),
		getColumnTextSize = gObjFnc("dgsGridListGetColumnTextSize"),
		setItemFont = gObjFnc("dgsGridListSetItemFont",true),
		getItemFont = gObjFnc("dgsGridListGetItemFont"),
		setRowSelectable = gObjFnc("dgsGridListSetRowSelectable",true),
		getRowSelectable = gObjFnc("dgsGridListGetRowSelectable"),
		setRowHoverable = gObjFnc("dgsGridListSetRowHoverable",true),
		getRowHoverable = gObjFnc("dgsGridListGetRowHoverable"),
		setItemSelectable = gObjFnc("dgsGridListSetItemSelectable",true),
		getItemSelectable = gObjFnc("dgsGridListGetItemSelectable"),
		setItemHoverable = gObjFnc("dgsGridListSetItemHoverable",true),
		getItemHoverable = gObjFnc("dgsGridListGetItemHoverable"),
	};
}

--------------------------Image
class {
	extends = "dgs2D";
	type = "dgsImage";
	dgsType = "dgs-dximage";
	preInstantiate = function(parent,x,y,w,h,image,rlt,...)
		return call(dgsOOP.dgsRes,"dgsCreateImage",x,y,w,h,image,rlt,parent.dgsElement,...)
	end;
	public = {
		setImage = gObjFnc("dgsImageSetImage",true),
		getImage = gObjFnc("dgsImageGetImage"),
		setUVSize = gObjFnc("dgsImageSetUVSize",true),
		getUVSize = gObjFnc("dgsImageGetUVSize"),
		setUVPosition = gObjFnc("dgsImageSetUVPosition",true),
		getUVPosition = gObjFnc("dgsImageGetUVPosition"),
	};
}

--------------------------Label
class {
	extends = "dgs2D";
	type = "dgsLabel";
	dgsType = "dgs-dxlabel";
	preInstantiate = function(parent,x,y,w,h,text,rlt,...)
		return call(dgsOOP.dgsRes,"dgsCreateLabel",x,y,w,h,text,rlt,parent.dgsElement,...)
	end;
	public = {
		setColor = gObjFnc("dgsLabelSetColor",true),
		getColor = gObjFnc("dgsLabelGetColor"),
		setHorizontalAlign = gObjFnc("dgsLabelSetHorizontalAlign",true),
		getHorizontalAlign = gObjFnc("dgsLabelGetHorizontalAlign"),
		setVerticalAlign = gObjFnc("dgsLabelSetVerticalAlign",true),
		getVerticalAlign = gObjFnc("dgsLabelGetVerticalAlign"),
		getTextExtent = gObjFnc("dgsLabelGetTextExtent"),
		getFontHeight = gObjFnc("dgsLabelGetFontHeight"),
	};
}

--------------------------Memo
class {
	extends = "dgs2D";
	type = "dgsMemo";
	dgsType = "dgs-dxmemo";
	preInstantiate = function(parent,x,y,w,h,text,rlt,...)
		return call(dgsOOP.dgsRes,"dgsCreateMemo",x,y,w,h,text,rlt,parent.dgsElement,...)
	end;
	public = {
		moveCaret = gObjFnc("dgsMemoMoveCaret",true),
		seekPosition = gObjFnc("dgsMemoSeekPosition"),
		getScrollBar = gObjFnc("dgsMemoGetScrollBar"),
		setScrollPosition = gObjFnc("dgsMemoSetScrollPosition",true),
		getScrollPosition = gObjFnc("dgsMemoGetScrollPosition"),
		setHorizontalScrollPosition = gObjFnc("dgsMemoSetHorizontalScrollPosition",true),
		getHorizontalScrollPosition = gObjFnc("dgsMemoGetHorizontalScrollPosition"),
		setVerticalScrollPosition = gObjFnc("dgsMemoSetVerticalScrollPosition",true),
		getVerticalScrollPosition = gObjFnc("dgsMemoGetVerticalScrollPosition"),
		setCaretPosition = gObjFnc("dgsMemoSetCaretPosition",true),
		getCaretPosition = gObjFnc("dgsMemoGetCaretPosition"),
		setCaretStyle = gObjFnc("dgsMemoSetCaretStyle",true),
		getCaretStyle = gObjFnc("dgsMemoGetCaretStyle"),
		setReadOnly = gObjFnc("dgsMemoSetReadOnly",true),
		getReadOnly = gObjFnc("dgsMemoGetReadOnly"),
		getPartOfText = gObjFnc("dgsMemoGetPartOfText"),
		deleteText = gObjFnc("dgsMemoDeleteText",true),
		insertText = gObjFnc("dgsMemoInsertText",true),
		appendText = gObjFnc("dgsMemoAppendText",true),
		clearText = gObjFnc("dgsMemoClearText",true),
		getTypingSound = gObjFnc("dgsMemoGetTypingSound"),
		setTypingSound = gObjFnc("dgsMemoSetTypingSound",true),
		getLineCount = gObjFnc("dgsMemoGetLineCount"),
		setWordWrapState = gObjFnc("dgsMemoSetWordWrapState",true),
		getWordWrapState = gObjFnc("dgsMemoGetWordWrapState"),
		setScrollBarState = gObjFnc("dgsMemoSetScrollBarState",true),
		getScrollBarState = gObjFnc("dgsMemoGetScrollBarState"),
	};
}

--------------------------ProgressBar
class {
	extends = "dgs2D";
	type = "dgsProgressBar";
	dgsType = "dgs-dxprogressbar";
	preInstantiate = function(parent,x,y,w,h,rlt,...)
		return call(dgsOOP.dgsRes,"dgsCreateProgressBar",x,y,w,h,rlt,parent.dgsElement,...)
	end;
	public = {
		getProgress = gObjFnc("dgsProgressBarGetProgress"),
		setProgress = gObjFnc("dgsProgressBarSetProgress",true),
		getMode = gObjFnc("dgsProgressBarGetMode"),
		setMode = gObjFnc("dgsProgressBarSetMode",true),
		getVerticalSide = gObjFnc("dgsProgressBarGetVerticalSide"),
		setVerticalSide = gObjFnc("dgsProgressBarSetVerticalSide",true),
		getHorizontalSide = gObjFnc("dgsProgressBarGetHorizontalSide"),
		setHorizontalSide = gObjFnc("dgsProgressBarSetHorizontalSide",true),
		getStyle = gObjFnc("dgsProgressBarGetStyle"),
		setStyle = gObjFnc("dgsProgressBarSetStyle",true),
		getStyleProperties = gObjFnc("dgsProgressBarGetStyleProperties"),
		setStyleProperty = gObjFnc("dgsProgressBarSetStyleProperty",true),
		getStyleProperty = gObjFnc("dgsProgressBarGetStyleProperty"),
	};
}

--------------------------RadioButton
class {
	extends = "dgs2D";
	type = "dgsRadioButton";
	dgsType = "dgs-dxradiobutton";
	preInstantiate = function(parent,x,y,w,h,text,rlt,...)
		return call(dgsOOP.dgsRes,"dgsCreateRadioButton",x,y,w,h,text,rlt,parent.dgsElement,...)
	end;
	public = {
		getSelected = gObjFnc("dgsRadioButtonGetSelected"),
		setSelected = gObjFnc("dgsRadioButtonSetSelected",true),
		getHorizontalAlign = gObjFnc("dgsRadioButtonGetHorizontalAlign"),
		setHorizontalAlign = gObjFnc("dgsRadioButtonSetHorizontalAlign",true),
		getVerticalAlign = gObjFnc("dgsRadioButtonGetVerticalAlign"),
		setVerticalAlign = gObjFnc("dgsRadioButtonSetVerticalAlign",true),
	};
}

--------------------------ScrollBar
class {
	extends = "dgs2D";
	type = "dgsScrollBar";
	dgsType = "dgs-dxscrollbar";
	preInstantiate = function(parent,x,y,w,h,voh,rlt,...)
		return call(dgsOOP.dgsRes,"dgsCreateScrollBar",x,y,w,h,voh,rlt,parent.dgsElement,...)
	end;
	public = {
		setScrollPosition = gObjFnc("dgsScrollBarSetScrollPosition",true),
		getScrollPosition = gObjFnc("dgsScrollBarGetScrollPosition"),
		setCursorLength = gObjFnc("dgsScrollBarSetCursorLength",true),
		getCursorLength = gObjFnc("dgsScrollBarGetCursorLength"),
		setLocked = gObjFnc("dgsScrollBarSetLocked",true),
		getLocked = gObjFnc("dgsScrollBarGetLocked"),
		setGrades = gObjFnc("dgsScrollBarSetGrades",true),
		getGrades = gObjFnc("dgsScrollBarGetGrades"),
		setCursorWidth = gObjFnc("dgsScrollBarSetCursorWidth",true),
		getCursorWidth = gObjFnc("dgsScrollBarGetCursorWidth"),
		setTroughWidth = gObjFnc("dgsScrollBarSetTroughWidth",true),
		getTroughWidth = gObjFnc("dgsScrollBarGetTroughWidth"),
		setArrowSize = gObjFnc("dgsScrollBarSetArrowSize",true),
		getArrowSize = gObjFnc("dgsScrollBarGetArrowSize"),
	};
}

--------------------------ScrollPane
class {
	extends = "dgs2D";
	type = "dgsScrollPane";
	dgsType = "dgs-dxscrollpane";
	preInstantiate = function(parent,x,y,w,h,rlt,...)
		return call(dgsOOP.dgsRes,"dgsCreateScrollPane",x,y,w,h,rlt,parent.dgsElement,...)
	end;
	public = {
		getScrollBar = gObjFnc("dgsScrollPaneGetScrollBar"),
		setScrollPosition = gObjFnc("dgsScrollPaneSetScrollPosition",true),
		getScrollPosition = gObjFnc("dgsScrollPaneGetScrollPosition"),
		setHorizontalScrollPosition = gObjFnc("dgsScrollPaneSetHorizontalScrollPosition",true),
		getHorizontalScrollPosition = gObjFnc("dgsScrollPaneGetHorizontalScrollPosition"),
		setVerticalScrollPosition = gObjFnc("dgsScrollPaneSetVerticalScrollPosition",true),
		getVerticalScrollPosition = gObjFnc("dgsScrollPaneGetVerticalScrollPosition"),
		setScrollBarState = gObjFnc("dgsScrollPaneSetScrollBarState",true),
		getScrollBarState = gObjFnc("dgsScrollPaneGetScrollBarState"),
	};
}

--------------------------Selector
class {
	extends = "dgs2D";
	type = "dgsSelector";
	dgsType = "dgs-dxselector";
	preInstantiate = function(parent,x,y,w,h,rlt,...)
		return call(dgsOOP.dgsRes,"dgsCreateSelector",x,y,w,h,rlt,parent.dgsElement,...)
	end;
	public = {
		addItem = gObjFnc("dgsSelectorAddItem"),
		removeItem = gObjFnc("dgsSelectorRemoveItem",true),
		setSelectedItem = gObjFnc("dgsSelectorSetSelectedItem",true),
		getSelectedItem = gObjFnc("dgsSelectorGetSelectedItem"),
		setItemText = gObjFnc("dgsSelectorSetItemText",true),
		getItemText = gObjFnc("dgsSelectorGetItemText"),
		setItemData = gObjFnc("dgsSelectorSetItemData",true),
		getItemData = gObjFnc("dgsSelectorGetItemData"),
	};
}

--------------------------SwitchButton
class {
	extends = "dgs2D";
	type = "dgsSwitchButton";
	dgsType = "dgs-dxswitchbutton";
	preInstantiate = function(parent,x,y,w,h,textOn,textOff,state,rlt,...)
		return call(dgsOOP.dgsRes,"dgsCreateSwitchButton",x,y,w,h,textOn,textOff,state,rlt,parent.dgsElement,...)
	end;
	public = {
		setState = gObjFnc("dgsSwitchButtonSetState",true),
		getState = gObjFnc("dgsSwitchButtonGetState"),
		setText = gObjFnc("dgsSwitchButtonSetText",true),
		getText = gObjFnc("dgsSwitchButtonGetText"),
	};
}

--------------------------Tab
class {
	extends = "dgs2D";
	type = "dgsTab";
	dgsType = "dgs-dxtab";
	preInstantiate = function(parent,text,...)
		return call(dgsOOP.dgsRes,"dgsCreateTab",text,parent.dgsElement,...)
	end;
	public = {
		delete = gObjFnc("dgsDeleteTab"),
	};
}

--------------------------TabPanel
class {
	extends = "dgs2D";
	type = "dgsTabPanel";
	dgsType = "dgs-dxtabpanel";
	preInstantiate = function(parent,x,y,w,h,rlt,...)
		return call(dgsOOP.dgsRes,"dgsCreateTabPanel",x,y,w,h,rlt,parent.dgsElement,...)
	end;
	public = {
		getSelectedTab = gObjFnc("dgsGetSelectedTab"),
		setSelectedTab = gObjFnc("dgsSetSelectedTab",true),
		getTabFromID = gObjFnc("dgsTabPanelGetTabFromID"),
		moveTab = gObjFnc("dgsTabPanelMoveTab",true),
		getTabID = gObjFnc("dgsTabPanelGetTabID"),
		dgsTab = function(...) return dgsOOP.dgsTab(...) end,
	};
}

--------------------------Window
class {
	extends = "dgs2D";
	type = "dgsWindow";
	dgsType = "dgs-dxwindow";
	preInstantiate = function(parent,...)
		return call(dgsOOP.dgsRes,"dgsCreateWindow",...)
	end;
	public = {
		setSizable = gObjFnc("dgsWindowSetSizable",true),
		setMovable = gObjFnc("dgsWindowSetMovable",true),
		getSizable = gObjFnc("dgsWindowGetSizable"),
		getMovable = gObjFnc("dgsWindowGetMovable"),
		close = gObjFnc("dgsCloseWindow"),
		setCloseButtonEnabled = gObjFnc("dgsWindowSetCloseButtonEnabled",true),
		getCloseButtonEnabled = gObjFnc("dgsWindowGetCloseButtonEnabled"),
		setCloseButtonSize = gObjFnc("dgsWindowSetCloseButtonSize",true),
		getCloseButtonSize = gObjFnc("dgsWindowGetCloseButtonSize"),
		getCloseButton = gObjFnc("dgsWindowGetCloseButton"),
		getHorizontalAlign = gObjFnc("dgsWindowGetHorizontalAlign"),
		setHorizontalAlign = gObjFnc("dgsWindowSetHorizontalAlign",true),
		getVerticalAlign = gObjFnc("dgsWindowGetVerticalAlign"),
		setVerticalAlign = gObjFnc("dgsWindowSetVerticalAlign",true),
	};
}

----------------------------------------------------------
----------------------------------------------------DGS 3D
----------------------------------------------------------
----------------DGS 3D
dgsOOP.position3D = {
	__index=function(self,key)
		local meta = getmetatable(self)
		if not isElement(meta.dgsElement) then return false end
		if key == "x" then
			local pos = dgsGetProperty(meta.dgsElement,"position")
			return pos[1]
		elseif key == "y" then
			local pos = dgsGetProperty(meta.dgsElement,"position")
			return pos[2]
		elseif key == "z" then
			local pos = dgsGetProperty(meta.dgsElement,"position")
			return pos[3]
		elseif key == "toVector" then
			return Vector3(dgsGetProperty(meta.dgsElement,"position"))
		end
	end,
	__newindex=function(self,key,value)
		local meta = getmetatable(self)
		if not isElement(meta.dgsElement) then return false end
		if key == "x" then
			local pos = dgsGetProperty(meta.dgsElement,"position")
			pos[1] = value
			return dgsSetProperty(meta.dgsElement,"position",pos)
		elseif key == "y" then
			local pos = dgsGetProperty(meta.dgsElement,"position")
			pos[2] = value
			return dgsSetProperty(meta.dgsElement,"position",pos)
		elseif key == "z" then
			local pos = dgsGetProperty(meta.dgsElement,"position")
			pos[3] = value
			return dgsSetProperty(meta.dgsElement,"position",pos)
		end
	end,
	__call=function(self,key)
		local meta = getmetatable(self)
		setmetatable(self,nil)
		self[1],self[2],self[3] = dgsGetProperty(meta.dgsElement,"position")
		setmetatable(self,meta)
		return self
	end,
}

class {
	extends = "dgsRoot";
	type = "dgs3D";
	public = {
		__index=function(self,key)
			if key == "children" then
				return self:getChildren()
			elseif key == "position" then
				return dgsOOP.genInterface(self.dgsElement,dgsOOP.position3D)
			end
			return call(dgsOOP.dgsRes,"dgsGetProperty",self.dgsElement,key)
		end,
		__newindex=function(self,key,value)
			if key == "position" then
				local vType = dgsOOP.getVectorType(value)
				if vType == "table" then
					return dgsSetProperty(self.dgsElement,"position",value[1] or value.x,value[2] or value.y,value[3] or value.z)
				elseif vType == 3 then
					return dgsSetProperty(self.dgsElement,"position",value.x,value.y,value.z)
				end
			end
			return call(dgsOOP.dgsRes,"dgsSetProperty",self.dgsElement,key,value) and self or false
		end,
		getChild = gObjFnc("dgsGetChild"),
		getChildren = gObjFnc("dgsGetChildren"),
		getType = gObjFnc("dgsGetType"),
		getProperty = gObjFnc("dgsGetProperty"),
		setProperty = gObjFnc("dgsSetProperty",true),
		getProperties = function(self,...) return call(dgsOOP.dgsRes,"dgsGetProperties",self.dgsElement,...) end,
		setProperties = gObjFnc("dgsSetProperties",true),
		getVisible = gObjFnc("dgsGetVisible"),
		setVisible = gObjFnc("dgsSetVisible",true),
		getEnabled = gObjFnc("dgsGetEnabled"),
		setEnabled = gObjFnc("dgsSetEnabled",true),
		blur = gObjFnc("dgsBlur",true),
		focus = gObjFnc("dgsFocus",true),
		getAlpha = gObjFnc("dgsGetAlpha"),
		setAlpha = gObjFnc("dgsSetAlpha",true),
		bringToFront = gObjFnc("dgsBringToFront",true),
		moveToBack = gObjFnc("dgsMoveToBack",true),
		simulateClick = gObjFnc("dgsSimulateClick",true),
		animTo = gObjFnc("dgsAnimTo",true),
		isAniming = gObjFnc("dgsIsAniming"),
		stopAniming = gObjFnc("dgsStopAniming",true),
		alphaTo = gObjFnc("dgsAlphaTo",true),
		isAlphaing = gObjFnc("dgsIsAlphaing"),
		stopAlphaing = gObjFnc("dgsStopAlphaing",true),
		getPostGUI = gObjFnc("dgsGetPostGUI"),
		setPostGUI = gObjFnc("dgsSetPostGUI",true),
		destroy = function(self) return destroyElement(self.dgsElement) end;
		isElement = gObjFnc("isElement",true);
		getElement = function(self) return self.dgsElement end,
		attachToTranslation = gObjFnc("dgsAttachToTranslation",true),
		detachFromTranslation = gObjFnc("dgsDetachFromTranslation",true),
		getTranslationName = gObjFnc("dgsGetTranslationName"),
	};
}

class {
	extends = "dgs3D";
	type = "dgs3DInterface";
	dgsType="dgs-dx3dinterface";
	preInstantiate = function(parent,...)
		return call(dgsOOP.dgsRes,"dgsCreate3DInterface",...)
	end;
	public = {
		getBlendMode = gObjFnc("dgs3DInterfaceGetBlendMode"),
		setBlendMode = gObjFnc("dgs3DInterfaceSetBlendMode",true),
		getPosition = gObjFnc("dgs3DInterfaceGetPosition"),
		setPosition = gObjFnc("dgs3DInterfaceSetPosition",true),
		getSize = gObjFnc("dgs3DInterfaceGetSize"),
		setSize = gObjFnc("dgs3DInterfaceSetSize",true),
		getResolution = gObjFnc("dgs3DInterfaceGetResolution"),
		setResolution = gObjFnc("dgs3DInterfaceSetResolution",true),
		attachToElement = gObjFnc("dgs3DInterfaceAttachToElement",true),
		isAttached = gObjFnc("dgs3DInterfaceIsAttached",true),
		getResolution = gObjFnc("dgs3DInterfaceGetResolution"),
		setResolution = gObjFnc("dgs3DInterfaceSetResolution",true),
		detachFromElement = gObjFnc("dgs3DInterfaceDetachFromElement",true),
		setAttachedOffsets = gObjFnc("dgs3DInterfaceSetAttachedOffsets",true),
		getAttachedOffsets = gObjFnc("dgs3DInterfaceGetAttachedOffsets"),
		setRotation = gObjFnc("dgs3DInterfaceSetRotation",true),
		getRotation = gObjFnc("dgs3DInterfaceGetRotation"),
		setFaceTo = gObjFnc("dgs3DInterfaceSetFaceTo",true),
		getFaceTo = gObjFnc("dgs3DInterfaceGetFaceTo"),
	};
}

class {
	extends = "dgs3D";
	type = "dgs3DText";
	dgsType="dgs-dx3dtext";
	preInstantiate = function(parent,...)
		return call(dgsOOP.dgsRes,"dgsCreate3DText",...)
	end;
	public = {
		getDimension = gObjFnc("dgs3DTextGetDimension"),
		setDimension = gObjFnc("dgs3DTextSetDimension",true),
		getInterior = gObjFnc("dgs3DTextGetInterior"),
		setInterior = gObjFnc("dgs3DTextSetInterior",true),
		attachToElement = gObjFnc("dgs3DTextAttachToElement",true),
		detachFromElement = gObjFnc("dgs3DTextDetachFromElement",true),
		isAttached = gObjFnc("dgs3DTextIsAttached"),
		setAttachedOffsets = gObjFnc("dgs3DTextSetAttachedOffsets",true),
		getAttachedOffsets = gObjFnc("dgs3DTextGetAttachedOffsets"),
		setPosition = gObjFnc("dgs3DTextSetPosition",true),
		getPosition = gObjFnc("dgs3DTextGetPosition"),
		getText = gObjFnc("dgsGetText"),
		setText = gObjFnc("dgsSetText",true),
	};
}

class {
	extends = "dgs3D";
	type = "dgs3DImage";
	dgsType="dgs-dx3dimage";
	preInstantiate = function(parent,...)
		return call(dgsOOP.dgsRes,"dgsCreate3DImage",...)
	end;
	public = {
		getSize = gObjFnc("dgs3DImageGetSize"),
		setSize = gObjFnc("dgs3DImageSetSize",true),
		getImage = gObjFnc("dgs3DImageGetImage"),
		setImage = gObjFnc("dgs3DImageSetImage",true),
		getDimension = gObjFnc("dgs3DImageGetDimension"),
		setDimension = gObjFnc("dgs3DImageSetDimension",true),
		getInterior = gObjFnc("dgs3DImageGetInterior"),
		setInterior = gObjFnc("dgs3DImageSetInterior",true),
		attachToElement = gObjFnc("dgs3DImageAttachToElement",true),
		detachFromElement = gObjFnc("dgs3DImageDetachFromElement",true),
		isAttached = gObjFnc("dgs3DImageIsAttached"),
		setAttachedOffsets = gObjFnc("dgs3DImageSetAttachedOffsets",true),
		getAttachedOffsets = gObjFnc("dgs3DImageGetAttachedOffsets"),
		setPosition = gObjFnc("dgs3DImageSetPosition",true),
		getPosition = gObjFnc("dgs3DImageGetPosition"),
	};
}


class {
	extends = "dgs3D";
	type = "dgs3DLine";
	dgsType="dgs-dx3dline";
	preInstantiate = function(parent,...)
		return call(dgsOOP.dgsRes,"dgsCreate3DLine",...)
	end;
	public = {
		addLine = gObjFnc("dgs3DLineAddLine"),
		removeLine = gObjFnc("dgs3DLineRemoveLine",true),
		getItemWidth = gObjFnc("dgs3DLineGetItemWidth"),
		setItemWidth = gObjFnc("dgs3DLineSetItemWidth",true),
		getItemColor = gObjFnc("dgs3DLineGetItemColor"),
		setItemColor = gObjFnc("dgs3DLineSetItemColor",true),
		getDimension = gObjFnc("dgs3DLineGetDimension"),
		setDimension = gObjFnc("dgs3DLineSetDimension",true),
		getInterior = gObjFnc("dgs3DLineGetInterior"),
		setInterior = gObjFnc("dgs3DLineSetInterior",true),
		attachToElement = gObjFnc("dgs3DLineAttachToElement",true),
		detachFromElement = gObjFnc("dgs3DLineDetachFromElement",true),
		isAttached = gObjFnc("dgs3DLineIsAttached"),
		setAttachedOffsets = gObjFnc("dgs3DLineSetAttachedOffsets",true),
		getAttachedOffsets = gObjFnc("dgs3DLineGetAttachedOffsets"),
		setPosition = gObjFnc("dgs3DLineSetPosition",true),
		getPosition = gObjFnc("dgs3DLineGetPosition"),
		setRotation = gObjFnc("dgs3DLineSetRotation",true),
		getRotation = gObjFnc("dgs3DLineGetRotation"),
	};
}
----------------------------------------------------------
--------------------------------------DGS Built-in Plugins
----------------------------------------------------------
----------------DGS Plugins

class {
	extends = "dgsRoot";
	type = "dgsPlugin";
	public = {
		__index=function(self,key)
			return call(dgsOOP.dgsRes,"dgsGetProperty",self.dgsElement,key)
		end,
		__newindex=function(self,key,value)
			return call(dgsOOP.dgsRes,"dgsSetProperty",self.dgsElement,key,value) and self or false
		end,
		getPluginType = gObjFnc("dgsGetPluginType"),
		getProperty = gObjFnc("dgsGetProperty"),
		setProperty = gObjFnc("dgsSetProperty",true),
		getProperties = function(self,...) return call(dgsOOP.dgsRes,"dgsGetProperties",self.dgsElement,...) end,
		setProperties = gObjFnc("dgsSetProperties",true),
		destroy = function(self) return destroyElement(self.dgsElement) end;
		isElement = gObjFnc("isElement",true);
		getElement = function(self) return self.dgsElement end,
	};
}

--------------------------Color Picker
class {
	extends = {"dgsPlugin","dgsImage"};
	type = "dgsColorPicker";
	dgsType = "dgs-dxcolorpicker";
	preInstantiate = function(parent,style,x,y,w,h,rlt,...)
		return call(dgsOOP.dgsRes,"dgsCreateColorPicker",style,x,y,w,h,rlt,parent.dgsElement,...)
	end;
	public = {
		getColor = gObjFnc("dgsColorPickerGetColor"),
		setColor = gObjFnc("dgsColorPickerSetColor",true),
	};
}

class {
	extends = {"dgsPlugin","dgsImage"};
	type = "dgsComponentSelector";
	dgsType = "dgs-dxcomponentselector";
	preInstantiate = function(parent,x,y,w,h,voh,rlt,...)
		return call(dgsOOP.dgsRes,"dgsColorPickerCreateComponentSelector",x,y,w,h,voh,rlt,parent.dgsElement,...)
	end;
	public = {
		getCursorThickness = gObjFnc("dgsComponentSelectorGetCursorThickness"),
		setCursorThickness = gObjFnc("dgsComponentSelectorSetCursorThickness",true),
		getValue = gObjFnc("dgsColorPickerGetComponentSelectorValue"),
		setValue = gObjFnc("dgsColorPickerSetComponentSelectorValue",true),
		bindToColorPicker = function(self,colorPicker,...)
			return call(dgsOOP.dgsRes,"dgsBindToColorPicker",self.dgsElement,colorPicker.dgsElement,...)
		end,
		unbindFromColorPicker = gObjFnc("dgsUnbindFromColorPicker",true),
	};
	inject = {
		dgsScrollBar = {
			default = {
				bindToColorPicker = function(self,colorPicker,...)
					return call(dgsOOP.dgsRes,"dgsBindToColorPicker",self.dgsElement,colorPicker.dgsElement,...)
				end,
				unbindFromColorPicker = gObjFnc("dgsUnbindFromColorPicker",true),
			}
		}
	}
}

------------------------------------------------
dgsRootInstance = dgsOOP.dgsRoot()
end