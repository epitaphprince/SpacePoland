local menu = menu
local Base = require(R.base_menuControlScript)
local soundsButtonLarge = Class(Base)

function soundsButtonLarge:initialize()
    local config = {
        defaultImage = R.menu_soundsOnButtonLarge,
        alterImage = R.menu_soundsOffButtonLarge,
        display = menu.optionsMenu,
        width = G.percentX(34),
        height = G.percentY(17),
        x = G.percentX(80),
        y = G.percentY(58)
    }
    
    Base.initialize(self, config)
    
    if(not settings.soundsEnabled) then
        Base.push(self)
    end
    
    menu:addEventListener("onMenuEvent", self)
    self.image:addEventListener("touch", self)
end

function soundsButtonLarge:touch(event)
    local phase = event.phase
    if(phase == "ended") then
        settings:set("soundsEnabled", not settings.soundsEnabled)
        settings:save()
        Base.push(self)
    end
end

function soundsButtonLarge:onMenuEvent(event)
    local phase = event.phase
    if(phase == "hideOverlay") then
        menu:removeEventListener("onMenuEvent", self)
        self.image:removeEventListener("touch", self)
        self.image:removeSelf()
        package.loaded[R.menu_soundsButtonLargeScript] = nil
    end
end

soundsButtonLarge:new()

return soundsButtonLarge










