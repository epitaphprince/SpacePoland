local game = game
local Base = require(R.base_gameObjectScript)
local enemy = Class(Base)
local levelData = game.levelData

function enemy:initialize(config)
    Base.initialize(self, config)

    self.direction = "none"
    self.speed = 4
    self.step = 0
    self.changeDirectionStep = 3
    self.image.directions = table.copy({"left", "right", "up", "down"})
    self.state = GlobalOptions.enemyState.normal
    self.cachedState = self.state

    self.startX = self.image.x
    self.startY = self.image.y

    self.image.activeImage = display.newImageRect(self.image, config.activeImage, config.size, config.size)
    self.image.fearImage = display.newImageRect(self.image, config.fearImage, config.size, config.size)
    self.image.angryImage = display.newImageRect(self.image, config.angryImage, config.size, config.size)
    self.image.woundImage = display.newImageRect(self.image, config.woundImage, config.size, config.size)
    self.image.activeImage.isVisible = false
    self.image.fearImage.isVisible = false
    self.image.angryImage.isVisible = false
    self.image.woundImage.isVisible = false

    game:addEventListener("onGameEvent", self)
    game:addEventListener("changeState", self)
    game:addEventListener(GlobalOptions.bonusActivationEvent, self)
end

function enemy:resumeEnemy()
    if(self.direction == "none") then
        self:getNextDirection()
    end
    if(self.blink) then
        transition.resume(self.blink)
    end
    if(self.immortalTimer) then
        timer.resume(self.immortalTimer)
    end
    Runtime:addEventListener("enterFrame", self)
end

function enemy:pauseEnemy()
    if(self.blink) then
        transition.pause(self.blink)
    end
    if(self.immortalTimer) then
        timer.pause(self.immortalTimer)
    end
    Runtime:removeEventListener("enterFrame", self)
end

function enemy:bonusActivation(event)
    local type = event.type
    local state = event.state
    if(type == GlobalOptions.bonusTypes.decreaseEnemiesSpeed) then
        if(state == GlobalOptions.bonusState.activation) then
            self.speed = 2;
        else
            self.speed = 4;
        end
    end
end

function enemy:changeState(event)
    local id = event.id
    local state = event.state

    if(self.type == id) then

        self.state = state
        if(state == GlobalOptions.enemyState.normal or state == GlobalOptions.enemyState.attack
        or state == GlobalOptions.enemyState.fear) then
            self.cachedState = state
        end
        
        self.image.defaultImage.isVisible = false
        self.image.activeImage.isVisible = false
        self.image.fearImage.isVisible = false
        self.image.angryImage.isVisible = false
        self.image.woundImage.isVisible = false
        if(state == "normal") then
            self.image.activeImage.isVisible = true
            self.state = GlobalOptions.enemyState.normal
        end
        if(state == "fear") then
            self.image.fearImage.isVisible = true
            self.state = GlobalOptions.enemyState.fear
        end
        if(state == "attack") then
            self.image.angryImage.isVisible = true
            self.state = GlobalOptions.enemyState.attack
        end
        if(state == "wound") then
            self.image.woundImage.isVisible = true
            self:wound()
        end
        if(state == "immortal") then
            self.image.activeImage.isVisible = true;
            self.blink = transition.blink(self.image, {time = 500})
            self.immortalTimer = timer.performWithDelay(GlobalOptions.enemyImmortalTime, function()
                transition.cancel(self.blink);
                self.blink = nil;
                self.image.alpha = 1;
                game:dispatchEvent({name = "changeState", id = self.type, state = self.cachedState});
                end, 1)
        end
    end
end

function enemy:wound()
    self.step = 0
    self:pauseEnemy()
    self.changeDirectionStep = 0
    self.direction = "none"
    game:dispatchEvent({name = GlobalOptions.changeInteractionEvent, interaction = false})
    game:dispatchEvent({name = "onGameEvent", phase = "pause"})
    game:dispatchEvent({name = "decreaseLivePoints", id = self.type})
    self.image.xScale = 1.5
    self.image.yScale = 1.5

    transition.to(self.image, {time = GlobalOptions.enemyWoundTime, x = self.startX, y = self.startY, onComplete = function()
        self.image.xScale = 1; self.image.yScale = 1
        game:dispatchEvent({name = "changeState", id = self.type, state = GlobalOptions.enemyState.immortal})
        game:dispatchEvent({name = "onGameEvent", phase = "resume"})
        game:dispatchEvent({name = GlobalOptions.changeInteractionEvent, interaction = true})
        self:getNextDirection()
        end })
end

function enemy:enterFrame()
    self:move({direction = self.direction, speed = self.speed})

    if(self.direction ~= "none") then
        self.step = self.step + self.speed

        local blockSize = GlobalOptions.gameElementSize
        if(self.step >= blockSize) then
            self:align()
            self.step = 0
            self.changeDirectionStep = self.changeDirectionStep - 1
            game:dispatchEvent({name = GlobalOptions.moveEnemyEvent, target = self})
        end

        if(self.changeDirectionStep == 0) then
            self.changeDirectionStep = 3
            self.image.directions = table.copy({"left", "right", "up", "down"})
            self:getNextDirection()
        end
    end
