local menu = menu
local shopMenu = {}

local preBackground = display.newRect(menu, G.centerX, G.centerY, G.w * 1.5, G.h * 1.5)
preBackground:setFillColor(1, 1, 1)

local shopMenuBackground = display.newImageRect(menu, R.menu_shopMenuBackground, G.w, G.h)
shopMenuBackground.x = G.centerX; 
shopMenuBackground.y = G.centerY

local shopBack = display.newImageRect(menu, R.menu_shopBack, G.percentX(95), G.percentY(82))
shopBack.x = G.centerX
shopBack.y = G.centerY

local scrollView = widget.newScrollView
{
    top = G.percentY(10),
    left = G.percentX(0),
    width = G.percentX(95),
    height = G.percentY(69),
    scrollHeight = G.percentY(0),
    horizontalScrollDisabled = true,
    hideBackground = true,
    hideScrollBar = true,
    bottomPadding = G.percentY(0.5)
}
menu:insert(scrollView)
menu.scrollView = scrollView

require(R.menu_optionsButtonScript)
require(R.menu_bonusCounterScript)
require(R.menu_pointsCounterScript)
require(R.menu_backButtonScript)
require(R.menu_buyButtonScript)
require(R.menu_shopItemScript)
require(R.menu_priceLabelScript)

menu:addEventListener("onMenuEvent", shopMenu)
function shopMenu:onMenuEvent(event)
    local phase = event.phase
    if(phase == "mainmenu") then
    end
    if(phase == "changeScene") then
        menu:removeEventListener("onMenuEvent", self)
        self = nil
        package.loaded[R.menu_shopMenuScript] = nil
    end
end

return shopMenu



