function dxScroll(x, y, wh, vertical, parent, rounded, colorbackground, colorboton, colortext)

	local self, element = createElement('dxScroll', parent, sourceResource)
	if self then

		self.x = math.round(x)
		self.y = math.round(y)

		self.font = Files['font']['Basic-Regular'][10]
		self.fontH = dxGetFontHeight( 1, self.font )

		self.vertical = vertical
		self.rounded = tonumber(rounded) or rounded == true and 10 or false
		self.wh = math.round(wh)

		if self.vertical then
			self.w = math.round(17*sh)
			self.h = self.wh
		else
			self.w = self.wh
			self.h = math.round(17*sh)
		end

		

		local back = dxLibraryThemes['back'][dxLibraryThemeBackSelected]
        local front = dxLibraryThemes['front'][dxLibraryThemeFrontSelected]
        
		self.colorbackground = colorbackground or back.scrollbackground
		self.colorboton = colorboton or front.scrollboton
		self.colortext = colortext or -1
		--
		self.cursorY = 0
		self.cursorX = 0

		self.scrollPosition = 0
		self.current = 0
		
		if self.parent then
			self.offsetX = self.x - Cache[self.parent].x
        	self.offsetY = self.y - Cache[self.parent].y
        end

        if tonumber(self.rounded) then
        	local rawSvgData = svgCreateRoundedRectangle(self.w, self.h, self.rounded, self.colorbackground)
        	self.svg = svgCreate(self.w, self.h, rawSvgData, function() self.update = true end)

			if self.vertical then
				local rawSvgData = svgCreateRoundedRectangle(self.w, self.h/3, self.rounded, self.colorboton)
        		self.svg2 = svgCreate(self.w, self.h/3, rawSvgData, function() self.update = true end)
			else
				local rawSvgData = svgCreateRoundedRectangle(self.w/3, self.h, self.rounded, self.colorboton)
        		self.svg2 = svgCreate(self.w/3, self.h, rawSvgData, function() self.update = true end)
			end
        else
        	self.update = true
        end
  	
        return element

	end

end

function dxScrollSetVertical(element, state)
	local self = Cache[element]
	if self then
		self.vertical = state

		if self.vertical then
			self.pos = self.y + self.fontH
			self.w = math.round(17*sh)
			self.h = self.wh
		else
			self.pos = self.x + dxGetTextWidth( "▲", 1, self.font )*2
			self.w = self.wh
			self.h = math.round(17*sh)
		end

		if self.parent then
			if not self.vertical then
	    		self.posOff = self.pos - Cache[self.parent].x
	    	else
	    		self.posOff = self.pos - Cache[self.parent].y
	    	end
	    end

		self.update = true
	end
	return false
end
function dxScrollGetCurrentPosition(element)
	local self = Cache[element]
	if self then
		return self.current
	end
	return false
end

function dxScrollSetCurrentPosition(element, current)
	local self = Cache[element]
	if self then

		local current = tonumber(current)
		if not current then return end
		if current > 1 then current = 1 end
		if current < 0 then current = 0 end

		self.newCurrent = current
	end
	return false
end


function dxScrollSetColorButton(element, r, g, b, a)
	local self = Cache[element]
	if self then
		self.colorboton = tocolor(r, g, b, a)
		return  true
	end
	return false
end
