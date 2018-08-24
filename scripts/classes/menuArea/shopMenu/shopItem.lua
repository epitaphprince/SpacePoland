local menu = menu
local Base = require(R.base_menuControlScript)
local shopItem = Class(Base)
local scrollView = menu.scrollView

function shopItem:initialize(config)
    Base.initialize(self, config)

    self.id = config.id
    self.current = false
    self.price = config.price
    local logo = display.newImageRect(self.image, config.logo, G.percentX(18), G.percentY(10))
    logo.x = - G.percentX(33)
    logo.y = G.percentY(0)

    local description = display.newText(self.text, config.description, G.percentX(10), G.percentY(3), G.percentX(60), G.percentY(10), GameFont.style, GameFont.descriptionSize)
    description:setFillColor(black)

    menu:addEventListener("onMenuEvent", self)
    menu:addEventListener("clearShopItems", self)
    self.image:addEventListener("touch", self)
end

function shopItem:touch(event)
    local phase = event.phase
    if ( phase == "moved" ) then
        local dy = math.abs( ( event.y - event.yStart ) )
        if ( dy > 10 ) then
            scrollView:takeFocus( event )
        end
    end
    if ( phase == "ended" ) then
        menu:dispatchEvent({name = "clearShopItems", item = self})
        self.current = not self.current
        Base.push(self)
        menu:dispatchEvent({name = "selectShopItem", item = self})
    end
    return true
end

function shopItem:clearShopItems(event)
    local item = event.item
    if(item.id ~= self.id) then
        self.image.defaultImage.isVisible = true
        self.image.alterImage.isVisible = false
        self.current = false
    end
end

function shopItem:onMenuEvent(event)
    local phase = event.phase
    if(phase == "changeScene") then
        menu:removeEventListener("onMenuEvent", self)
        menu:removeEventListener("clearShopItems", self)
        self.image:removeEventListener("touch", self)
        self.text:removeSelf()
        self.image:removeSelf()
        package.loaded[R.menu_shopItemScript] = nil
    end
end

local shopItemsConfig =
{
    {
        id = 1,
        description = "Increase Poland's speed by 50% for 20 seconds",
        price = 101,
        display = scrollView,
        logo = R.menu_bonus1,
        defaultImage = R.menu_shopItem,
        alterImage = R.menu_shopItemSelected,
        width = G.percentX(90),
        height = G.percentY(13),
        x = G.centerX,
        y = G.percentY(7),
        text = "Apple",
        textX = - G.percentX(5),
        textY = - G.percentY(3.5),
        textWidth = G.percentX(30),
        textHeight = G.percentY(4)
    },
    {
        id = 2,
        description = "Gives Poland one-time immortality for 20 seconds",
        price = 102,
        display = scrollView,
        logo = R.menu_bonus2,
        defaultImage = R.menu_shopItem,
        alterImage = R.menu_shopItemSelected,
        width = G.percentX(90),
        height = G.percentY(13),
        x = G.centerX,
        y = G.percentY(21),
        text = "Catholicism",
        textX = - G.percentX(5),
        textY = - G.percentY(3.5),
        textWidth = G.percentX(30),
        textHeight = G.percentY(4),
    },
    {
        id = 3,
        description = "Slows enemies down by 50% for 20 secnods",
        price = 103,
        display = scrollView,
        logo = R.menu_bonus3,
        defaultImage = R.menu_shopItem,
        alterImage = R.menu_shopItemSelected,
        width = G.percentX(90),
        height = G.percentY(13),
        x = G.centerX,
        y = G.percentY(35),
        text = "Waggon",
        textX = - G.percentX(5),
        textY = - G.percentY(3.5),
        textWidth = G.percentX(30),
        textHeight = G.percentY(4),
    },
    {
        id = 4,
        description = "Doubles the number of coins collected for 20 seconds",
        price = 104,
        display = scrollView,
        logo = R.menu_bonus4,
        defaultImage = R.menu_shopItem,
        alterImage = R.menu_shopItemSelected,
        width = G.percentX(90),
        height = G.percentY(13),
        x = G.centerX,
        y = G.percentY(49),
        text = "The Jews",
        textX = - G.percentX(5),
        textY = - G.percentY(3.5),
        textWidth = G.percentX(30),
        textHeight = G.percentY(4)
    },
    {
        id = 5,
        description = "Steals one life from the enemy and passes it to the Poland",
        price = 105,
        display = scrollView,
        logo = R.menu_bonus5,
        defaultImage = R.menu_shopItem,
        alterImage = R.menu_shopItemSelected,
        width = G.percentX(90),
        height = G.percentY(13),
        x = G.centerX,
        y = G.percentY(63),
        text = "Polish-Lithuanian Commonwealth",
        textX = - G.percentX(-15),
        textY = - G.percentY(3.5),
        textWidth = G.percentX(70),
        textHeight = G.percentY(4),
    }
}

for i = 1, #shopItemsConfig do
    shopItem:new(shopItemsConfig[i])
end

return shopItem
