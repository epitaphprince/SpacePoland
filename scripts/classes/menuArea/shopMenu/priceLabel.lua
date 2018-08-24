local menu = menu
local Base = require(R.base_menuControlScript)
local priceLabel = Class(Base)

function priceLabel:initialize()
    local config = {
        defaultImage = R.menu_pointsCounter,
        width = G.percentX(14),
        height = G.percentY(7.5),
        x = G.percentX(70),
        y = G.percentY(86),
        text = "x 0",
        textX = G.percentX(9),
        textY = G.percentY(0)
    }
    
    Base.initialize(self, config)
    
    self.text.defaultText.anchorX = 0
    menu:addEventListener("onMenuEvent", self)
    menu:addEventListener("selectShopItem", self)
    self.image:addEventListener("touch", self)
end

function priceLabel:selectShopItem(event)
    local item = event.item
    if(item.current) then
        self.text.defaultText.text = "x " .. item.price
    else
        self.text.defaultText.text = "x 0"
    end
end

function priceLabel:onMenuEvent(event)
    local phase = event.phase
    if(phase == "changeScene") then
        menu:removeEventListener("onMenuEvent", self)
        self.image:removeEventListener("touch", self)
        self.image:removeSelf()
        self.text:removeSelf()
        package.loaded[R.menu_priceLabelScript] = nil
    end
end

priceLabel:new()

return priceLabel




