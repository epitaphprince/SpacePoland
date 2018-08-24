local game = game
local Base = require(R.base_gameControlScript)
local replayButtonLarge = Class(Base)
local composer = require("composer")

function replayButtonLarge:initialize()
    local config = {
        defaultImage = R.game_replayButtonLarge,
        display = game.gamewinMenu,
        width = G.percentX(25),
        height = G.percentX(25),
        x = G.percentX(20),
        y = G.percentY(47)
    }

    Base.initialize(self, config)
    game:addEventListener("onGameEvent", self)
    self.image:addEventListener("touch", self)
end

function replayButtonLarge:touch(event)
    local phase = event.phase
    if(phase == "ended") then
--        composer.gotoScene(R.levelsListScene)
    end
end

function replayButtonLarge:onGameEvent(event)
    local phase = event.phase
    if(phase == "hideOverlay") then
        game:removeEventListener("onGameEvent", self)
        self.image:removeEventListener("touch", self)
        self.image:removeSelf()
        package.loaded[R.gamewin_replayButtonLargeScript] = nil
    end
end

replayButtonLarge:new()

return replayButtonLarge
