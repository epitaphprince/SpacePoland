local game = game
local gameArea = {}
local composer = require("composer")

require(R.game_gameChaptersConfigScript)

local preBackground = display.newRect(game, G.centerX, G.centerY, G.w * 1.5, G.h * 1.5)
preBackground:setFillColor(1, 1, 1)

local gameBackground = display.newImageRect(game, game.chapterConfig.background, G.w, G.h)
gameBackground.x = G.centerX;
gameBackground.y = G.centerY

require(R.game_fileModuleScript)
require(R.game_gameObjectsScript)
require(R.game_gameHudScript)
require(R.game_gameTimerScript)

GlobalOptions.pointsToRussianAttack = GlobalOptions.totalPoints / 4
GlobalOptions.pointsToGermanAttack = GlobalOptions.pointsToRussianAttack * 2
GlobalOptions.pointsToUfoAttack = GlobalOptions.pointsToRussianAttack * 3

game:addEventListener(GlobalOptions.gameWinEvent, gameArea)
game:addEventListener(GlobalOptions.gameOverEvent, gameArea)

game:addEventListener("onGameEvent", gameArea)
function gameArea:onGameEvent(event)
    local phase = event.phase
    if(phase == "changeScene") then
        game:removeEventListener("onGameEvent", self)
        game:removeEventListener(GlobalOptions.gameWinEvent, self)
        game:removeEventListener(GlobalOptions.gameOverEvent, self)
        self = nil
        package.loaded[R.game_gameAreaScript] = nil
    end
end

function gameArea:gameWin()
    GlobalOptions.pause = true
    game:dispatchEvent({name = "onGameEvent", phase = "pause"})
    composer.showOverlay(R.gamewinScene, {isModal = true})
end

function gameArea:gameOver()
    GlobalOptions.pause = true
    game:dispatchEvent({name = "onGameEvent", phase = "pause"})
    composer.showOverlay(R.gameoverScene, {isModal = true})
end

composer.showOverlay(R.bonusesSelectScene, {isModal = true})

return gameArea
