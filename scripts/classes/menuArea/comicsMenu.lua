local menu = menu
local comicsMenu = {}

menu.selectedComicsScreen = 1

require(R.menu_comicsConfigScript)
require(R.menu_comicsSliderScript)
require(R.menu_prevComicsButtonScript)
require(R.menu_nextComicsButtonScript)

menu:addEventListener("onMenuEvent", comicsMenu)
function comicsMenu:onMenuEvent(event)
    local phase = event.phase
    if(phase == "changeScene") then
        menu:removeEventListener("onMenuEvent", self)
        self = nil
        package.loaded[R.menu_comicsMenuScript] = nil
    end
end

return comicsMenu

