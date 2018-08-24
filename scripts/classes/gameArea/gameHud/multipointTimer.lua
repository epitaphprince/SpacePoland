local Base = require(R.base_gameControlScript)
local multipointTimer = Class(Base)

function multipointTimer:initialize()
    local config = {
        defaultImage = game.chapterConfig.multipoint,
        text = "x " .. GlobalOptions.multipointTime,
        fontColor = {1, 1, 1, 1},
        textX = G.percentX(3.5),
        textY = G.percentY(0),
        textAnchor = 0,
        width = G.percentX(7),
        height = G.percentY(4),
        x = G.percentX(34),
        y = G.percentY(80)
    }

    self.value = GlobalOptions.multipointTime

    Base.initialize(self, config)

    local function timerStep()
        self.value = self.value - 1
        self:updateText(self.value)
        if(self.value <= 0) then
            self:multipointTimeDestroy()
        end
    end

    game:dispatchEvent({name = "changeState", id = GlobalOptions.germanEnemy, state = "fear"})
    game:dispatchEvent({name = "changeState", id = GlobalOptions.russianEnemy, state = "fear"})
    game:dispatchEvent({name = "changeState", id = GlobalOptions.ufoEnemy, state = "fear"})
    game:dispatchEvent({name = GlobalOptions.multipointActivationEvent, value = true})

    self.timer = timer.performWithDelay(1000, timerStep, -1)

    game:addEventListener("onGameEvent", self)
    game:addEventListener(GlobalOptions.getMultipointEvent, self)
    game:addEventListener(GlobalOptions.multipointTimeDestroy, self)

end

function multipointTimer:multipointTimeDestroy()

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

    game:dispatchEvent({name = "changeState", id = GlobalOptions.germanEnemy, state = germanState})
    game:dispatchEvent({name = "changeState", id = GlobalOptions.russianEnemy, state = russianState})
    game:dispatchEvent({name = "changeState", id = GlobalOptions.ufoEnemy, state = ufoState})
    game:dispatchEvent({name = GlobalOptions.multipointActivationEvent, value = false})

    game:removeEventListener("onGameEvent", self)
    game:removeEventListener("activateTimer", self)
    game:removeEventListener(GlobalOptions.getMultipointEvent, self)
    timer.cancel(self.timer)
    self.image:removeSelf()
    self.text:removeSelf()
    package.loaded[R.game_multipointTimerScript] = nil
end

function multipointTimer:getMultipoint()
    self.value = GlobalOptions.multipointTime
    self:updateText(self.value)
    game:dispatchEvent({name = "changeState", id = GlobalOptions.germanEnemy, state = "fear"})
    game:dispatchEvent({name = "changeState", id = GlobalOptions.russianEnemy, state = "fear"})
    game:dispatchEvent({name = "changeState", id = GlobalOptions.ufoEnemy, state = "fear"})
end

function multipointTimer:onGameEvent(event)
    local phase = event.phase
    if(phase == "changeScene") then
        self:multipointTimeDestroy()
    end
    if(phase == "pause") then
        timer.pause(self.timer)
    end
    if(phase == "resume") then
        timer.resume(self.timer)
    end
end

multipointTimer:new()

return multipointTimer
