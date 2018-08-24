local game = game
local gameObjects = {}

require(R.base_gameRectangleScript)
require(R.game_blockScript)
require(R.game_pointScript)
require(R.game_multipointScript)
require(R.game_playerScript)
require(R.game_enemyScript)

game:addEventListener("onGameEvent", gameObjects)
function gameObjects:onGameEvent(event)
    local phase = event.phase
    if(phase == "changeScene") then
        game:removeEventListener("onGameEvent", self)
        self = nil
        package.loaded[R.game_gameObjectsScript] = nil
    end
end

return gameObjects


