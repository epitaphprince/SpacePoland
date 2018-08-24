local menu = menu
local Base = require(R.base_menuControlScript)
local leaderboardButton = Class(Base)

function leaderboardButton:initialize()
    local config = {
        defaultImage = R.menu_leaderboardButton,
        width = G.percentX(14),
        height = G.percentY(8),
        x = G.percentX(10),
        y = G.percentY(96)
    }
    
    Base.initialize(self, config)
    menu:addEventListener("onMenuEvent", self)
    self.image:addEventListener("touch", self)
end

function leaderboardButton:touch(event)
    local phase = event.phase
    if(phase == "ended") then
    end
end

function leaderboardButton:onMenuEvent(event)
    local phase = event.phase
    if(phase == "changeScene") then
        menu:removeEventListener("onMenuEvent", self)
        self.image:removeEventListener("touch", self)
        self.image:removeSelf()
        package.loaded[R.menu_leaderboardButtonScript] = nil
    end
end

leaderboardButton:new()

return leaderboardButton




