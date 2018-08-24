local menu = menu
local menuArea = {}

if(menu.sceneName == "mainmenu") then
    require(R.menu_mainMenuScript)
end
if(menu.sceneName == "shopmenu") then
    require(R.menu_shopMenuScript)
end
if(menu.sceneName == "levelslistmenu") then
    require(R.menu_levelsListMenuScript)
end

menu:addEventListener("onMenuEvent", menuArea)
function menuArea:onMenuEvent(event)
    local phase = event.phase
    if(phase == "changeScene") then
        menu:removeEventListener("onMenuEvent", self)
        self = nil
        package.loaded[R.menu_menuAreaScript] = nil
    end
end

return menuArea

