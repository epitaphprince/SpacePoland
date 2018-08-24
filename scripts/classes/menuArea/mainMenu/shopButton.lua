local menu = menu
local Base = require(R.base_menuControlScript)
local shopButton = Class(Base)
local composer = require("composer")

function shopButton:initialize()
    local config = {
        defaultImage = R.menu_shopButton,
        width = G.percentX(100),
        height = G.percentY(12),
        x = G.centerX,
        y = G.percentY(55)
    }

    Base.initialize(self, config)
    menu:addEventListener("onMenuEvent", self)
    self.image:addEventListener("touch", self)
end

function shopButton:touch(event)
    local phase = event.phase
    if(phase == "ended") then
        composer.gotoScene(R.shopScene)
    end
end

function shopButton:onMenuEvent(event)
    local phase = event.phase
    if(phase == "changeScene") then
        menu:removeEventListener("onMenuEvent", self)
        self.image:removeEventListener("touch", self)
        self.image:removeSelf()
        package.loaded[R.menu_shopButtonScript] = nil
    end
end

shopButton:new()

return shopButton
