local game = game
local Base = require(R.base_gameControlScript)
local levelsListButtonLarge = Class(Base)
local composer = require("composer")

function levelsListButtonLarge:initialize()
    local config = {
        defaultImage = R.game_levelsListButtonLarge,
        display = game.pauseMenu,
        width = G.percentX(34),
        height = G.percentY(17),
        x = G.percentX(50),
        y = G.percentY(58)
    }

    Base.initialize(self, config)
    game:addEventListener("onGameEvent", self)
    self.image:addEventListener("touch", self)
end

function levelsListButtonLarge:touch(event)
    local phase = event.phase
    if(phase == "ended") then
        composer.gotoScene(R.levelsListScene)
        GlobalOptions.gameStart = false
        GlobalOptions.pause = false
    end
end

function levelsListButtonLarge:onGameEvent(event)
    local phase = event.phase
    if(phase == "hideOverlay") then
        game:removeEventListener("onGameEvent", self)
        self.image:removeEventListener("touch", self)
        self.image:removeSelf()
        package.loaded[R.game_levelsListButtonLargeScript] = nil
    end
end

levelsListButtonLarge:new()

return levelsListButtonLarge
