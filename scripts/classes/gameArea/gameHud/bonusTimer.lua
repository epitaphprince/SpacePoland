local Base = require(R.base_gameControlScript)
local bonusTimer = Class(Base)

function bonusTimer:initialize(bonus)
    local config = {
        defaultImage = bonus.defaultImage,
        text = "x " .. GlobalOptions.bonusTime,
        fontColor = {1, 1, 1, 1},
        textX = G.percentX(3.5),
        textY = G.percentY(0),
        textAnchor = 0,
        width = G.percentX(7),
        height = G.percentY(4),
        x = G.percentX(57),
        y = G.percentY(80)
    }

    self.value = GlobalOptions.bonusTime

    Base.initialize(self, config)

    local function timerStep()
        self.value = self.value - 1
        self:updateText(self.value)
        if(self.value <= 0) then
            local russianState = GlobalOptions.enemyState.normal
            if(GlobalOptions.attacks.russian) then
                russianState = GlobalOptions.enemyState.attack
            end
            local germanState = GlobalOptions.enemyState.normal
            if(GlobalOptions.attacks.german) then
                germanState = GlobalOptions.enemyState.attack
            end
            local ufoState = GlobalOptions.enemyState.normal
            if(GlobalOptions.attacks.ufo) then
                ufoState = GlobalOptions.enemyState.attack
            end

            game:dispatchEvent({name = GlobalOptions.bonusActivationEvent, id = bonus.id,
            state = GlobalOptions.bonusState.deactivation, type = bonus.type})

        end
    end

    game:dispatchEvent({name = GlobalOptions.bonusActivationEvent, id = bonus.id,
    state = GlobalOptions.bonusState.activation, type = bonus.type})

    self.timer = timer.performWithDelay(1000, timerStep, -1)

    game:addEventListener("onGameEvent", self)
    game:addEventListener(GlobalOptions.bonusActivationEvent, self)
end

function bonusTimer:destroy()
    game:removeEventListener("onGameEvent", self)
    game:removeEventListener("activateTimer", self)
    game:removeEventListener(GlobalOptions.bonusActivationEvent, self)
    timer.cancel(self.timer)
    self.image:removeSelf()
    self.text:removeSelf()
    package.loaded[R.game_bonusTimerScript] = nil
end

function bonusTimer:bonusActivation(event)
    local state = event.state
    if(state == GlobalOptions.bonusState.deactivation) then
        self:destroy()
    end
end

function bonusTimer:onGameEvent(event)
    local phase = event.phase
    if(phase == "changeScene") then
        self:destroy()
    end
    if(phase == "pause") then
        timer.pause(self.timer)
    end
    if(phase == "resume") then
        timer.resume(self.timer)
    end
end

return bonusTimer
