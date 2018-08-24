--
-- Created by IntelliJ IDEA.
-- User: dgrebennikov
-- Date: 03.06.2018
-- Time: 13:31
--

local game = game
local gameTimer = {}

game:addEventListener("onGameEvent", gameTimer)
function gameTimer:onGameEvent(event)
    local phase = event.phase
    if(phase == "start") then
        self.timer = timer.performWithDelay(1000, function() GlobalOptions.gameTime = GlobalOptions.gameTime + 1 end, -1)
    end
    if(phase == "pause") then
        timer.pause(self.timer)
    end
    if(phase == "resume") then
        timer.resume(self.timer)
    end
    if(phase == "changeScene") then
        game:removeEventListener("onGameEvent", self)
        timer.cancel(self.timer)
        GlobalOptions.gameTime = 0
        self = nil
        package.loaded[R.game_gameTimerScript] = nil
    end
end

return gameTimer