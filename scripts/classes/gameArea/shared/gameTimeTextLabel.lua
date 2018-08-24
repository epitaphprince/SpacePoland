local game = game
local Base = require(R.base_gameControlScript)
local gameTimeTextLabel = Class(Base)

function gameTimeTextLabel:initialize(display)

    local config = {
        display = display,
        text = GlobalOptions.gameTime,
        fontColor = {0, 0, 0, 1},
        fontSize = 48,
        textX = G.percentX(0),
        textY = G.percentY(0),
        textAnchor = 0.5,
        width = G.percentX(10),
        height = G.percentY(5),
        x = G.percentX(80),
        y = G.percentY(36.7)
    }

    Base.initialize(self, config)
end

game:addEventListener("onGameEvent", gameTimeTextLabel)
function gameTimeTextLabel:onGameEvent(event)
    local phase = event.phase
    if(phase == "hideOverlay") then
        game:removeEventListener("onGameEvent", self)
        self = nil
        package.loaded[R.game_gameTimeTextLabelScript] = nil
    end
end

return gameTimeTextLabel