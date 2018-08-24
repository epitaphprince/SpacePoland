local game = game
local Base = require(R.base_gameControlScript)
local optionsButtonLarge = Class(Base)
local composer = require("composer")

function optionsButtonLarge:initialize()
    local config = {
        defaultImage = R.game_optionsButtonLarge,
        display = game.pauseMenu,
        width = G.percentX(34),
        height = G.percentX(34),
        x = G.percentX(80),
        y = G.percentY(58)
    }

    Base.initialize(self, config)
    game:addEventListener("onGameEvent", self)
    self.image:addEventListener("touch", self)
end

function optionsButtonLarge:touch(event)
    local phase = event.phase
    if(phase == "ended") then
        local options =
        {
            isModal = true,
            params = {sceneName = "pause"}
        }
        composer.showOverlay(R.optionsScene, options)
    end
end

function optionsButtonLarge:onGameEvent(event)
    local phase = event.phase
    if(phase == "hideOverlay") then
        game:removeEventListener("onGameEvent", self)
        self.image:removeEventListener("touch", self)
        self.image:removeSelf()
        package.loaded[R.game_optionsButtonLargeScript] = nil
    end
end

optionsButtonLarge:new()

return optionsButtonLarge
