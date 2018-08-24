local menu = menu
local Base = require(R.base_menuControlScript)
local levelsListPoint = Class(Base)

function levelsListPoint:initialize(number)
    local baseX = G.centerX - (G.percentX(10) * (GlobalOptions.levelsScreenCount + 1)) / 2
    
    local config = 
    {
        defaultImage = R.menu_levelsListPoint,
        alterImage = R.menu_levelsListPointCurrent,
        width = G.percentX(10),
        height = G.percentX(10),
        x = baseX + G.percentX(10) * number,
        y = G.percentY(85),
    }
    Base.initialize(self, config)
    
    self.id = number
    if(self.id == GlobalOptions.selectedScreen) then
        Base.push(self)
    end
    
    menu:addEventListener("onMenuEvent", self)
    menu:addEventListener("changeLevelScreen", self)
end

function levelsListPoint:changeLevelScreen(event)
    
    self.image.defaultImage.isVisible = true
    self.image.alterImage.isVisible = false
    
    if(self.id == GlobalOptions.selectedScreen) then
        Base.push(self)
    end
end

function levelsListPoint:onMenuEvent(event)
    local phase = event.phase
    if(phase == "changeScene") then
        menu:removeEventListener("onMenuEvent", self)
        menu:removeEventListener("changeLevelScreen", self)
        self.image:removeSelf()
        package.loaded[R.menu_levelsListPointScript] = nil
    end
end

for i = 1, GlobalOptions.levelsScreenCount do
    levelsListPoint:new(i)
end

return levelsListPoint












