local game = game
local Base = require(R.base_gameObjectScript)
local block = Class(Base)
local levelData = game.levelData

function block:initialize(config)
    Base.initialize(self, config)
    
    game:addEventListener("onGameEvent", self)
end

function block:onGameEvent(event)
    local phase = event.phase
    if(phase == "changeScene") then
        game:removeEventListener("onGameEvent", self)
        self.image:removeSelf()
        package.loaded[R.game_blockScript] = nil
    end
end

for i = 1, #levelData do
    local type = levelData[i].type
    if(type == GlobalOptions.line or type == GlobalOptions.lineCircle
        or type == GlobalOptions.angle or type == GlobalOptions.angleCircle
        or type == GlobalOptions.triangle or type == GlobalOptions.triangleCircle 
        or type == GlobalOptions.tetra) then
            block:new(levelData[i])
    end
    
end

return block
