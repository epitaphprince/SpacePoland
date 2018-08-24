-----------------------------------------------------------------------------------------
--
-- GButton.lua
--
----------------------------------------------------------------------------------------------------

local GButton = {}

GButton.presets = {}



function GButton:new(onRelease, x, y, width, height, customOptions)

    -- И еще: over - это нажатое состояние, alt - для переключения (toggle)
    local self = display.newGroup()
    self.anchorChildren = true
    self.x = x
    self.y = y

    -- options inheritance
    local customOpts = table.deepCopy(fnn(customOptions, {}))
    self.options = customOptions
    self.options.releaseSound = sounds:get("tap")

    local function createIcon(iconOptions)
        if iconOptions then
            local icon = display.newImageRect(self, unpack(iconOptions))
            icon.x = width/2 - icon.width/2
            icon.anchorX = 0
            icon.anchorY = 0.5
            icon.y = 0 
            return icon
        end    
        return false
    end

    local icon = createIcon(self.options.icon)
    local iconAlt = createIcon(self.options.alt.icon)
    if iconAlt then
        iconAlt.isVisible = false
    end
    
    local function setOptions(opts)
        opts = fnn(opts, {})
    end

    setOptions(self.options)

    local function effectPress()
        setOptions(self.options.over)
       
    end

    local function effectRelease()
        setOptions(self.options)
       
    end

    local function onReleaseListener(event)
        function inBounds( event )
            local bounds = event.target.contentBounds
            if event.x > bounds.xMin and event.x < bounds.xMax and event.y > bounds.yMin and event.y  < bounds.yMax then
                return true
            else
                return false
            end
        end 

        if event.target.isVisible and event.target.parent.isVisible then
            if event.phase == "began" then
                
                effectPress()
                display.getCurrentStage():setFocus( event.target )

            elseif event.phase == "ended" or event.phase == "cancelled" then

                effectRelease()

                if inBounds(event) then
                    onRelease(event)

                    if self.options.releaseSound then
                        self.options.releaseSound:play()
                    end
                end
                
                display.getCurrentStage():setFocus(nil)

            elseif event.phase=="moved" then

                if not inBounds(event) then
                    effectRelease()
                end

            end

            return true
        end
    end
    self:addEventListener("touch", onReleaseListener)

    function self:setLabel(text)
        label.text = text
    end

    function self:toggle(value)
        if value then

            if icon and iconAlt then
                icon.isVisible = true
                iconAlt.isVisible = false
            end
        else

            if icon and iconAlt then
                iconAlt.isVisible = true
                icon.isVisible = false
            end
        end

    end

    return self
end

return GButton