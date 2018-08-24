local menu = menu
local Base = require(R.base_menuControlScript)
local buyButton = Class(Base)

function buyButton:initialize()
    local config = {
        defaultImage = R.menu_buyButton,
        width = G.percentX(60),
        height = G.percentY(8),
        x = G.percentX(25),
        y = G.percentY(86)
    }
    
    self.price = 0
    Base.initialize(self, config)
    menu:addEventListener("onMenuEvent", self)
    menu:addEventListener("selectShopItem", self)
    self.image:addEventListener("touch", self)
end

function buyButton:selectShopItem(event)
    local item = event.item
    if(item.current) then
        self.id = item.id
        self.price = item.price
    else
        self.price = 0
    end
end

function buyButton:touch(event)
    local phase = event.phase
    if(phase == "ended" and self.price > 0 and settings.userPoints >= self.price) then
        -- test
        menu:dispatchEvent({name = "buyShopItem", price = self.price, id = self.id})
    end
end

function buyButton:onMenuEvent(event)
    local phase = event.phase
    if(phase == "changeScene") then
        menu:removeEventListener("onMenuEvent", self)
        menu:removeEventListener("selectShopItem", self)
        self.image:removeEventListener("touch", self)
        self.image:removeSelf()
        package.loaded[R.menu_buyButtonScript] = nil
    end
end

buyButton:new()

return buyButton




