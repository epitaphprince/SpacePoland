local game = game
local Base = require(R.base_gameObjectScript)
local player = Class(Base)
local levelData = game.levelData

function player:initialize(config)
    Base.initialize(self, config)

    -- initialize state images
    self.image.activeImage = display.newImageRect(self.image, config.activeImage, config.size, config.size)
    self.image.angryImage = display.newImageRect(self.image, config.angryImage, config.size, config.size)
    self.image.woundImage = display.newImageRect(self.image, config.woundImage, config.size, config.size)
    self.image.activeImage.isVisible = false
    self.image.angryImage.isVisible = false
    self.image.woundImage.isVisible = false

    self.direction = "none"
    self.nextDirection = "none"
    self.speed = 4
    self.step = 0
    self.state = "normal"

    self.startX = self.image.x
    self.startY = self.image.y

    self.multipointActivation = false

    -- global properties
    game.player = self

    game:addEventListener("onGameEvent", self)
    game:addEventListener("changeState", self)
    game:addEventListener(GlobalOptions.changeInteractionEvent, self)
    game:addEventListener(GlobalOptions.moveEnemyEvent, self)
    game:addEventListener(GlobalOptions.bonusActivationEvent, self)
end

function player:moveEnemy(event)
    local enemy = event.target

    local x = enemy.image.x
    local y = enemy.image.y
    local offset = GlobalOptions.gameElementOffset

    local collate = self:collate({x = x - offset, y = y}) or self:collate({x = x, y = y - offset})
        or self:collate({x = x + offset, y = y}) or self:collate({x = x, y = y + offset}) or
        self:collate({x = x - 0.5 * offset, y = y}) or self:collate({x = x, y = y - 0.5 * offset})
           or self:collate({x = x + 0.5 * offset, y = y}) or self:collate({x = x, y = y + 0.5 * offset}) or
           self:collate({x = x - 1.5 * offset, y = y}) or self:collate({x = x, y = y - 1.5 * offset})
              or self:collate({x = x + 1.5 * offset, y = y}) or self:collate({x = x, y = y + 1.5 * offset})

    -- player wound
    if(collate and enemy.state ~= GlobalOptions.enemyState.fear and enemy.state ~= GlobalOptions.enemyState.immortal
        and self.state ~= GlobalOptions.playerState.immortal and not self.immortalBonus) then
            game:dispatchEvent({name = "changeState", id = GlobalOptions.player, state = GlobalOptions.playerState.wound})
    -- enemy wound
    elseif(collate and enemy.state == GlobalOptions.enemyState.fear) then
        game:dispatchEvent({name = GlobalOptions.changeStateEvent, id = enemy.type, state = GlobalOptions.enemyState.wound})
        elseif(collate and self.immortalBonus and enemy.state ~= GlobalOptions.enemyState.immortal) then
        game:dispatchEvent({name = GlobalOptions.changeStateEvent, id = enemy.type, state = GlobalOptions.enemyState.wound})
        game:dispatchEvent({name = GlobalOptions.bonusActivationEvent, state = GlobalOptions.bonusState.deactivation, type = GlobalOptions.bonusTypes.playerImmortal})
    end
end

function player:bonusActivation(event)
    local type = event.type
    local state = event.state
    if(type == GlobalOptions.bonusTypes.increasePlayerSpeed) then
        if(state == GlobalOptions.bonusState.activation) then
            self.speed = 6;
        else
            self.speed = 4;
        end
    elseif(type == GlobalOptions.bonusTypes.playerImmortal) then
        if(state == GlobalOptions.bonusState.activation) then
            self.immortalBonus = true;
        else
            self.immortalBonus = false;
        end
    end
end

function player:resumePlayer()
    if(self.blink) then
        transition.resume(self.blink)
    end
    if(self.immortalTimer) then
        timer.resume(self.immortalTimer)
    end
    Runtime:addEventListener("enterFrame", self)
end

function player:pausePlayer()
    if(self.blink) then
        transition.pause(self.blink)
    end
    if(self.immortalTimer) then
        timer.pause(self.immortalTimer)
    end
    Runtime:removeEventListener("enterFrame", self)
end

function player:changeInteraction(event)
    local interaction = event.interaction
    if(interaction) then
        game:addEventListener("moveEnemy", self)
    else
        game:removeEventListener("moveEnemy", self)
    end
end

function player:stopPlayer()
    self.direction = "none"
    Runtime:removeEventListener("enterFrame", self)
end

function player:multipointActivation(event)
    self.multipointActivation = event.value
    print(GlobalOptions.multipointActivationEvent)
end

