local game = game
local Base = require(R.base_gameControlScript)
local pauseButton = Class(Base)
local composer = require("composer")

function pauseButton:initialize()
    local config = {
        defaultImage = game.chapterConfig.pauseButton,
        width = G.percentX(14),
        height = G.percentY(8),
        x = G.percentX(92),
        y = G.percentY(76)
    }

    Base.initialize(self, config)
    game:addEventListener("onGameEvent", self)
    self.image:addEventListener("touch", self)
    game:addEventListener(GlobalOptions.bonusActivationStartEvent, self)
    game:addEventListener(GlobalOptions.bonusActivationEvent, self)
end

function pauseButton:touch(event)
    local phase = event.phase
    if(phase == "ended") then
        GlobalOptions.pause = true
        composer.showOverlay(R.pauseScene, {isModal = true})
    end
end

function pauseButton:bonusActivationStart()
    self.image:removeEventListener("touch", self)
end

function pauseButton:bonusActivation()
    self.image:addEventListener("touch", self)
end

function pauseButton:onGameEvent(event)
    local phase = event.phase
    if(phase == "changeScene") then
        game:removeEventListener("onGameEvent", self)
        game:removeEventListener(GlobalOptions.bonusActivationStartEvent, self)
        game:removeEventListener(GlobalOptions.bonusActivationEvent, self)
        self.image:removeEventListener("touch", self)
        self.image:removeSelf()
        package.loaded[R.game_pauseButtonScript] = nil
    end
    if(phase == "pause") then
        self.image:removeEventListener("touch", self)
    end
    if(phase == "resume") then
        self.image:addEventListener("touch", self)
    end
end

pauseButton:new()

return pauseButton
