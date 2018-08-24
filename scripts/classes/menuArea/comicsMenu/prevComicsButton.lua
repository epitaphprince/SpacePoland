local menu = menu
local Base = require(R.base_menuControlScript)
local prevComicsButton = Class(Base)

function prevComicsButton:initialize()
    local config = {
        defaultImage = R.menu_prevComicsButton,
        width = G.percentX(18),
        height = G.percentY(13),
        x = G.percentX(12),
        y = G.percentY(93),
        alpha = 0.7
    }
    
    Base.initialize(self, config)
    self.enabled = true
    
    menu:addEventListener("onMenuEvent", self)
    menu:addEventListener("changeComicsScreen", self)
    self.image:addEventListener("touch", self)
end

function prevComicsButton:touch(event)
    local phase = event.phase
    if(phase == "ended" and self.enabled) then
        if(menu.selectedComicsScreen > 1) then
            local index = -1
            menu.selectedComicsScreen = menu.selectedComicsScreen + index
            menu:dispatchEvent({name = "changeComicsScreen", delay = GlobalOptions.levelScreenDelay, index = index})
        end
    end
end

function prevComicsButton:changeComicsScreen(event)
    self.enabled = false
    self.timer = timer.performWithDelay(event.delay, 
    function() 
        self.enabled = true;
    end)
end

function prevComicsButton:onMenuEvent(event)
    local phase = event.phase
    if(phase == "changeScene") then
        menu:removeEventListener("onMenuEvent", self)
        menu:removeEventListener("changeLevelScreen", self)
        if(self.timer) then
            timer.cancel(self.timer)
        end
        self.image:removeEventListener("touch", self)
        self.image:removeSelf()
        package.loaded[R.menu_prevComicsButtonScript] = nil
    end
end

prevComicsButton:new()

return prevComicsButton
