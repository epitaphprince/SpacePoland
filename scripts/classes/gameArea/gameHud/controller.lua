local game = game
local Base = require(R.base_gameControlScript)
local controller = Class(Base)
local startPos = {}

function controller:initialize()
    local config = {
        defaultImage = game.chapterConfig.controller,
        width = G.percentX(35),
        height = G.percentX(35),
        x = G.centerX,
        y = G.percentY(86.5)
    }

    Base.initialize(self, config)
    game:addEventListener("onGameEvent", self)
    self.image:addEventListener("touch", self)
end

function controller:touch(event)
    local phase = event.phase
    if(phase == "ended") then
        local horizontal = self.image.x - event.x
        local vertical = self.image.y - event.y

        if(math.abs(horizontal) <= math.abs(vertical)) then
            if(vertical <= 0) then
                game:dispatchEvent({name = "changePlayerDirection", direction = "down"})
                return
            end
            if(vertical > 0) then
                game:dispatchEvent({name = "changePlayerDirection", direction = "up"})
                return
            end
        end
        if(math.abs(horizontal) > math.abs(vertical)) then
            if(horizontal <= 0) then
                game:dispatchEvent({name = "changePlayerDirection", direction = "right"})
                return
            end
            if(vertical > 0) then
                game:dispatchEvent({name = "changePlayerDirection", direction = "left"})
                return
            end
        end
    end
    -- if(phase == "moved") then
    --     -- Up event
    --     if(event.y < startPos.Y) then
    --         if(math.abs(startPos.X - event.x) <= math.abs(startPos.Y - event.y)) then
    --             game:dispatchEvent({name = "changePlayerDirection", direction = "up"})
    --             return
    --         end
    --     end
    --     -- Down event
    --     if(event.y > startPos.Y) then
    --         if(math.abs(startPos.X - event.x) <= math.abs(startPos.Y - event.y)) then
    --             game:dispatchEvent({name = "changePlayerDirection", direction = "down"})
    --             return
    --         end
    --     end
    --     -- Left event
    --     if(event.x < startPos.X) then
    --         if(math.abs(startPos.Y - event.y) <= math.abs(startPos.X - event.x)) then
    --             game:dispatchEvent({name = "changePlayerDirection", direction = "left"})
    --             return;
    --         end
    --     end
    --     -- Right event
    --     if(event.x > startPos.X) then
    --         if(math.abs(startPos.Y - event.y) <= math.abs(startPos.X - event.x)) then
    --             game:dispatchEvent({name = "changePlayerDirection", direction = "right"})
    --             return;
    --         end
    --     end
    -- end
end

function controller:onGameEvent(event)
    local phase = event.phase
    if(phase == "changeScene") then
        game:removeEventListener("onGameEvent", self)
        self.image:removeEventListener("touch", self)
        self.image:removeSelf()
        package.loaded[R.game_controllerScript] = nil
    end
    if(phase == "pause") then
        self.image:removeEventListener("touch", self)
    end
    if(phase == "resume") then
        self.image:addEventListener("touch", self)
    end
end

controller:new()

return controller
