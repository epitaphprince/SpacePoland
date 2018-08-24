local menu = menu
local Base = require(R.base_menuControlScript)
local backButton = Class(Base)
local composer = require("composer")

function backButton:initialize()
    local config = {
        defaultImage = R.menu_backButton,
        width = G.percentX(14),
        height = G.percentY(8),
        x = G.percentX(10),
        y = G.percentY(96)
    }

    Base.initialize(self, config)
    menu:addEventListener("onMenuEvent", self)
    self.image:addEventListener("touch", self)
end

function backButton:touch(event)
    local phase = event.phase
    if(phase == "began") then
        composer.gotoScene(R.menuScene)
    end
end

function backButton:onMenuEvent(event)
    local phase = event.phase
    if(phase == "changeScene") then
        menu:removeEventListener("onMenuEvent", self)
        self.image:removeEventListener("touch", self)
        self.image:removeSelf()
        package.loaded[R.menu_backButtonScript] = nil
    end
end

backButton:new()

return backButton
