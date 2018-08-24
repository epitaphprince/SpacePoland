local game = game
local Base = require(R.base_gameControlScript)
local applyButtonLarge = Class(Base)
local composer = require("composer")

function applyButtonLarge:initialize()
    local config = {
        defaultImage = R.game_applyButtonLarge,
        display = game.bonusesSelectMenu,
        width = G.percentX(30),
        height = G.percentX(30),
        x = G.centerX,
        y = G.percentY(30)
    }

    Base.initialize(self, config)
    game:addEventListener("onGameEvent", self)
    self.image:addEventListener("touch", self)
end

function applyButtonLarge:touch(event)
    local phase = event.phase
    if(phase == "ended") then
        game:dispatchEvent({name = GlobalOptions.selectBonusesEvent, bonuses = game.selectedBonuses})
        composer.hideOverlay()
    end
end

function applyButtonLarge:onGameEvent(event)
    local phase = event.phase
    if(phase == "hideOverlay") then
        game:removeEventListener("onGameEvent", self)
        self.image:removeEventListener("touch", self)
        self.image:removeSelf()
        package.loaded[R.game_applyButtonLargeScript] = nil
    end
end

applyButtonLarge:new()

return applyButtonLarge
