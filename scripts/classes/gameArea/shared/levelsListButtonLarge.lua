local game = game
local Base = require(R.base_gameControlScript)
local levelsListButtonLarge = Class(Base)
local composer = require("composer")

function levelsListButtonLarge:initialize(params)
    local config = {
        defaultImage = R.game_levelsListButtonLarge,
        display = params.display,
        width = params.width or G.percentX(25),
        height = params.height or G.percentX(25),
        x = params.x,
        y = params.y
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

return levelsListButtonLarge
