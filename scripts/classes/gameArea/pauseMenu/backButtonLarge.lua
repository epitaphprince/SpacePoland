local game = game
local Base = require(R.base_gameControlScript)
local backButtonLarge = Class(Base)
local composer = require("composer")

function backButtonLarge:initialize()
    local config = {
        defaultImage = R.game_backButtonLarge,
        display = game.pauseMenu,
        width = G.percentX(34),
        height = G.percentY(17),
        x = G.percentX(20),
        y = G.percentY(58)
    }

    Base.initialize(self, config)
    game:addEventListener("onGameEvent", self)
    self.image:addEventListener("touch", self)
end

function backButtonLarge:touch(event)
    local phase = event.phase
    if(phase == "ended") then
        GlobalOptions.pause = false
        composer.hideOverlay()
    end
end

function backButtonLarge:onGameEvent(event)
    local phase = event.phase
    if(phase == "hideOverlay") then
        game:removeEventListener("onGameEvent", self)
        self.image:removeEventListener("touch", self)
        self.image:removeSelf()
        package.loaded[R.game_backButtonLargeScript] = nil
    end
end

backButtonLarge:new()

return backButtonLarge
