local menu = menu
local mainMenu = {}

local preBackground = display.newRect(menu, G.centerX, G.centerY, G.w * 1.5, G.h * 1.5)
preBackground:setFillColor(1, 1, 1)

local mainMenuBackground = display.newImageRect(menu, R.menu_mainMenuBackground, G.w, G.h)
mainMenuBackground.x = G.centerX; 
mainMenuBackground.y = G.percentY(51);

require(R.menu_playButtonScript)
require(R.menu_shopButtonScript)
require(R.menu_optionsButtonScript)
require(R.menu_leaderboardButtonScript)
require(R.menu_achievmentsButtonScript)
require(R.menu_bonusCounterScript)
require(R.menu_pointsCounterScript)

menu:addEventListener("onMenuEvent", mainMenu)
function mainMenu:onMenuEvent(event)
    local phase = event.phase
    if(phase == "mainmenu") then
    end
    if(phase == "changeScene") then
        menu:removeEventListener("onMenuEvent", self)
        self = nil
        package.loaded[R.menu_mainMenuScript] = nil
    end
end

return mainMenu

