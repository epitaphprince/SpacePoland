local menu = menu
local Base = require(R.base_menuControlScript)
local backButtonLarge = Class(Base)
local composer = require("composer")

function backButtonLarge:initialize()
    local config = {
        defaultImage = R.menu_backButtonLarge,
        display = menu.optionsMenu,
        width = G.percentX(34),
        height = G.percentY(17),
        x = G.percentX(20),
        y = G.percentY(58)
    }

    Base.initialize(self, config)
    menu:addEventListener("onMenuEvent", self)
    self.image:addEventListener("touch", self)
end

function backButtonLarge:touch(event)
    local phase = event.phase
    if(phase == "ended") then
        composer.hideOverlay()
        if(GlobalOptions.pause and menu.sceneName == "pause") then
            composer.showOverlay(R.pauseScene, {isModal = true})
        end
    end
end

function backButtonLarge:onMenuEvent(event)
    local phase = event.phase
    if(phase == "hideOverlay") then
        menu:removeEventListener("onMenuEvent", self)
        self.image:removeEventListener("touch", self)
        self.image:removeSelf()
        package.loaded[R.menu_backButtonLargeScript] = nil
    end
end

backButtonLarge:new()

return backButtonLarge
