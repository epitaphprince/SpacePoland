local menu = menu
local Base = require(R.base_menuControlScript)
local optionsButton = Class(Base)
local composer = require("composer")

function optionsButton:initialize()
    local config = {
        defaultImage = R.menu_optionsButton,
        width = G.percentX(14),
        height = G.percentY(8),
        x = G.percentX(90),
        y = G.percentY(96)
    }

    Base.initialize(self, config)
    menu:addEventListener("onMenuEvent", self)
    self.image:addEventListener("touch", self)
end

function optionsButton:touch(event)
    local phase = event.phase
    if(phase == "ended") then
        composer.showOverlay(R.optionsScene, {isModal = true})
    end
end

function optionsButton:onMenuEvent(event)
    local phase = event.phase
    if(phase == "changeScene") then
        menu:removeEventListener("onMenuEvent", self)
        self.image:removeEventListener("touch", self)
        self.image:removeSelf()
        package.loaded[R.menu_optionsButtonScript] = nil
    end
end

optionsButton:new()

return optionsButton
