local menu = menu
local optionsMenu = display.newGroup()
menu.optionsMenu = optionsMenu

local optionsMenuBackground = display.newImageRect(optionsMenu, R.menu_optionsMenuBackground, G.percentX(95), G.percentY(35))
optionsMenuBackground.x = G.centerX; 
optionsMenuBackground.y = G.percentY(51);

local optionsMenuLabel = display.newImageRect(optionsMenu, R.menu_optionsMenuLabel, G.percentX(80), G.percentY(14))
optionsMenuLabel.x = G.centerX
optionsMenuLabel.y = G.percentY(42)

require(R.menu_backButtonLargeScript)
require(R.menu_musicButtonLargeScript)
require(R.menu_soundsButtonLargeScript)

menu:addEventListener("onMenuEvent", optionsMenu)
function optionsMenu:onMenuEvent(event)
    local phase = event.phase
    if(phase == "hideOverlay") then
        menu:removeEventListener("onMenuEvent", self)
        optionsMenu:removeSelf()
        self = nil
        package.loaded[R.menu_optionsMenuScript] = nil
    end
end

return optionsMenu



