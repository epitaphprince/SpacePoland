local menu = menu
local Base = require(R.base_menuControlScript)
local nextLevelsListButton = Class(Base)


function nextLevelsListButton:initialize()
    local config = {
        defaultImage = R.menu_nextLevelsListButton,
        width = G.percentX(18),
        height = G.percentY(13),
        x = G.percentX(88),
        y = G.percentY(85),
    }
    Base.initialize(self, config)
    self.enabled = true
    
    menu:addEventListener("onMenuEvent", self)
    menu:addEventListener("changeLevelScreen", self)
    self.image:addEventListener("touch", self)
end

function nextLevelsListButton:touch(event)
    local phase = event.phase
    if(phase == "ended" and self.enabled) then
        if(GlobalOptions.selectedScreen < GlobalOptions.levelsScreenCount) then
            local index = 1
            GlobalOptions.selectedScreen = GlobalOptions.selectedScreen + index
            menu:dispatchEvent({name = "changeLevelScreen", delay = GlobalOptions.levelScreenDelay, index = index})
        end
    end
end

function nextLevelsListButton:changeLevelScreen(event)
    self.enabled = false
    self.timer = timer.performWithDelay(event.delay, 
    function() 
        self.enabled = true;
    end)
end

function nextLevelsListButton:onMenuEvent(event)
    local phase = event.phase
    if(phase == "changeScene") then
        menu:removeEventListener("onMenuEvent", self)
        menu:removeEventListener("changeLevelScreen", self)
        if(self.timer) then
            timer.cancel(self.timer)
        end
        self.image:removeEventListener("touch", self)
        self.image:removeSelf()
        package.loaded[R.menu_nextLevelsListButtonScript] = nil
    end
end

nextLevelsListButton:new()

return nextLevelsListButton