local menu = menu
local Base = require(R.base_menuControlScript)
local achievmentsButton = Class(Base)

function achievmentsButton:initialize()
    local config = {
        defaultImage = R.menu_achievmentsButton,
        width = G.percentX(14),
        height = G.percentY(7),
        x = G.percentX(25),
        y = G.percentY(96)
    }
    
    Base.initialize(self, config)
    menu:addEventListener("onMenuEvent", self)
    self.image:addEventListener("touch", self)
end

function achievmentsButton:touch(event)
    local phase = event.phase
    if(phase == "ended") then
    end
end

function achievmentsButton:onMenuEvent(event)
    local phase = event.phase
    if(phase == "changeScene") then
        menu:removeEventListener("onMenuEvent", self)
        self.image:removeEventListener("touch", self)
        self.image:removeSelf()
        package.loaded[R.menu_achievmentsButtonScript] = nil
    end
end

achievmentsButton:new()

return achievmentsButton






