local game = game
local Base = require(R.base_gameControlScript)
local bonus = Class(Base)

function bonus:initialize(config)
    Base.initialize(self, config)
    self.type = config.type
    self.defaultImage = config.defaultImage

    game:addEventListener("onGameEvent", self)
    game:addEventListener(GlobalOptions.bonusActivationEvent, self)
    self.image:addEventListener("touch", self)
end

function bonus:touch(event)
    local phase = event.phase
    if(phase == "ended") then
        self.image:removeEventListener("touch", self);
        game:dispatchEvent({name = GlobalOptions.bonusActivationStartEvent})
        self.image.xScale = 2
        self.image.yScale = 2
        self.activationTransition = transition.to(self.image, {time = 1000, x = G.centerX, y = G.percentY(35), onComplete = function()
            local bonusTimer = require(R.game_bonusTimerScript)
            bonusTimer:new(self)
            game:removeEventListener("onGameEvent", self)
            game:removeEventListener(GlobalOptions.bonusActivationEvent, self)
            game:removeEventListener(GlobalOptions.selectBonusesEvent, self)
            self.image:removeSelf()
        end
        })
    end
end

function bonus:bonusActivation(event)
    local type = event.type
    local state = event.state
    if(state == GlobalOptions.bonusState.activation) then
        self.image:removeEventListener("touch", self)
    else
        self.image:addEventListener("touch", self)
    end
end

function bonus:onGameEvent(event)
    local phase = event.phase
    if(phase == "changeScene") then
        game:removeEventListener("onGameEvent", self)
        game:removeEventListener(GlobalOptions.bonusActivationEvent, self)
        self.image:removeEventListener("touch", self)
        self.image:removeSelf()
        package.loaded[R.game_bonusScript] = nil
    end
end

return bonus
