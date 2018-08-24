local menu = menu
local levelsListMenu = {}

local preBackground = display.newRect(menu, G.centerX, G.centerY, G.w * 1.5, G.h * 1.5)
preBackground:setFillColor(1, 1, 1)

local levelsListMenuBackground = display.newImageRect(menu, R.menu_levelsListMenuBackground, G.w, G.h)
levelsListMenuBackground.x = G.centerX 
levelsListMenuBackground.y = G.centerY

local levelsListBack = display.newImageRect(menu, R.menu_levelsListBack, G.percentX(95), G.percentY(70))
levelsListBack.x = G.centerX
levelsListBack.y = G.percentY(43)

require(R.menu_comicsButtonScript)
require(R.menu_optionsButtonScript)
require(R.menu_bonusCounterScript)
require(R.menu_pointsCounterScript)
require(R.menu_backButtonScript)
require(R.menu_prevLevelsListButtonScript)
require(R.menu_nextLevelsListButtonScript)
require(R.menu_levelsListPointScript)
require(R.menu_levelItemScript)

menu:addEventListener("onMenuEvent", levelsListMenu)
function levelsListMenu:onMenuEvent(event)
    local phase = event.phase
    if(phase == "changeScene") then
        menu:removeEventListener("onMenuEvent", self)
        self = nil
        package.loaded[R.menu_levelsListMenuScript] = nil
    end
end

return levelsListMenu





