local game = game
local gamewinMenu = display.newGroup()
game.gamewinMenu = gamewinMenu 

local gamewinMenuBackground = display.newImageRect(gamewinMenu, R.game_gamewinMenuBackground, G.percentX(95), G.percentY(40))
gamewinMenuBackground.x = G.centerX; 
gamewinMenuBackground.y = G.percentY(35);

require(R.gamewin_replayButtonLargeScript)
require(R.gamewin_nextLevelButtonLargeScript)
require(R.game_levelsListButtonLargeScript):new({display = gamewinMenu, x = G.percentX(50), y = G.percentY(47)})
require(R.game_gameTimeTextLabelScript):new(gamewinMenu)
require(R.game_gameScoresTextLabelScript):new(gamewinMenu)

game:addEventListener("onGameEvent", gamewinMenu)
function gamewinMenu:onGameEvent(event)
    local phase = event.phase
    if(phase == "hideOverlay") then
        game:removeEventListener("onGameEvent", self)
        gamewinMenu:removeSelf()
        self = nil
        package.loaded[R.game_gamewinMenuScript] = nil
    end
end

return gamewinMenu









