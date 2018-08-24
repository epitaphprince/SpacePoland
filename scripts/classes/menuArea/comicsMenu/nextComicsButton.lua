local menu = menu
local Base = require(R.base_menuControlScript)
local nextComicsButton = Class(Base)
local composer = require("composer")

function nextComicsButton:initialize()
    local config = {
        defaultImage = R.menu_nextComicsButton,
        width = G.percentX(18),
        height = G.percentY(13),
        x = G.percentX(88),
        y = G.percentY(93),
        alpha = 0.7
    }
    Base.initialize(self, config)
    self.enabled = true

    menu:addEventListener("onMenuEvent", self)
    menu:addEventListener("changeComicsScreen", self)
    self.image:addEventListener("touch", self)
end

function nextComicsButton:touch(event)
    local phase = event.phase
    if(phase == "ended" and self.enabled) then
        if(menu.selectedComicsScreen < menu.comicsCount) then
            local index = 1
            menu.selectedComicsScreen = menu.selectedComicsScreen + index
            menu:dispatchEvent({name = "changeComicsScreen", delay = GlobalOptions.levelScreenDelay, index = index})
        elseif
            (menu.selectedComicsScreen == menu.comicsCount) then
            composer.gotoScene(R.levelsListScene)
        end
    end
end

function nextComicsButton:changeComicsScreen(event)
    self.enabled = false
    self.timer = timer.performWithDelay(event.delay,
    function()
        self.enabled = true;
    end)
end

function nextComicsButton:onMenuEvent(event)
    local phase = event.phase
    if(phase == "changeScene") then
        menu:removeEventListener("onMenuEvent", self)
        menu:removeEventListener("changeComicsScreen", self)
        if(self.timer) then
            timer.cancel(self.timer)
        end
        self.image:removeEventListener("touch", self)
        self.image:removeSelf()
        package.loaded[R.menu_nextComicsButtonScript] = nil
    end
end

nextComicsButton:new()

return nextComicsButton
