local game = game
local Base = require(R.base_gameControlScript)
local pointsCounter = Class(Base)

function pointsCounter:initialize()
    local config = {
        defaultImage = game.chapterConfig.point,
        text = "x 0",
        fontColor = {1, 1, 1, 1},
        textX = G.percentX(3.5),
        textY = G.percentY(0),
        textAnchor = 0,
        width = G.percentX(7),
        height = G.percentY(4),
        x = G.percentX(72),
        y = G.percentY(75)
    }

    self.value = 0

    self.coinCount = 1

    Base.initialize(self, config)
    game:addEventListener("onGameEvent", self)
    game:addEventListener(GlobalOptions.getPointEvent, self)
    game:addEventListener(GlobalOptions.getMultipointEvent, self)
    game:addEventListener(GlobalOptions.bonusActivationEvent, self)
end

function pointsCounter:getPoint(event)
    self.value = self.value + self.coinCount
    GlobalOptions.levelPoints = GlobalOptions.levelPoints + 1
    self:updateText(self.value)
end

function pointsCounter:getMultipoint(event)
    self.value = self.value + self.coinCount * 10
    GlobalOptions.levelPoints = GlobalOptions.levelPoints + 1
    self:updateText(self.value)
end

function pointsCounter:bonusActivation(event)
    local type = event.type
    local state = event.state
    if(type == GlobalOptions.bonusTypes.doubleCoins) then
        if(state == GlobalOptions.bonusState.activation) then
            self.coinCount = 2;
        else
            self.coinCount = 1;
        end
    end
end

function pointsCounter:onGameEvent(event)
    local phase = event.phase
    if(phase == "changeScene") then
        game:removeEventListener("onGameEvent", self)
        game:removeEventListener(GlobalOptions.getPointEvent, self)
        game:removeEventListener(GlobalOptions.getMultipointEvent, self)
        game:removeEventListener(GlobalOptions.bonusActivationEvent, self)
        GlobalOptions.levelPoints = 0
        self.image:removeSelf()
        self.text:removeSelf()
        package.loaded[R.game_pointsCounterScript] = nil
    end
end

pointsCounter:new()

return pointsCounter
