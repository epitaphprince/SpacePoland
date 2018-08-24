local game = game
local Base = require(R.base_gameControlScript)
local nextLevelButtonLarge = Class(Base)
local composer = require("composer")

function nextLevelButtonLarge:initialize()
    local config = {
        defaultImage = R.game_nextLevelButtonLarge,
        display = game.gamewinMenu,
        width = G.percentX(25),
        height = G.percentX(25),
        x = G.percentX(80),
        y = G.percentY(47)
    }

    Base.initialize(self, config)
    game:addEventListener("onGameEvent", self)
    self.image:addEventListener("touch", self)
end

function nextLevelButtonLarge:touch(event)
    local phase = event.phase
    if(phase == "ended") then
--        composer.gotoScene(R.levelsListScene)
    end
end

function nextLevelButtonLarge:onGameEvent(event)
    local phase = event.phase
    if(phase == "hideOverlay") then
        game:removeEventListener("onGameEvent", self)
        self.image:removeEventListener("touch", self)
        self.image:removeSelf()
        package.loaded[R.gamewin_nextLevelButtonLargeScript] = nil
    end
end

nextLevelButtonLarge:new()

return nextLevelButtonLarge
