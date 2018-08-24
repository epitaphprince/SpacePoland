local menu = menu
local Base = require(R.base_menuControlScript)
local musicButtonLarge = Class(Base)

function musicButtonLarge:initialize()
    local config = {
        defaultImage = R.menu_musicOnButtonLarge,
        alterImage = R.menu_musicOffButtonLarge,
        display = menu.optionsMenu,
        width = G.percentX(34),
        height = G.percentY(17),
        x = G.percentX(50),
        y = G.percentY(58)
    }
    
    Base.initialize(self, config)
    
    if(not settings.musicEnabled) then
        Base.push(self)
    end
    
    menu:addEventListener("onMenuEvent", self)
    self.image:addEventListener("touch", self)
end

function musicButtonLarge:touch(event)
    local phase = event.phase
    if(phase == "ended") then
        settings:set("musicEnabled", not settings.musicEnabled)
        settings:save()
        Base.push(self)
    end
end

function musicButtonLarge:onMenuEvent(event)
    local phase = event.phase
    if(phase == "hideOverlay") then
        menu:removeEventListener("onMenuEvent", self)
        self.image:removeEventListener("touch", self)
        self.image:removeSelf()
        package.loaded[R.menu_musicButtonLargeScript] = nil
    end
end

musicButtonLarge:new()

return musicButtonLarge








