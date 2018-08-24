local game = game
local bonusesSelectMenu = display.newGroup()
game.bonusesSelectMenu = bonusesSelectMenu

require(R.game_bonusSelectItemScript)
require(R.game_applyButtonLargeScript)

game:addEventListener("onGameEvent", bonusesSelectMenu)
function bonusesSelectMenu:onGameEvent(event)
    local phase = event.phase
    if(phase == "hideOverlay") then
        game:removeEventListener("onGameEvent", self)
        bonusesSelectMenu:removeSelf()
        self = nil
        package.loaded[R.game_bonusesSelectMenuScript] = nil
    end
end

return bonusesSelectMenu
