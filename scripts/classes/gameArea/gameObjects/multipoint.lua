local game = game
local Base = require(R.base_gameObjectScript)
local multipoint = Class(Base)
local levelData = game.levelData

function multipoint:initialize(config)
    Base.initialize(self, config)

    game:addEventListener("onGameEvent", self)
    game:addEventListener(GlobalOptions.getMultipointEvent, self)
end

function multipoint:onGameEvent(event)
    local phase = event.phase
    if(phase == "changeScene") then
        self:remove()
    end
end

function multipoint:getMultipoint(event)
    if(self:checkCoordinates(event.target)) then
        self:remove()
        require(R.game_multipointTimerScript)
        GlobalOptions.objectsToWin = GlobalOptions.objectsToWin - 1
        self:checkWin()
        self:checkAttack()
    end
end

function multipoint:remove()
    game:removeEventListener("onGameEvent", self)
    game:removeEventListener(GlobalOptions.getMultipointEvent, self)
    self.image:removeSelf()
    package.loaded[R.game_multipointScript] = nil
end

for i = 1, #levelData do
    local type = levelData[i].type
    local config = levelData[i]
    if(type == GlobalOptions.multipoint) then
        multipoint:new(config)
        GlobalOptions.objectsToWin = GlobalOptions.objectsToWin + 1
        GlobalOptions.totalPoints = GlobalOptions.totalPoints + 10
    end

end

return multipoint
