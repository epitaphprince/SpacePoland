local menu = menu
local Base = require(R.base_menuControlScript)
local pointsCounter = Class(Base)

function pointsCounter:initialize()
    local config = {
        defaultImage = R.menu_pointsCounter,
        width = G.percentX(10),
        height = G.percentY(5.5),
        x = G.percentX(6),
        y = G.percentY(3),
        text = "x " .. settings.userPoints,
        textX = G.percentX(6),
        textY = G.percentY(0),
    }
    self.value = settings.userPoints
    
    Base.initialize(self, config)
    
    self.text.defaultText.anchorX = 0
    menu:addEventListener("onMenuEvent", self)
    menu:addEventListener("buyShopItem", self)
end

function pointsCounter:buyShopItem(event)
    self.value = self.value - event.price
    self.text.defaultText.text = "x " .. self.value
    settings:set("userPoints", self.value);
    settings:save()
end

function pointsCounter:onMenuEvent(event)
    local phase = event.phase
    if(phase == "changeScene") then
        menu:removeEventListener("onMenuEvent", self)
        menu:removeEventListener("buyShopItem", self)
        self.text:removeSelf()
        self.image:removeSelf()
        package.loaded[R.menu_pointsCounterScript] = nil
    end
end

pointsCounter:new()

return pointsCounter








