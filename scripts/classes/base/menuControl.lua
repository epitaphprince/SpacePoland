local menu = menu
local menuControl = Class()

function menuControl:initialize(config)
    self.config = config or {}
    local config = self.config
    local image = display.newGroup()
    image.x = config.x
    image.y = config.y
    local text = display.newGroup()

    if(config.defaultImage) then
        local defaultImage = display.newImageRect(image, config.defaultImage, config.width, config.height)
        image.defaultImage = defaultImage
    end
    if(config.alterImage) then
        local alterImage = display.newImageRect(image, config.alterImage, config.width, config.height)
        alterImage.isVisible = false
        image.alterImage = alterImage
    end
    if(config.alpha) then
        image.alpha = config.alpha
    end
    if(config.text) then
        text.x = config.x
        text.y = config.y
        local defaultText = display.newText(text, tostring(config.text), config.textX, config.textY, config.textWidth, config.textHeight, GameFont.style, GameFont.size)
        text.defaultText = defaultText
        defaultText:setFillColor(black)
    end
    self.image = image
    self.text = text
    self.display = config.display or menu

    self.display:insert(image)
    self.display:insert(text)

    menu:addEventListener("onMenuEvent", menuControl)
end

function menuControl:push(event)
    local image = self.image
    image.defaultImage.isVisible = not image.defaultImage.isVisible
    image.alterImage.isVisible = not image.alterImage.isVisible
end

function menuControl:onMenuEvent(event)
    local phase = event.phase
    if(phase == "changeScene" or phase == "hideOverlay") then
        menu:removeEventListener("onMenuEvent", self)
        menuControl:dispose()
        package.loaded[R.base_menuControlScript] = nil
    end
end

return menuControl
