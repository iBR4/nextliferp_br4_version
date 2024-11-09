if localPlayer then


local sx, sy = guiGetScreenSize()
local EditBox = {}
local editSelected;

addEvent('onEditBoxEnter')

function dxDrawEditBox(key, text, x, y, w, h, font, masked, max, r, g, b, color2, alignX, caretVisible)

    if not EditBox[key] then
        EditBox[key] = {
            text = '',
            max = max or -1,
            over = false
        }
    end

    local font = font or 'default-bold'
    local color2 = color2 or tocolor(30,30,30,100)
    local v = EditBox[key]

    if (#v.text == 0) then
        dxDrawText(text, x + 5, y, x + w - 10, y + h, color2, 1, font, (alignX or "center"), "center", true, false, false)
    end
    
    if (dxGetTextWidth(masked and string.gsub(v.text, ".", "•") or v.text, 1, font) <= w - 10) then
        dxDrawText(masked and string.gsub(v.text, ".", "•") or v.text, x + 5, y, x + w - 10, y + h, tocolor(r, g, b, 255), 1, font, "left", "center", true, false, false)
    else
        dxDrawText(masked and string.gsub(v.text, ".", "•") or v.text, x + 5, y, x + w - 10, y + h, tocolor(r, g, b, 255), 1, font, "right", "center", true, false, false)
    end
    
    if editSelected and editSelected == key and (caretVisible == nil or caretVisible == true) then
        if (dxGetTextWidth(masked and string.gsub(v.text, ".", "•") or v.text, 1, font) <= w - 10) then
            dxDrawLine(x + 5 + dxGetTextWidth(masked and string.gsub(v.text, ".", "•") or v.text, 1, font), y + 5, x + 5 + dxGetTextWidth(masked and string.gsub(v.text, ".", "•") or v.text, 1, font), y + h - 5, tocolor(r, g, b, math.abs(math.sin(getTickCount() / 255) * 255)), 1, false)
        else
            dxDrawLine(x + w - 10, y + 5, x + w - 10, y + h - 5, tocolor(r, g, b, math.abs(math.sin(getTickCount() / 255) * 255)), 1, false)
        end
    end
    
    if isCursorShowing() then
        local cx, cy = getCursorPosition()
        local cx, cy =(cx*sx),(cy*sy)
        v.over = (cx >= x and cx <= x + w) and (cy >= y and cy <= y + h)
    else
        v.over = false
    end

    if editSelected and editSelected == key then
        if getKeyState( 'backspace' ) then

            if not tickDelete or getTickCount(  ) - tickDelete >= 90 then

                if #v.text > 0 then
                    EditBox[key].text = EditBox[key].text:sub(1, #EditBox[key].text-1)
                end
                tickDelete = getTickCount(  )

            end
        else
            if tickDelete then
                tickDelete = nil
            end
        end
    end

    return EditBox[key].text
end
 

function editSetText(key, txt)
    if EditBox[key] then
        EditBox[key].text = txt
        return true
    end
    return false
end

function editGetText(key)
    return EditBox[key] and EditBox[key].text or false
end


function activeInputEditBox(key)
    editSelected = key
    if editSelected then
        guiSetInputEnabled( true )
        showCursor( true )
    else
        guiSetInputEnabled( false )
        showCursor( false )
    end
end

addEventHandler("onClientClick", getRootElement(),
    function(button, state, cx, cy)
        if (button == "left") and (state == "down") then

            local key
            for k, v in pairs(EditBox) do
                if v.over then
                    key = k
                    break
                end
            end

            if key and EditBox[key] then
                --guiSetInputMode("no_binds")
                guiSetInputEnabled( true )
                --showCursor( true )
                editSelected = key
            else
                --guiSetInputMode("allow_binds")
                if editSelected then
                    guiSetInputEnabled( false )
                    --showCursor( false )
                    editSelected = nil
                end
            end

        end
    end
)

addEventHandler("onClientCharacter", getRootElement(),
    function(c)
        if (isChatBoxInputActive()) or (isConsoleActive()) or (isMainMenuActive()) then
            return
        end

        for k, v in pairs(EditBox) do
            if v.over then
                key = k
                break
            end
        end

        local key = editSelected
        if key and EditBox[key] then
            if (EditBox[key].max == -1) or (#EditBox[key].text < EditBox[key].max) then
                EditBox[key].text = EditBox[key].text..c
            end
        end
    end
)

addEventHandler("onClientKey", getRootElement(),
    function(button, press)
        if (isChatBoxInputActive()) or (isConsoleActive()) or (isMainMenuActive()) then
            return
        end

        local key = editSelected
        if key and EditBox[key] then
            if (press) then
                if (button == "enter") then
                    triggerEvent('onEditBoxEnter', root, key, EditBox[key].text)
                end
            end
        end
    end
)

addEventHandler("onClientPaste", root, function(text2)
    local key = editSelected
    if key and EditBox[key] then
        EditBox[key].text = (EditBox[key].text or '') .. text2
    end
end)

end