end

function enemy:getNextDirection(event)

    local function randomDirection()
        if(#self.image.directions == 0) then
            self.image.directions = table.copy({"left", "right", "up", "down"})
        end
        local rand = math.random(1, #self.image.directions)
        local direction = self.image.directions[rand]
        table.remove(self.image.directions, rand)
        return direction
    end

    local function AIDirection()
        local horizontal = self.image.x - game.player.image.x
        local vertical = self.image.y - game.player.image.y
        local AIScale = 0.1
        local fear = self.state == GlobalOptions.enemyState.fear
        local elementSize = GlobalOptions.gameElementSize
        local directions = GlobalOptions.directions

        -- resolving horizontal direction
        if(math.abs(horizontal) <= math.abs(vertical)) then
            if(vertical <= - elementSize * AIScale) then
                if(fear) then
                    return directions.up
                else
                    return directions.down
                end
            end
            if(vertical >= elementSize * AIScale) then
                if(fear) then
                    return directions.down
                else
                    return directions.up
                end
            end
            if(vertical > - elementSize * AIScale and vertical < elementSize * AIScale) then
                if(horizontal > 0) then
                    if(fear) then
                        return directions.left
                    else
                        return directions.right
                    end
                end
                if(horizontal <= 0) then
                    if(fear) then
                        return directions.right
                    else
                        return directions.left
                    end
                end
            end
        end
        -- resolving vertical direction
        if(math.abs(vertical) < math.abs(horizontal)) then
            if(horizontal <= - elementSize * AIScale) then
                if(fear) then
                    return directions.left
                else
                    return directions.right
                end
            end
            if(horizontal >= elementSize * AIScale) then
                if(fear) then
                    return directions.right
                else
                    return directions.left
                end
            end
            if(horizontal > - elementSize * AIScale and horizontal < elementSize * AIScale) then
                if(vertical > 0) then
                    if(fear) then
                        return directions.down
                    else
                        return directions.up
                    end
                end
                if(vertical <= 0) then
                    if(fear) then
                        return directions.up
                    else
                        return directions.down
                    end
                end
            end
        end
    end

    local backDirection = "none"
    if(self.direction == "left") then
        backDirection = "right"
    end
    if(self.direction == "right") then
        backDirection = "left"
    end
    if(self.direction == "up") then
        backDirection = "down"
    end
    if(self.direction == "down") then
        backDirection = "up"
    end

    for i = 1, #self.image.directions do
        if(self.image.directions[i] == backDirection) then
            table.remove(self.image.directions, i)
        end
    end
    if(event ~= nil) then
        if(event.state == GlobalOptions.enemyState.normal) then
            if(self.state == GlobalOptions.enemyState.fear or self.state == GlobalOptions.enemyState.attack or
               self.state == GlobalOptions.enemyState.immortal) then
                self.image.directions = table.copy({"left", "right", "up", "down"})
                    for i = 1, #self.image.directions do
                        if(self.image.directions[i] == backDirection) then
                        table.remove(self.image.directions, i)
                    end
                end
            end
            self:changeEnemyDirection({direction = randomDirection()})
            return
        end
    end
    if(self.state == GlobalOptions.enemyState.attack or
        self.state == GlobalOptions.enemyState.fear or
        self.state == GlobalOptions.enemyState.immortal) then
        self:changeEnemyDirection({direction = AIDirection()})
        return
    end
    if(self.state == GlobalOptions.enemyState.normal) then
        self:changeEnemyDirection({direction = randomDirection()})
        return
    end
end

function enemy:changeEnemyDirection(event)
    self.direction = event.direction
    game:dispatchEvent({name = GlobalOptions.moveEnemyEvent, target = self})
end

function enemy:onGameEvent(event)
    local phase = event.phase
    if(phase == "start") then
        self:resumeEnemy()
        self:getNextDirection()
    end
    if(phase == "pause") then
        self:pauseEnemy()
    end
    if(phase == "resume") then
        self:resumeEnemy()
    end
    if(phase == "changeScene") then
        game:removeEventListener("onGameEvent", self)
        game:removeEventListener("changeState", self)
        game:removeEventListener(GlobalOptions.bonusActivationEvent, self)

        -- transitions
        if(self.blink) then
            transition.cancel(self.blink)
        end
        if(self.immortalTimer) then
            timer.cancel(self.immortalTimer)
        end

        self.image:removeSelf()
        package.loaded[R.game_enemyScript] = nil
    end
end

for i = 1, #levelData do
    local type = levelData[i].type
    local config = levelData[i]
    if(type == GlobalOptions.russianEnemy
        or type == GlobalOptions.germanEnemy
        or type == GlobalOptions.ufoEnemy) then
            enemy:new(config)
    end
end

return enemy
