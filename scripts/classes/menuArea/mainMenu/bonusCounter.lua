local menu = menu
local Base = require(R.base_menuControlScript)
local bonusCounter = Class(Base)

function bonusCounter:initialize(config)
    self.id = config.id
    self.value = config.value
    Base.initialize(self, config)
    menu:addEventListener("onMenuEvent", self)  
    menu:addEventListener("buyShopItem", self)
end

function bonusCounter:buyShopItem(event)
    if(self.id == event.id) then
        self.value = self.value + 1
        self.text.defaultText.text = self.value
        settings:set("bonus" .. self.id, self.value);
        settings:save()
    end
end

function bonusCounter:onMenuEvent(event)
    local phase = event.phase
    if(phase == "changeScene") then
        menu:removeEventListener("onMenuEvent", self)
        menu:removeEventListener("buyShopItem", self)
        self.text:removeSelf()
        self.image:removeSelf()
        package.loaded[R.menu_bonusCounterScript] = nil
    end
end

local bonusesConfig = 
{
    {
        id = 1,
        value = settings.bonus1,
        defaultImage = R.menu_bonus1,
        width = G.percentX(8),
        height = G.percentY(4),
        x = G.percentX(55),
        y = G.percentY(2.5),
        text = settings.bonus1,
        textX = G.percentX(0),
        textY = G.percentY(3)
    },
    {
        id = 2,
        value = settings.bonus2,
        defaultImage = R.menu_bonus2,
        width = G.percentX(8),
        height = G.percentY(4),
        x = G.percentX(65),
        y = G.percentY(2.5),
        text = settings.bonus2,
        textX = G.percentX(0),
        textY = G.percentY(3)
    },
    {
        id = 3,
        value = settings.bonus3,
        defaultImage = R.menu_bonus3,
        width = G.percentX(8),
        height = G.percentY(4),
        x = G.percentX(75),
        y = G.percentY(2.5),
        text = settings.bonus3,
        textX = G.percentX(0),
        textY = G.percentY(3)
    },
    {
        id = 4,
        value = settings.bonus4,
        defaultImage = R.menu_bonus4,
        width = G.percentX(8),
        height = G.percentY(4),
        x = G.percentX(85),
        y = G.percentY(2.5),
        text = settings.bonus4,
        textX = G.percentX(0),
        textY = G.percentY(3)
    },
    {
        id = 5,
        value = settings.bonus5,
        defaultImage = R.menu_bonus5,
        width = G.percentX(8),
        height = G.percentY(4),
        x = G.percentX(95),
        y = G.percentY(2.5),
        text = settings.bonus5,
        textX = G.percentX(0),
        textY = G.percentY(3)
    }
}

for i = 1, #bonusesConfig do
    bonusCounter:new(bonusesConfig[i])
end

return bonusCounter








