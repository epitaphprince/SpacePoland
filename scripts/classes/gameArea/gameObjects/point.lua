local game = game
local Base = require(R.base_gameObjectScript)
local point = Class(Base)
local levelData = game.levelData

function point:initialize(config)
    Base.initialize(self, config)
    
    game:addEventListener("onGameEvent", self)
    game:addEventListener(GlobalOptions.getPointEvent, self) 
end

function point:onGameEvent(event)
    local phase = event.phase
    if(phase == "changeScene") then
        self:remove()
    end
end

function point:remove()
    game:removeEventListener("onGameEvent", self)
    game:removeEventListener(GlobalOptions.getPointEvent, self)
    self.image:removeSelf()
    package.loaded[R.game_pointScript] = nil
end

function point:getPoint(event)
    if(self:checkCoordinates(event.target)) then
        self:remove()
        GlobalOptions.objectsToWin = GlobalOptions.objectsToWin - 1
        self:checkWin()
        self:checkAttack()
    end
end

for i = 1, #levelData do
    local type = levelData[i].type
    local config = levelData[i]
    if(type == GlobalOptions.point) then 
        point:new(config)
        GlobalOptions.objectsToWin = GlobalOptions.objectsToWin + 1
        GlobalOptions.totalPoints = GlobalOptions.totalPoints + 1
    end
    
end

return point