function player:wound()
    self.step = 0
    game:dispatchEvent({name = GlobalOptions.changeInteractionEvent, interaction = false})
    self:stopPlayer()
    game:dispatchEvent({name = "onGameEvent", phase = "pause"})
    game:dispatchEvent({name = GlobalOptions.multipointTimeDestroy})
    self.image.xScale = 1.5
    self.image.yScale = 1.5

    transition.to(self.image, {time = GlobalOptions.playerWoundTime, x = self.startX, y = self.startY, onComplete = function()
        self.image.xScale = 1; self.image.yScale = 1;
        game:dispatchEvent({name = "changeState", id = GlobalOptions.player, state = GlobalOptions.playerState.immortal});
        game:dispatchEvent({name = GlobalOptions.changeInteractionEvent, interaction = true})
        game:dispatchEvent({name = "onGameEvent", phase = "resume"});
        end })
end

function player:changeState(event)
    local id = event.id
    local state = event.state
    if(self.type == id) then
        self.state = state
        self.image.defaultImage.isVisible = false
        self.image.activeImage.isVisible = false
        self.image.angryImage.isVisible = false
        self.image.woundImage.isVisible = false

        if(state == "normal") then
            self.image.activeImage.isVisible = true
        end
        if(state == "angry") then
            self.image.angryImage.isVisible = true
        end
        if(state == "wound") then
            self.image.woundImage.isVisible = true
            game:dispatchEvent({name = "decreaseLivePoints", id = GlobalOptions.player})
            if(GlobalOptions.playerLives > 0) then
                self:wound()
            end
        end
        if(state == "immortal") then
            self.image.activeImage.isVisible = true;
            self.blink = transition.blink(self.image, {time = 500})
            self.immortalTimer = timer.performWithDelay(GlobalOptions.playerImmortalTime, function()
                transition.cancel(self.blink);
                self.blink = nil;
                self.image.alpha = 1;
                game:dispatchEvent({name = "changeState", id = GlobalOptions.player, state = "normal"});
                end, 1)
        end
    end
end

function player:enterFrame()
    self:move({direction = self.direction, speed = self.speed})

    if(self.direction ~= "none") then
        self.step = self.step + self.speed

        local blockSize = GlobalOptions.gameElementSize
        if(self.step >= blockSize) then
            self.direction = self.nextDirection
            self:align()
            self.step = 0
            self:dispatchMoveEvent({x = self.image.x, y = self.image.y})
        end
    end
end

function player:changePlayerDirection(event)
    if(self.direction == "none") then
        self.direction = event.direction
        self.nextDirection = event.direction
        self:resumePlayer()
        self:dispatchMoveEvent({x = self.image.x, y = self.image.y})
    else
        local blockSize = GlobalOptions.gameElementSize
        if(self.step >= blockSize - self.speed * GlobalOptions.swipeSensitivity
            and self.step + blockSize <= blockSize + self.speed * GlobalOptions.swipeSensitivity ) then
            self.direction = self.nextDirection
            self:align()
            self.step = 0
            self:dispatchMoveEvent({x = self.image.x, y = self.image.y})
        else
            self.nextDirection = event.direction
        end
    end
end

function player:dispatchMoveEvent(config)
    local x = config.x
    local y = config.y
    -- top left
    if(x <= GlobalOptions.axis.x and y <= GlobalOptions.axis.y) then
        game:dispatchEvent({name = GlobalOptions.movePlayerTopLeftAreaEvent, target = self})
    end
    -- top right
    if(x >= GlobalOptions.axis.x and y <= GlobalOptions.axis.y) then
        game:dispatchEvent({name = GlobalOptions.movePlayerTopRightAreaEvent, target = self})
    end
    -- bottom left
    if(x <= GlobalOptions.axis.x and y >= GlobalOptions.axis.y) then
        game:dispatchEvent({name = GlobalOptions.movePlayerBottomLeftAreaEvent, target = self})
    end
    -- bottom right
    if(x >= GlobalOptions.axis.x and y >= GlobalOptions.axis.y) then
        game:dispatchEvent({name = GlobalOptions.movePlayerBottomRightAreaEvent, target = self})
    end
end

function player:onGameEvent(event)
    local phase = event.phase
    if(phase == "start") then
        game:addEventListener("changePlayerDirection", self)
        game:addEventListener("multipointActivation", self)
    end
    if(phase == "pause") then
        self:pausePlayer()
    end
    if(phase == "resume") then
        if(self.direction ~= "none") then
            self:resumePlayer()
        end
    end
    if(phase == "changeScene") then
        game:removeEventListener("onGameEvent", self)
        game:removeEventListener("changePlayerDirection", self)
        game:removeEventListener("multipointActivation", self)
        game:removeEventListener(GlobalOptions.bonusActivationEvent, self)
        game:removeEventListener("changeState", self)
        game:removeEventListener(GlobalOptions.changeInteractionEvent, self)
        game:removeEventListener(GlobalOptions.moveEnemyEvent, self)

        -- transitions
        if(self.blink) then
            transition.cancel(self.blink)
        end
        if(self.immortalTimer) then
            timer.cancel(self.immortalTimer)
        end
        self:stopPlayer()
        self.image:removeSelf()
        package.loaded[R.game_playerScript] = nil
    end
end

for i = 1, #levelData do
    local type = levelData[i].type
    local config = levelData[i]
    if(type == GlobalOptions.player) then
        player:new(config)
    end

end

return player
