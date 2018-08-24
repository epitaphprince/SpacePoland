local game = game
local gameControl = Class()

function gameControl:initialize(config)
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
    if(config.disabledImage) then
        local disabledImage = display.newImageRect(image, config.disabledImage, config.width, config.height)
        disabledImage.isVisible = false
        image.disabledImage = disabledImage
    end
    if(config.text and config.textX and config.textY) then
        local fontSize = GameFont.size
        local fontColor = GameFont.color
        local textAnchor = 0.5
        if(config.fontSize) then
            fontSize = config.fontSize
        end
        if(config.fontColor) then
            fontColor = config.fontColor
        end
        if(config.textAnchor) then
            textAnchor = config.textAnchor
        end
        text.x = config.x
        text.y = config.y
        local defaultText = display.newText(text, tostring(config.text), config.textX, config.textY, GameFont.style, fontSize)
        text.defaultText = defaultText
        defaultText:setFillColor(unpack(fontColor))
        defaultText.anchorX = textAnchor
    end
    if(config.id) then
        self.id = config.id
    end
    self.image = image
    self.text = text
    self.display = config.display or game
    
    self.display:insert(image)
    self.display:insert(text)

    game:addEventListener("onGameEvent", gameControl)
end

function gameControl:updateText(value)
    if(self.text.defaultText) then
        self.text.defaultText.text = "x " .. value
    end
end

function gameControl:push(event)
    local image = self.image
    image.disabledImage.isVisible = false
    image.defaultImage.isVisible = not image.defaultImage.isVisible
    image.alterImage.isVisible = not image.alterImage.isVisible
end

function gameControl:disable()
    local image = self.image
    image.defaultImage.isVisible = false
    image.disabledImage.isVisible = true
end

function gameControl:enable()
    local image = self.image
    image.defaultImage.isVisible = true
    image.disabledImage.isVisible = false
end

function gameControl:onGameEvent(event)
    local phase = event.phase
    if(phase == "changeScene" or phase == "hideOverlay") then
        game:removeEventListener("onGameEvent", self)
        gameControl:dispose()
        package.loaded[R.base_gameControlScript] = nil
    end
end

return gameControl





