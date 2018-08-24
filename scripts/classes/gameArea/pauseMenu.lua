local game = game
local pauseMenu = display.newGroup()
game.pauseMenu = pauseMenu

local pauseMenuBackground = display.newImageRect(pauseMenu, R.game_pauseMenuBackground, G.percentX(95), G.percentY(35))
pauseMenuBackground.x = G.centerX; 
pauseMenuBackground.y = G.percentY(51);

local pauseMenuLabel = display.newImageRect(pauseMenu, R.game_pauseMenuLabel, G.percentX(80), G.percentY(14))
pauseMenuLabel.x = G.centerX
pauseMenuLabel.y = G.percentY(42)

require(R.game_backButtonLargeScript)
require(R.game_levelsListButtonLargeScript)
require(R.game_optionsButtonLargeScript)

game:addEventListener("onGameEvent", pauseMenu)
function pauseMenu:onGameEvent(event)
    local phase = event.phase
    if(phase == "hideOverlay") then
        game:removeEventListener("onGameEvent", self)
        pauseMenu:removeSelf()
        self = nil
        package.loaded[R.game_pauseMenuScript] = nil
    end
end

return pauseMenu





