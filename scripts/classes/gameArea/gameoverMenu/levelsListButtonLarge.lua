local game = game
local Base = require(R.base_gameControlScript)
local levelsListButtonLarge = Class(Base)
local composer = require("composer")

function levelsListButtonLarge:initialize()
    local config = {
        defaultImage = R.game_levelsListButtonLagre,
        display = game.gameoverMenu,
        width = G.percentX(25),
        height = G.percentX(25),
        x = G.percentX(70),
        y = G.percentY(47)
    }

    Base.initialize(self, config)
    game:addEventListener("onGameEvent", self)
    self.image:addEventListener("touch", self)
end

function levelsListButtonLarge:touch(event)
    local phase = event.phase
    if(phase == "ended") then
        composer.gotoScene(R.levelsListScene)
    end
end

function levelsListButtonLarge:onGameEvent(event)
    local phase = event.phase
    if(phase == "hideOverlay") then
        game:removeEventListener("onGameEvent", self)
        self.image:removeEventListener("touch", self)
        self.image:removeSelf()
        package.loaded[R.gameover_levelsListButtonLargeScript] = nil
    end
end

levelsListButtonLarge:new()

return levelsListButtonLarge
