local menu = menu
local Base = require(R.base_menuControlScript)
local playButton = Class(Base)
local composer = require("composer")

function playButton:initialize()
    local config = {
        defaultImage = R.menu_playButton,
        width = G.percentX(100),
        height = G.percentY(12),
        x = G.centerX,
        y = G.percentY(35)
    }

    Base.initialize(self, config)
    menu:addEventListener("onMenuEvent", self)
    self.image:addEventListener("touch", self)
end

function playButton:touch(event)
    local phase = event.phase
    if(phase == "ended") then
        composer.gotoScene(R.levelsListScene)
    end
end

function playButton:onMenuEvent(event)
    local phase = event.phase
    if(phase == "changeScene") then
        menu:removeEventListener("onMenuEvent", self)
        self.image:removeEventListener("touch", self)
        self.image:removeSelf()
        package.loaded[R.menu_playButtonScript] = nil
    end
end

playButton:new()

return playButton
