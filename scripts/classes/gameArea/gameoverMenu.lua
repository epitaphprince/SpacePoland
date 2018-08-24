local game = game
local gameoverMenu = display.newGroup()
game.gameoverMenu = gameoverMenu

local gameoverMenuBackground = display.newImageRect(gameoverMenu, R.game_gameoverMenuBackground, G.percentX(95), G.percentY(40))
gameoverMenuBackground.x = G.centerX; 
gameoverMenuBackground.y = G.percentY(35);

require(R.gameover_replayButtonLargeScript)
require(R.game_levelsListButtonLargeScript):new({display = gameoverMenu, x = G.percentX(65), y = G.percentY(47)})
require(R.game_gameTimeTextLabelScript):new(gameoverMenu)
require(R.game_gameScoresTextLabelScript):new(gameoverMenu)

game:addEventListener("onGameEvent", gameoverMenu)
function gameoverMenu:onGameEvent(event)
    local phase = event.phase
    if(phase == "hideOverlay") then
        game:removeEventListener("onGameEvent", self)
        gameoverMenu:removeSelf()
        self = nil
        package.loaded[R.game_gameoverMenuScript] = nil
    end
end

return gameoverMenu







